<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <%@ taglib prefix="pagNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>항공 관리자</title>
<style type="text/css">
body td {
	color: #444;
}
th {
	background-color: #ff8533;
	color:white;
}
.choice {
	background-color: #FF9933;
	border-radius:5px;
	color: white !important;
}
li > a{
	color:black;
}

.dataRow:hover {
	background: #d4d4d4;
	cursor:pointer;
}
.dataRow > .card-header {
	background: #e0e0e0;
}
#header:hover {
	cursor:pointer;
}

fieldset {
	border-radius:15px; 
	background-color:#e0e0e0;
}

legend {
	font-size:16px; 
	background-color:white; 
	border-radius:5px;
}
.searchBtn:hover {
	cursor:pointer;
	background-color: #e25600 !important;
}
.searchBtn {
	background-color:#FF9C2A; 
	padding:10px; 
	border-radius:5px; 
	color:white; 
	font-weight:bold;
	text-align:center; 
	box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.5);
	border:1px solid rgba(255, 255, 255, 0);
}

.hiddenInput {
/* 	display: none; */
}
.selected {
	background-color: #FEDB92;
}

</style>
<script type="text/javascript" src="/js/priceAddComma.js"></script>
<script type="text/javascript">
$(function() {
	
	$(".dataRow").click(function() {
		
		let routeId = $(this).find(".routeId").data("routeid");
		alert(routeId);
		location="airSheduleDetail.do?routeId=" + routeId;
		
	});
	
	// 바로 스케줄 없는 항공편 리스트 세팅
	$(".flightList").load("/airajax/getFlightList.do?airlineNo=22");
	
	let inputRowCnt = 1;
	// input 항목 늘리기
	$(".addBtn").click(function(){
		
		
		if(inputRowCnt >= 10) {
			alert("스케줄 추가는 최대 5개까지만 가능합니다.");
			return false;
		}
		
		let inputRow = "";
		inputRow+= '<tr>'
		inputRow+= '<td>'		
		inputRow+= '<input class="form-control" value="${vo.departure } ~ ${vo.arrival}" readonly>'		
		inputRow+= '<input type="hidden" class="routeId" value="${vo.routeId }" name="list[' + inputRowCnt + '].routeId" readonly>'		
		inputRow+= '</td>'	
		inputRow+= '<td>'	
		inputRow+= '<select class="form-control flightList" name="list[' + inputRowCnt + '].flightName">'		
		inputRow+= '<option>KE5574</option>'			
		inputRow+= '</select>'		
		inputRow+= '</td>'	
		inputRow+= '<td>'	
		inputRow+= '<input type="date" class="form-control departureDate" name="list[' + inputRowCnt + '].departureDate" min="today">'		
		inputRow+= '</td>'	
		inputRow+= '<td>'	
		inputRow+= '<input type="time" class="form-control departureTimeStr" name="list[' + inputRowCnt + '].departureTimeStr">'		
		inputRow+= '<input type="hidden" class="departureTime" name="list[' + inputRowCnt + '].departureTime">'		
		inputRow+= '</td>'	
		inputRow+= '<td>'	
		inputRow+= '<input type="date" class="form-control arrivalDate" name="list[' + inputRowCnt + '].arrivalDate">'		
		inputRow+= '</td>'	
		inputRow+= '<td>'	
		inputRow+= '<input type="time" class="form-control arrivalTimeStr" name="list[' + inputRowCnt + '].arrivalTimeStr">'		
		inputRow+= '<input type="hidden" class="arrivalTime" name="list[' + inputRowCnt + '].arrivalTime">'		
		inputRow+= '</td>'	
		inputRow+= '<td>'	
		inputRow+= '<input class="form-control durationStr" name="list[' + inputRowCnt + '].durationStr" readonly>'		
		inputRow+= '<input type="hidden" class="duration" name="list[' + inputRowCnt + '].duration">'		
		inputRow+= '</td>'	
		inputRow+= '<td>'	
		inputRow+= '<i class="fa fa-close btn-danger btn inputDeleteBtn" style="color:white;"></i>'		
		inputRow+= '</td>'	
		inputRow+= '</tr>'
		
		let newRow = $(inputRow).clone();
		
		$("#inputRow").append(newRow);
		
		// 새로 추가된 행의 대분류 선택에 따른 중분류 리스트 세팅
	    newRow.find(".flightList").load("/airajax/getFlightList.do?airlineNo=22");
		return inputRowCnt++;
	});
	
	// inputRow x 버튼 클릭하면 해당 줄 삭제
	$("#inputRow").on("click", ".inputDeleteBtn", function() {
		
		$(this).closest("tr").remove();
		inputRowCnt--;
	});
	
	// 항공편 일괄 등록 버튼
	$("#totalAddBtn").click(function(){
		$("#scheduleWriteForm").attr("action", "airAdminScheduleWrite.do");
        $("#scheduleWriteForm").attr("method", "post");
        $("#scheduleWriteForm").submit();
		$(this).html('<span class="spinner-border spinner-border-sm"></span> Loading..');
	});
	
	// 반복등록 체크하면 폼 안에 날짜 입력 불가
	$('#repeat').change(function() {
        if ($(this).is(':checked')) {
            // 체크박스가 체크되면 아래 인풋 필드들을 비활성화
            $('#startDate').prop('disabled', false);
            $('#endDate').prop('disabled', false);
        } else {
            // 체크박스가 체크 해제되면 인풋 필드들을 다시 활성화
            $('#startDate').prop('disabled', true);
            $('#endDate').prop('disabled', true);
        }
    });
	
	// 도착 시간 입력 하면 소요시간 자동 계산
	$(document).on("change", ".arrivalTimeStr", function() {
	    // 데이터 수집
	    let departureDate = $(this).closest("tr").find(".departureDate").val();
	    let departureTime = $(this).closest("tr").find(".departureTimeStr").val();
	    let arrivalDate = $(this).closest("tr").find(".arrivalDate").val();
	    let arrivalTime = $(this).closest("tr").find(".arrivalTimeStr").val();
		
		// 시간을 분으로 변환하는 함수
	    function timeToMinutes(time) {
	        let parts = time.split(":");
	        return parseInt(parts[0], 10) * 60 + parseInt(parts[1], 10);
	    }
	    
	    // 시간을 분으로 변환
	    let departureMinutes = timeToMinutes(departureTime);
	    let arrivalMinutes = timeToMinutes(arrivalTime);
	    
	    // 소요 시간 계산
	    let durationMinutes = arrivalMinutes - departureMinutes;
	    
	    // 음수일 경우, 다음 날로 간주하여 24시간(1440분)을 더함
	    if (durationMinutes < 0) {
	        durationMinutes += 24 * 60;
	    }
	    
	    // 시간을 시간과 분으로 변환
	    let hours = Math.floor(durationMinutes / 60);
	    let minutes = durationMinutes % 60;
	    
		 // 시간을 "HH:mm" 형식으로 변환
	    let formattedDuration = (hours < 10 ? '0' + hours : hours) + ':' + (minutes < 10 ? '0' + minutes : minutes);
	    
	    // alert("departureTime: " + departureTime + ", arrivalTime: " + arrivalTime + ", duration: " + hours + "시간 " + minutes + "분");
	    
	    // 계산된 소요 시간을 input 태그에 설정
	    $(this).closest("tr").find(".durationStr").val(hours + "시간 " + minutes + "분");
	    $(this).closest("tr").find(".duration").val(durationMinutes);
	    $(this).closest("tr").find(".departureTime").val(departureDate + " " + departureTime);
	    $(this).closest("tr").find(".arrivalTime").val(arrivalDate + " " + arrivalTime);
	});
	
	// 반복 등록시 날짜 계산
	$("#endDate").change(function() {
		
		// 데이터 수집
		let startDateStr = $("#startDate").val();
		let endDateStr = $(this).val();
		
		// Date 객체로 변환
	    let startDate = new Date(startDateStr);
	    let endDate = new Date(endDateStr);
	    
	    // 날짜 차이를 밀리초 단위로 계산한 후, 일(day) 단위로 변환
	    let timeDiff = endDate.getTime() - startDate.getTime(); // 밀리초 차이
	    let repeatDays = timeDiff / (1000 * 3600 * 24); // 밀리초 -> 일 단위로 변환
	    
	    $("#repeatDays").val(repeatDays);
		
// 		alert("startDate : " + startDate + ", endDate : " + endDate + ", repeatDays : " + repeatDays);
		
	});
	
	
	
});
</script>

