package com.bangkok.city.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bangkok.city.service.CityService;

@Controller
@RequestMapping("/city")
public class CityController {

	@Autowired
	@Qualifier("cityServiceImpl")
	CityService cityService;
	
	// 1. city list
	@GetMapping("/list.do")
	public String list(Model model) {
		
		model.addAttribute("cityList", cityService.list());
		
		return "city/list";
		// return "plan/cityList";
	}
	
}
