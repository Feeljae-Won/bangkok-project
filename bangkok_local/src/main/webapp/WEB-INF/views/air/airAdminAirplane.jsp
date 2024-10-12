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
	color:#444;
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
	
	// 바로 중분류의 데이터를 세팅한다.
	$(".airplaneList").load("/airajax/getAirplane.do?airplanePdt="	+ $(".airplanePdt").val());
	
	let inputRowCnt = 1;
	
	// 항공편 등록 창 보이기
	$(".addFlightBtn").click(function(){
		$(".hiddenInput").toggle();
	});
	
	// input 항목 늘리기
	$(".addBtn").click(function(){
		
		if(inputRowCnt >= 10) {
			alert("항공편 추가는 최대 10개까지만 가능합니다.");
			return false;
		}
		
		let inputRow = "";
		inputRow+= '<tr>';
		inputRow+=		'<td class="">';
		inputRow+=			'<select class="form-control mr-4 airplanePdt" name="list[' + inputRowCnt + '].airplanePdt" id="airplanePdt" style="width:90%;">';
		inputRow+=				'<option value="AIRBUS">AIRBUS (에어버스)</option>';
		inputRow+=				'<option value="BOEING">BOEING (보잉)</option>';
		inputRow+=			'</select>';
		inputRow+=		'</td>';
		inputRow+=		'<td>';
		inputRow+=			'<select class="form-control mr-4 airplaneList" name="list[' + inputRowCnt + '].airplaneId" id="airplaneList" style="width:90%;">';
		inputRow+=			'</select>';
		inputRow+=		'</td>';
		inputRow+=		'<td>';
		inputRow+=			'<input class="form-control" name="list[' + inputRowCnt + '].flightName" id="flightName" placeholder="flightName" required style="width:90%;">';
		inputRow+=		'</td>';
		inputRow+=		'<td>';
		inputRow+=			'<input class="form-control" name="list[' + inputRowCnt + '].seatCapacity" id="seatCapacity" type="number" value="300" style="width:90%;">';
		inputRow+=		'</td>';
		inputRow+=		'<td>';
		inputRow+=			'<input class="form-control" name="list[' + inputRowCnt + '].ecoCnt" id="ecoCnt" type="number" value="252" style="width:90%;">';
		inputRow+=		'</td>';
		inputRow+=		'<td>';
		inputRow+=			'<input class="form-control" name="list[' + inputRowCnt + '].bisCnt" id="bisCnt" type="number" value="36" style="width:90%;">';
		inputRow+=		'</td>';
		inputRow+=		'<td>';
		inputRow+=			'<input class="form-control" name="list[' + inputRowCnt + '].fstCnt" id="fstCnt" type="number" value="12" style="width:90%;">';
		inputRow+=			'<input type="hidden" name="list[' + inputRowCnt + '].seatX" value="6">';
		inputRow+=			'<input type="hidden" name="list[' + inputRowCnt + '].seatY" value="6">';
		inputRow+=		'</td>';
		inputRow+=		'<td>';
		inputRow+=			'<i class="fa fa-close btn-danger btn inputDeleteBtn" style="color:white;"></i>';
		inputRow+=		'</td>';
		inputRow+=	'</tr>';
		
		let newRow = $(inputRow).clone();
		
		$("#inputRow").append(newRow);
		
		// 새로 추가된 행의 대분류 선택에 따른 중분류 리스트 세팅
	    newRow.find(".airplaneList").load("/airajax/getAirplane.do?airplanePdt=" + newRow.find(".airplanePdt").val());
		return inputRowCnt++;
	});
	
	// 대분류 선택에 따른 중분류 리스트 가져오기
	$("#inputRow").on("change", ".airplanePdt", function() {
	    let airplanePdt = $(this).closest("tr").find(".airplanePdt").val();
	    $(this).closest("tr").find(".airplaneList").load("/airajax/getAirplane.do?airplanePdt=" + airplanePdt);
	});
	
	// inputRow x 버튼 클릭하면 해당 줄 삭제
	$("#inputRow").on("click", ".inputDeleteBtn", function() {
		
		$(this).closest("tr").remove();
		inputRowCnt--;
	});
	
	// 항공편 일괄 등록 버튼
	$("#totalAddBtn").click(function(){
		
		
		$(this).html('<span class="spinner-border spinner-border-sm"></span> Loading..');
	});
	
	// 항공편 상세보기
	$(".dataRow").click(function() {
		let flightName = $(this).data("flightname");
		// console.log(flightName);
		
		$(".dataRow").removeClass("selected");
		$(this).addClass("selected");
		
		$(".collapse").hide();
		
		$("#view"+flightName).load("/airajax/getFlightInfo.do?flightName="	+ flightName);
		
		$("#view"+flightName).toggle("collapse");
		
	})
	
	// 항공편 수정
	$(".flightInfo").on("click", "#flightEditBtn", function() {
		
		let flightName = $(this).data("flightname");
		console.log(flightName);
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
				<li class="nav-item ">
					<a class="nav-link " href="airAdminNOC.do"> 
						<Strong>국가 및 공항 관리</Strong>
					</a>
				</li>
				<li class="nav-item choice">
					<a class="nav-link choice" href="airAdminAirplane.do"> 
						<Strong>항공사 기종 관리</Strong>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="airAdminRoutePrice.do"> 
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
					<button class="searchBtn float-right addFlightBtn">[ 항공편 등록 ]</button>
					<h3>
						항공사 기종 관리
					</h3>
					<small>
						<span class="ml-3 mt-2">
							새로운 항공편을 등록하려면 <b>[ 항공편 등록 ]</b> 버튼을 누르세요.<br>
						</span>
						<span class="ml-3 mt-2">
							새로운 항공편의 노선과 스케줄을 등록하려면 <b>[ 노선 및 운임 관리 ]</b> 또는 <b>[ 운항 스케줄 관리 ]</b> 에서 등록할 수 있습니다.
						</span>
					</small>
					<div class="hiddenInput mt-3 mb-3 p-3" style="background:#e2e2e2; border-radius:10px; padding:10px;">
						<form action="airplaneWrite.do" method="post">

						
							<!-- 비행기 등록 폼 -->
							<button type="submit" class="btn searchBtn float-right mb-2" id="totalAddBtn">일괄 등록</button>
							<h5> 항공편 등록 </h5>
							<table class="table text-center align-middle">
								<tr>
									<th style="width:200px;">제조사</th>
									<th style="width:120px;">모델</th>
									<th style="width:170px;">편명</th>
									<th style="width:80px;">총 좌석수</th>
									<th style="width:80px;">일반석</th>
									<th style="width:80px;">비즈니스</th>
									<th style="width:80px;">일등석</th>
									<th style="width:80px;"><i class="fa fa-plus btn-outline-light btn addBtn"></i></th>
								</tr>
							<tbody id="inputRow">
								<tr>
									<td >
										<select class="form-control mr-4 airplanePdt" name="list[0].airplanePdt" id="airplanePdt" style="width:90%;">
											<option value="AIRBUS">AIRBUS (에어버스)</option>
											<option value="BOEING">BOEING (보잉)</option>
										</select>
									</td>
									<td>
										<select class="form-control mr-4 airplaneList" name="list[0].airplaneId" id="airplaneList" style="width:90%;">
										</select>
									</td>
									<td>
										<input class="form-control flightName" name="list[0].flightName" id="flightName" placeholder="flightName" required
											style="width:90%;">
									</td>
									<td>
										<input class="form-control" name="list[0].seatCapacity" id="seatCapacity" type="number" value="300"
											style="width:90%;">
									</td>
									<td>
										<input class="form-control" name="list[0].ecoCnt" id="ecoCnt" type="number" value="252"
											style="width:90%;">
									</td>
									<td>
										<input class="form-control" name="list[0].bisCnt" id="bisCnt" type="number" value="36"
											style="width:90%;">
									</td>
									<td>
										<input class="form-control" name="list[0].fstCnt" id="fstCnt" type="number" value="12"
											style="width:90%;">
										<!-- 항공기 x, y 축 고정 -->
										<input type="hidden" name="list[0].seatX" value="6">
										<input type="hidden" name="list[0].seatY" value="50">
									</td>
									<td>
										<i class="fa fa-close btn-light btn"></i>
									</td>
								</tr>
							</tbody>
							</table>
						</form>
					</div>
					<small>
						<span class="ml-3 mt-2">
							<br><br>* <b>[ 수정 ]</b> : 해당 항공편을 선택하면 자세한 내용을 확인할 수 있으며, <b>기종, 제조사, 좌석, 출발지, 도착지, 운항 스케줄</b>을 변경할 수 있습니다.
							<br>* <b>[ 삭제 ]</b> : 해당 항공편과 관련된 <span style="color:red; font-weight:bold;">모든 데이터가 삭제</span> 됩니다. <br>
						</span>
					</small>
					<!-- 검색 -->
					<div class="row float-right">
					  	<div class="col-md-4 form-inline ">
					  		<div class="form-group">
								<select class="form-control" name="searchKey" id="searchKey"  style="margin: 0 10px;">
										<option value="all">모두</option>
										<option value="flightName">편명</option>
										<option value="airplaneId">기종</option>
										<option value="airplanePdt">제조사</option>
										<option value="departure" >출발지</option>
										<option value="arrival" >도착지</option>
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
					<div class="form-check-inline ml-3 mt-3">
						<label class="form-check-label">
							<input type="radio" class="form-check-input" value="all" name="optradio" checked>전체 항공편
							<input type="radio" class="form-check-input" value="noSchedule" name="optradio">미운항 항공편
							<input type="radio" class="form-check-input" value="scheduled" name="optradio">운항중인 항공편
						</label>
					</div>
					<table class="table text-center align-middle mt-3">
						<tr>
							<th>순번</th>
							<th>편명</th>
							<th>기종</th>
							<th>제조사</th>
							<th>총 좌석수</th>
							<th>일반석</th>
							<th>비즈니스석</th>
							<th>일등석</th>
							<th>운항여부</th>
							<th>출발지</th>
							<th>도착지</th>
						</tr>
					<tbody id="flightList">
					<c:if test="${empty flightList }">
						<tr>
							<td colspan="12">
								<div class="alert alert-warning">
									<strong>해당 항공편이 없습니다.</strong> 항공편을 등록해 주세요.
								</div>
							</td>
						</tr>
					</c:if>
					<c:if test="${!empty flightList }">
						<c:forEach items="${flightList }" var="vo">
							<tr class="dataRow" data-flightname="${vo.flightName }" data-airplaneid="${vo.airplaneId }"
								data-routeid="${vo.routeId }" data-scheduleid="${vo.scheduleId }">
								<td>${vo.rnum }</td>
								<td>${vo.flightName }</td>
								<td>${vo.airplaneId }</td>
								<td>${vo.airplanePdt }</td>
								<td>${vo.seatCapacity }</td>
								<td>${vo.ecoCnt }</td>
								<td>${vo.bisCnt }</td>
								<td>${vo.fstCnt }</td>
								<td>${(vo.scheduleId > 0)? '<i class="fa fa-circle-thin"></i>' : '<i class="fa fa-close"></i>' }</td>
								<td>${(empty vo.departure )? '' : vo.departure }</td>
								<td>${(empty vo.arrival )? '' : vo.arrival }</td>
							</tr>
							<tr class="collapse" id="view${vo.flightName }">
								<td colspan="12">
									${vo.flightName } 상세보기
								</td>
							</tr>
						</c:forEach>
					</c:if>
					</tbody>
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

<!-- 항공편 수정 모달 -->
<div class="modal" id="flightEditModal">
  <div class="modal-dialog modal-xl modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Modal Heading</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        Modal body..
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
</body>
</html>