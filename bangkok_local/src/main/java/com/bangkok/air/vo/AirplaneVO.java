package com.bangkok.air.vo;

import java.util.List;

import lombok.Data;

@Data
public class AirplaneVO {

	private Long airlineNo;
	private String airplaneId;
	private String airplanePdt;
	private String flightName;
	private int seatCapacity;
	private int seatX;
	private int seatY;
	
	private int ecoCnt;
	private int prEcoCnt;
	private int bisCnt;
	private int fstCnt;
	
	private List<AirplaneVO> list;
	
}
