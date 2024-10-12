<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <%@ taglib prefix="pagNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>돌아오는 항공 선택</title>
 <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
 <script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
<style type="text/css">
body, html {
	margin: 0;
	padding: 0;
	height: 100%;
	width: 100%;
}

.background-image {
	left:15px;
	position: relative;
	width: 100%;
	height: 180px;
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
	width: 80%;
	height:40%;
	text-align: center;
	box-shadow: 10px 10px 12px rgba(0, 0, 0, 0.5);
	/* Optional shadow for better visibility */
}

.overlay h5 {
	color: #444;
}

.type {
	margin: 0 20px;
	font-border: 3px;
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
#departure {
	font-size: 20px;
	font-weight: bold;
	margin-bottom: 10px;
}
#departureKor {
	font-size: 14px;
	font-weight: bold;
	margin-bottom: 10px;
}
#arrival {
	font-size: 20px;
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
/* 	width:260px;  */
	padding:10px;
}
#passenger {
	border-top:1px solid rgba(255, 255, 255, 0); 
	border-left:1px solid rgba(255, 255, 255, 0); 
	border-right:1px solid rgba(255, 255, 255, 0); 
	border-bottom:1px solid #444; 
/* 	width:200px;  */
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
/* 	width:180px;  */
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
.searchBtn:hover {
	cursor:pointer;
	background-color: #e25600 !important;
}
.searchBtn {
	background-color:#E37027; 
	padding:10px; 
	border-radius:5px; 
	color:white; 
	font-weight:bold;
	text-align:center; 
	box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.5);
	border:1px solid rgba(255, 255, 255, 0);
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

.btn-group .btn {
	border:1px solid #444;
	border-radius:10px;
}

