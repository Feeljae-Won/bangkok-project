package com.bangkok.air.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bangkok.air.vo.AirVO;
import com.bangkok.air.vo.AirlineVO;
import com.bangkok.air.vo.AirplaneVO;
import com.bangkok.air.vo.PriceVO;
import com.bangkok.air.vo.RouteVO;
import com.bangkok.air.vo.ScheduleVO;
import com.bangkok.util.page.PageObject;


@Repository
public interface AirMapper {
	
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
	public List<AirVO> getAirport(@Param("countryCode") String countryCode);
	
	// 공항 등록
	public Integer airportWrite(@Param("vo") AirVO vo);
	
	// 공항 수정
	public Integer airportUpdate(@Param("vo") AirVO vo);
	
	// 공항 삭제
	public Integer airportDelete(@Param("vo") AirVO vo);
	
	// 제조사별 비행기 리스트 가져오기
	public List<AirVO> getAirplane(@Param("airplanePdt") String airplanePdt);
	
	// 항공사 기종 리스트
	public List<AirVO> flightList(@Param("pageObject") PageObject pageObject, @Param("airlineNo") Long airlineNo);
	
	// 전체 데이터 개수 가져오기
	public Long getTotalRow(@Param("pageObject") PageObject pageObject, @Param("airlineNo") Long airlineNo);
	
	// 관리자 - 항공편 상세보기
	public AirVO getFlightInfo(@Param("flightName") String flightName);
	
	// 관리자 - 항공편 등록
	public Integer writeAirplane(@Param("AirplaneVO") AirplaneVO vo);
	
	// 관리자 - 항공편 옵션 등록
	public Integer writeAirplaneOpt(@Param("vo") AirplaneVO vo);
	
	// 관리자 - 항공편 이코노미 좌석 등록
	public Integer writeFlightEcoCnt(@Param("vo") AirplaneVO vo);
	// 관리자 - 항공편 비즈니스 좌석 등록
	public Integer writeFlightBisCnt(@Param("vo") AirplaneVO vo);
	// 관리자 - 항공편 일등석 좌석 등록
	public Integer writeFlightFstCnt(@Param("vo") AirplaneVO vo);
	
	// 항공 노선 리스트
	public List<AirVO> routeList(@Param("pageObject") PageObject pageObject, @Param("airlineNo") Long airlineNo, @Param("routeId") Long routeId);
	
	// 항공 노선 상세보기
	public AirVO routeView(@Param("airlineNo") Long airlineNo, @Param("routeId") Long routeId);
	
	// 전체 데이터 개수 가져오기
	public Long getRouteTotalRow(@Param("pageObject") PageObject pageObject, @Param("airlineNo") Long airlineNo);
	
	// 항공 노선 등록
	public Integer routeWrite(@Param("vo") RouteVO vo);
	
	// 항공 노선 등록 - return
	public Integer routeReturnWrite(@Param("vo") RouteVO vo);
	
	// 항공 노선 수정
	public Integer routeUpdate(@Param("vo") RouteVO vo);
	
	// 항공 노선 삭제
	public Integer routeDelete(@Param("routeId") Long routeId);
	
	// 노선에 따른 금액 정보 가져오기
	public AirVO getPrice(@Param("airlineNo") Long airlineNo, @Param("routeId") Long routeId);
	
	// 전체 데이터 개수 가져오기
	public Long getScheduleTotalRow(@Param("pageObject") PageObject pageObject, @Param("airlineNo") Long airlineNo, @Param("routeId") Long routeId);
	
	// 노선별 스케줄 리스트
	public List<AirVO> airScheduleDetail(@Param("airlineNo") Long airlingeNo, @Param("routeId") Long routeId, @Param("pageObject") PageObject pageObject);

	// 스케줄 등록 - 스케줄 없는 항공편 리스트
	public List<AirVO> getFlightList(@Param("airlineNo") Long airlineNo);
	
	// 스케줄 등록 처리
	public Integer airScheduleWrite(@Param("vo") ScheduleVO vo);
	
	// 스케줄 삭제
	public Integer airScheduleDelete(@Param("airlineNo") Long airlineNo, @Param("scheduleId") Long scheduleId);
	
	// 금액 등록
	public Integer priceWrite(@Param("vo") PriceVO vo);
	
	// 금액 수정
	public Integer priceUpdate(@Param("vo") PriceVO vo);
	
	// 항공사 등록
	public List<AirVO> airlineList(@Param("pageObject") PageObject pageObject);
	
	// 항공사 정보 가져오기
	public AirlineVO getAirlineInfo(@Param("airlineNo") Long airlineNo);
	
	// 항공사 등록 이메일 가져오기
	public List<AirVO> getEmail();
	
	// 항공사 등록 국가 가져오기
	public List<AirVO> getNoc();
	
	// 항공사 등록 처리
	public Integer airlineWrite(@Param("vo") AirlineVO vo);
	
	// 항공사 등록 처리
	public Integer airlineUpdate(@Param("vo") AirlineVO vo);

}
