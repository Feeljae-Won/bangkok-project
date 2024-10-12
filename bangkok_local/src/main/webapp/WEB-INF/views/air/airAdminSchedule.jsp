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
// 		alert(routeId);
		location="airAdminScheduleDetail.do?routeId=" + routeId;
		
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
			
			<!-- Tab panes -->
			<div class="tab-content">
				<div id="nocTab" class="container-fluid p-3 tab-pane active">
					<h3>
						운항 스케줄 관리
					</h3>
					<small>
						<span class="ml-3 mt-2">
							해당 노선을 선택하면 <b>상세화면</b>으로 이동해 스케줄을 새로 <b>[ 등록 ]</b> 하거나 <b>[ 변경 ]</b> 할 수 있습니다.<br>
						</span>
					</small>
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
					<table class="table text-center align-middle mt-2">
						<tr>
							<th style="width:8%;">번호</th>
							<th style="width:8%;">타입</th>
							<th style="">출발 국가</th>
							<th style="width:8%;">출발지</th>
							<th style="">출발 공항</th>
							<th style="">도착 국가</th>
							<th style="width:8%;">도착지</th>
							<th style="">도착 공항</th>
							<th style="width:8%;">거리</th>
						</tr>
						<c:forEach items="${routeList }" var="vo">
							<tr class="dataRow">
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
						</c:forEach>
					</table>
				</div>
			</div>
			
		<div class="card-footer">
			<div>
				<pagNav:pageNav listURI="airAdminAirplane.do" pageObject="${pageObject }"></pagNav:pageNav>
			</div>
		</div>
	</div>
</div>
</div>
</body>
</html>