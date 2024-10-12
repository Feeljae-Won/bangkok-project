package com.bangkok.event.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bangkok.Ecategory.mapper.EcategoryMapper;
import com.bangkok.event.vo.EcategoryVO;

import lombok.extern.log4j.Log4j;

//자동 생성을 위한 어노테이션
//- @Controller - url : HTML, @Service - 처리, @Repository - 데이터 저장, 
//@Component - 구성체, @RestController - url : data : ajax, @~Advice - 예외 처리
@Service
@Log4j
// Type이 같으면 식별할 수 있는 문자열 지정 - id를 지정
@Qualifier("EcategoryServiceImpl")
public class EcategoryServiceImpl implements EcategoryService{

	// 자동 DI 적용 - @Setter, @Autowired, @Inject
	@Inject
	private EcategoryMapper mapper;
	
	// 카테고리 리스트
	@Override
	public List<EcategoryVO> list(Integer categoryNo) {
		return mapper.list(categoryNo);
	}
	
	// 카테고리 등록
	@Override
	public Integer write(EcategoryVO vo) {
		// 카테로리 등록 - categoryNo이 있으면 중분류 등록, 없으면 대분류 등록
		if(vo.getCategoryNo() == 0) return mapper.writeBig(vo);
		return mapper.writeMid(vo);
	}
	
	// 카테고리 수정
	@Override
	public Integer update(EcategoryVO vo) {
		return mapper.update(vo);
	}
	
	// 카테고리 삭제
	@Override
	public Integer delete(EcategoryVO vo) {
		return mapper.delete(vo);
	}
	
}
