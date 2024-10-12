<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<style type="text/css">
body, html {
	margin: 0;
	padding: 0;
	height: 100%;
	width: 100%;
}

.background-image {
/* 	left:15px; */
	position: relative;
	width: 100%;
	height: 600px;
	background-image: url('/uploads/airMain.jpg');
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
}

.overlay {
	position: absolute;
	top: 45%;
	left: 50%;
	transform: translate(-50%, -40%);
	background-color: rgba(255, 255, 255, 0.8);
	/* White background with transparency */
	border-radius: 20px;
	width: 70%;
	text-align: left;
	box-shadow: 10px 10px 12px rgba(0, 0, 0, 0.5);
	/* Optional shadow for better visibility */
}

.overlay h5 {
	color: #444;
}

.searchAir {
	padding: 30px 40px;
	
}
.type {
	margin: 0 20px;
	font-border: 3px;
}

.airport {
	margin: 20px;
	text-align: center;
	position: relative;
}
#departureAirport {
	border:2px solid rgba(255, 255, 255, 0);
	background-color: rgba(255, 255, 255, 0);

}
#departureAirport:hover {
	cursor: pointer;
	border: 2px solid #E37027;
	border-radius: 10px;
}
#arrivalAirport {
	border:2px solid rgba(255, 255, 255, 0);
	background-color: rgba(255, 255, 255, 0);

}
#arrivalAirport:hover {
	cursor: pointer;
	border: 2px solid #E37027;
	border-radius: 10px;
}
.material-icons:hover {
	cursor: pointer;
	color: #e25600 !important;
}
#airportList {
	display: none;
	background-color: white;
	border: 1px solid #ccc;
	border-radius: 15px;
	padding: 20px;
	width: 500px;
	position: absolute;
	top: 100%;
	left: 0;
	z-index: 10;
	text-align: left;
}
#departure {
	font-size: 37px;
	font-weight: bold;
	margin-bottom: 10px;
}
#departureKor {
	font-size: 14px;
	font-weight: bold;
	margin-bottom: 10px;
}
#arrival {
	font-size: 37px;
	font-weight: bold;
	margin-bottom: 10px;
}
#arrivalKor {
	font-size: 14px;
	font-weight: bold;
	margin-bottom: 10px;
}

#inputDate {
	border-top:1px solid rgba(255, 255, 255, 0); 
	border-left:1px solid rgba(255, 255, 255, 0); 
	border-right:1px solid rgba(255, 255, 255, 0); 
	border-bottom:1px solid #444; 
	width:260px; 
	padding:10px;
}
#passenger {
	border-top:1px solid rgba(255, 255, 255, 0); 
	border-left:1px solid rgba(255, 255, 255, 0); 
	border-right:1px solid rgba(255, 255, 255, 0); 
	border-bottom:1px solid #444; 
	width:200px; 
	padding:10px;
}
#passenger:hover {
	cursor:pointer;
	border:1px solid #E37027 !important;
	border-radius: 10px;
}
#passengerSelect {
	display: none;
	background-color: white;
	border: 1px solid #ccc;
	border-radius: 15px;
	padding: 20px;
	width: 500px;
	position: absolute;
	top: 100%;
	left: 0;
	z-index: 10;
	text-align: left;
}
#inputSeat {
	border-top:1px solid rgba(255, 255, 255, 0); 
	border-left:1px solid rgba(255, 255, 255, 0); 
	border-right:1px solid rgba(255, 255, 255, 0); 
	border-bottom:1px solid #444; 
	width:180px; 
	padding:10px;
}

#inputDate:hover {
	cursor:pointer;
	border:1px solid #E37027 !important;
	border-radius: 10px;
}

#inputSeat:hover {
	cursor:pointer;
	border:1px solid #E37027 !important;
	border-radius: 10px;
}
#searchBtn:hover {
	cursor:pointer;
	background-color: #e25600 !important;
}
.active {
	color:#E37027 ; 
	border-bottom: 3px solid #E37027; 
	font-weight:bold;
}
.type:hover {
	cursor: pointer;
	color:#E37027 !important;
}

#inputSchedule {
	display: none;
	background-color: white;
	border: 1px solid #ccc;
	border-radius: 15px;
	padding: 20px;
	width: 500px;
	position: absolute;
	top: 100%;
	left: 0;
	z-index: 10;
	text-align: left;
}
/* datepicker UI */
.ui-datepicker-inline {
	width:90%;
	height:400px;
	margin: 0 auto;
	border-radius:10px;
	border:2px solid rgba(255, 255, 255, 0) !important;
	background-color: rgba(255, 255, 255, 0) !important;
}
.ui-datepicker-title {
	margin: 0 auto;
	height: 50px;
	
}
.ui-datepicker-header {
	background-color:#FFE3CD;
	border-radius:10px;
	padding:3px;
	height:60px;
	margin-bottom:5px;
}

