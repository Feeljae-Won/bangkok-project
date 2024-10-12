package com.bangkok.airReservation.vo;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class AirReservationVO {

	// 국가 정보
	private String countryCode; // 국가 코드
	private String countryEng;  // 국가 영어 이름
	
	// 예약 정보
	private String id;           // 예약 ID
	private Long reservationNo;  // 예약 번호
	private String reservationLabel;
	private String email;        // 이메일
	private Long scheduleId_a;
	private Long scheduleId_d;
	private Long total_Price;    // 총 가격
	private Date booking_Date;    // 예약일
	private String paymentMethod; // 결제 방식
	private String status;       // 예약 상태
	private String flightName;   // 항공편 이름

	// 항공 예약에서 받아오는 정보
	private Long aPassenger; // 성인 승객 수
	private Long cPassenger; // 아동 승객 수
	private Long iPassenger; // 유아 승객 수

	// 첫번째 구간
	private String firstDeparture;  // 첫 출발지
	private String firstArrival;    // 첫 도착지
	private String secondDeparture; // 두 번째 출발지 (환승)
	private String secondArrival;   // 두 번째 도착지 (환승)
	private Date departureTime;     // 출발 시간
	private Date arrivalTime;       // 도착 시간
	private Long departPrice;       // 출발지 가격
	private Long arrivePrice;       // 도착지 가격
	private String duration;        // 비행 소요 시간
	private String seatClass;       // 좌석 클래스
	private String seatGrade;       // 좌석 등급
	private String seatIDs;         // 좌석 ID들
	private String type;            // 왕복 / 편도 여부

	private String passengerType;
	private Long passengerNo;
	private String firstName;
	private String lastName;
	private Date birth;
	private String nationality;
	private String passport_number;


	// 예약에 포함된 승객 수
	private int passenger_cnt;                // 승객 수
	
	// 예약 목록
	public List<AirReservationVO> list; // AirReservation 목록
}