.fixed-bottom-bar {
    position: fixed;
    bottom: 0;
    left: 0;
    width: 100%;
    background-color: #333;
    color: white;
    padding: 10px;
    box-shadow: 0 -2px 10px rgba(0, 0, 0, 1);
}
.dataRow:hover {
	background-color: #FEDB92;
}
.selected {
	background-color: #FEDB92;
}
.disabled {
	background-color : #fff1c0 !important;
	cursor: default !important;
}
</style>
<!-- 천 단위 콤마 관련 함수 -->
<script type="text/javascript" src="/js/priceAddComma.js"></script>
<script type="text/javascript">
$(function() {
	
	// 백엔드에서 전달받은 숫자 데이터에 콤마를 추가하여 표시
    $(".totalPrice").each(function() {
        let totalPrice = $(this).text().trim();
        if (totalPrice) {
            $(this).text(addCommas(totalPrice));  // 콤마 추가
        }
    });
	
	
	// 공항 버튼을 클릭했을 때 동작
	$('.airport').click(function() {
		
		// 새로 오픈 될 때 검색 데이터 지우기
		$("#searchAirport").val("");

		// '출발지 검색' 또는 '도착지 검색'에 맞게 텍스트를 설정
		if ($(this).attr('id') === 'departureAirport') {
			$('#airportList h5').text('출발지 검색');
			$('#searchAirport').data('target', 'departure'); // target 설정
		} else {
			$('#airportList h5').text('도착지 검색');
			$('#searchAirport').data('target', 'arrival'); // target 설정
		}

		// 현재 열려 있는 리스트가 있으면 닫기
// 		$('#airportList').hide();
		
		// 모달 오픈
		$("#airportList").modal("show");

		// input 필드에 포커스를 줘서 커서가 잡히도록 함
		$('#airportList input').focus();
	});

	// 공항 리스트 외부를 클릭하면 닫기
	$(document).click(function(event) {
		// 공항 리스트, 공항 버튼, 입력 필드를 제외한 외부 클릭 시에만 닫기
		if (!$(event.target).closest('.airport, #airportList, input').length) {
			$('#airportList').hide();
		}
	});
	
	// 공항 데이터 검색
	$("#searchAirport").keyup(function() {
		let searchAirport = $(this).val();
		console.log("key up : " + searchAirport);
		
		// 입력 데이터 없을 때 처리
		if(searchAirport.length === 0) {
			$('#airportListResults').empty();
            return;
		};
		
		// AJAX 요청 보내기
        $.ajax({
            url: '/air/searchAirport', // 서버의 공항 검색 API URL
            type: 'GET',
            data: { searchAirport: searchAirport }, // 요청에 검색어 전달
            dataType: 'json', // 반환되는 데이터 타입을 명시
            success: function(data, status, xhr) {
            	
            	console.log(data);
                // 검색 결과를 받아온 후 처리
                $('#airportListResults').empty(); // 기존 결과를 초기화
                if(data.list && data.list.length > 0) {
                    // 검색된 공항 목록을 추가
                    $.each(data.list, function(index, airport) {
                        $('#airportListResults').append(
                        		'<p class="search-result" data-code="' + airport.airportCode + '" data-name="' 
                        		+ airport.airportKor + '" style="cursor: pointer;">'
                        		+ ' <i class="fa fa-plane" style="color:#E37027"></i> '
                                + airport.airportKor + ' (<b>' + airport.airportCode + '</b>) - ' 
                                + airport.countryKor + '(' + airport.pan + ')</p>'
                        );
                    });
                } else {
                    $('#airportListResults').append('<p>검색 결과가 없습니다.</p>');
                }
            },
            error: function(xhr, status, er) {
                // 오류 발생 시 처리
                $('#airportListResults').empty();
                $('#airportListResults').append('<p>오류가 발생했습니다.</p>');
            }
        });
	});
	
	// 검색된 공항 클릭 시 overlay에 반영
    $(document).on('click', '.search-result', function() {
        let selectedCode = $(this).data('code');  // 공항 코드
        let selectedName = $(this).data('name');  // 공항 이름
        
        // 선택한 공항을 반영할 target이 'departure'인지 'arrival'인지 확인
        if ($('#searchAirport').data('target') === 'departure') {
            $('#departure').text(selectedCode);
            $('#departureKor').text(selectedName);
            $('#dCode').val(selectedCode);
        } else if ($('#searchAirport').data('target') === 'arrival') {
            $('#arrival').text(selectedCode);
            $('#arrivalKor').text(selectedName);
            $('#aCode').val(selectedCode);
        }

        // 검색 결과 닫기
        $('#airportListResults').empty();
        $('#airportList').modal("hide");
    });

    // 출발지 선택 시
    $('#departureAirport').click(function() {
        $('#searchAirport').data('target', 'departure');
        $('#airportList').show();
    });

    // 도착지 선택 시
    $('#arrivalAirport').click(function() {
        $('#searchAirport').data('target', 'arrival');
        $('#airportList').show();
    });
	
	// swap 버튼 클릭 시 출발 공항과 도착 공항의 데이터를 교체
	$('.swap-button').click(function() {
		// 출발 공항의 텍스트 정보
		let departureCode = $('#departure').text();
		let departureKor = $('#departureKor').text();
		
		// 도착 공항의 텍스트 정보
		let arrivalCode = $('#arrival').text();
		let arrivalKor = $('#arrivalKor').text();
		
		// 출발과 도착 정보를 서로 교환
		$('#departure').text(arrivalCode);
		$('#departureKor').text(arrivalKor);
		$("#dCode").val(arrivalCode);
		$('#arrival').text(departureCode);
		$('#arrivalKor').text(departureKor);
		$("#aCode").val(departureCode);
	});
	
	// 편도 - 왕복 - 다구간 변경
	$(".type").click(function() {
		$(".type").removeClass("active");
		
		let type = $(this).text();
		if(type == "편도") {
			$("#dateRange").text("가는 날");
			$(".dateModal").removeClass("modal-xl");
			$(".dateModal").addClass("modal-md");
			$(".backType").hide();
			$("#typeGo").addClass("active");
			$("#modalTypeGo").addClass("active");
			$("#tripType").val("편도");
		}
		if(type == "왕복") {
			$("#dateRange").text("가는 날 ~ 오는 날");
			$(".dateModal").removeClass("modal-md");
			$(".dateModal").addClass("modal-xl");
			$(".backType").show();
			$("#typeGoBack").addClass("active");
			$("#modalTypeGoBack").addClass("active");
			$("#tripType").val("왕복");
		}
		console.log(type);
	});
	
	// 여행 일정 클릭했을 때 이벤트
	$('#inputDate').click(function() {
		
		// 새로 오픈 될 때 검색 데이터 지우기
		$("#inputSchedule").val("");
		$('#dateRange').text("가는 날" + " ~ " + "오는 날");
        $("#dDate").val("");
        $("#aDate").val("");
        $("#selectedDepartDate").val("");
        $("#selectedArriveDate").val("");

	});
	
	// 날짜 입력 설정 - datepicker
	let now = new Date();
	
	// Datepicker를 초기화
    $('#departureCalendar').datepicker({
    	// 입력란의 데이터 포맷 
		dateFormat: "yy-mm-dd",
		// 월 선택 입력 추가
		changeMonth: true,
		// 년 선택 입력 추가
		changeYear: true,
		// 월 선택할 때의 이름 - 원래는 영어가 기본
		monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
		// 달력의 요일 표시
		dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
		// 오늘까지만의 날짜를 선택 가능
		minDate : now,
		onSelect: function(dateText) {
// 			let dateAddTime = dateText + " 00:00:00" 
//             $("#selectedDepartDate").val(dateAddTime);
            $("#selectedDepartDate").val(dateText);
		}
    });
	
	//초기값을 오늘 날짜로 설정해줘야 합니다.
    $('#departureCalendar').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
	
    $('#arrivalCalendar').datepicker({
    	// 입력란의 데이터 포맷 
		dateFormat: "yy-mm-dd",
		// 월 선택 입력 추가
		changeMonth: true,
		// 년 선택 입력 추가
		changeYear: true,
		// 월 선택할 때의 이름 - 원래는 영어가 기본
		monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
		// 달력의 요일 표시
		dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
		// 오늘까지만의 날짜를 선택 가능
		minDate : now,
		onSelect: function(dateText) {
//             let dateAddTime = dateText + " 00:00:00" 
//             $("#selectedArriveDate").val(formattedDate);
            $("#selectedArriveDate").val(dateText);
		}
    });
    
 	 //초기값을 오늘 날짜로 설정해줘야 합니다.
    $('#arrivalCalendar').datepicker('setDate', '+1M'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)

    // "일정 선택 완료" 버튼 클릭 시 선택된 날짜를 표시
    $('#confirmDateBtn').click(function() {
        if ($("#selectedArriveDate").val() != null) {
            $('#dateRange').text($("#selectedDepartDate").val() + " ~ " + $("#selectedArriveDate").val());
            $("#dDate").val($("#selectedDepartDate").val());
            $("#aDate").val($("#selectedArriveDate").val());
        } else {
        	$('#dateRange').text($("#selectedDepartDate").val());
        	$("#dDate").val($("#selectedDepartDate").val());
        }
        // 모달 창 닫기
        console.log($("#selectedDepartDate").val()  + " ~ " + $("#selectedArriveDate").val());
        $('#datePickerModal').modal('hide');
        $('.modal-backdrop').remove();
    });
    
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
	$(".cntControl").click(function(){
// 		alert($(this).val());
// 		alert(cnt);
		// 값을 가져온다.
		let inputField = $(this).parent("span").find("input");
		let cntValue = parseInt($(this).parent("span").find("input").val());
		let increment = parseInt($(this).val());
		
		// 계산 값
		let newCnt = cntValue + increment;
		if (newCnt >= 0) {
			inputField.val(newCnt);
		}
		
		if ($("#adultCnt") == 0) {
			$(".alert-danger").show();
		}
	});
	
	// 인원 정보를 버튼으로 전송
	$("#comfirmPassengerBtn").click(function() {
		let adultCnt = parseInt($("#adultCnt").val());
		let childCnt = parseInt($("#childCnt").val());
		let infantCnt = parseInt($("#infantCnt").val());
		let totalCnt = adultCnt + childCnt + infantCnt;
// 		alert("성인 : " + adultCnt + ", 소아 : " + childCnt + ", 유아 : " + infantCnt);
		
		$("#aPassenger").val(adultCnt);
		$("#cPassenger").val(childCnt);
		$("#iPassenger").val(infantCnt);
		$('#totalPassenger').text("성인 : " + adultCnt + ", 소아 : " + childCnt + ", 유아 : " + infantCnt + " - 총 " + totalCnt + "명");
		$('#passengerModal').modal('hide');
	});
	
	
	// 좌석 등급 선택
	// span 클릭 시 아래에 div 창을 오버레이 밖에 표시
    $('#inputSeat').click(function() {
        // 현재 클릭한 span 태그의 위치 계산
        let offset = $(this).offset();
        
        // 모달 오픈
        $("#seatInfo").modal("show");
    });
	
	$(".seatBtn").click(function() {
		let seatGrade = $(this).data("seatgrade");
// 		alert(seatGrade);
		$("#selectedSeat").text(seatGrade);
		$("#seatGrade").val(seatGrade);
		$(".seatBtn").removeClass("active");
		$(this).addClass("active");
		$("#seatInfo").modal("hide");
	});
	
	// 항공권 검색 버튼 눌렀을 때 데이터 유효성 검사
	$("#topSearchBtn").click(function() {
		let departure = $("#dCode").val();
		let arrival = $("#aCode").val();
		let departureTime = $("#dDate").val();
		let arrivalTime = $("#aDate").val();
		let adult = parseInt($("#aPassenger").val());
		let child = parseInt($("#cPassenger").val());
		let infant = parseInt($("#iPassenger").val());
		let type = $("#tripType").val();
		
		let totalCnt = adult + child + infant;
		
// 		alert("1.departure : " + departure + ", 2. arrival :" + arrival + ", 3. departureTime :" + departureTime
// 				+ ", 4.arrivalTime : " + arrivalTime + ", 5. adult : " + adult + ", 6. child : " + child 
// 				+ ", 7. infant : " + infant + ", 8. type : " + type);
		if (departure === null || departure === "" || arrival === null || arrival === "") {
			alert("출발지와 도착지는 필수 입니다. 출발지와 도착지를 선택해 주세요.");
			return false;
		}
		if (type === "왕복" && (arrivalTime === null || arrivalTime === "")) {
			alert("왕복 항공권 검색은 돌아오는 날 일정을 선택해야 합니다.");
			return false;
		}
		if (totalCnt == 0) {
			alert("최소 1인 이상 선택되어야 합니다.");
			return false;
		}
		
	});
	
	$(".selectedTicket").click(function() {
		$(".dataRow").removeClass("selected");
		$(this).closest(".dataRow").addClass("selected");
		
		let text = ''
		
		let airlineKor = $(this).closest(".dataRow").find("#selectedAirlineKor").text();
		let flightName = $(this).closest(".dataRow").find("#selectedFlightName").text();
		let departDate = $(this).data("date");
		let departureTime = $(this).closest(".dataRow").find("#selectedDepartTime").text();
		let arrivalTime = $(this).closest(".dataRow").find("#selectedAriivalTime").text();
		let departure = $(this).closest(".dataRow").find("#selectedDeparture").text();
		let departureKor = $(this).closest(".dataRow").find("#selecteDepartureKor").text();
		let arrival = $(this).closest(".dataRow").find("#selectedArrival").text();
		let arrivalEng = $(this).closest(".dataRow").find("#selectedArrivalKor").text();
		let seatGrade = $(this).closest(".dataRow").find("#selectedSeatGrade").text();
		let scheduleId_a = $(this).data("scheduleid");
		
		let arrivePrice = $(this).closest(".dataRow").find(".totalPrice").data("totalprice");
		
		let adult = parseInt($(this).data("adult"), 10);
		let child = parseInt($(this).data("child"), 10);
		let infant = parseInt($(this).data("infant"), 10);
		
		// 숫자가 아닌 값 처리 (예를 들어 NaN 발생시 0으로 대체)
	    adult = isNaN(adult) ? 0 : adult;
	    child = isNaN(child) ? 0 : child;
	    infant = isNaN(infant) ? 0 : infant;
	    
	    console.log(adult);
	    
		let adultPrice = adult * arrivePrice;
		let childPrice = (child * arrivePrice) * 0.75;
		let infantPrice = (infant * arrivePrice) * 0.1;
		let departPrice = parseInt($(this).data("departprice"));
		
		let totalPrice = adultPrice + childPrice + infantPrice + departPrice;
		console.log(totalPrice);
		
		text += "오는 편 : ";
		text += airlineKor + " (" + flightName + ") " + departDate + " (" + departureTime + " ~ " + arrivalTime + ") " + seatGrade;
		
		$("#bottomArriveInfo").text(text);
		$("#totalPrice").text(addCommas(totalPrice));
		$("#arrivePrice").val(arrivePrice);
		$("#nextAirlineKor").val(airlineKor);
		$("#nextFlightName").val(flightName);
		$("#nextDepartureTime").val(departureTime);
		$("#nextArrivalTime").val(arrivalTime);
		$("#scheduleId_a").val(scheduleId_a);
		
		$("#nextForm").attr("action", "/airReservation/writeForm.do");
		$("#nextForm").attr("method", "post");
		$(".nextBtn").attr("type","submit");
		$(".nextBtn").removeClass("disabled");
		
	});
	
});
</script>

