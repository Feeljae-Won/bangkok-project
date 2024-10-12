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
fieldset {
	border: 1px solid #e0e0e0;
	border-radius:5px; 
}

legend {
	font-size:20px; 
	background-color:white; 
	border-radius:5px;
}
.hiddenInput {
	display: none;
}
.selected {
	background-color: #FEDB92;
}
th {
	background-color: #ff8533;
	color:white;
}
</style>
<script type="text/javascript" src="/js/priceAddComma.js"></script>
<script type="text/javascript">
$(function() {
	
	// 노선 선택시 운임 정보 불러오기
	$(".dataRow").click(function() {
		
		let routeId = $(this).find(".routeId").data("routeid");
		let departure = $(this).find(".departure").data("departure");
		let arrival = $(this).find(".arrival").data("arrival");
		console.log(routeId);
		
		$(".priceList").remove();
		$(".dataRow").removeClass("selected");
		
		$(this).addClass("selected");
		
		$("#selectRouteId").text(routeId);
		$("#selectDeparture").text(departure);
		$("#selectArrival").text(arrival);
		
		$("#priceInfo").load("/airajax/getPrice.do?airlineNo=1&routeId=" + routeId);
		
	});
	
	// 노선 등록 창 보이기
	$("#addRouteBtn").click(function(){
		$(".hiddenInput").toggle();
		
		// 창이 열리면 체크박스 상태를 확인
	    $("#routeWriteBtn").click(function() {
	        
	    	let departure = $("#departure").val();
	    	let arrival = $("#arrival").val();
	    	let distance = $("#distance").val();
	    	let type = $("#type").val();
	    	let goback = $("#goBackStr").prop('checked');
	    	
	    	// 체크박스 상태 확인
	        if (goback) {
	            $("#goBackStr").val("true");  // 체크되었을 때 true 값을 설정
	        } else {
	            $("#goBackStr").val("false");  // 체크되지 않았을 때 hidden으로 false를 전달
	        }
	    	
// 	     	alert("goback = " + $("#goBackStr").val());

			if(departure == null || departure === "") {
				alert("출발지를 입력하셔야 합니다.");
				return false;
			} else if(arrival == null || arrival === "") {
				alert("도착지를 입력하셔야 합니다.");
				return false;
			} else if(distance == null || distance === "") {
				alert("운항 거리를 입력하셔야 합니다.");
				return false;
			} 
			else {
		        $(this).html('<span class="spinner-border spinner-border-sm"></span> Loading..');
		        $("#routeWriteForm").attr("action", "airRouteWrite.do");
		        $("#routeWriteForm").attr("method", "post");
		        $("#routeWriteForm").submit();
			}
	    });
	});
	
	
	// 공항 버튼을 클릭했을 때 동작
	$('.airport').on("focus",function() {
		
		// 새로 오픈 될 때 검색 데이터 지우기
		$("#searchAirport").val("");

		// '출발지 검색' 또는 '도착지 검색'에 맞게 텍스트를 설정
		if ($(this).data('departure') === 'departure') {
			$('#airportList h5').text('출발지 검색');
			$('#searchAirport').data('target', 'departure'); // target 설정
		} else {
			$('#airportList h5').text('도착지 검색');
			$('#searchAirport').data('target', 'arrival'); // target 설정
		}
		
		// 모달 오픈
		$("#airportList").modal("show");

		// input 필드에 포커스를 줘서 커서가 잡히도록 함
		$('#airportList input').focus();
	});
	
	// 공항 데이터 검색
	$("#searchAirport").keyup(function() {
		let searchAirport = $(this).val();
// 		console.log("key up : " + searchAirport);
		
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
                        		+ airport.airportKor + '"data-country="' + airport.countryKor + '"'
                        		+ '" style="cursor: pointer;">'
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
        let selectedCountry = $(this).data('country') // 국가 이름
        
        let departureCountry = $("#departureCountry").val();
        
        
        // 선택한 공항을 반영할 target이 'departure'인지 'arrival'인지 확인
        if ($('#searchAirport').data('target') === 'departure') {
            $('#departure').val(selectedCode);
            $('#departureKor').val(selectedName);
            $('#departureCountry').val(selectedCountry);
            $('#modalDeparture').val(selectedCode);
            $('#modalDepartureKor').val(selectedName);
        } else if ($('#searchAirport').data('target') === 'arrival') {
            $('#arrival').val(selectedCode);
            $('#arrivalKor').val(selectedName);
            $('#arrivalCountry').val(selectedCountry);
            $('#modalArrival').val(selectedCode);
            $('#modalArrivalKor').val(selectedName);
            console.log(departureCountry + " +  " + selectedCountry)
            if (departureCountry === selectedCountry) {
            	$("#type").val("D");
        		$("#typeStr").val("국내선");
        	} else if (departureCountry != selectedCountry) {
        		$("#type").val("I");
        		$("#typeStr").val("국제선");
        	} else {
        		$("#type").val("");
        		$("#typeStr").val("");
        	};
        }
        
        // 검색 결과 닫기
        $('#airportListResults').empty();
        $('#airportList').modal("hide");
    });
	
 	// 출발지 선택 시
    $('.departureAirport').click(function() {
        $('#searchAirport').data('target', 'departure');
        $('#airportList').show();
    });

    // 도착지 선택 시
    $('.arrivalAirport').click(function() {
        $('#searchAirport').data('target', 'arrival');
        $('#airportList').show();
    });
    
    
    $("#goback").click(function() {
    	$(this).attr("checked", false);
    });
    
    // 노선 수정
    $(".routeUpdateBtn").click(function() {
    	let routeId = $(this).closest(".dataRow").find(".routeId").data("routeid");
    	let departure = $(this).closest(".dataRow").find(".departure").data("departure");
    	let departureKor = $(this).closest(".dataRow").find("#deaprtureKorRow").text();
    	let arrival = $(this).closest(".dataRow").find(".arrival").data("arrival");
    	let arrivalKor = $(this).closest(".dataRow").find("#arrivalKorRow").text();
    	let distance = $(this).closest(".dataRow").find(".distance").data("distance");
    	let type = $(this).closest(".dataRow").find(".type").data("type");
    	let typeStr = $(this).closest(".dataRow").find(".type").text();
    	
//     	console.log("routeId : " + routeId);
//     	console.log("departure : " + departure);
//     	console.log("arrival : " + arrival);
//     	console.log("distance : " + distance);
    	console.log("type : " + type);
//     	console.log("typeStr : " + typeStr);

		$("#modalRouteId").val(routeId);
		$("#modalDeparture").val(departure);
		$("#modalDepartureKor").val(departureKor);
		$("#modalArrival").val(arrival);
		$("#modalArrivalKor").val(arrivalKor);
		$("#modalDistance").val(distance);
		$("#modalType").val(type);
		$("#modalTypeStr").val(typeStr);
    	
    	$("#routeUpdateModal").modal("show");
    });
    
   	// 모달창 안에 수정 버튼 클릭
   	$("#modalRouteUpdateBtn").click(function() {
   		let routeId = $("#modalRouteId").val();
   		let departure = $("#modalDeparture").val();
   		let arrival = $("#modalArrival").val();
   		let distance = $("#modalDistance").val();
   		let type = $("#modalType").val();
   		
//    		alert("routeId : "+ routeId + ", departure : " + departure + ", arrival : " + arrival + ", distance : " + distance + ", type : " + type);

		if(departure == null || departure === "") {
			alert("출발지를 입력하셔야 합니다.");
			return false;
		} else if(arrival == null || arrival === "") {
			alert("도착지를 입력하셔야 합니다.");
			return false;
		} else if(distance == null || distance === "") {
			alert("운항 거리를 입력하셔야 합니다.");
			return false;
		} 
		else {
	        $(this).html('<span class="spinner-border spinner-border-sm"></span> Loading..');
	        $("#routeUpdateForm").attr("action", "airRouteUpdate.do");
	        $("#routeUpdateForm").attr("method", "post");
	        $("#routeUpdateForm").submit();
		}
   		
   	});
   	
   	// 노선 삭제
   	$(".routeDeleteBtn").click(function() {
   		let routeId = $(this).closest(".dataRow").find(".routeId").data("routeid");
    	let departure = $(this).closest(".dataRow").find(".departure").data("departure");
    	let departureKor = $(this).closest(".dataRow").find("#deaprtureKorRow").text();
    	let arrival = $(this).closest(".dataRow").find(".arrival").data("arrival");
    	let arrivalKor = $(this).closest(".dataRow").find("#arrivalKorRow").text();
    	let distance = $(this).closest(".dataRow").find(".distance").data("distance");
    	let type = $(this).closest(".dataRow").find(".type").data("type");
    	let typeStr = $(this).closest(".dataRow").find(".type").text();
    	
    	$("#deleteModalRouteId").text(routeId);
    	$("#deleteModalDeparture").text(departure);
    	$("#deleteModalDepartureKor").text(departureKor);
    	$("#deleteModalArrival").text(arrival);
    	$("#deleteModalArrivalKor").text(arrivalKor);
    	$("#deleteModalDistance").text(distance + " km");
    	$("#deleteModalTypeStr").text(typeStr);
    	$("#routeDeleteId").val(routeId);
    	
    	
   		$("#routeDeleteModal").modal("show");
   	});
   	
   	$("#modalDeleteBtn").click(function() {
   		// alert("modalDeleteBtn");
   		$(this).html('<span class="spinner-border spinner-border-sm"></span> Loading..');
        $("#routeDeleteForm").attr("action", "airRouteDelete.do");
        $("#routeDeleteForm").attr("method", "post");
        $("#routeDeleteForm").submit();
   	});
   	
   	$(".submitBtn").click(function(){
   		let priceId = $("#priceId").val();
   		let routeId = $("#hiddenRouteId").val();
   		let basePrice = $("#basePrice").val();
   		let tax = $("#tax").val();
   		let fuelSurCharge = $("#fuelSurCharge").val();
   		let bookingFee	= $("#bookingFee").val();
   		let distance = $("#hiddenDistance").val();
   		
//    		alert(priceId + " + " + routeId + " + " + basePrice + " + " + tax + " + " + fuelSurCharge + " + " + bookingFee + " + " + distance);
   		
   		if (priceId === 0 || priceId == "") {
//    			alert("가격 정보 없음");
   			$("#priceForm").attr("action", "airPriceWrite.do");
   	        $("#priceForm").attr("method", "post");
   	        $("#priceForm").submit();
   		} else {
//    			alert("가격 정보 있음");
   			$("#priceForm").attr("action", "airPriceUpdate.do");
   	        $("#priceForm").attr("method", "post");
   	        $("#priceForm").submit();
   		}
   		
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
				<li class="nav-item choice">
					<a class="nav-link choice" href="airAdminRoutePrice.do"> 
						<Strong>노선 및 운임 관리</Strong>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="airAdminSchedule.do"> 
						<Strong>운항 스케줄 관리</Strong>
					</a>
				</li>
			</ul>
		</div>
		<div class="card-body">
			

			<!-- Tab panes -->
			<div class="tab-content">
				<div id="nocTab" class="container-fluid p-3 tab-pane active">
					<button class="searchBtn float-right mb-3" id="addRouteBtn">노선 등록</button>
					<h3>
						노선 및 운임 관리
					</h3>
					<small>
						<span class="ml-3 mt-2">
							새로운 노선을 등록하려면 <b>[ 노선 등록 ]</b> 버튼을 누르세요.<br>
						</span>
						<span class="ml-3 mt-2">
							아래 노선 탭에서 노선을 선택하면 운임에 대한 상세정보를 볼 수 있습니다.
						</span>
					</small>
					
					<div class="row mt-3">
						<!-- 노선 탭 -->
						<div class="col-sm-9">
							<fieldset class="border p-4">
							<legend class="w-auto px-2"> <b>[ 노선 ]</b></legend>
								<div class="hiddenInput  p-3" style="background:#e2e2e2; border-radius:10px; padding:10px;">
								<form id="routeWriteForm">
									<!-- 노선 등록 폼 -->
									<button type="button" class="btn searchBtn float-right mb-2" id="routeWriteBtn">등록</button>
									<h5> 노선 등록 </h5>
									<table class="table text-center align-middle mb-2">
										<tr>
											<th style="width:6%;">번호</th>
											<th style="width:10%;">출발지</th>
											<th style="width:20%;">출발공항</th>
											<th style="width:10%;">도착지</th>
											<th style="width:20%;">도착공항</th>
											<th style="width:20%;">거리</th>
											<th style="width:8%;">타입</th>
											<th style="width:6%;">왕복</th>
										</tr>
									<tbody id="inputRow">
										<tr>
											<td >
												<input class="form-control" name="routeId" id="routeId" readonly>
											</td>
											<td >
												<input class="form-control airport" name="departure" id="departure" required data-departure="departure"
													placeholder="코드 검색">
											</td>
											<td >
												<input class="form-control" name="departureKor" id="departureKor" readonly>
												<input type="hidden" id="departureCountry">
											</td>
											<td >
												<input class="form-control airport" name="arrival" id="arrival" required
													placeholder="코드 검색" >
											</td>
											<td >
												<input class="form-control" name="arrivalKor" id="arrivalKor" readonly>
												<input type="hidden" id="arrivalCountry">
											</td>
											<td >
												<input class="form-control" name="distance" id="distance" placeholder="거리 입력 (km)" required>
											</td>
											<td >
												<input class="form-control" id="typeStr" readonly>
												<input type="hidden" name="type" id="type">
											</td>
											<td >
												<input type="checkbox" class="form-check-input" name="goBackStr" id="goBack" checked value="true"
    												style="width:25px;height:25px;">
											</td>
										</tr>
									</tbody>
									</table>
								</form>
							</div>
							<!-- 검색 -->
							<div class="row float-right">
							  	<div class="col-md-4 form-inline ">
							  		<div class="form-group">
										<select class="form-control" name="searchKey" id="searchKey"  style="margin: 0 10px;">
												<option value="all">모두</option>
												<option value="flightName">출발국가</option>
												<option value="airplaneId">출발지</option>
												<option value="airplanePdt">도착국가</option>
												<option value="departure">도착지</option>
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
										<th style="width:10%;">출발 국가</th>
										<th style="width:25%;">출발지</th>
										<th style="width:10%;">도착 국가</th>
										<th style="width:25%;">도착지</th>
										<th style="width:16%;">거리</th>
										<th style="width:8%;">변경</th>
									</tr>
									<c:if test="${empty routeList }">
										<tr>
											<td colspan="12">
												<div class="alert alert-warning">
													<strong>해당 항공사에 노선이 없습니다.</strong> 노선을 등록해 주세요.
												</div>
											</td>
										</tr>
									</c:if>
									<c:if test="${!empty routeList }">
									<c:forEach items="${routeList }" var="vo">
										<tr class="dataRow">
											<td class="routeId" data-routeid="${vo.routeId}">${vo.routeId }</td>
											<td class="type" data-type="${vo.type}">${(vo.type =='I')? '국제선' : '국내선'}</td>
											<td class="departureCountry">${vo.departureCountry }</td>
											<td class="departure" data-departure="${vo.departure}">${vo.departure } ( <span id="deaprtureKorRow">${vo.departureKor }</span> )</td>
											<td class="arrivalCountry" >${vo.arrivalCountry }</td>
											<td class="arrival" data-arrival="${vo.arrival}">${vo.arrival } ( <span id="arrivalKorRow">${vo.arrivalKor }</span> )</td>
											<td class="distance" data-distance="${vo.distance}">
												<fmt:formatNumber value="${vo.distance}" type="number" /> km
											</td>
											<td class="btn-group" >
												<button class="btn btn-sm btn-light routeUpdateBtn"><i class="fa fa-pencil" style="font-size:18px;"></i></button>
												<button class="btn btn-sm btn-danger routeDeleteBtn"><i class="fa fa-minus"></i></button>
											</td>
										</tr>
									</c:forEach>
									</c:if>
								</table>
							</fieldset>
						</div>
						<!-- 운임 탭 -->
						<div class="col-sm-3">
							<fieldset class="border p-4">
							<legend class="w-auto px-2"> <b>[ 운임 ]</b></legend>
									<span class="ml-2">
										<strong>
											[ 번호 : <span id="selectRouteId" class="mr-2"></span>
											구간 : <span id="selectDeparture"></span> ~  <span id="selectArrival"></span> ]<br>
										</strong>
									</span>
									<span class="ml-3">
										<small>
											* 기본 운임을 입력하면 자동계산 됩니다.
										</small>											
									</span>
									<form id="priceForm">
										<div id="priceInfo">
											<table class="table text-center" >
												<tr class="priceList">
													<th style="width:110px;">기본 운임</th>
													<td class="form-inline">
														<input class="form-control basePrice text-right ml-3" id="basePrice" name="basePrice" value="" type="number"
															style="width:80%"><span class="ml-2">원</span>
													</td>
												</tr>	
												<tr class="priceList">
													<th>세금</th>
													<td class="text-right"> 
														<span id="tax" >
														</span>
														<span class="ml-2">원</span>
													
													</td>
												</tr>	
												<tr class="priceList">
													<th>유류할증료</th>
													<td class="text-right">
														<span id="fuelSurCharge" >
														</span>
														<span class="ml-2">원</span>
													</td>
												</tr>	
												<tr class="priceList">
													<th>발권 수수료</th>
													<td class="text-right">
														<span id="bookingFee">
														</span>
														<span class="ml-2">원</span>
													</td>
												</tr>	
												<tr class="priceList">
													<th style="border-top: 5px double #444; background-color:#FF8533; color:white;">총액 <br>
														<small>(일반석)</small>
													</th>
													<td style="border-top: 5px double #444;" class="text-right">
														<span id="ecoPrice">
														</span>
														<span class="ml-2">원</span>
													</td>
												</tr>	
												<tr class="priceList">
													<th style="background-color:#FF8533; color:white;">총액 <br>
														<small>(비즈니스)</small>
													</th>
													<td class="text-right">
														<span id="bisPrice">
														</span>
														<span class="ml-2">원</span>
													</td>
												</tr>	
												<tr class="priceList">
													<th style="background-color:#FF8533; color:white;">총액 <br>
														<small>(일등석)</small>
													</th>
													<td class="text-right">
														<span id="fstPrice" >
														</span>
														<span class="ml-2">원</span>
													</td>
												</tr>
										</table>
									</div>
									<div class="float-right">
										<button class="btn btn-warning submitBtn" type="button">저장</button>
										<button class="btn btn-secondary" type="reset">초기화</button>
									</div>
								</form>
							</fieldset>
						</div>
					
					</div>
					
				</div>
			
			</div>
			<div class="card-footer">
				<pagNav:pageNav listURI="airAdminRoute.do" pageObject="${pageObject }"></pagNav:pageNav>
			</div>
		</div>
	</div>
</div>



<!-- 노선 수정 모달 -->
<div class="modal" id="routeUpdateModal">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">노선 수정</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
       		<form id="routeUpdateForm">
	        <table class="table text-center align-middle mb-2">
				<tr>
					<th style="width:6%;">번호</th>
					<th style="width:10%;">출발지</th>
					<th style="width:20%;">출발공항</th>
					<th style="width:10%;">도착지</th>
					<th style="width:20%;">도착공항</th>
					<th style="width:20%;">거리</th>
					<th style="width:8%;">타입</th>
				</tr>
			<tbody id="inputRow">
				<tr>
					<td >
						<input class="form-control" name="routeId" id="modalRouteId" readonly>
					</td>
					<td >
						<input class="form-control airport " name="departure" id="modalDeparture" required data-departure="departure"
							placeholder="코드 검색">
					</td>
					<td >
						<input class="form-control" name="departureKor" id="modalDepartureKor" readonly>
					</td>
					<td >
						<input class="form-control airport arrivalAirport" name="arrival" id="modalArrival" required data-arrival="arrival"
							placeholder="코드 검색" >
					</td>
					<td >
						<input class="form-control" name="arrivalKor" id="modalArrivalKor" readonly>
					</td>
					<td >
						<input class="form-control" name="distance" id="modalDistance" placeholder="거리 입력 (km)" required>
					</td>
					<td >
						<input class="form-control" id="modalTypeStr" readonly>
						<input type="hidden" name="type" id="modalType">
					</td>
				</tr>
			</tbody>
			</table>
			</form>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-dark" id="modalRouteUpdateBtn">Update</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>

<!-- 노선 삭제 모달 -->
<div class="modal" id="routeDeleteModal">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">노선 삭제</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <form id="routeDeleteForm">
      <div class="modal-body">
      		<span>
      			해당 노선을 정말 삭제하시겠습니까?
      			<br>삭제하면 관련된 모든 데이터가 <span style="font-weight:bold; color:red;">삭제</span>됩니다.
      			<br>삭제된 이후 복구는 불가능합니다.
      		</span>
      		<hr>
      		<span><strong>삭제할 노선 : </strong></span>
      		
	        <table class="table table-sm text-center align-middle mb-2">
				<tr>
					<th style="width:6%;">번호</th>
					<th style="width:10%;">출발지</th>
					<th style="width:20%;">출발공항</th>
					<th style="width:10%;">도착지</th>
					<th style="width:20%;">도착공항</th>
					<th style="width:20%;">거리</th>
					<th style="width:8%;">타입</th>
				</tr>
			<tbody id="inputRow">
				<tr>
					<td id="deleteModalRouteId"></td>
					<td id="deleteModalDeparture"></td>
					<td id="deleteModalDepartureKor"></td>
					<td id="deleteModalArrival"></td>
					<td id="deleteModalArrivalKor"></td>
					<td id="deleteModalDistance"></td>
					<td id="deleteModalTypeStr"></td>
					
				</tr>
			</tbody>
			</table>

      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
		<input type="hidden" name="routeId" id="routeDeleteId">
        <button type="button" class="btn btn-danger" id="modalDeleteBtn">Delete</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal" >Close</button>
      </div>
      </form>

    </div>
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
</body>
</html>