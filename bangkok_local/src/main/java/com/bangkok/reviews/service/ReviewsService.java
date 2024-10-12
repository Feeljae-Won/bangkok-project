package com.bangkok.reviews.service;

import java.util.List;

import com.bangkok.reviews.vo.ReviewsVO;
import com.bangkok.util.page.PageObject;



public interface ReviewsService {

	// 리뷰 리스트
	public List<ReviewsVO> list(PageObject pageObject);
	
	// 리뷰 글보기
	public ReviewsVO view(Long reservations_no);
	
	// 리뷰 글등록
	public Integer write(ReviewsVO vo);
	
	// 리뷰 글수정
	public Integer update(ReviewsVO vo);
	
	// 리뷰 글삭제
	public Integer delete(ReviewsVO vo);
	// 리뷰 등록 여부 확인
	public Integer hasReview(ReviewsVO vo);
	public Integer hasReviewMinus(ReviewsVO vo);
	
}
