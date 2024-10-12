package com.bangkok.airReservation.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bangkok.airReservation.service.AirReservationService;
import com.bangkok.airReservation.vo.APassengerVO;
import com.bangkok.airReservation.vo.AirReservationVO;
import com.bangkok.airReservation.vo.BaggageVO;
import com.bangkok.airReservation.vo.CPassengerVO;
import com.bangkok.airReservation.vo.IPassengerVO;
import com.bangkok.airReservation.vo.ReservationScheduleVO;
import com.bangkok.member.vo.LoginVO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/airReservation")
@Log4j
public class AirReservationController {

	@Autowired
	@Qualifier("AirReservationServiceImpl")
	private AirReservationService service;
	
	
	@GetMapping("/list.do")
	public String list(Model model) {	

		model.addAttribute("list", service.list());

		return "airReservation/list";

	}

	// --- 상품 글등록 폼 ------------------------------------
	@PostMapping("/writeForm.do")
	public String writeForm(@ModelAttribute("list") AirReservationVO vo) {
		log.info("writeForm.do");
		log.info("airReservationWriteForm-- " + vo);
		
		// 항공 검색 결과
		 log.info("aPassenger: " + vo.getAPassenger());  // aPassenger 값 로그
		    log.info("cPassenger: " + vo.getCPassenger());
		    log.info("iPassenger: " + vo.getIPassenger());
		
		return "airReservation/writeForm";
	}
	
	@PostMapping("/write.do")
	public String write(AirReservationVO vo, 
			@ModelAttribute("apassengers") APassengerVO apassengerList,
			@ModelAttribute("cpassengers") CPassengerVO cpassengerList,
			@ModelAttribute("ipassengers") IPassengerVO ipassengerList,
			@ModelAttribute("baggages") BaggageVO baggageList,
			@ModelAttribute("scheduleID") ReservationScheduleVO  reservationScheduleVO,
			HttpSession session,
			RedirectAttributes rttr) {
		
	    log.info("write.do");
	    log.info("AirReservationVO " + vo);
	   
	    log.info("List<BaggageVO> " + baggageList);
	    log.info("ReservationScheduleVO " + reservationScheduleVO);
	    log.info("APassengerVO " + apassengerList);
	    log.info("CPassengerVO " + cpassengerList);
	    log.info("IPassengerVO " + ipassengerList);
	    log.info("ReservationScheduleVO-scheduleID " + reservationScheduleVO.getScheduleID());
	    
		/* vo.setEmail(getEmail(session)); */
	    vo.setEmail("test1@naver.com");
	    
	    service.reservation(vo, 
	    		apassengerList.getApassengers(), 
	    		cpassengerList.getCpassengers(),
	    		ipassengerList.getIpassengers(), 
	    		baggageList.getBaggages(), reservationScheduleVO);
	   
	    
	    rttr.addFlashAttribute("msg", "예약이 완료 되었습니다.");


	    return "redirect:list.do";
	}
	
	@PostMapping("updateForm.do")
	public String updateForm(Model model) {
		
		model.addAttribute("vo" , service.list());
		
		return "airReservation/updateForm";
		
	}
	
	
	/*
	 * // 관리자 페이지
	 * 
	 * @GetMapping("/adminList.do") public String adminList(Model model) {
	 * 
	 * // 예약 리스트를 가져오는 서비스 메서드에서 각 예약의 승객 리스트도 함께 포함 List<AirReservationVO>
	 * reservations = service.listAllReservations();
	 * 
	 * for (AirReservationVO reservation : reservations) { List<PassengerVO>
	 * passengers = service.listPassengers(reservation.getReservationNo());
	 * reservation.setPassengers(passengers); }
	 * 
	 * model.addAttribute("reservations", reservations);
	 * 
	 * return "airReservation/adminList";
	 * 
	 * }
	 */
	
	private String getEmail(HttpSession session) {
		LoginVO vo = (LoginVO)session.getAttribute("login");
		String email = vo.getEmail();
		return email; // 강제 로그인 처리해서 test로 하드코딩했다.
	}
	

	


}
