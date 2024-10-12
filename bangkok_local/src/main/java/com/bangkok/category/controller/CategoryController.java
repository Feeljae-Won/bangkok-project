package com.bangkok.category.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.bangkok.category.service.CategoryService;
import com.bangkok.category.vo.CategoryVO;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/category")
@Log4j
public class CategoryController {

	// @Autowired- Springframework에 있다!
	@Autowired
	// 자동 DI. type이 2~3개 이상되면 안 됨
	//@Setter(onMethod_ =  @Autowired) - error 발생!
	// type이 같으면 식별할 수 있는 문자열을 지정해서 사용 - id를 지정한 것과 동일
	@Qualifier("categoryServiceImpl")
	// categoryService를 categoryServiceImpl를 상속받아서 찾을 수 없다는 오류 발생
	private CategoryService service;
	
	
	// request의 get 방식
	// void도 가능하지만, uri와 jsp 정보가 동일해야함
	@GetMapping("/list.do")
		
	//public String list(HttpServletRequest request) {
	 public String list(@RequestParam(defaultValue = "0")
	 Integer cate_code1, Model model) { // cate_code1를 받. 넘어오는 데이터가 없으면 0으로 세팅
		
		// 대분류 가져오기. 0이어야 가져올 수 있다...
		List<CategoryVO> bigList = service.list(0);
		
		// cate_code1이 없으면 code1 중에서 가장 적은 것을 가져와서 처리
		// code1이 제일 작은걸... bigList - index 번호가 제일 작은것이 1
		if(cate_code1 == 0 && (bigList != null && bigList.size() !=0))
			cate_code1 = bigList.get(0).getCate_code1(); // 첫 번째 데이터에 code1을 가져와서 처리
		
		
		// model에 담으면 request에 자동으로 담기게 됨 - 처리된 데이터를 Model에 저장
		model.addAttribute("bigList", bigList);
		
	model.addAttribute("cate_code1", cate_code1);
		
		return "category/list"; // return을 jsp로 받아서 처리
		
	}
	    
	}
