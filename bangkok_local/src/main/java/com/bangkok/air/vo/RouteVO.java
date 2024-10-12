package com.bangkok.air.vo;

import lombok.Data;

@Data
public class RouteVO {

	private Long routeId;
	private String departure;
	private String arrival;
	private double distance;
	private String type;
	private String goBackStr;
	
	private Long airlineNo;
	
}
