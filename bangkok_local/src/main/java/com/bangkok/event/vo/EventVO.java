package com.bangkok.event.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class EventVO {
	//DB에 있는 데이터 
	private Long eventNo; //이벤트 번호 
	private String image; //이벤트 사진
	private String sub_image; //이벤트 사진
	private String title; //이벤트 제목
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDay;  // 이벤트 시작일
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDay;  // 이벤트 종료일 
	
	
	private String category;  // 이벤트 종류

	
}
