package com.bangkok.airajax.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bangkok.air.service.AirService;

import lombok.extern.log4j.Log4j;

@RequestMapping("/airajax")
@Controller
@Log4j
public class AirAjaxController {
	
	
	@Autowired
	@Qualifier("airServiceImpl")
	private AirService airService;
	
	//--- 공항 가져오기 ------------------------------------
	@GetMapping("/getAirport.do")
	public String getAirport(Model model, String countryCode) {
		log.info("getAirport.do");
		// 중분류를 가져와서 JSP로 넘기기
		model.addAttribute("airportList", airService.getAirport(countryCode));
		// midList.jsp 에 select tag 작성
		return "air/getAirport";
	}
	
	//--- 항공편 가져오기 ------------------------------------
	@GetMapping("/getAirplane.do")
	public String getAirplane(Model model, String airplanePdt) {
		log.info("getAirplane.do");
		// 중분류를 가져와서 JSP로 넘기기
		model.addAttribute("airplaneList", airService.getAirplane(airplanePdt));
		// midList.jsp 에 select tag 작성
		return "air/getAirplane";
	}
	
	//--- 관리자 기종 상세보기 ------------------------------------
	@GetMapping("/getFlightInfo.do")
	public String getFlightInfo(Model model, String flightName) {
		log.info("getFlightInfo.do");
		
		model.addAttribute("info", airService.getFlightInfo(flightName));
		
		return "air/getFlightInfo";
	}
	
	//--- 노선에 따른 금액 가져오기 ------------------------------------
	@GetMapping("/getPrice.do")
	public String getPrice(Model model, Long airlineNo, Long routeId) {
		log.info("getPrice.do");
		// 중분류를 가져와서 JSP로 넘기기
		model.addAttribute("priceInfo", airService.getPrice(airlineNo, routeId));
		// midList.jsp 에 select tag 작성
		return "air/getPrice";
	}
	
	//--- 스케줄 등록 - 스케줄 없는 항공편 리스트 ------------------------------------
	@GetMapping("/getFlightList.do")
	public String getFlightList(Model model, Long airlineNo) {
		log.info("getFlightList.do");
		// 중분류를 가져와서 JSP로 넘기기
		model.addAttribute("flightList", airService.getFlightList(airlineNo));
		// midList.jsp 에 select tag 작성
		return "air/getFlightList";
	}
	
	//--- 항공사 정보 가져오기 ------------------------------------
	@GetMapping("/getAirlineInfo.do")
	public String getAirlineInfo(Model model, Long airlineNo) {
		log.info("getAirlineInfo.do");
		// 중분류를 가져와서 JSP로 넘기기
		model.addAttribute("info", airService.getAirlineInfo(airlineNo));
		// midList.jsp 에 select tag 작성
		return "air/getAirlineInfo";
	}
	
	//--- 항공사 등록 이메일 가져오기 ------------------------------------
	@GetMapping("/getEmail.do")
	public String getEmail(Model model) {
		log.info("getEmail.do");
		// 중분류를 가져와서 JSP로 넘기기
		model.addAttribute("email", airService.getEmail());
		// midList.jsp 에 select tag 작성
		return "air/getEmail";
	}
	
	//--- 항공사 등록 이메일 가져오기 ------------------------------------
	@GetMapping("/getNoc.do")
	public String getNoc(Model model) {
		log.info("getNoc.do");
		// 중분류를 가져와서 JSP로 넘기기
		model.addAttribute("noc", airService.getNoc());
		// midList.jsp 에 select tag 작성
		return "air/getNoc";
	}
	
}
