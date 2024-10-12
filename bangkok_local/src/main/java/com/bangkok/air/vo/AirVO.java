package com.bangkok.air.vo;

import lombok.Data;

@Data
public class AirVO {
	
	private Long rnum;
	
	// 국가 코드
	private String country;
	private String countryCode;
	private String countryKor;
	private String countryEng;
	private String pan;
	
	// 공항 코드
	private String airportCode;
	private String airportEng;
	private String airportKor;
	private Integer airportCnt;
	
	// 항공사
	private String email; // 항공사 ID
	private Long airlineNo; // 항공사 고유번호
	private String airlineKor;
	private String airlineEng;
	private String photo;
	private String nickName;
	private Long gradeNo;
	
	// 항공기
	private String airplaneId; // 비행기 모델명
	private String airplanePdt; // 비행기 제조사
	private Long seatCapacity; // 좌석 총 개수
	private Long seatX; // 열 좌석수
	private Long seatY; // 행 좌석수
	
	// 항공기 옵션
	private String flightName; // 편명
	private Long ecoCnt; // 이코노미 수
	private Long prEcoCnt; // 프리미엄 이코노미 수
	private Long bisCnt; // 비즈니스 수
	private Long fstCnt; // 퍼스트 수
	
	// 운항 노선
	private Long routeId; // 노선 고유 번호
	private String departure; // 출발지
	private String departureCountry; // 출발 국가
	private String departureKor;
	private String arrival; // 도착지
	private String arrivalCountry; // 도착 국가
	private String arrivalKor;
	private String type; // 국내 D, 국외 I
	private double distance; // 운항 거리
	
	// 운항 요금
	private Long priceId; // 가격 고유 번호
	private Long basePrice; // 기본 운임
	private Long tax; // 세금
	private Long fuelSurCharge; // 유류할증료
	private Long bookingFee; // 발권 수수료
	private Long totalPrice;
	
	// 운항 스케줄
	private Long scheduleId; // 스케줄 고유 번호
	private String departureTime; // 출발 날짜
	private String arrivalTime; // 도착 날짜
	private String duration; // 소요 시간
	private String status; // 현재 운항 상태 - '운항' , '미운항'
	

}
