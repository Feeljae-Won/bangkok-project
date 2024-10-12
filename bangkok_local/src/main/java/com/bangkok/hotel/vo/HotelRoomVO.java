package com.bangkok.hotel.vo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class HotelRoomVO {

	private Long rno; // 객실 번호
	private Integer no; // 호텔 번호
	private String room_title; // 객실 이름
	private String room_type; // 객실 타입
	private Integer people; // 수용 인원
	private Long price; // 가격
	private Integer room_number; // 객실 개수
	private String room_image_name; // 객실 이미지 사진
	private String room_content; // 객실 소개
	
	private List<HotelRoomVO> list;
	ArrayList<MultipartFile> roomImage;
	ArrayList<String> room_image_names;
}
