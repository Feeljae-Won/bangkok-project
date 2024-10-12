package com.bangkok.reviews.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
// import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bangkok.reviews.service.ReviewsService;
import com.bangkok.reviews.vo.ReviewsVO;
import com.bangkok.util.file.FileUtil;
import com.bangkok.util.page.PageObject;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/reviews")
@Log4j
public class ReviewsController {

	// 자동 DI
	// @Setter(onMethod_ = @Autowired)
	// Type이 같으면 식별할 수 있는 문자열 지정 - id를 지정
	@Autowired
	@Qualifier("reviewsServiceImpl")
	private ReviewsService service;
	
	//--- 리뷰 리스트 ------------------------------------
	@GetMapping("/list.do")
	// public ModelAndView list(Model model) {
	public String list(Model model, HttpServletRequest request,@RequestParam(defaultValue = "0") Integer categoryNo)
			throws Exception {
	//	public String list(HttpServletRequest request) {
		log.info("list.do");
		// request.setAttribute("list", service.list());
		
		// 페이지 처리를 위한 객체 생겅
		PageObject pageObject = PageObject.getInstance(request);
		String strPerPageNum = request.getParameter("perPageNum");
//		if(strPerPageNum == null  || strPerPageNum.equals("") )
//			pageObject.setPerPageNum(12);
		// model에 담으로 request에 자동을 담기게 된다. - 처리된 데이터를 Model에 저장
		model.addAttribute("list", service.list(pageObject));
		log.info(pageObject);
		model.addAttribute("pageObject", pageObject);
		return "rivews/list";
	}
	
	// --- 리뷰 보기 ------------------------------------
	@GetMapping("/view.do")
	@ResponseBody
	public ResponseEntity<?> view(@RequestParam("reservations_no") Long reservationsNo) {
	    log.info("view.do");

	    // 서비스에서 데이터를 가져옴
	    ReviewsVO reviewVO = service.view(reservationsNo);

	    // 데이터를 JSON 형식으로 반환
	    return ResponseEntity.ok(reviewVO);
	}
	
	//--- 리뷰 등록 처리 ------------------------------------
	@PostMapping("/write.do")
	public String write(ReviewsVO vo, RedirectAttributes rttr){
		log.info("write.do");
		int result = service.write(vo);
		log.info(vo);
		
		service.hasReview(vo);
		// 처리 결과에 대한 메시지 처리
		if(result == 1) {
			rttr.addFlashAttribute("msg", "리뷰가 정상 등록되었습니다."); 
			return "redirect:/hotel_reservations/list.do";
		}
		else {
			rttr.addFlashAttribute("msg",
					"리뷰는 한 번만 등록할 수 있습니다. ");
			return "redirect:/hotel_reservations/list.do";
		}		
	}
	
	//--- 리뷰 수정 폼 ------------------------------------
	@GetMapping("/updateForm.do")
	public String updateForm(Long no, Model model ) throws Exception {
		log.info("updateForm.do");
		model.addAttribute("vo", service.view(no));
		return "rivews/updateForm";
	}
	
	//--- 리뷰 수정 처리 ------------------------------------
	@PostMapping("/update.do")
	public String update(ReviewsVO vo, RedirectAttributes rttr, @RequestParam ArrayList<MultipartFile> files,
			HttpServletRequest request) throws Exception {
		log.info("update.do");
		String path = "/upload/rivews";
		for(MultipartFile file : files) {
			log.info("---------------------------------------------------");
			log.info("name : " +file.getOriginalFilename());
			log.info("size : " +file.getSize());
			// file upload
			String add=(FileUtil.upload(path, file, request));
//			if(vo.getImage() ==null)
//			vo.setImage(add);
//			
//			vo.setSub_image(add);
		}
		service.update(vo);
		PageObject pageObject = PageObject.getInstance(request);
		rttr.addFlashAttribute("msg", "리뷰 수정이 되었습니다.");
		return null; //"redirect:view.do?rivewsNo=" + vo.getEventNo()+"&"+pageObject.getPageQuery();
	}
	
	
	//--- 리뷰 삭제 처리 ------------------------------------
	@GetMapping("/delete.do")
	public String delete(ReviewsVO vo, RedirectAttributes rttr) {
		log.info("delete.do");
		// 처리 결과에 대한 메시지 처리
		service.hasReviewMinus(vo);
		if(service.delete(vo) == 1) {
			rttr.addFlashAttribute("msg", vo.getReservations_no()+"번 리뷰가 삭제가 되었습니다."); 
			return "redirect:/hotel_reservations/list.do";
		}
		else {
			rttr.addFlashAttribute("msg",
					"리뷰가 삭제 되지 않았습니다. ");
			return "redirect:/hotel_reservations/list.do";
		}
	}
}
