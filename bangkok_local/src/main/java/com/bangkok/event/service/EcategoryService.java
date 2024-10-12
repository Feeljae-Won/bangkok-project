package com.bangkok.event.service;

import java.util.List;

import com.bangkok.event.vo.EcategoryVO;


public interface EcategoryService {

	// 카테로리 리스트
	public List<EcategoryVO> list(Integer categoryNo);
	
	// 카테로리 등록 - cate_code1이 있으면 중분류 등록, 없으면 대분류 등록
	public Integer write(EcategoryVO vo);
	
	// 카테로리 수정
	public Integer update(EcategoryVO vo);
	
	// 카테로리 삭제
	public Integer delete(EcategoryVO vo);
	
}
