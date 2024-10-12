package com.bangkok.hotel_reservations.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Hotel_reservationsVO {
	//회원에 있는 정보 가지고 오기 
	private String name; //이름
	private String email; //아이디
	private String tel; //전화번호
	//호텔 및 객실에 대한 정보 가지고 오기 
	private String title; //호텔 이름
	private String hotel_image_name; //호텔 이미지
	private String room_image_name; //객실 이미지
	private String room_type; //객실 이름
	private Long price; //객실 가격
	private String address; //호텔 주소
	private Integer gradeno; // 사업자 체크용
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	//private String checkOut;
	private Date checkOut;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date checkIn;
	//private String checkIn;
	private Integer people; //인원 수 
	private Integer roomnumber; //객실 수
	private Integer rno; //객실 번호 
	private String id; //예약 아이디
	//DB에 저장할 컬럼 
	private Long reservation_no; //예약 번호
	private String paymentStatus; //예약자 상태
	private String paymentMethod; //결제 수단
	private String payment_Type; //결제 방식
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date paymentdate; //결제한 날짜
	
	private String has_review; 
	
	
}
