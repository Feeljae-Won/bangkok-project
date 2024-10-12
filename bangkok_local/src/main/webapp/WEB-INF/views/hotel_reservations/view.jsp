<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 상세보기</title>
<style type="text/css">
#back{
	cursor: pointer;
}
.paymentStatus{
	margin-top: 30px;
	margin-bottom: 30px;
	font-weight: 900;
	font-size: 25px;
	color:#333;
}
.ReservationInformation,.PayInformation,.cansleInformation{
	margin-top: 30px;
	margin-bottom: 30px;
	font-weight: 900;
	font-size: 20px;
	color:#333;
}
.hotelImage{
  width: 330px;
  height: 250px;
  border: 1px solid rgba(0, 0, 0, 0.1); /* 테두리 두께를 0.5px로 설정하여 얇게 */
  border-radius: 10px; /* 모서리 둥글게 */
}
.image-container {
  display: flex;
  flex-direction: row; /* 가로 정렬 */
  align-items: center; /* 이미지와 텍스트 수직 중앙 정렬 */
  gap: 20px; /* 이미지와 텍스트 사이 간격 */
}
#copyText{
	display: none;
}
#copyTextNo{
	display: none;
}
.horizontal-line {
    width: 100%; /* 선의 길이 조절 */
    margin: 0 auto; /* 중앙 정렬 */
    border-top: 1px solid rgba(0, 0, 0, 0.1); /* 매우 희미한 선 */
    margin-top: 50px;
    margin-bottom: 50px;
}
/* 모달 스타일 */
.custom-modal {
  border-radius: 15px; /* 모서리를 부드럽게 둥글게 처리 */
  padding: 20px;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3); /* 그림자 추가로 더 입체감 있게 */
}

/* 모달의 내용 정렬 */
/* 모달 스타일 */
.custom-modal {
  border-radius: 30px; /* 모서리를 부드럽게 둥글게 처리 */
  padding: 30px; /* 모달 내부의 여유 공간 확보 */
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3); /* 그림자 추가 */
}

/* 버튼 중앙 배치와 크기 조정 */
.modal-footer {
  justify-content: center; /* 버튼을 중앙 배치 */
}

.btn-lg {
  font-size: 1.25rem; /* 버튼 텍스트 크기 조정 */
  padding: 10px 20px; /* 버튼 패딩을 키워서 버튼 크기 확대 */
}

.modal-body {
  font-size: 1.1rem; /* 본문 텍스트 크기를 조금 키움 */
  padding-bottom: 20px; /* 텍스트와 버튼 간의 간격 조정 */
}
</style>
<script type="text/javascript">
$(function(){
	$("#back").click(function(){
		location = "list.do";
	});
	//클립보드 이벤트
	$('.clip').click(function() {
        var copyText = $('#copyText').val(); // 복사할 텍스트 가져오기
        navigator.clipboard.writeText(copyText).then(function() {
            alert("주소가 클립보드에 복사되었습니다!"); // 복사가 성공하면 알림 메시지를 보여줌
        });
    });
	//클립보드 이벤트
	$('.clipNo').click(function() {
        var copyText = $('#copyTextNo').val(); // 복사할 텍스트 가져오기
        navigator.clipboard.writeText(copyText).then(function() {
            alert("예약 번호가 클립보드에 복사되었습니다!"); // 복사가 성공하면 알림 메시지를 보여줌
        });
    });
	let cancel = $(".cancel").text();
	console.log(cancel); // 2024년10월02일23:59:59

	// 문자열을 분리하여 일(day) 부분만 추출
	let year = cancel.substring(0, 4);           // "2024"
	let month = cancel.substring(5, 7);          // "10"
	let day = parseInt(cancel.substring(8, 10)); // "02" -> 숫자로 변환하여 2
	
	console.log(year,month,day);
	// 일(day)에서 1을 뺌
	day -= 1;
	console.log(year,month,day);
	
	
	$(".cancel").text(year+"년"+month+"월"+day+"일23:59:59 까지 취소 가능합니다. 그 이후 환불 및 예약취소가 불가능합니다.");

});
</script>
<script type="text/javascript">
$(function(){
	$("#cancelBtn").click(function(){
		$('#deleteForm').submit();  // form을 제출합니다.
	});
});
</script>
</head>
<body>