</head>
<body>
<div class="container-fluid p-3">
	<div class="card">
		<div class="card-header">
			<h4>항공 관리</h4>
			<!-- Nav tabs -->
			<ul class="nav nav-pills">
				<li class="nav-item">
					<a class="nav-link" href="airAdmin.do"> 
						<Strong>항공사 관리</Strong>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="airAdminNOC.do"> 
						<Strong>국가 및 공항 관리</Strong>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="airAdminAirplane.do"> 
						<Strong>항공사 기종 관리</Strong>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="airAdminRoutePrice.do"> 
						<Strong>노선 및 운임 관리</Strong>
					</a>
				</li>
				<li class="nav-item choice">
					<a class="nav-link choice" href="airAdminSchedule.do"> 
						<Strong>운항 스케줄 관리</Strong>
					</a>
				</li>
			</ul>
		</div>
		<div class="card-body">
			<h3>
				운항 스케줄 상세보기
					<span class="ml-3 mt-2" style="font-size:14px;">
						선택한 노선에 대한 스케줄 리스트 입니다.
					</span>
			</h3>
			<fieldset class="border p-4">
				<legend class="w-auto px-2"> <b>[ 노선 정보 ]</b></legend>
					<button class="btn btn-sm btn-secondary" onclick="history.back()"><b><i class="	fa fa-angle-double-left"></i> Back</b></button>
					<table class="table table-sm text-center align-middle mt-2">
						<tr>
							<th style=width:8%;>노선번호</th>
							<th style=width:8%;>타입</th>
							<th style="">출발 국가</th>
							<th style="width:8%;">출발지</th>
							<th style="">출발 공항</th>
							<th style="">도착 국가</th>
							<th style="width:8%;">도착지</th>
							<th style="">도착 공항</th>
							<th style=width:16%;>거리</th>
						</tr>
							<tr class="">
								<td class="routeId" data-routeid="${vo.routeId}">${vo.routeId }</td>
								<td class="type" data-type="${vo.type}">${(vo.type =='I')? '국제선' : '국내선'}</td>
								<td class="departureCountry">${vo.departureCountry }</td>
								<td class="departure" data-departure="${vo.departure}">${vo.departure }</td>
								<td class="departureAirport" data-departureairport="${vo.departureKor}">${vo.departureKor }</td>
								<td class="arrivalCountry" >${vo.arrivalCountry }</td>
								<td class="arrival" data-arrival="${vo.arrival}">${vo.arrival }</td>
								<td class="arrivalAirport" data-arrivalairport="${vo.arrivalKor}">${vo.arrivalKor }</td>
								<td class="distance" data-distance="${vo.distance}">
									<fmt:formatNumber value="${vo.distance}" type="number" /> km
								</td>
							</tr>
					</table>
			</fieldset>
			<hr>
			<h5>
				운항 스케줄 등록
			</h5>
			<form id="scheduleWriteForm">
				<div>
					<button type="button" class="btn searchBtn float-right" id="totalAddBtn">일괄 등록</button>
					<button type="button" class="btn-warning btn addBtn mr-3"><i class="fa fa-plus "></i></button>스케줄 추가
					<div class="form-inline float-right">
						<div class="input-group m-2">
							<input type="checkbox" id="repeat" name="repeat" class="mr-2" style="width:20px;">
							<label class="mr-2"><Strong>반복 등록</Strong></label>
							<input type="date" id="startDate" name="startDate" class="form-control mr-2" disabled> 
							<label class="mr-2">부터</label>
							<input type="date" id="endDate" name="endDate" class="form-control mr-2 ml-2" disabled>
							<label class="mr-2">까지</label>
							<input type="hidden" id="repeatDays" name="repeatDays">
						</div>
					</div>
					
					<table class="table text-center">
						<tr>
							<th style="width:10%">노선</th>
							<th style="width:15%">운항편명</th>
							<th style="width:15%;">출발일</th>
							<th style="width:15%;">출발시간</th>
							<th style="width:15%;">도착일</th>
							<th style="width:15%;">도착시간</th>
							<th style="width:10%">소요시간</th>
							<th style="width:5%">삭제</th>
						</tr>
					<tbody id="inputRow">
						<tr>
							<td>
								<input class="form-control" value="${vo.departure } ~ ${vo.arrival}" readonly>
								<input type="hidden" class="routeId" value="${vo.routeId }" name="list[0].routeId" readonly>
								<input type="hidden" value="${vo.routeId }" name="routeId" readonly>
							</td>
							<td>
								<select class="form-control flightList" name="list[0].flightName">
									<option>KE5574</option>
								</select>
							</td>
							<td>
								<input type="date" class="form-control departureDate" name="list[0].departureDate" min="today">
							</td>
							<td>
								<input type="time" class="form-control departureTimeStr" name="list[0].departureTimeStr">
								<input type="hidden" class="departureTime" name="list[0].departureTime">
							</td>
							<td>
								<input type="date" class="form-control arrivalDate" name="list[0].arrivalDate">
							</td>
							<td>
								<input type="time" class="form-control arrivalTimeStr" name="list[0].arrivalTimeStr">
								<input type="hidden" class="arrivalTime" name="list[0].arrivalTime">
							</td>
							<td>
								<input class="form-control durationStr" name="list[0].durationStr" readonly>
								<input type="hidden" class="duration" name="list[0].duration">
							</td>
							<td>
								<i class="fa fa-close btn-light btn firstInputDeleteBtn" style="color:white;"></i>
							</td>
						</tr>
					</tbody>
					</table>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>