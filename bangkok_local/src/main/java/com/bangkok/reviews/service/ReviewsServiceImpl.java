package com.bangkok.reviews.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bangkok.reviews.mapper.ReviewsMapper;
import com.bangkok.reviews.vo.ReviewsVO;
import com.bangkok.util.page.PageObject;

import lombok.extern.log4j.Log4j;

//자동 생성을 위한 어노테이션
//- @Controller - url : HTML, @Service - 처리, @Repository - 데이터 저장, 
//@Component - 구성체, @RestController - url : data : ajax, @~Advice - 예외 처리
@Service
@Log4j
// Type이 같으면 식별할 수 있는 문자열 지정 - id를 지정
@Qualifier("reviewsServiceImpl")
public class ReviewsServiceImpl implements ReviewsService{

	// 자동 DI 적용 - @Setter, @Autowired, @Inject
	@Inject
	private ReviewsMapper mapper;
	
	// 리뷰 리스트
	@Override
	public List<ReviewsVO> list(PageObject pageObject) {
		log.info("list() 실행");
		// 전체 데이터 개수 구하기
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}
	
	// 리뷰 보기
	@Override
	public ReviewsVO  view(Long reservations_no) {
		log.info("view() 실행");
		return mapper.view(reservations_no);
	}
	
	// 리뷰 등록
	@Override
	public Integer write(ReviewsVO vo) {
        String hasReview = mapper.getHasReview(vo.getReservations_no());
        
        // has_review 값이 'Y'일 경우에만 리뷰를 등록합니다.
        if ("Y".equals(hasReview)) {
            return mapper.write(vo);
        } else {
            // 조건에 맞지 않는 경우 처리 (예: 예외를 던지거나, 특정 값 반환)
            // 예를 들어, 0을 반환하거나 예외를 던질 수 있습니다.
            return 0;
        }
	}
	
	// 리뷰 수정
	@Override
	public Integer update(ReviewsVO vo) {
		log.info(vo);
		return mapper.update(vo);
	}
	
	// 리뷰 삭제
	@Override
	public Integer delete(ReviewsVO vo) {
		log.info(vo);
		return mapper.delete(vo);
	}
	//리뷰 등록 여부 확인
	@Override
	public Integer hasReview(ReviewsVO vo) {
		// TODO Auto-generated method stub
		return mapper.hasReview(vo);
	}

	@Override
	public Integer hasReviewMinus(ReviewsVO vo) {
		// TODO Auto-generated method stub
		return mapper.hasReviewMinus(vo);
	}
}
