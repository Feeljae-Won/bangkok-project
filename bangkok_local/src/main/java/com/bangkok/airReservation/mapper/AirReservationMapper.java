package com.bangkok.airReservation.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bangkok.airReservation.vo.APassengerVO;
import com.bangkok.airReservation.vo.AirReservationVO;
import com.bangkok.airReservation.vo.BaggageTypeVO;
import com.bangkok.airReservation.vo.BaggageVO;
import com.bangkok.airReservation.vo.CPassengerVO;
import com.bangkok.airReservation.vo.CountryVO;
import com.bangkok.airReservation.vo.IPassengerVO;
import com.bangkok.airReservation.vo.ReservationScheduleVO;
import com.bangkok.airReservation.vo.SeatVO;

@Repository
public interface AirReservationMapper {

	// 예약 리스트

	public List<AirReservationVO> list();

	// 예약 등록

	public Integer reservation(AirReservationVO vo);

	public Integer reservationAPassenger(List<APassengerVO> apassengerList);
	public Integer reservationCPassenger(List<CPassengerVO> cpassengerList);
	public Integer reservationIPassenger(List<IPassengerVO> ipassengerList);

	public Integer reservationBaggage(List<BaggageVO> baggageList);

	public Integer reservationSchedule(ReservationScheduleVO reservationScheduleVO);

	public Integer reservationState(AirReservationVO vo);

	// 예약 삭제

	public Integer reservationDelete(AirReservationVO vo);

	public List<CountryVO> selectCountry();

	public List<BaggageTypeVO> selectBaggage();

	// 좌석 mapper
	public List<SeatVO> seatList();

	public Integer seatWrite();
	
	
	// 관리자 
	public List<AirReservationVO> listAllReservations();
	

	public Integer updateReservationStatus(AirReservationVO vo);

	public Integer deletePassenger(Long passengerNo);

	

}
