package com.bangkok.air.service;

import java.util.ArrayList;
import java.util.List;


import com.bangkok.air.vo.AirVO;
import com.bangkok.air.vo.AirlineVO;
import com.bangkok.air.vo.AirplaneVO;
import com.bangkok.air.vo.PriceVO;
import com.bangkok.air.vo.RouteVO;
import com.bangkok.air.vo.ScheduleVO;
import com.bangkok.util.page.PageObject;

public interface AirService {

	// 공항 검색 리스트
	public List<AirVO> searchList(String searchAirport);
	
	// 항공권 검색 리스트
	public List<AirVO> searchResult(AirVO vo);
	
	// 대륙별 국가 리스트
	public List<AirVO> nocList(String pan);
	
	// 국가 등록
	public Integer nocWrite(AirVO vo);
	
	// 국가 수정
	public Integer nocUpdate(AirVO vo);
	
	// 국가 삭제
	public Integer nocDelete(AirVO vo);
	
	// 국가별 공항 리스트 가져오기
	public List<AirVO> getAirport(String countryCode);
	
	// 공항 등록
	public Integer airportWrite(AirVO vo);
	
	// 공항 수정
	public Integer airportUpdate(AirVO vo);
	
	// 공항 삭제
	public Integer airportDelete(AirVO vo);
	
	// 제조사별 비행기 모델 리스트 가져오기
	public List<AirVO> getAirplane(String airplanePdt);
	
	// 관리자 - 항공사 기종 리스트
	public List<AirVO> flightList(PageObject pageObject, Long airlineNo);
	
	// 관리자 기종 상세보기
	public AirVO getFlightInfo(String flightName);
	
	// 항공편 등록
	public Integer write(ArrayList<AirplaneVO> list);

	// 항공 노선 리스트
	public List<AirVO> routeList(PageObject pageObject, Long airlineNo, Long routeId);
	
	// 항공 노선 상세보기
	public AirVO routeView(Long airlineNo, Long routeId);
	
	// 항공 노선 등록
	public Integer routeWrite(RouteVO vo);
	
	// 항공 노선 수정
	public Integer routeUpdate(RouteVO vo);
	
	// 항공 노선 수정
	public Integer routeDelete(Long routeId);
	
	// 항공 노선에 따른 금액 가져오기
	public AirVO getPrice(Long airlineNo, Long routeId);
	
	// 노선에 금액 등록
	public Integer priceWrite(PriceVO vo);
	
	// 노선에 금액 수정
	public Integer priceUpdate(PriceVO vo);

	// 노선별 운항 스케줄 리스트
	public List<AirVO> airScheduleDetail(Long airlineNo, Long routeId, PageObject pageObject);
	
	// 스케줄 등록 - 스케줄 없는 항공편 리스트
	public List<AirVO> getFlightList(Long airlingeNo);
	
	// 스케줄 등록 - 일괄 등록
	public Integer airScheduleWrite(Long airlineNo, ScheduleVO vo);
	
	// 스케줄 삭제
	public Integer airScheduleDelete(Long airlineNo, Long scheduleId);
	
	// 관리자 항공사 리스트
	public List<AirVO> airlineList(PageObject pageObject);
	
	// 항공사 정보 가져오기
	public AirlineVO getAirlineInfo(Long airlineNo);
	
	// 항공사 등록 이메일 가져오기
	public List<AirVO> getEmail();
	
	// 항공사 등록 이메일 가져오기
	public List<AirVO> getNoc();
	
	// 항공사 등록 처리
	public Integer airlineWrite(AirlineVO vo);
	
	// 항공사 등록 처리
	public Integer airlineUpdate(AirlineVO vo);
	

}
