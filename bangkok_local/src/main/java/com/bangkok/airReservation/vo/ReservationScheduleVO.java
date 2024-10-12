package com.bangkok.airReservation.vo;

import java.util.List;

import lombok.Data;

@Data
public class ReservationScheduleVO {
	
	private Long reservationNo;
	private List<Long> scheduleID;    // 스케줄 ID
	

}
