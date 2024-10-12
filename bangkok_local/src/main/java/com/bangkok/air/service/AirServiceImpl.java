package com.bangkok.air.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bangkok.air.mapper.AirMapper;
import com.bangkok.air.vo.AirVO;
import com.bangkok.air.vo.AirlineVO;
import com.bangkok.air.vo.AirplaneVO;
import com.bangkok.air.vo.PriceVO;
import com.bangkok.air.vo.RouteVO;
import com.bangkok.air.vo.ScheduleVO;
import com.bangkok.util.page.PageObject;

import lombok.extern.log4j.Log4j;

///자동 생성을 위한 어노테이션
//- @Controller - url : HTML, @Service - 처리, @Repository - 데이터 저장, 
//@Component - 구성체, @RestController - url : data : ajax, @~Advice - 예외 처리
@Service
@Log4j
//Type이 같으면 식별할 수 있는 문자열 지정 - id를 지정
@Qualifier("AirServiceImpl")
public class AirServiceImpl implements AirService{

	// 자동 DI 적용 - @Setter, @Autowired, @Inject
	@Inject
	private AirMapper mapper;
	
	// 공항 검색 리스트
	@Override
	public List<AirVO> searchList(String searchAirport) {
		// 전체 데이터 개수 구하기
		return mapper.searchList(searchAirport);
	}
	
	//항공권 검색 리스트
	@Override
	public List<AirVO> searchResult(AirVO vo) {
		
		return mapper.searchResult(vo);
	}
	
	// 대륙별 국가 리스트
	@Override
	public List<AirVO> nocList(String pan) {
		
		return mapper.nocList(pan);
	}
	
	// 국가 등록
	@Override
	public Integer nocWrite(AirVO vo) {
		
		return mapper.nocWrite(vo);
	}
	
	// 국가 수정
	@Override
	public Integer nocUpdate(AirVO vo) {
		
		return mapper.nocUpdate(vo);
	}
	
	// 국가 삭제
	@Override
	public Integer nocDelete(AirVO vo) {
		
		return mapper.nocDelete(vo);
	}
	
	// 국가별 공항 리스트 가져오기
	@Override
	public List<AirVO> getAirport(String countryCode) {
		return mapper.getAirport(countryCode);
	}
	
	// 공항 등록
	@Override
	public Integer airportWrite(AirVO vo) {
		return mapper.airportWrite(vo);
	}
	
	// 공항 수정
	@Override
	public Integer airportUpdate(AirVO vo) {
		return mapper.airportUpdate(vo);
	}
	
	// 공항 수정
	@Override
	public Integer airportDelete(AirVO vo) {
		return mapper.airportDelete(vo);
	}
	
	// 제조사별 비행기 리스트 가져오기
	@Override
	public List<AirVO> getAirplane(String airplanePdt) {
		return mapper.getAirplane(airplanePdt);
	}
	
	// 항공사 기종 리스트
	@Override
	public List<AirVO> flightList(PageObject pageObject, Long airlineNo) {
		// 전체 데이터 개수 구하기
		pageObject.setTotalRow(mapper.getTotalRow(pageObject, airlineNo));
		return mapper.flightList(pageObject, airlineNo);
	}
	
	// 항공사 기종 상세보기
	@Override
	public AirVO getFlightInfo(String flightName) {
		return mapper.getFlightInfo(flightName);
	}
	
	// 항공편 등록
	@Override
	@Transactional
	public Integer write(ArrayList<AirplaneVO> list) {
		
		Integer result = 0;
		
		if (list != null && list.size() > 0 ) {
			for (AirplaneVO vo : list) {
				vo.setAirlineNo(22L);
				mapper.writeAirplaneOpt(vo);
				mapper.writeFlightEcoCnt(vo);
				mapper.writeFlightBisCnt(vo);
				mapper.writeFlightFstCnt(vo);
			}
			result = 1;
		}
		return result;
	}
	
	// 항공 노선 리스트
	@Override
	public List<AirVO> routeList(PageObject pageObject, Long airlineNo, Long routeId) {
		// 전체 데이터 개수 구하기
		pageObject.setTotalRow(mapper.getRouteTotalRow(pageObject, airlineNo));
		return mapper.routeList(pageObject, airlineNo, routeId);
	}
	
	// 항공 노선 상세보기
	@Override
	public AirVO routeView(Long airlineNo, Long routeId) {
		
		return mapper.routeView(airlineNo, routeId);
	}
	
	// 항공 노선 등록
	@Override
	public Integer routeWrite(RouteVO vo) {
		
		vo.setAirlineNo(22L);
		
		if (vo.getGoBackStr() != null && !vo.getGoBackStr().equals("")) {
			
			mapper.routeReturnWrite(vo);
			return mapper.routeWrite(vo);
		} 
		return mapper.routeWrite(vo);
	}
	
	// 항공 노선 수정
	@Override
	public Integer routeUpdate(RouteVO vo) {
		
		return mapper.routeUpdate(vo);
	}
	
	// 항공 노선 삭제
	@Override
	public Integer routeDelete(Long routeId) {
		
		return mapper.routeDelete(routeId);
	}
	
	// 항공 노선에 따른 금액 상세보기
	@Override
	public AirVO getPrice(Long airlineNo, Long routeId) {
		// 노선에 따른 금액 가져오기
		
		log.info("---------------------------------- routeId : " + routeId);
		return mapper.getPrice(22L, routeId);
	}
	
