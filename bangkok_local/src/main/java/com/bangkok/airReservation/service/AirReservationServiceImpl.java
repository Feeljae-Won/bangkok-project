package com.bangkok.airReservation.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bangkok.airReservation.mapper.AirReservationMapper;
import com.bangkok.airReservation.vo.APassengerVO;
import com.bangkok.airReservation.vo.AirReservationVO;
import com.bangkok.airReservation.vo.BaggageTypeVO;
import com.bangkok.airReservation.vo.BaggageVO;
import com.bangkok.airReservation.vo.CPassengerVO;
import com.bangkok.airReservation.vo.CountryVO;
import com.bangkok.airReservation.vo.IPassengerVO;
import com.bangkok.airReservation.vo.ReservationScheduleVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("AirReservationServiceImpl")
public class AirReservationServiceImpl implements AirReservationService {

	@Inject
	private AirReservationMapper mapper;

	@Override
	public List<AirReservationVO> list() {
		// TODO Auto-generated method stub
		return mapper.list();
	}

	@Override
	public Integer reservation(AirReservationVO vo, List<APassengerVO> apassengerList,
			List<CPassengerVO> cpassengerList, List<IPassengerVO> ipassengerList, List<BaggageVO> baggageList,
			ReservationScheduleVO reservationScheduleVO) {
		Integer result = null;

		mapper.reservation(vo);
		
		log.info("Reservation Number: " + vo.getReservationNo());

		reservationScheduleVO.setReservationNo(vo.getReservationNo());
		mapper.reservationSchedule(reservationScheduleVO); // 개별 스케줄 저장

		log.info("제발 성공해줘 ----------------- ");

		if (apassengerList != null && !apassengerList.isEmpty()) {
			for (APassengerVO apassengerVO : apassengerList) 
				apassengerVO.setReservationNo(vo.getReservationNo());
				mapper.reservationAPassenger(apassengerList);
			
		}
		
		if (cpassengerList != null && cpassengerList.size() > 0) {
			for (CPassengerVO cpassengerVO : cpassengerList) 
				cpassengerVO.setReservationNo(vo.getReservationNo());
				mapper.reservationCPassenger(cpassengerList);
			
		}
		
		log.info("진짜 제발 성공");
		
		if (ipassengerList != null && ipassengerList.size() > 0) {
			for (IPassengerVO ipassengerVO : ipassengerList) 
				ipassengerVO.setReservationNo(vo.getReservationNo());
				mapper.reservationIPassenger(ipassengerList);
			
		}

		

		if (baggageList != null && !baggageList.isEmpty()) {
			for (BaggageVO baggageVO : baggageList) {
				baggageVO.setReservationNo(vo.getReservationNo());
			}
			mapper.reservationBaggage(baggageList);
		}

		log.info("진짜 제발~!!!!!!!!!!!!!!!!!!!!");

		result = mapper.reservationState(vo);

		return result;
	}


	// --------------------------- Ajax -------------------------------

	@Override
	public List<CountryVO> selectCountry() {
		// TODO Auto-generated method stub
		return mapper.selectCountry();
	}

	@Override
	public List<BaggageTypeVO> selectBaggage() {
		// TODO Auto-generated method stub
		return mapper.selectBaggage();
	}
	
	
	// 관리자 ------------------

	@Override
	public List<AirReservationVO> listAllReservations() {
		// TODO Auto-generated method stub
		return mapper.listAllReservations();

	}
	
	
	@Override
	public Integer updateReservationStatus(AirReservationVO vo) {
		// TODO Auto-generated method stub
		return mapper.updateReservationStatus(vo);
	}


	@Override
	public Integer deletePassenger(Long passengerNo) {
		// TODO Auto-generated method stub
		return mapper.deletePassenger(passengerNo);
	}

	



}