.ui-icon-circle-triangle-e {
	color: #e0e0e0;
}
.ui-datepicker-month {
	height: 80%;
	text-align:center;
	font-weight:bold;
	border-radius:10px;
}
.ui-datepicker-year {
	height: 80%;
	text-align:center;
	font-weight:bold;
	border-radius:10px;
}
th {
	background-color:#FF9C2A;
	margin-left:2px;
	margin-right:2px;
	color:#ffffff;
	width:30px;
	font-weight:bold;

}
table {
	border-radius: 10px;
}
th.ui-datepicker-week-end {
	background-color:#FF7145;
}
td.ui-datepicker-week-end {
	background-color:#FFF7DF;
}
td {
	height:57px;
	font-weight:bold;
}
.ui-state-default {
	height:90%;
	width:90%;
	border-radius:5px;
	border:2px solid rgba(255, 255, 255, 0) !important;
	background-color: rgba(255, 255, 255, 0) !important;
}
.ui-state-hover {
	background-color: #FFC720 !important;
}
.ui-state-active {
	background-color: #FF9C2A !important;
	color: #444;
}
.ui-state-default, 
.ui-widget-content .ui-state-default, 
.ui-widget-header .ui-state-default, 
.ui-button, 
html .ui-button.ui-state-disabled:hover, 
html .ui-button.ui-state-disabled:active {
	text-align: center;
	font-weight:bold;
}

.flex-container {
  display: flex;
  align-items: center;  /* 수직 정렬 */
  justify-content: space-between;  /* 수평으로 공간 분배 */
  width: 100%;
}

.inputPassenger {
  width: 60px;
  text-align: center;
}

.cntControl {
  font-size: 24px;
}

/* 아이콘 크기 맞추기 */
.fa-question-circle {
  font-size: 24px;
  color: #E37027;
}

.cntControl {
	width: 35px;
	height: 40px;
	font-size:20px;
}

.alert-danger {
	display: none;
}

.inputPassenger {
	text-align: center;
}

.seat-info {
	display: none;
	background-color: white;
	border: 1px solid #ccc;
	border-radius: 15px;
	padding: 20px;
	width: 370px;
	position: absolute;
	top: 100%;
	left: 0;
	z-index: 10;
	text-align: left;
}
#inputSeat {
    cursor: pointer;
    position: relative; /* 부모를 기준으로 자식이 위치할 수 있도록 설정 */
}
.btn-group .btn {
	border:1px solid #444;
	border-radius:10px;
}

</style>
<script type="text/javascript">
$(function(){
	let now = new Date();

	// 체크인 달력 설정
	$('#checkinCalendar').datepicker({
	    dateFormat: "yy-mm-dd",
	    changeMonth: true,
	    changeYear: true,
	    monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
	    dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
	    minDate: now,
	    onSelect: function(dateText) {
	        $("#selectedCheckinDate").val(dateText);
	    }
	});
	$('#checkinCalendar').datepicker('setDate', 'today');

	// 체크아웃 달력 설정
	$('#checkoutCalendar').datepicker({
	    dateFormat: "yy-mm-dd",
	    changeMonth: true,
	    changeYear: true,
	    monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
	    dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
	    minDate: now,
	    onSelect: function(dateText) {
	        $("#selectedCheckoutDate").val(dateText);
	    }
	});
	$('#checkoutCalendar').datepicker('setDate', '+1M');

	// "일정 선택 완료" 버튼 클릭 시 선택된 날짜를 표시
	$('#confirmDateBtn').click(function() {
	    if ($("#selectedCheckoutDate").val() != null) {
	        $('#dateRange').text($("#selectedCheckinDate").val() + " ~ " + $("#selectedCheckoutDate").val());
	        $("#checkinDate").val($("#selectedCheckinDate").val());
	        $("#checkoutDate").val($("#selectedCheckoutDate").val());
	    } else {
	        $('#dateRange').text($("#selectedCheckinDate").val());
	        $("#checkinDate").val($("#selectedCheckinDate").val());
	    }
	    // 모달 창 닫기
	    console.log($("#selectedCheckinDate").val() + " ~ " + $("#selectedCheckoutDate").val());
	    $('#datePickerModal').modal('hide');
	    $('.modal-backdrop').remove();
	});	
});
</script>
<!-- 인원 부분 -->
<script type="text/javascript">
$(function(){
	// 탑승객 버튼을 클릭했을 때 동작
	// tooltip
	$(document).ready(function(){
	    $('[data-toggle="tooltip"]').tooltip();   
	});

	// 출발지 선택 시
	$('#passenger').click(function() {
	    $('#passengerSelect').css({
	        top: $('#passenger').outerHeight() + 'px',  // 공항 아이콘 아래에 위치
	        left: 0  // 공항 아이콘의 왼쪽에 정렬
	    }).show();
	});

	// 인원 선택 버튼
	$(".cntControl").click(function() {
	    // 값을 가져온다.
	    let inputField = $(this).parent("span").find("input");
	    let cntValue = parseInt($(this).parent("span").find("input").val());
	    let increment = parseInt($(this).val());
	    
	    // 계산 값
	    let newCnt = cntValue + increment;
	    if (newCnt >= 0) {
	        inputField.val(newCnt);
	    }
	    
	    // 인원 수가 0명일 경우 경고 메시지 표시
	    if ($("#personCnt").val() == 0) {
	        $(".alert-danger").show();
	    } else {
	        $(".alert-danger").hide();
	    }
	});

	// 인원 정보를 버튼으로 전송
	$("#comfirmPassengerBtn").click(function() {
	    let personCnt = parseInt($("#personCnt").val());
	    
	    // 인원 수가 0명일 경우 경고 메시지 표시
	    if (personCnt === 0) {
	        $(".alert-danger").show();
	        return;
	    }

	    // 인원 정보를 업데이트
	    $("#totalPassenger").text("총 " + personCnt + "명");
	    $('#personModal').modal('hide');
	});
});
</script>

