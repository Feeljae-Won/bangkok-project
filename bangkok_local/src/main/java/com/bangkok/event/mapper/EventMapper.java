package com.bangkok.event.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bangkok.event.vo.EventVO;
import com.bangkok.util.page.PageObject;

@Repository
public interface EventMapper {

	// 이벤트 리스트
	public List<EventVO> list(PageObject pageObject);
	
	// 이벤트 리스트 페이지 처리를 위한 전체 데이터 개수
	public Long getTotalRow(PageObject pageObject);
	
	
	// 보기
	public EventVO view(Long eventNo);

	// 등록
	public Integer write(EventVO vo);
	// 글등록 트랜젝션 처리 테스트
	// public Integer writeTx(EventVO vo);
	
	// 수정
	public Integer update(EventVO vo);
	
	// 삭제
	public Integer delete(EventVO vo);

	public List<EventVO> hotelList();

	public List<EventVO> tripList();

	public List<EventVO> listEvent();
	
}
