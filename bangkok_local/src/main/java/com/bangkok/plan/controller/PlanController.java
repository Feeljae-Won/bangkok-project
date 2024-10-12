package com.bangkok.plan.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bangkok.plan.service.PlanService;
import com.bangkok.plan.vo.PlanVO;
import com.bangkok.planDetail.service.PlanDetailService;

@Controller
@RequestMapping("/plan")
public class PlanController {

	// service
	@Autowired
	@Qualifier("planServiceImpl")
	PlanService service;
	
	// 1. list
	@GetMapping("/list.do")
	public String list(Model model) {
		model.addAttribute("tripList", service.list());
		return "plan/list";
	}
	
	// 2-1. view & 2-2. planList
	@GetMapping("/view.do")
	public String view(Model model, @RequestParam(name="tno") Long tno) {
		model.addAttribute("vo", service.view(tno));
		model.addAttribute("planDetailList", service.planList(tno));
		return "plan/view";
	}
	
	// 2-3. planView
	@GetMapping("/planView.do")
	public String planView(Model model, Long pno) {
		model.addAttribute("planDetailList", service.planView(pno));
		return "plan/planView";
	}
	
	
	// 3. write
	@PostMapping("/write.do")
	public String write(PlanVO vo, RedirectAttributes rttr) {
		
		service.write(vo);
		rttr.addFlashAttribute("msg", "여행 계획이 정상적으로 등록되었습니다.");
		
		return "redirect:/plan/list.do";
	}
	
	// 4. update
	@PostMapping("/update.do")
	public String update(PlanVO vo, RedirectAttributes rttr) {
		
		service.update(vo);
		rttr.addFlashAttribute("msg", "여행 계획이 정상적으로 수정되었습니다.");
		
		return "redirect:/plan/view.do?tno=" + vo.getTno();
	}
	
	// 5. delete
	@PostMapping("/delete.do")
	public String delete(@RequestParam(name = "tno") Long tno, RedirectAttributes rttr) {
		// 삭제 서비스 실행
		service.delete(tno);
		// 삭제 메시지 출력
		rttr.addFlashAttribute("msg", "여행 계획이 정상적으로 삭제되었습니다.");
		// 리스트로 돌아가기
		return "redirect:/plan/list.do";
	}
	
}
