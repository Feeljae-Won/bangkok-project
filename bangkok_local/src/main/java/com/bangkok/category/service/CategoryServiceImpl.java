package com.bangkok.category.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import com.bangkok.category.mapper.CategoryMapper;
import com.bangkok.category.vo.CategoryVO;

import lombok.extern.log4j.Log4j;

//자동 생성을 위한 어노테이션
//- @Controller - url : HTML, @Service - 처리, @Repository - 데이터 저장, 
//@Component - 구성체, @RestController - url : data : ajax, @~Advice - 예외 처리
@Service
@Log4j
// Type이 같으면 식별할 수 있는 문자열 지정 - id를 지정
@Qualifier("categoryServiceImpl")
public class CategoryServiceImpl implements CategoryService{

	// 자동 DI 적용 - @Setter, @Autowired, @Inject
	@Inject
	private CategoryMapper mapper;
	
	// list
	@Override
	public List<CategoryVO> list(Integer cate_code1) {
		return mapper.list(cate_code1);
	}
	
	@Override
    public List<CategoryVO> getBigList() {
        List<CategoryVO> bigList = CategoryMapper.getBigList();
        if (bigList == null || bigList.isEmpty()) {
            log.info("Big category list is empty!");
        }
        return bigList;
    }
	

}