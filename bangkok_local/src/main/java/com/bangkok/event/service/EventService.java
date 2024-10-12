package com.bangkok.event.service;

import java.util.List;

import com.bangkok.event.vo.EventVO;
import com.bangkok.util.page.PageObject;



public interface EventService {

	// 이벤트 리스트
	public List<EventVO> list(PageObject pageObject);
	public List<EventVO> listEvent();
	
	// 이벤트 글보기
	public EventVO view(Long eventNo);
	
	// 이벤트 글등록
	public Integer write(EventVO vo);
	
	// 이벤트 글수정
	public Integer update(EventVO vo);
	
	// 이벤트 글삭제
	public Integer delete(EventVO vo);
	
	public List<EventVO> hotelList();
	public List<EventVO> tripList();
}
