package com.bangkok.airReservation.vo;

import lombok.Data;

@Data
public class SeatVO {
	private Long seatNo;
    private String flightName;
    private String seatID;
    private Long seatRow;
    private Long seatCol;
    private Long classNo;
    private Long passengerNo;
    private Long passengerCount;
}
