package com.bangkok.hotel.vo;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class RoomImageVO {

	private Integer room_image_no; // 객실 이미지 번호
	private Long rno; // 객실 번호
	private Integer no;
	private String room_image_name; // 객실 이미지 이름
	
	ArrayList<MultipartFile> roomImage;
}
