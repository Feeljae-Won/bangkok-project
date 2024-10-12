package com.bangkok.air.vo;

import lombok.Data;

@Data
public class AirlineVO {
	
	private String email;
	private String photo;
	private String airlineKor;
	private String airlineEng;
	private String countryCode;
	private String countryKor;
	private Long airlineNo;
	private Long routes;
	private Long flights;
	private Long preSchedule;
	private Long endSchedule;
	private Long todaySchedule;
	private Long allSchedule;

}
