package com.bangkok.Ecategory.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bangkok.event.vo.EcategoryVO;

@Repository
public interface EcategoryMapper {

	// 카테고리 리스트
	public List<EcategoryVO> list(@Param("categoryNo") Integer categoryNo);
	
	// 대분류 등록
	public Integer writeBig(EcategoryVO vo);
	
	// 중분류 등록
	public Integer writeMid(EcategoryVO vo);
	
	// 수정
	public Integer update(EcategoryVO vo);
	
	// 삭제
	public Integer delete(EcategoryVO vo);
	
}
