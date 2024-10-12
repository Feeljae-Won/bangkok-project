package com.bangkok.plan.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class PlanVO {

	// from. tripPlan
	private Long tno;
	private String tripThema;
	private String tripComment;
	@DateTimeFormat(pattern = "yyyy.MM.dd")
	private Date tripStartDate;
	@DateTimeFormat(pattern = "yyyy.MM.dd")
	private Date tripEndDate;
	private Long cityNum;
	private String email;
	// from. city T
	private String cityName;
	// from. country T
	private String countryKor; 
	
}