</head>
<body>
<body>
<div class="background-image">
	<div class="overlay">
		<!-- 공항 및 항공권 예약 관련 내용 -->
		<div class="searchAir">
			 <div class="row justify-content-center align-items-center m-0">
			 	 <!-- 출발 공항 클릭 시 히든 창 열기 -->
      				 <div class="col-sm d-flex justify-content-around align-items-center" >
					<button class="airport p-2 mt-3" id="departureAirport" >
						<span id="departure" >
							<b>${param.departure }</b>
						</span>
					</button>
					
					<!-- 공항 변환 아이콘 -->
					<span class="swap-button mt-4">
						<i class="material-icons" style="font-size:30px;color:#E37027;">swap_horizontal_circle</i>
					</span>
					
					<!-- 도착 공항 클릭 시 히든 창 열기 -->
					<button class="airport p-2 mt-3" id="arrivalAirport">
						<span id="arrival">
							<b>${param.arrival }</b>
						</span>
					</button>
				</div>
				<span class="mt-3">|</span>
				<div class="col-sm-3 ml-3 mr-3 mt-3" style="width:300px;">
					<span class="d-flex align-items-center" id="inputDate" data-toggle="modal" 
						data-target="#datePickerModal">
						<i class="material-icons mr-3" style="font-size:22px">date_range</i> 
						<b>
						<span id="dateRange">${param.arrivalTime }
							<c:if test="${!empty param.arrivalTime }">
								~ ${param.departureTime }
							</c:if>
						</span>
						</b>
						
					</span>
				</div>
				<span class="mt-3">|</span>
				<div class="col-sm ml-3 mr-3 mt-3">
					<span class="d-flex align-items-center" id="passenger" data-toggle="modal" 
						data-target="#passengerModal">
						<i class="fa fa-user mr-3" style="font-size:24px"></i> 
						<c:if test="${!empty param.aPassenger }">
							<b><span id="aPassenger">성인 : ${param.aPassenger }</span></b>
						</c:if>
						<c:if test="${!empty param.cPassenger }">
							<b><span id="cPassenger">, 소아 : ${param.cPassenger }</span></b>
						</c:if>
						<c:if test="${!empty param.iPassenger }">
							<b><span id="iPassenger">, 유아 : ${param.iPassenger }</span></b>
						</c:if>
					</span>
				</div>
				<span class="mt-3">|</span>
				<div class="col-sm ml-3 mr-3 mt-3">
					<span class="d-flex align-items-center" id="inputSeat">
						<i class="material-icons mr-3" style="font-size:24px">airline_seat_recline_extra</i>
						<b><span id="selectedSeat">${param.seatGrade }</span></b>
					</span>
					
				</div>
				<div class="col-sm">
					<form action="/air/selectFlight-D.do" method="post">
						<input type="hidden" id="tripType" name="type" value="${param.type }">
						<input type="hidden" id="dCode" name="departure" value="${param.departure }">
						<input type="hidden" id="aCode" name="arrival" value="${param.arrival }">
						<input type="hidden" id="dDate" name="departureTime" value="${param.departureTime }">
						<input type="hidden" id="aDate" name="arrivalTime" value="${param.arrivalTime }">
						<input type="hidden" id="aPassenger" name="aPassenger" value="${param.aPassenger }">
						<input type="hidden" id="cPassenger" name="cPassenger" value="${param.cPassemger }">
						<input type="hidden" id="iPassenger" name="iPassenger" value="${param.iPassenger }">
						<input type="hidden" id="seatGrade" name="seatGrade"value="${param.seatGrade }">
						
						<button class="searchBtn" id="topSearchBtn" style="width:90%">
							항공편 검색
						</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="container">