	// 노선별 스케줄 리스트
	@Override
	public List<AirVO> airScheduleDetail(@Param("airlineNo") Long airlineNo, @Param("routeId") Long routeId, @Param("pageObject") PageObject pageObject) {
		
		pageObject.setTotalRow(mapper.getScheduleTotalRow(pageObject, airlineNo, routeId));
		return mapper.airScheduleDetail(22L, routeId, pageObject);
	}

	// 스케줄 등록 - 항공편 가져오기
	@Override
	public List<AirVO> getFlightList(Long airlineNo) {
		
		return mapper.getFlightList(airlineNo);
	}

	// 스케줄 등록 처리
	@Override
	public Integer airScheduleWrite(Long airlineNo, ScheduleVO vos) {
		Integer result = 0;
		
		if (vos.isRepeat()) {
			List<ScheduleVO> list = vos.getList();
			Long repeatDays = vos.getRepeatDays();
			
			for(ScheduleVO vo : list) {
				
				vo.setAirlineNo(22L);
				Date originalDepartureTime = vo.getDepartureTime();
				Date originalArrivalTime = vo.getArrivalTime();
				mapper.airScheduleWrite(vo);
				
				// 반복 등록
		        for (long i = 1; i <= repeatDays; i++) {
		        	Date newDepartureTime = addDaysToDate(originalDepartureTime, i);
		        	Date newArrivalTime = addDaysToDate(originalArrivalTime, i);
                  vo.setDepartureTime(newDepartureTime);
                  vo.setArrivalTime(newArrivalTime);
		            mapper.airScheduleWrite(vo);
		        }
		        
		        result = 1;
			} // end of for write
			
		} else {
			List<ScheduleVO> list = vos.getList();
			
			for(ScheduleVO vo : list) {
				
				vos.setAirlineNo(22L);
				mapper.airScheduleWrite(vo);
			} // end of for write
			
			result = 1;
			
		} // end of if reapeat false
		return result;
	}

	// Date 객체에 일(day)을 더하는 함수
  private Date addDaysToDate(Date date, long days) {
      Calendar calendar = Calendar.getInstance();
      calendar.setTime(date);
      calendar.add(Calendar.DATE, (int) days);  // 일(day) 더하기
      return calendar.getTime();  // Date 객체로 반환
  }

  // 스케줄 삭제
	@Override
	public Integer airScheduleDelete(Long airlineNo, Long scheduleId) {
		
		return mapper.airScheduleDelete(airlineNo, scheduleId);
	}

	// 노선별 금액 등록
	@Override
	public Integer priceWrite(PriceVO vo) {
		
		// 기본 고정 금액
		Long tax = 28000L;
		Long fuelSurCharge = 18000L;
		Long bookingFee = 1000L;
		
		// 항공사 번호 입력
		vo.setAirlineNo(22L);
		
		// 세금 입력(고정)
		vo.setTax(tax);
		
		// 거리에 따른 유류할증료 계산
		if(vo.getDistance() >= 0 && vo.getDistance() < 1000L ) vo.setFuelSurCharge(fuelSurCharge);
		else if(vo.getDistance() >= 1000L && vo.getDistance() < 2000L ) vo.setFuelSurCharge((long) (fuelSurCharge * 1.2));
		else if(vo.getDistance() >= 2000L && vo.getDistance() < 4000L ) vo.setFuelSurCharge((long) (fuelSurCharge * 1.4));
		else if(vo.getDistance() >= 4000L && vo.getDistance() < 6000L ) vo.setFuelSurCharge((long) (fuelSurCharge * 1.6));
		else if(vo.getDistance() >= 6000L && vo.getDistance() < 9000L ) vo.setFuelSurCharge((long) (fuelSurCharge * 2.8));
		else if(vo.getDistance() >= 9000L && vo.getDistance() < 12000L ) vo.setFuelSurCharge((long) (fuelSurCharge * 2.8));
		else vo.setFuelSurCharge((long) (fuelSurCharge * 3));
		
		// 발권수수료
		vo.setBookingFee(bookingFee);
		
		return mapper.priceWrite(vo);
	}

	// 노선별 금액 수정
	@Override
	public Integer priceUpdate(PriceVO vo) {

		// 항공사 번호 입력
		vo.setAirlineNo(22L);
		
		return mapper.priceUpdate(vo);
	}

	// 항공사 리스트
	@Override
	public List<AirVO> airlineList(PageObject pageObject) {
		
		
		return mapper.airlineList(pageObject);
	}
	
	// 항공사 정보 가져오기
	@Override
	public AirlineVO getAirlineInfo(Long airlineNo) {
		
		return mapper.getAirlineInfo(airlineNo);
	}
	
	// 항공사 등록 이메일 가져오기
	@Override
	public List<AirVO> getEmail(){
		
		return mapper.getEmail();
	}
	
	// 항공사 등록 국가 가져오기
	@Override
	public List<AirVO> getNoc(){
		
		return mapper.getNoc();
	}
	
	// 항공사 등록 처리
	@Override
	public Integer airlineWrite(AirlineVO vo) {
		
		return mapper.airlineWrite(vo);
	}
	
	// 항공사 수정 처리
	@Override
	public Integer airlineUpdate(AirlineVO vo) {
		
		return mapper.airlineUpdate(vo);
	}
	
}
