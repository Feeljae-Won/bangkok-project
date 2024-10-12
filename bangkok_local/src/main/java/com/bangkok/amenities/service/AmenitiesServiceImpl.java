package com.bangkok.amenities.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bangkok.amenities.mapper.AmenitiesMapper;
import com.bangkok.amenities.vo.AmenitiesVO;
import com.bangkok.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("amenitiesServiceImpl")
public class AmenitiesServiceImpl implements AmenitiesService{
	
	// 자동 DI 적용 - @Setter, @Autowired, @Inject
		@Inject
		private AmenitiesMapper mapper;
		
		// 편의시설 리스트
		@Override
		public List<AmenitiesVO> list() {
			log.info("list() 실행");
			// 전체 데이터 개수 구하기
			return mapper.list();
		}
		
		// 편의시설 등록
		@Override
		public Integer write(AmenitiesVO vo) {
			Integer result = mapper.write(vo); // 편의시설 번호를 시퀀스에서 새로운 번호 사용
			return result;
		}
		
		// 편의시설 수정
		@Override
		public Integer update(AmenitiesVO vo) {
			log.info(vo);
			return mapper.update(vo);
		}
		
		// 편의시설 삭제
		@Override
		public Integer delete(AmenitiesVO vo) {
			log.info(vo);
			return mapper.delete(vo);
		}
}
