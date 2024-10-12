package com.bangkok.amenities.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bangkok.amenities.vo.AmenitiesVO;
import com.bangkok.util.page.PageObject;

@Repository
public interface AmenitiesMapper {

	// 편의시설 리스트
		public List<AmenitiesVO> list();
		
		// 편의시설 등록
		public Integer write(AmenitiesVO vo);
		
		// 편의시설 수정
		public Integer update(AmenitiesVO vo);
		
		// 편의시설 삭제
		public Integer delete(AmenitiesVO vo);
}
