package com.bangkok.planDetail.controller;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bangkok.planDetail.service.PlanDetailService;

@Controller
@RequestMapping("/ajax")
public class PlanDetailController {

	@Autowired
	@Qualifier("planDetailServiceImpl")
	PlanDetailService service;
	
	@GetMapping("/getPlanView.do")
	public String getPlanDetailList(Model model, @RequestParam(name = "pno") Long pno) {
		model.addAttribute("planView", service.planView(pno));
		return "plan/planView";
	}
}
