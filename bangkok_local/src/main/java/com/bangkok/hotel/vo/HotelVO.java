package com.bangkok.hotel.vo;

import lombok.Data;

@Data
public class HotelVO {

	private Integer no; // 호텔 번호
	private String title; // 호텔명
	private Integer rating; // 호텔 등급
	private String content; // 호텔 소개
	private String tel; // 호텔 번호
	private String notice; // 호텔 공지사항
	private String address; // 호텔 주소
	private String accommodations; // 국내, 해외 숙소 구분
	private String image_name; // 호텔 사진
	private Long price; // 호텔 가격
	private String detail_image_name; // 호텔 상세보기 이동시 바로 보여지는 사진
	private Long hit; // 조회수
	private Long amenitiesNo; // 편의시설 번호
	private String amenitiesName; // 편의시설 네임
	
}
