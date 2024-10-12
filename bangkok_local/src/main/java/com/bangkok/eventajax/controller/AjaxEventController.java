package com.bangkok.eventajax.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bangkok.event.service.EventService;
import com.bangkok.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/ajax")
@Log4j
public class AjaxEventController {
	// 자동 DI
	// @Setter(onMethod_ = @Autowired)
	// Type이 같으면 식별할 수 있는 문자열 지정 - id를 지정
	@Autowired
	@Qualifier("eventServiceImpl")
	private EventService eventService;
	

	@GetMapping("/getHotel.do")
	public String getHotel(Model model, HttpServletRequest request) throws Exception {
		log.info("getHotel.do");
		// 페이지 처리를 위한 객체 생겅
		PageObject pageObject = PageObject.getInstance(request);
		String strPerPageNum = request.getParameter("perPageNum");
		if(strPerPageNum == null  || strPerPageNum.equals("") )
			pageObject.setPerPageNum(12);
		
		model.addAttribute("hotel", eventService.hotelList());
		model.addAttribute("pageObject", pageObject);
		return "event/hotelList";
	}
	@GetMapping("/getTrip.do")
	public String getTrip(Model model,HttpServletRequest request) throws Exception {
		log.info("getTrip.do");
		PageObject pageObject = PageObject.getInstance(request);
		String strPerPageNum = request.getParameter("perPageNum");
		if(strPerPageNum == null  || strPerPageNum.equals("") )
			pageObject.setPerPageNum(12);
		
		model.addAttribute("trip", eventService.tripList());
		model.addAttribute("pageObject", pageObject);		
		return "event/tripList";
	}
	
}
