package com.bangkok.info.controller;

import java.util.List;
import javax.inject.Inject;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.bangkok.category.service.CategoryService;
import com.bangkok.category.vo.CategoryVO;
import com.bangkok.info.controller.InfoController;
import com.bangkok.info.service.InfoService;
import com.bangkok.info.vo.InfoImageVO;
import com.bangkok.info.vo.InfoVO;
import com.bangkok.util.page.PageObject;
import lombok.extern.log4j.Log4j;

	
	@Controller
	@Log4j
	@RequestMapping("/info")
	public class InfoController {
		

		private static final ServletRequest request = null;
		@Inject
		@Qualifier("infoServiceImpl")
		private InfoService service;
		@Autowired
		// 자동 DI. type이 2~3개 이상되면 안 됨
		//@Setter(onMethod_ =  @Autowired) - error 발생!
		// type이 같으면 식별할 수 있는 문자열을 지정해서 사용 - id를 지정한 것과 동일
		@Qualifier("categoryServiceImpl")
		// categoryService를 categoryServiceImpl를 상속받아서 찾을 수 없다는 오류 발생
		private CategoryService cate_service;
		private String path;
		
		@GetMapping("/list.do")
		public String list(Model model, HttpServletRequest request, String cityname, String countrycode
				, String filename) throws Exception {
		    PageObject pageObject = PageObject.getInstance(request);
		    model.addAttribute("list", service.list(pageObject, cityname, countrycode, filename));
		    model.addAttribute("pageObject", pageObject);
		    return "info/list";
		}


		@GetMapping("/view.do")
		public String view(Model model, Long no, @RequestParam(defaultValue = "0")
		 Integer cate_code1) {
		    InfoVO vo = service.view(no);
		    List<InfoImageVO> imageList = service.ImageList(no);
		    
		    	List<CategoryVO> bigList = cate_service.list(0);
			
			// cate_code1이 없으면 code1 중에서 가장 적은 것을 가져와서 처리
			// code1이 제일 작은걸... bigList - index 번호가 제일 작은것이 1
			if(cate_code1 == 0 && (bigList != null && bigList.size() !=0))
				cate_code1 = bigList.get(0).getCate_code1(); // 첫 번째 데이터에 code1을 가져와서 처리


		    log.info("Category Name: " + vo.getCate_name());
		    model.addAttribute("vo", vo);
		    model.addAttribute("imageList", imageList);
		    model.addAttribute("bigList", bigList);
		    return "info/view";
		}


}
