package com.bangkok.reviews.vo;

import lombok.Data;

@Data
public class ReviewsVO {
	//DB에 있는 데이터 
	private Long reviewNo; //후기 번호
	private Integer service_Rating; //서비스,친절도 별점
	private Integer cleanliness_Rating;//호텔,객실 청결도 별점
	private Integer convenience_Rating;//시설,편의성 별점
	private Integer Amenities_Rating;//비품,용품 별점
	private String reviewContent;//리뷰 내용
	private String reviewDate; // 리뷰 작성 일
	private Long reservations_no; //예약 번호
	private String reviewTitle; // 리뷰 제목
	private String has_review; // 리뷰 확인
	private String title; // 호텔명
	private String room_type; // 객실명
	//좋아요 DB 테이블
	private String email;//아이디 내용
	
}