<!-- 모달 창 -->
<div class="modal" id="datePickerModal">
    <div class="modal-dialog modal-xl modal-dialog-centered dateModal" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="datePickerModalLabel"><strong>체크인 및 체크아웃 날짜 선택</strong></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- 달력이 표시될 곳 -->
                <div class="row">
                    <!-- 체크인 달력 -->
                    <div class="col">
                        <div style="text-align:center;" class="mb-2">
                            <i class="fa fa-hotel mb-0 mr-2" style="font-size:18px;color:#E37027"></i>
                            <b>체크인 날짜 선택</b>
                        </div>
                        <div id="checkinCalendar" class="mb-3"></div>
                    </div>
                    <!-- 체크아웃 달력 -->
                    <div class="col">
                        <div style="text-align:center;" class="mb-2">
							<i class="fa fa-hotel mb-0 mr-2" style="font-size:18px;color:#E37027"></i>
                            <b>체크아웃 날짜 선택</b>
                        </div>
                        <div id="checkoutCalendar" class="mb-3"></div>
                    </div>
                </div>
            </div>
            <div class="modal-footer align-items-bottom">
                <div class="form-inline">
                    <span>
                        <label for="selectedCheckinDate" class="float-left">
                            <i class="material-icons mb-0 mr-2" style="font-size:18px;color:#E37027">calendar_today</i>
                            <b>체크인 날짜</b>
                        </label>
                        <br>
                        <input class="form-control mr-3 mb-3" id="selectedCheckinDate" placeholder="체크인 날짜" readonly>
                    </span>
                    <span class="mr-3"> ~ </span>
                    <span>
                        <label for="selectedCheckoutDate" class="float-left">
                            <i class="material-icons mb-0 mr-2" style="font-size:18px;color:#E37027">calendar_today</i>
                            <b>체크아웃 날짜</b>
                        </label>
                        <br>
                        <input class="form-control mr-3 mb-3" id="selectedCheckoutDate" placeholder="체크아웃 날짜" readonly>
                    </span>
                </div>
                <button type="button" id="confirmDateBtn" class="btn btn-primary">일정 선택 완료</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<!-- 인원 선택 모달 -->
<div class="modal" id="personModal">
    <div class="modal-dialog modal-md modal-dialog-centered passengerModal" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="personModalLabel"><strong>인원 선택</strong></h5> 
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            
            <div class="modal-body">
                <div class="alert alert-danger" style="display: none;">
                    <strong>인원은 1명 이상이어야 합니다.</strong> 
                </div>
                <ul>
                    <li class="mb-5 flex-container p-0">
                        <div class="d-flex align-items-center">
                            <i class="material-icons" style="font-size:36px">person_pin_circle</i>
                            <b style="font-size:20px;">인원</b>
                        </div>
                        <span class="d-flex justify-content-center align-items-center mr-5">
                            <button class="btn btn-light btn-sm cntControl -sub" value="-1"><i class="fa fa-minus"></i></button>
                            <input class="inputPassenger form-control" id="personCnt" type="number" value="1" min="0">
                            <button class="btn btn-light btn-sm cntControl +add" value="+1"><i class="fa fa-plus"></i></button>
                        </span>
                    </li>
                </ul>
            </div>
            
            <div class="modal-footer align-items-bottom">
                <button type="button" id="comfirmPassengerBtn" class="btn btn-primary">인원 선택 완료</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>