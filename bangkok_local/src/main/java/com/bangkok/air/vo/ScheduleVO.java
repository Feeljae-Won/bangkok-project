package com.bangkok.air.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class ScheduleVO {
	
	private Long airlineNo;
	private Long routeId;
	private String flightName;
	
	private boolean repeat;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate;
	private Long repeatDays;
	
	private String departureDate;
	private String departureTimeStr;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date departureTime;
	private String arrivalDate;
	private String arrivalTimeStr;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date arrivalTime;
	private String durationStr;
	private Long duration;
	
	private List<ScheduleVO> list;

	

}
