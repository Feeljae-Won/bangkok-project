package com.bangkok.hotel_reservations.controller;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bangkok.hotel_reservations.service.Hotel_reservationsService;
import com.bangkok.hotel_reservations.vo.Hotel_reservationsVO;

import lombok.extern.log4j.Log4j;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Base64;
import java.util.Date;

@Controller
@Log4j
public class Hotel_reservationsRestController {
	
	@Autowired
	@Qualifier("hotel_reservationsServiceImpl")
	private Hotel_reservationsService service;
	
    @RequestMapping(value = "/hotel_reservationsRest", method = RequestMethod.POST)
    public ResponseEntity<JSONObject> confirmPayment(@RequestBody String jsonBody) throws Exception {
        JSONParser parser = new JSONParser();
        String orderId;
        String amount;
        String paymentKey;
        Date checkOut;
        Date checkIn;
        Integer people;
        Integer rno;
        try {
            // 클라이언트에서 받은 JSON 요청 바디입니다.
            JSONObject requestData = (JSONObject) parser.parse(jsonBody);
             paymentKey = (String) requestData.get("paymentKey");
             orderId = (String) requestData.get("orderId");
             amount = (String) requestData.get("amount");
            // 날짜 처리
//            String checkOutStr = (String) requestData.get("checkOut");
//            String checkInStr = (String) requestData.get("checkIn");
            // 숫자 처리
             rno = Integer.parseInt((String) requestData.get("rno"));
             people = Integer.parseInt((String) requestData.get("people"));
        } catch (ParseException e) {
            throw new RuntimeException(e);
        };
        JSONObject obj = new JSONObject();
        obj.put("orderId", orderId);
        obj.put("amount", amount);
        obj.put("paymentKey", paymentKey);
//        obj.put("checkOut", checkOut);
//        obj.put("checkIn", checkIn);
        obj.put("rno", rno);
        obj.put("people", people);

        // 토스페이먼츠 API는 시크릿 키를 사용자 ID로 사용하고, 비밀번호는 사용하지 않습니다.
        // 비밀번호가 없다는 것을 알리기 위해 시크릿 키 뒤에 콜론을 추가합니다.
        String widgetSecretKey = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";
        Base64.Encoder encoder = Base64.getEncoder();
        byte[] encodedBytes = encoder.encode((widgetSecretKey + ":").getBytes(StandardCharsets.UTF_8));
        String authorizations = "Basic " + new String(encodedBytes);

        // 결제를 승인하면 결제수단에서 금액이 차감돼요.
        URL url = new URL("https://api.tosspayments.com/v1/payments/confirm");
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestProperty("Authorization", authorizations);
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setRequestMethod("POST");
        connection.setDoOutput(true);

        OutputStream outputStream = connection.getOutputStream();
        outputStream.write(obj.toString().getBytes("UTF-8"));

        int code = connection.getResponseCode();
        boolean isSuccess = code == 200;

        InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();

        // 결제 성공 및 실패 비즈니스 로직을 구현하세요.
        Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
        JSONObject jsonObject = (JSONObject) parser.parse(reader);
        
        log.info(jsonObject);
     // 예제: jsonObject에서 데이터 추출
        String method = (String) jsonObject.get("method");

        // easyPay는 nested JSON 객체로 되어 있으므로, JSONObject로 캐스팅한 후 값을 가져옵니다.
        JSONObject easyPay = (JSONObject) jsonObject.get("easyPay");
        String easyPayProvider = (String) easyPay.get("provider");
        String easyPayAmount = String.valueOf(easyPay.get("amount"));

        // 로그로 출력
        log.info("Payment Key: " + paymentKey);
//        log.info("checkOut: " + checkOut);
//        log.info("checkIn: " + checkIn);
        log.info("Order ID: " + orderId);
        log.info("Amount: " + amount);
        log.info("Method: " + method);
        log.info("rno: " + rno);
        log.info("people: " + people);
        log.info("EasyPay Provider: " + easyPayProvider);
        log.info("EasyPay Amount: " + easyPayAmount);
        
        String dateString = "2024-09-13 15:30:00";
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = dateFormat.parse(dateString);
        
        String dateString1 = "2024-09-20 15:30:00";
        SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date1 = dateFormat2.parse(dateString1);
         
        Hotel_reservationsVO vo = new Hotel_reservationsVO();
        vo.setPaymentMethod(easyPayProvider);
        vo.setPayment_Type(method);
        vo.setPeople(people);
        vo.setRno(rno);
        vo.setCheckIn(date);
        vo.setCheckOut(date1);
		//나중에 풀자
//		HttpSession session = request.getSession();
//		LoginVO login = (LoginVO) session.getAttribute("login");
//		String id =login.getEmail();		
        vo.setEmail("john@example.com");
        service.write(vo);
        
        service.decrease(rno);
        
       
        
        responseStream.close();

        return ResponseEntity.status(code).body(jsonObject);
    }
}
