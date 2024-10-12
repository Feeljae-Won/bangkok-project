package com.bangkok.airReservation.service;

import java.util.List;

import com.bangkok.airReservation.vo.APassengerVO;
import com.bangkok.airReservation.vo.AirReservationVO;
import com.bangkok.airReservation.vo.BaggageTypeVO;
import com.bangkok.airReservation.vo.BaggageVO;
import com.bangkok.airReservation.vo.CPassengerVO;
import com.bangkok.airReservation.vo.CountryVO;
import com.bangkok.airReservation.vo.IPassengerVO;
import com.bangkok.airReservation.vo.ReservationScheduleVO;

public interface AirReservationService {
	
	public List<AirReservationVO> list();
	
	public List<CountryVO> selectCountry();
	
	public List<BaggageTypeVO> selectBaggage();

	public Integer reservation(AirReservationVO vo,
			List<APassengerVO> apassengerList,
			List<CPassengerVO> cpassengerList,
			List<IPassengerVO> ipassengerList,
			List<BaggageVO> baggageList,
			ReservationScheduleVO  reservationScheduleVO);
	
	
	
	// 관리자 
	
	public List<AirReservationVO> listAllReservations();
	
	
	public Integer updateReservationStatus(AirReservationVO vo);
	
	public Integer deletePassenger(Long passengerNo);

}