<div class="container">
	<i class="material-icons" style="font-size:30px;margin-right: 30px;" id="back">arrow_back </i>
	<b style="font-size:30px; font-weight: 510;">예약내역 상세</b>
	
	<div class="paymentStatus">
		${vo.paymentStatus }
	</div>
	
	<!-- Flexbox로 이미지와 텍스트 정렬 -->
	<div class="row">
	<div class="image-container col-md-4" >
		<img class="hotelImage" alt="이미지가 존재하지 않습니다." src="${vo.room_image_name }">
	</div>
	<div class="col-md" style="padding: 0;">
	<div style="font-size: 30px;">${vo.title }</div>
	<b style="font-size: 15px;">${vo.address }<i class="fa fa-clipboard clip" style="margin-left: 10px; color:#1273e4; cursor: pointer;">주소 복사</i></b>
	<input type="text" id="copyText" value="${vo.address }" />
	</div>
	</div>
	<div class="row" style="margin-top: 20px;">
		<div class="col-md-1" style="padding: 0">
		일정
		</div>	
		<div class="col-md">
		<span><b><fmt:formatDate value="${vo.checkIn }" pattern="yyyy-MM-dd(EEE)HH:mm"/> ~ </b><b><fmt:formatDate value="${vo.checkOut }" pattern="yyyy-MM-dd(EEE)HH:mm"/></b></span>
		</div>
	</div>
	<div class="row" style="margin-top: 20px;">
		<div class="col-md-1" style="padding: 0">
		객실 타입
		</div>	
		<div class="col-md">
		${vo.room_type }
		</div>
	</div>
	
	<div class="horizontal-line"></div> <!-- 얇은 선  -->
	
	<div class="ReservationInformation row">
		예약 정보
	</div>	
	<div class="row" style="margin-top: 30px;">
		<div class="col-md-1" style="padding: 0">
		예약 번호
		</div>	
		<div class="col-md">
		<b>${vo.reservation_no}</b>
		<i class="fa fa-clipboard clipNo" style="margin-left: 10px; color:#1273e4; cursor: pointer;">예약번호 복사</i>
		<input type="text" id="copyTextNo" value="${vo.reservation_no}" />
		</div>
	</div>
	<div class="row" style="margin-top: 20px;">
		<div class="col-md-1" style="padding: 0">
		예약자 이름
		</div>	
		<div class="col-md">
		<b>${vo.name}</b>
		</div>
	</div>
	<div class="row" style="margin-top: 20px;">
		<div class="col-md-1" style="padding: 0">
		전화번호
		</div>	
		<div class="col-md">
		<b>${vo.tel}</b>
		</div>
	</div>
	<div class="row" style="margin-top: 20px;">
		<div class="col-md-1" style="padding: 0">
		인원 수
		</div>	
		<div class="col-md">
		<b>${vo.people}</b>
		</div>
	</div>
	<div class="horizontal-line"></div> <!-- 얇은 선  -->
	<div class="PayInformation row">
		결제 정보
	</div>	
	<div class="backgroundPay" style="background: white;padding: 20px;">
		
	<div class="row">
		<div class="col-md-3">
		결제 일시
		</div>
		<div class="col-md-3">
		<fmt:formatDate value="${vo.paymentdate }" pattern="yyyy-MM-dd(EEE)HH:mm"/>
		</div>
		<div class="col-md-3" >
		객실 가격
		</div>
		<div class="col-md-3">
		${vo.price }
		</div>
	</div>
	<br>
	<div class="row">
		<div class="col-md-3">
		결제 수단
		</div>
		<div class="col-md-3">
		${vo.paymentMethod }
		</div>
	</div>
	<br>
	<div class="row">
		<div class="col-md-3">
		결제 방식
		</div>
		<div class="col-md-3">
		${vo.payment_Type }
		</div>
	</div>
	<div class="horizontal-line" style="margin-bottom:15px;"></div> <!-- 얇은 선  -->
	<div class="row">
		<div class="col-md-6">
		</div>
		<div class="col-md-3">
		<b style="font-size:20px;">실 결제 금액</b>
		</div>
		<div class="col-md">
		<b style="font-size:20px; color:red;">${vo.price}</b>
		</div>
	</div>
	</div>
	
	<div class="horizontal-line"></div> <!-- 얇은 선  -->

		<button type="button" class="float-right btn btn-outline-danger" data-toggle="modal" data-target="#cancelModal">예약 취소</button>
	<div class="cansleInformation row">
	예약 취소
	</div>	
	<div style="margin-bottom: 100px;">
	<b class="cancel" style="color:red; font-size:20px; "><fmt:formatDate value="${vo.checkIn }" pattern="yyyy년MM월dd일"/></b>
	</div>
</div>
<jsp:include page="cancelModal.jsp"/>
<%-- <jsp:include page="allModal.jsp"/> --%>
<!-- <span class="d-flex align-items-center" id="inputDate" data-toggle="modal"  -->
<!-- 	data-target="#datePickerModal"> -->
<!-- 	<i class="material-icons mr-3" style="font-size:22px">date_range</i>  -->
<!-- 	<b><span id="dateRange">체크인 ~ 체크아웃</span></b> -->
<!-- </span> -->
<!-- 인원 선택 버튼 -->
<!-- <span class="d-flex align-items-center" id="passenger" data-toggle="modal" data-target="#personModal"> -->
<!--     <i class="fa fa-user mr-3" style="font-size:24px"></i>  -->
<!--     <b><span id="totalPassenger">총 1명</span></b> -->
<!-- </span> -->

</body>
