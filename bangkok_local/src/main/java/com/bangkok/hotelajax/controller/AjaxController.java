package com.bangkok.hotelajax.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bangkok.amenities.service.AmenitiesService;
import com.bangkok.hotel.service.HotelService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/ajax")
@Log4j
public class AjaxController {

	@Autowired
	@Qualifier("amenitiesServiceImpl")
	private AmenitiesService amenitiesService;

	@Autowired
	@Qualifier("hotelServiceImpl")
	private HotelService hotelService;
	
	// ------- 편의시설 가져오기 ---------
	@GetMapping("/getAmenities.do")
	public String getAmenities(Model model, Integer amenitiesNo) {
		log.info("getAmenities");
		
		model.addAttribute("amenities", amenitiesService.list());
		
		return "hotel/amenitiesList";
	}
	
	@GetMapping("/getRoomImageList.do")
	public String getRoomImageList(Model model, Long rno) {
		log.info("getRoomImageList");
		
		model.addAttribute("roomImageList", hotelService.roomImageList(rno));
		
		return "hotel/roomImageList";
	}
}
