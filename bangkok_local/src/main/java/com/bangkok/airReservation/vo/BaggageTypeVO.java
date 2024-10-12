package com.bangkok.airReservation.vo;

import lombok.Data;

@Data
public class BaggageTypeVO {
	
	private Long baggageTypeID;
	private String description;
	private String baggage_Type;
	private Long maxweight;
	private Long price;
	
	private Long exampleID;
	private String exampleName;
	private String example_description;
	
	
}
