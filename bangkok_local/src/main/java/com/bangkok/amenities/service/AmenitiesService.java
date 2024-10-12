package com.bangkok.amenities.service;

import java.util.List;

import com.bangkok.amenities.vo.AmenitiesVO;
import com.bangkok.util.page.PageObject;

public interface AmenitiesService {

	// 편의시설 리스트
		public List<AmenitiesVO> list();
		
		// 편의시설 등록 - cate_code1이 있으면 중분류 등록, 없으면 대분류 등록
		public Integer write(AmenitiesVO vo);
		
		// 편의시설 수정
		public Integer update(AmenitiesVO vo);
		
		// 편의시설 삭제
		public Integer delete(AmenitiesVO vo);
}
