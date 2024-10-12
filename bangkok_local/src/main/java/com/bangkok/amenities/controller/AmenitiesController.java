package com.bangkok.amenities.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bangkok.amenities.service.AmenitiesService;
import com.bangkok.amenities.vo.AmenitiesVO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/amenities")
@Log4j
public class AmenitiesController {

	// 자동 DI
		// @Setter(onMethod_ = @Autowired)
		// Type이 같으면 식별할 수 있는 문자열 지정 - id를 지정
		@Autowired
		@Qualifier("amenitiesServiceImpl")
		private AmenitiesService service;
		
		@GetMapping("/list.do")
		// @ModelAttribute() - 전달받는 데이터를 Model에 담아서 바로 JSP까지 보낼 때 사용
		//  속성명을 보통 타입으로 사용한다. name = "searchVO" 설정해서 변경해서 사용
		public String list(Model model, HttpServletRequest request)
				throws Exception {
			
			// 대분류 가져오기.
			List<AmenitiesVO> amenitiesList = service.list();
			
			// model에 담으로 request에 자동을 담기게 된다. - 처리된 데이터를 Model에 저장
			model.addAttribute("list", amenitiesList);
			// pageObject에 데이터 가져 오기 전에는 시작 페이지, 끝 페이지, 전체 페이지가 정해지지 않는다.
			return "amenities/list";
			
		}
		
		//--- 편의시설 등록 폼 ------------------------------------
		@GetMapping("/writeForm.do")
		public String writeForm() {
			log.info("writeForm.do");
			return "amenities/writeForm";
		}
		
		//--- 편의시설 등록 처리 ------------------------------------
		@PostMapping("/write.do")
		public String write(AmenitiesVO vo, RedirectAttributes rttr) {
			log.info("write.do");
			log.info(vo);
			service.write(vo);
			
			// 처리 결과에 대한 메시지 처리
			rttr.addFlashAttribute("msg", "편의시설 등록이 완료되었습니다.");
			
			return "redirect:list.do";
		}
		
		//--- 편의시설 수정 폼 ------------------------------------
		@GetMapping("/updateForm.do")
		public String updateForm(Long amenitiesNo, Model model) {
			log.info("updateForm.do");
			
			
			return "amenities/updateForm";
		}
		
		//--- 편의시설 수정 처리 ------------------------------------
		@PostMapping("/update.do")
		public String update(AmenitiesVO vo, RedirectAttributes rttr) {
			log.info("update.do");
			log.info(vo);
			if(service.update(vo) == 1)
				// 처리 결과에 대한 메시지 처리
				rttr.addFlashAttribute("msg", "편의시설이 수정이 되었습니다.");
			else
				rttr.addFlashAttribute("msg",
						"편의시설이 수정이 되지 않았습니다. ");
			
			return "redirect:list.do?no=" + vo.getAmenitiesNo();
		}
		
		
		//--- 일반 게시판 글삭제 처리 ------------------------------------
		@PostMapping("/delete.do")
		public String delete(AmenitiesVO vo, RedirectAttributes rttr) {
			log.info("delete.do");
			log.info(vo);
			// 처리 결과에 대한 메시지 처리
			if(service.delete(vo) == 1) {
				rttr.addFlashAttribute("msg", "편의시설이 삭제 되었습니다.");
				return "redirect:list.do";
			}
			else {
				rttr.addFlashAttribute("msg",
						"편의시설이 삭제 되지 않았습니다.");
				return "redirect:list.do?no=" + vo.getAmenitiesNo();
			}
		}
		
	}
