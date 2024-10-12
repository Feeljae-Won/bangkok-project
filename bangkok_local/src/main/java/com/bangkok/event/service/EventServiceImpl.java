package com.bangkok.event.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bangkok.event.mapper.EventMapper;
import com.bangkok.event.vo.EventVO;
import com.bangkok.util.page.PageObject;

import lombok.extern.log4j.Log4j;

//자동 생성을 위한 어노테이션
//- @Controller - url : HTML, @Service - 처리, @Repository - 데이터 저장, 
//@Component - 구성체, @RestController - url : data : ajax, @~Advice - 예외 처리
@Service
@Log4j
// Type이 같으면 식별할 수 있는 문자열 지정 - id를 지정
@Qualifier("eventServiceImpl")
public class EventServiceImpl implements EventService{

	// 자동 DI 적용 - @Setter, @Autowired, @Inject
	@Inject
	private EventMapper mapper;
	
	// 이벤트 리스트
	@Override
	public List<EventVO> list(PageObject pageObject) {
		log.info("list() 실행");
		// 전체 데이터 개수 구하기
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}
	
	// 이벤트 보기
	@Override
	public EventVO view(Long eventNo) {
		log.info("view() 실행");
		return mapper.view(eventNo);
	}
	
	// 이벤트 등록
	@Override
	public Integer write(EventVO vo) {
		return mapper.write(vo);
	}
	
	// 이벤트 수정
	@Override
	public Integer update(EventVO vo) {
		log.info(vo);
		return mapper.update(vo);
	}
	
	// 이벤트 삭제
	@Override
	public Integer delete(EventVO vo) {
		log.info(vo);
		return mapper.delete(vo);
	}

	@Override
	public List<EventVO> hotelList() {
		// TODO Auto-generated method stub
		return mapper.hotelList();
	}

	@Override
	public List<EventVO> tripList() {
		// TODO Auto-generated method stub
		return mapper.tripList();
	}

	@Override
	public List<EventVO> listEvent() {
		// TODO Auto-generated method stub
		return mapper.listEvent();
	}
}
