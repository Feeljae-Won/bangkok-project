package com.bangkok.hotel_reservations.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bangkok.hotel_reservations.mapper.Hotel_reservationsMapper;
import com.bangkok.hotel_reservations.vo.Hotel_reservationsVO;
import com.bangkok.util.page.PageObject;

import lombok.extern.log4j.Log4j;

//자동 생성을 위한 어노테이션
//- @Controller - url : HTML, @Service - 처리, @Repository - 데이터 저장, 
//@Component - 구성체, @RestController - url : data : ajax, @~Advice - 예외 처리
@Service
@Log4j
// Type이 같으면 식별할 수 있는 문자열 지정 - id를 지정
@Qualifier("hotel_reservatiServiceImpl")
public class Hotel_reservationsServiceImpl implements Hotel_reservationsService{

	// 자동 DI 적용 - @Setter, @Autowired, @Inject
	@Inject
	private Hotel_reservationsMapper mapper;
	
	// 호텔 예약 리스트 상태(예약완료,미 입실, 입실 전)
	@Override
	public List<Hotel_reservationsVO> list(String email) {
		log.info("list() 실행");
		return mapper.list(email);
	}
	// 호텔 예약 리스트 상태(취소,입실 완료)
	@Override
	public List<Hotel_reservationsVO> listCompletion(String email) {
		// TODO Auto-generated method stub
		log.info("list() 실행");
		return mapper.listCompletion(email);
	}
	
	// 호텔 예약 보기
	@Override
	public Hotel_reservationsVO view(Long reservation_no) {
		log.info("view() 실행");
		return mapper.view(reservation_no);
	}
	
	// 호텔 예약 등록
	@Override
	public Integer write(Hotel_reservationsVO vo) {
		return mapper.write(vo);
	}
	
	// 호텔 예약 수정
	@Override
	public Integer update(Hotel_reservationsVO vo) {
		log.info(vo);
		return mapper.update(vo);
	}
	
	// 호텔 예약 삭제
	@Override
	public Integer delete(Hotel_reservationsVO vo) {
		log.info(vo);
		return mapper.delete(vo);
	}

	@Override
	public Hotel_reservationsVO hotel(Hotel_reservationsVO vo) {
		// TODO Auto-generated method stub
		return mapper.hotel(vo);
	}


	@Override
	public Integer increase(Integer rno) {
		// TODO Auto-generated method stub
		return mapper.increase(rno);
	}


	@Override
	public Integer decrease(Integer rno) {
		// TODO Auto-generated method stub
		return mapper.decrease(rno);
	}
	@Override
	public Hotel_reservationsVO check(String email) {
		// TODO Auto-generated method stub
		return mapper.check(email);
	}




}