<p>
	<div class="card">
		<div class="card-header">
			<h3 id="header">돌아오는 항공편 검색</h3>
		</div>
		<div class="card-body bg-light">
			<c:if test="${!empty list }">
				<c:forEach items="${list }" var="list">
					<div class="media border p-4 dataRow">
						<img src="${list.photo }" class="mr-5 mt-5" style="width:130px;">
						<div class="media-body row">
							<div class="col-sm-9">
								<span id="selectedAirlineKor">${list.airlineKor }</span>
								<span class="mt-2" id="selectedFlightName">${list.flightName }</span>
								<p>
								<h5>
									<b>
										<span id="selectedDepartTime">${list.departureTime }</span>
										 ~ 
										<span id="selectedAriivalTime">${list.arrivalTime }</span>
									</b> 
									<small><i>(소요시간 : ${list.duration })</i></small>
								</h5>
								<span id="selectedDeparture">${list.departure }</span> 
									(<span id="selecteDepartureKor">${list.departureKor }</span>) 
									- 
								<span id="selectedArrival">${list.arrival }</span>
									(<span id="selectedArrivalKor">${list.arrivalKor }</span>)
							</div>
							<div class="col-sm-3">
								<span id="selectedSeatGrade"><b>${param.seatGrade }</b></span> 기준
								<br>
								<span style="font-size: 24px; font-weight:bold;" id="selectedTotalPrice">
									<b>
								    <!-- 일반석일 경우 -->
								    <c:if test="${param.seatGrade == '일반석'}">
								        <span class="totalPrice" data-totalprice="${list.totalPrice}">${list.totalPrice} 원</span>
								    </c:if>
								    
								    <!-- 비즈니스석일 경우 -->
								    <c:if test="${param.seatGrade == '비즈니스석'}">
								        <span class="totalPrice" data-totalprice="${list.totalPrice * 2}">${list.totalPrice * 2} 원</span>
								    </c:if>
								    
								    <!-- 퍼스트 클래스일 경우 -->
								    <c:if test="${param.seatGrade == '일등석'}">
								        <span class="totalPrice" data-totalprice="${list.totalPrice * 4}">${list.totalPrice * 4} 원</span>
								    </c:if>
									</b>
								</span>
								<button class="searchBtn selectedTicket"style="width:90%" 
									data-date="${param.departureTime }"
									data-adult="${param.aPassenger }"
									data-child="${param.cPassenger }"
									data-infant="${param.iPassenger }"
									data-departprice="${param.departPrice }"
									data-scheduleid="${list.scheduleId }"
									>항공편 선택</button>
							</div>
						</div>
					</div>
				</c:forEach>
			<div class="card-footer">
				<div>
					검색한 노선의 항공권 리스트 입니다.
				</div>
			</div>
			</c:if>
			<c:if test="${empty list }">
				<div class="alert alert-warning">
					<strong>선택한 날짜에 운항 가능한 항공편이 없습니다.</strong> 다른 날짜를 선택해 주세요.
				</div>
			</c:if>
		</div>
	</div>
