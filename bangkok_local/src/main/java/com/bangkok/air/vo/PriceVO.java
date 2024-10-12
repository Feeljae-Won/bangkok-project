package com.bangkok.air.vo;

import lombok.Data;

@Data
public class PriceVO {

	private Long priceId;
	private Long routeId;
	private Long basePrice;
	private Long tax;
	private Long fuelSurCharge;
	private Long bookingFee;
	private Long airlineNo;
	private double distance;
}
