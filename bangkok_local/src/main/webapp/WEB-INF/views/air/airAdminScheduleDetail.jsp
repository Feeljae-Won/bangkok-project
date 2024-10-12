<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <%@ taglib prefix="pageNavSchedule" tagdir="/WEB-INF/tags" %>
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
// 		alert(routeId);
// 		location="airSheduleDetail.do?routeId=" + routeId;
		
	});
	
	// 스케줄 추가 버튼
	$("#scheduleAddBtn").click(function(){
		let routeId = $(".routeId").data("routeid");
// 		alert(routeId);
		location = "airAdminScheduleWriteForm.do?routeId=" + routeId;
	});
	
	// 스케줄 수정
	$(".scheduleUpdateBtn").click(function() {
		
		// 데이터 수집
		let scheduleId = $(this).closest(".dataRow").find(".scheduleId").val();
		let departrue = $(this).closest(".dataRow").find(".departure").val();
		let arrival = $(this).closest(".dataRow").find(".arrival").val();
		let departDate = $(this).closest(".dataRow").find(".departDate").val();
		let departTimeStr = $(this).closest(".dataRow").find(".departTimeStr").val();
		let arrivalDate = $(this).closest(".dataRow").find(".arrivalDate").val();
		let arrivalTimeStr = $(this).closest(".dataRow").find(".arrivalTimeStr").val();
		
		$("#updateScheduleModal").modal("show");
	});
	
	// 스케줄 수정
	$(".scheduleDeleteBtn").click(function() {
		let scheduleId = $(this).closest(".dataRow").find(".scheduleId").data("scheduleid");
		let routeId = $(this).data("routeid");
		
// 		alert("scheduleId : " + scheduleId + ", routeId : " + routeId);
		location = "airAdminScheduleDelete.do?scheduleId=" + scheduleId + "&routeId=" + routeId;
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
							<th style="">출발지</th>
							<th style="">출발 공항</th>
							<th style="">도착 국가</th>
							<th style="">도착지</th>
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
			<!-- 검색 -->
			<div class="row float-right">
			  	<div class="col-md-4 form-inline ">
			  		<div class="form-group">
						<select class="form-control" name="searchKey" id="searchKey"  style="margin: 0 10px;">
								<option value="all">모두</option>
								<option value="flightName">출발 국가</option>
								<option value="airplaneId">출발 공항 코드</option>
								<option value="airplanePdt">출발 공항</option>
								<option value="flightName">도착 국가</option>
								<option value="airplaneId">도착 공항 코드</option>
								<option value="airplanePdt">도착 공항</option>
								<!-- ajax를 이용한 중분류 option 로딩하기 -->
						</select>
						<input class="form-control " id="searchWord" name="searchWord" placeholder="검색">
						<div class="input-group-append">
						    <button class="btn btn-outline-primary " id="searchBtn">
						     	<i class="fa fa-search"></i>
						    </button>
						</div>
					</div>
			  	</div>
			</div>
			<h5>
				운항 스케줄 리스트
				<button class="btn btn-sm btn-warning" id="scheduleAddBtn"><i class="fa fa-plus"></i> add</button>
			</h5>
			<table class="table text-center align-middle mt-2">
				<tr>
					<th style="width:10%;">스케줄 번호</th>
					<th style="width:10%;">출발지</th>
					<th style="">출발 시간</th>
					<th style="width:10%;">도착지</th>
					<th style="">도착 시간</th>
					<th style="width:15%;">소요시간</th>
					<th style="width:10%;">운항 편명</th>
					<th style="width:6%">상태</th>
					<th style="width:8%">편집</th>
				</tr>
				<c:if test="${!empty scheduleList }">
					<c:forEach items="${scheduleList }" var="vo">
						<tr class="dataRow">
							<td class="scheduleId" data-scheduleid="${vo.scheduleId}">${vo.scheduleId }</td>
							<td class="departure" >${vo.departure }</td>
							<td class="departureTime" >${vo.departureTime }</td>
							<td class="arrival" >${vo.arrival }</td>
							<td class="arrivalTime" >${vo.arrivalTime }</td>
							<td class="duration" >${vo.duration }</td>
							<td class="flightName" >${vo.flightName }</td>
							<td class="status" >${vo.status }</td>
							<td class="btn-group" >
								<button class="btn btn-sm btn-light scheduleUpdateBtn"><i class="fa fa-pencil" style="font-size:18px;"></i></button>
								<button class="btn btn-sm btn-danger scheduleDeleteBtn" data-routeid="${vo.routeId }"><i class="fa fa-minus"></i></button>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty scheduleList }">
					<tr>
						<td colspan="12">
							<div class="alert alert-warning">
								<strong>해당 항공편의 스케줄이 없습니다.</strong> 운항 스케줄을 등록해 주세요.
							</div>
						</td>
					</tr>
				</c:if>
			</table>
		</div>
		<div class="card-footer">
			<div>
				<pageNavSchedule:pageNavSchedule listURI="airAdminScheduleDetail.do?routeId=${vo.routeId }" pageObject="${pageObject }"></pageNavSchedule:pageNavSchedule>
			</div>
		</div>
	</div>
</div>

<!-- 스케줄 수정 모달 -->
<div class="modal" id="updateScheduleModal">
  <div class="modal-dialog modal-xl modal-dialog-centered">
    <div class="modal-content">

      <form>
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">스케줄 수정</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
	      <div class="modal-body">
		      <div class="form-inline">
		        	<span>
			        	<strong>선택한 스케줄 : </strong>
			        	<input id="modalScheduleId" class="form-control" name="scheduleId" readonly>
			        	<input id="modalFlightName" class="form-control" name="flightName" readonly>
		       		</span>
	   			</div>
	   			<br>
		       <table class="table text-center">
					<tr>
						<th style="width:20%;">출발일</th>
						<th style="width:20%;">출발시간</th>
						<th style="width:20%;">도착일</th>
						<th style="width:20%;">도착시간</th>
						<th style="width:20%">소요시간</th>
					</tr>
				<tbody id="inputRow">
					<tr>
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
					</tr>
				</tbody>
				</table>
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	      </div>
      </form>

    </div>
  </div>
</div>
</body>
</html>