</div>
<div class="fixed-bottom-bar">
	<div class="container">
		<form id="nextForm">
			<!-- 첫번째 선택 데이터 - 가는 편 -->
			<input type="hidden" id="firstDeparture" name="firstDeparture" value="${param.arrival }">
			<input type="hidden" id="firstArrival" name="firstArrival" value="${param.departure }">
			<input type="hidden" id="departPrice" name="departPrice" value="${param.departPrice }">
			<input type="hidden" id="scheduleId_d" name="scheduleId_d" value="${param.scheduleId_d }" >
			
			<!-- 두번째 선택 데이터 - 돌아오는 편 -->
			<input type="hidden" id="secondDeparture" name="secondDeparture" value="${param.departure }">
			<input type="hidden" id="secondArrival" name="secondArrival" value="${param.arrival }">
			<input type="hidden" id="arrivePrice" name="arrivePrice" >
			<input type="hidden" id="scheduleId_a" name="scheduleId_a" >
			
			<!-- 탑승객 정보 인원수 : aPassenger - 성인 / cPassenger - 소아 / iPassenger - 유아 -->
			<input type="hidden" id="nextAPassenger" name="aPassenger" value="${param.aPassenger }">
			<input type="hidden" id="nextCPassenger" name="cPassenger" value="${param.cPassenger }">
			<input type="hidden" id="nextIPassenger" name="iPassenger" value="${param.iPassenger }">
			<!-- 좌석 정보 -->
			<input type="hidden" id="nextSeatGrade" name="seatGrade" value="${param.seatGrade }">
			<!-- 항공권 타입 : 편도/왕복 -->
			<input type="hidden" id="nextTripType" name="type" value="${param.type }">
			
			<div class="float-right">
					<button type="button" class="searchBtn float-right ml-5 nextBtn disabled" style="width: 150px;">항공편 예약</button>
				<div class="float-right" style="font-size:24px; font-weight:bold;">
					총액 : <span id="totalPrice" class="totalPrice"> ${param.departPrice }</span> 원
				</div>
			</div>
			<span id="bottomDepartInfo">가는 편 : 
				${param.airlineKor } (${param.flightName }) ${param.arrivalTime } (${param.paramDepartureTime }
				 ~ 
				 ${param.paramArrivalTime }) ${param.seatGrade }
			</span>
			<br>
			<c:if test="${param.type == '왕복' }">
				<span id="bottomArriveInfo">오는 편 : </span>
			</c:if>
		</form>
	</div>
