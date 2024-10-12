package com.bangkok.hotel_reservations.service;

import java.util.List;

import com.bangkok.hotel_reservations.vo.Hotel_reservationsVO;



public interface Hotel_reservationsService {

	// 호텔 예약 리스트 상태(예약완료,미 입실, 입실 전)
	public List<Hotel_reservationsVO> list(String email);
	//사업자 리스트 
//	public List<Hotel_reservationsVO> Business(String email);
	//사업자 관리 체크 
	public Hotel_reservationsVO check(String email);
	
	// 호텔 예약 리스트 상태(취소,입실 완료)
	public List<Hotel_reservationsVO> listCompletion(String email);
	
	// 호텔 예약글보기
	public Hotel_reservationsVO view(Long reservation_no);
	
	// 호텔 예약글등록
	public Integer write(Hotel_reservationsVO vo);
	
	// 호텔 예약글수정
	public Integer update(Hotel_reservationsVO vo);
	
	// 호텔 예약글삭제
	public Integer delete(Hotel_reservationsVO vo);
	
	//호텔 예약 등록 정보 가지고 오기 
	public Hotel_reservationsVO hotel(Hotel_reservationsVO vo);
	
	//호텔 객실 수 증가 
	public Integer increase (Integer rno);
	//호텔 객실 수 차감
	public Integer decrease (Integer rno);
}
