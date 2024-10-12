package com.bangkok.event.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
// import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bangkok.event.service.EcategoryService;
import com.bangkok.event.service.EventService;
import com.bangkok.event.vo.EcategoryVO;
import com.bangkok.event.vo.EventVO;
import com.bangkok.util.file.FileUtil;
import com.bangkok.util.page.PageObject;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/event")
@Log4j
public class EventController {

	// 자동 DI
	// @Setter(onMethod_ = @Autowired)
	// Type이 같으면 식별할 수 있는 문자열 지정 - id를 지정
	@Autowired
	@Qualifier("eventServiceImpl")
	private EventService service;
	
	@Autowired
	@Qualifier("EcategoryServiceImpl")
	private EcategoryService Categoryservice;
	
	//--- 이벤트 리스트 ------------------------------------
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
		if(strPerPageNum == null  || strPerPageNum.equals("") )
			pageObject.setPerPageNum(12);
		
		// 대분류 가져오기.
		List<EcategoryVO> bigList = Categoryservice.list(0);
		// cate_code1이 없으면 cate_code1 중에서 제일 작은것 가져와서 처리
		if(categoryNo == 0 && (bigList != null && bigList.size() != 0))
			categoryNo = bigList.get(0).getCategoryNo();	
		// model에 담으로 request에 자동을 담기게 된다. - 처리된 데이터를 Model에 저장
		model.addAttribute("bigList", bigList);
		model.addAttribute("list", service.list(pageObject));
		log.info(pageObject);
		model.addAttribute("pageObject", pageObject);
		return "event/list";
	}
	@GetMapping("/listEvent.do")
	// public ModelAndView list(Model model) {
	public String list(Model model)
			 {
		
		model.addAttribute("list", service.listEvent());
		return "event/listEvent";
	}
	
	//--- 이벤트 보기 ------------------------------------
	@GetMapping("/view.do")
	public String view(Model model, Long eventNo) {
		log.info("view.do");
		log.info(eventNo);
		
		model.addAttribute("vo", service.view(eventNo));
		
		return "event/view";
	}
	
	//--- 이벤트 등록 폼 ------------------------------------
	@GetMapping("/writeForm.do")
	public String writeForm() {
		log.info("writeForm.do");
		return "event/writeForm";
	}
	
	//--- 이벤트 등록 처리 ------------------------------------
	@PostMapping("/write.do")
	public String write(EventVO vo, RedirectAttributes rttr, @RequestParam ArrayList<MultipartFile> files,
			HttpServletRequest request) throws Exception {
		log.info("write.do");
		String path = "/upload/event";
		for(MultipartFile file : files) {
			log.info("---------------------------------------------------");
			log.info("name : " +file.getOriginalFilename());
			log.info("size : " +file.getSize());
			// file upload
			String add=(FileUtil.upload(path, file, request));
			if(vo.getImage() ==null)
			vo.setImage(add);
			
			vo.setSub_image(add);
		}
		service.write(vo);
		
		// 처리 결과에 대한 메시지 처리
		rttr.addFlashAttribute("msg", "이벤트가 정상 등록되었습니다.");
		
		return "redirect:list.do";
	}
	
	//--- 이벤트 수정 폼 ------------------------------------
	@GetMapping("/updateForm.do")
	public String updateForm(Long no, Model model ) throws Exception {
		log.info("updateForm.do");
		model.addAttribute("vo", service.view(no));
		return "event/updateForm";
	}
	
	//--- 이벤트 수정 처리 ------------------------------------
	@PostMapping("/update.do")
	public String update(EventVO vo, RedirectAttributes rttr, @RequestParam ArrayList<MultipartFile> files,
			HttpServletRequest request) throws Exception {
		log.info("update.do");
		String path = "/upload/event";
		for(MultipartFile file : files) {
			log.info("---------------------------------------------------");
			log.info("name : " +file.getOriginalFilename());
			log.info("size : " +file.getSize());
			// file upload
			String add=(FileUtil.upload(path, file, request));
			if(vo.getImage() ==null)
			vo.setImage(add);
			
			vo.setSub_image(add);
		}
		service.update(vo);
		PageObject pageObject = PageObject.getInstance(request);
		rttr.addFlashAttribute("msg", "이벤트 수정이 되었습니다.");
		return "redirect:view.do?eventNo=" + vo.getEventNo()+"&"+pageObject.getPageQuery();
	}
	
	
	//--- 이벤트 삭제 처리 ------------------------------------
	@GetMapping("/delete.do")
	public String delete(EventVO vo, RedirectAttributes rttr) {
		log.info("delete.do");
		// 처리 결과에 대한 메시지 처리
		if(service.delete(vo) == 1) {
			rttr.addFlashAttribute("msg", vo.getEventNo()+"번 이벤트가 삭제가 되었습니다."); 
			return "redirect:list.do";
		}
		else {
			rttr.addFlashAttribute("msg",
					"이벤트 글삭제가 되지 않았습니다. ");
			return "redirect:view.do?no=" + vo.getEventNo();
		}
	}
	@PostMapping("/categoryWrite.do")
	public String categoryWrite(EcategoryVO vo, RedirectAttributes rttr) {
		log.info(vo);
		Categoryservice.write(vo);
		
		// 처리 결과에 대한 메시지 처리
		rttr.addFlashAttribute("msg", "카테고리 등록이 되었습니다.");
		
		return "redirect:list.do?getCategoryNo=" + vo.getCategoryNo();
	}
	//--- 카테고리 글수정 처리 ------------------------------------
	@PostMapping("/categoryUpdate.do")
	public String categoryUpdate(EcategoryVO vo, RedirectAttributes rttr) {
		log.info("vo입니다 : "+vo);
		if(Categoryservice.update(vo) == 1)
			// 처리 결과에 대한 메시지 처리
			rttr.addFlashAttribute("msg", "카테고리 수정이 되었습니다.");
		else
			rttr.addFlashAttribute("msg",
					"카테고리 수정이 되지 않았습니다.");
		
		return "redirect:list.do?getCategoryNo=" + vo.getCategoryNo();
	}	
	//--- 카테고리 글삭제 처리 ------------------------------------
	@PostMapping("/categoryDelete.do")
	public String categoryDelete(EcategoryVO vo, RedirectAttributes rttr) {
		log.info("vo입니다 : "+vo);
		// 처리 결과에 대한 메시지 처리
		if(Categoryservice.delete(vo) >= 1) {
			rttr.addFlashAttribute("msg", "카테고리가 삭제되었습니다.");
		}
		else {
			rttr.addFlashAttribute("msg",
					"카테고리가 삭제되지 않았습니다.");
		}
		return "redirect:list.do"; 
	}
}