</div>

<!-- 공항 검색 -->
<div id="airportList" class="modal">
	<div class="modal-dialog modal-md modal-dialog-centered passengerModal" role="document" >
        <div class="modal-content">
            <div class="modal-header">
				<h5><strong>출발지 검색</strong></h5>
			</div>
			<div class="modal-body">
				<input class="form-control mt-3" placeholder="공항 또는 도시 검색" id="searchAirport" autocomplete="off">
				
				<!-- 검색 결과 출력 -->
				<div id="airportListResults" class="mt-3">
				
				</div>
			</div>
			<div class="modal-footer">
				<p class="mt-5">
					<i class="material-icons" style="font-size:18px;color:#E37027">place</i>
					<strong>모든 공항 보기</strong>
				</p>
			</div>
		</div>
	</div>
</div>

<!-- 모달 창 -->
<div class="modal" id="datePickerModal">
    <div class="modal-dialog modal-xl modal-dialog-centered dateModal" role="document" >
        <div class="modal-content">
            <div class="modal-header">
            	
                <h5 class="modal-title" id="datePickerModalLabel"><strong>여정 일자 선택</strong></h5> 
                
                <div id="modalType" class="selectType justify-content-center">
					<span class="type ${(param.type == '왕복')?'active' : '' }" id="modalTypeGoBack"><strong>왕복</strong></span>
					<span class="type ${(param.type == '편도')?'active' : '' }" id="modalTypeGo"><strong>편도</strong></span>
					<span class="type" id="modalTypeGoMany"><strong>다구간</strong></span>
				</div>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- 달력이 표시될 곳 -->
                <div class="row ">
                	<div class="col goType">
	                	<div style="text-align:center;" class="mb-2">
	                		<i class="material-icons mb-0 mr-2" style="font-size:18px;color:#E37027">flight_takeoff</i>
	          				<b> 가는 날 선택</b>
	          			</div>
	                	<div id="departureCalendar" class="mb-3"></div>
		            </div>
		            <div class="col backType">
		            	<div style="text-align:center;" class="mb-2">
	                		<i class="material-icons mb-0 mr-2" style="font-size:18px;color:#E37027">flight_land</i>
	          				<b> 오는 날 선택</b>
	          			</div>
	          			<div id="arrivalCalendar" class="mb-3"></div>
	                </div>
                </div>
            </div>
            <div class="modal-footer align-items-bottom">
            	<div class="form-inline">
            		<span class="goType">
		          		<label for="selectedDepartDate" class="float-left" >
		          			<i class="material-icons mb-0 mr-2" style="font-size:18px;color:#E37027">flight_takeoff</i>
		          			<b> 가는 날</b>
		          		</label>
		          		<br>
				        <input class="form-control mr-3 mb-3" id="selectedDepartDate" placeholder="${param.departureTime }" readonly
				        	value="${param.departureTime }">
			        </span>
			        <span class="mr-3 backType"> ~ </span>
			        <span class="backType">
				        <label for="selectedArriveDate" class="float-left" >
				        	<i class="material-icons mb-0 mr-2" style="font-size:18px;color:#E37027">flight_land</i>
				        	<b>오는 날</b>
				        </label>
		          		<br>
		                <input class="form-control mr-3 mb-3" id="selectedArriveDate" placeholder="${param.arrivalTime }" readonly
		                	value="${param.arrivalTime }">
	                </span>
		        </div>
                <button type="button" id="confirmDateBtn" class="btn btn-primary">일정 선택 완료</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<!-- 인원 선택 -->
