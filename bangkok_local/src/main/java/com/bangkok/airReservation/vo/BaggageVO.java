package com.bangkok.airReservation.vo;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class BaggageVO {
		
	private Long reservationNo;
	private Long passengerNo;
	private Long baggageTypeID;
	private Long baggageNo;
	private String description;
	private Integer baggage_weight;
	
	private int cnt;
	
	public List<BaggageVO> baggages;
	

}
