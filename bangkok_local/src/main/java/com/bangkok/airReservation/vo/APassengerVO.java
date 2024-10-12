package com.bangkok.airReservation.vo;

import java.time.LocalDate;
import java.util.List;
import org.springframework.format.annotation.DateTimeFormat;
import lombok.Data;

@Data
public class APassengerVO {
	
	private Long adultPassengerNo;  // 고유 번호
    private Long reservationNo;      // 예약 고유 번호
    private String firstName;        // 이름
    private String lastName;         // 성

	@DateTimeFormat(pattern = "yyyy-MM-dd") // 수정된 부분
    private LocalDate birth;

    private String nationality;
    private String passport_number;

    @DateTimeFormat(pattern = "yyyy-MM-dd") // 수정된 부분
    private LocalDate passportEndDate;
    
	private String gender;
	
	private Integer adultCount;      // 성인 수 (기본값 0)
	
	public List<APassengerVO> apassengers;
}