<div class="modal" id="passengerModal">
    <div class="modal-dialog modal-md modal-dialog-centered passengerModal" role="document" >
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="passengerModalLabel"><strong>탑승객 선택</strong></h5> 
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            
            <div class="modal-body">
            	<div class="alert alert-danger">
					<strong>탑승객은 성인 1명을 포함해야 합니다.</strong> 
				</div>
            	<ul>
            		<li class="mb-5 flex-container">
				      	<div class="d-flex align-items-center">
					      	<i class="material-icons" style="font-size:36px">person_pin_circle</i>
					        <b style="font-size:20px;">성인(Adult)</b>
					        <a href="#" data-toggle="tooltip" data-placement="top" title="출발일 기준 만 12세 이상">
					          	<i class="fa fa-question-circle ml-2"></i>
					        </a>
				     	 </div>
				      
				      <span class="d-flex justify-content-center align-items-center mr-5">
					        <button class="btn btn-light btn-sm cntControl -sub" value="-1"><i class="fa fa-minus"></i></button>
					        <input class="inputPassenger form-control" id="adultCnt" type="number" value="1" min="0">
					        <button class="btn btn-light btn-sm cntControl +add" value="+1"><i class="fa fa-plus"></i></button>
				      </span>
				    </li>
            		<li class="mb-5 flex-container">
				      	<div class="d-flex align-items-center">
					      	<i class="material-icons" style="font-size:36px">person_pin_circle</i>
	            			<b style="font-size:20px;">소아(Child)</b> 
	            			<a href="#" data-toggle="tooltip" data-placement="top" title="출발일 기준 만 12세 미만">
	            				<i class="fa fa-question-circle" style="font-size:24px; color:#E37027;"></i>
	            			</a>
            			</div>
            			<span class="d-flex justify-content-center align-items-center mr-5">
					        <button class="btn btn-light btn-sm cntControl -sub" value="-1"><i class="fa fa-minus"></i></button>
					        <input class="inputPassenger form-control" id="childCnt" type="number" value="0" min="0">
					        <button class="btn btn-light btn-sm cntControl +add" value="+1"><i class="fa fa-plus"></i></button>
				      	</span>
            		</li>
            		<li class="mb-5 flex-container">
	            		<div class="d-flex align-items-center">
					      	<i class="material-icons" style="font-size:36px">person_pin_circle</i>
	            			<b style="font-size:20px;">유아(Infant)</b> 
	            			<a href="#" data-toggle="tooltip" data-placement="top" title="출발일 기준 만 2세 미만">
	            				<i class="fa fa-question-circle" style="font-size:24px; color:#E37027;"></i>
	            			</a>
	            		</div>
	            		<span class="d-flex justify-content-center align-items-center mr-5">
					        <button class="btn btn-light btn-sm cntControl -sub" value="-1"><i class="fa fa-minus"></i></button>
					        <input class="inputPassenger form-control" id="infantCnt" type="number" value="0" min="0">
					        <button class="btn btn-light btn-sm cntControl +add" value="+1"><i class="fa fa-plus"></i></button>
				      	</span>
            		</li>
            	</ul>
            </div>
            
            <div class="modal-footer align-items-bottom">
                <button type="button" id="comfirmPassengerBtn" class="btn btn-primary">탑승객 선택 완료</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
<div class="modal seat-info" id="seatInfo">
    <div class="modal-dialog modal-md modal-dialog-centered passengerModal" role="document" >
        <div class="modal-content">
            <div class="modal-header">
				<h5>좌석 등급 선택</h5>
			</div>
			<div class="modal-body mx-auto">
				<div class="btn-group btn-group-lg mx-auto">
			        <button class="btn btn-light seatBtn active" id="ecoSeat" data-seatgrade="일반석">일반석</button>
			        <button class="btn btn-light seatBtn" id="bisSeat" data-seatgrade="비즈니스석">비즈니스석</button>
			        <button class="btn btn-light seatBtn" id="fstSeat" data-seatgrade="일등석">일등석</button>
			    </div>
			</div>
		</div>
	</div>
</div>
</body>
</html>