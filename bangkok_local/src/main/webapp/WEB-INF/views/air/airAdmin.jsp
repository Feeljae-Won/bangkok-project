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
.selected {
	background-color: #FEDB92;
}
</style>
<script type="text/javascript">
$(function() {
	$(".dataRow").click(function() {
		
		let airlineNo = $(this).data("airlineno");
		let airlineKor = $(this).find(".airlineKor").text();
		
		$(".dataRow").removeClass("selected");
		
		$(this).addClass("selected");
		
		$("#detailAirlineKor").text("(" + airlineKor + ")");
// 		alert("dataRow : " + airlineNo + ", " + airlineKor);

		$("#airlineInfo").load("/airajax/getAirlineInfo.do?airlineNo=" + airlineNo);
		
	});
	
	// 항공사 등록 버튼
	$("#airlineAddBtn").click(function(){
		
		$("#emailList").show();
		$("#email").val("");
		$("#airlineKor").val("");
		$("#airlineEng").val("");
		$("#countryCode").val("");
		$("#airlineNo").val("");
		
		$(".modal-title").text("항공사 등록");
		$("#modalSubmitBtn").text("add");
		$("#airlineModal").modal("show");
		
		// 모달창 안에 제출 버튼
		$("#modalSubmitBtn").click(function() {
			let airlineKor = $("#airlineKor").val();
			let airlineEng = $("#airlineEng").val();
			
			// alert(airlineKor + airlineEng);
			
			if (airlineKor == null || airlineKor == ''){
				alert("항공사명을 입력하셔야 합니다.");
				return false;
			} else if (airlineEng == null || airlineEng == '') {
				alert("항공사 영문을 입력하셔야 합니다.");
				return false;
			} else {
				$("#airlineForm").attr("action", "airlineWrite.do");
	   	        $("#airlineForm").attr("method", "post");
	   	        $("#airlineForm").submit();
			}
		});
	});
	
	// 항공사 수정 버튼
	$("#airlineEditBtn").click(function(){
		
		let airlineNo = $(".selected").data("airlineno");
		let email = $(".selected").find(".email").text();
		let airlineKor = $(".selected").find(".airlineKor").text();
		let airlineEng = $(".selected").find(".airlineEng").text();
		let countryCode = $(".selected").find(".countryKor").data("countrycode");
		let countryKor = $(".selected").find(".countryKor").text();
		
		// alert("email : " + email + ", airlineKor : " + airlineKor + ", airlineEng : " + airlineEng + ", countryCode : " + countryCode + ", countryKor : " + countryKor);
		
		$("#emailList").hide();
		$("#email").val(email);
		$("#airlineKor").val(airlineKor);
		$("#airlineEng").val(airlineEng);
		$("#countryCode").val(countryCode);
		$("#airlineNo").val(airlineNo);
		
		$(".modal-title").text("항공사 수정");
		$("#modalSubmitBtn").text("edit");
		$("#airlineModal").modal("show");
		
		// 모달창 안에 제출 버튼
		$("#modalSubmitBtn").click(function() {
			let airlineKor = $("#airlineKor").val();
			let airlineEng = $("#airlineEng").val();
			
			// alert(airlineKor + airlineEng);
			
			if (airlineKor == null || airlineKor == ''){
				alert("항공사명을 입력하셔야 합니다.");
				return false;
			} else if (airlineEng == null || airlineEng == '') {
				alert("항공사 영문을 입력하셔야 합니다.");
				return false;
			} else {
				$("#airlineForm").attr("action", "airlineUpdate.do");
	   	        $("#airlineForm").attr("method", "post");
	   	        $("#airlineForm").submit();
			}
		});
	});
	
	// 바로 중분류의 데이터를 세팅한다.
	$("#emailList").load("/airajax/getEmail.do");
	$("#nocList").load("/airajax/getNoc.do");
	
	// email 리스트 선택시 바로 val값 저장
	$("#airlineModal").on("change", "#emailList", function() {
		//alert("chage");
		
		let email = $("#emailList").val();
		
		$("#email").val(email);
	});
	
	// noc 리스트 선택시 바로 val값 저장
	$("#airlineModal").on("change", "#nocList", function() {
		//alert("chage");
		
		let noc = $("#nocList").val();
		
		$("#countryCode").val(noc);
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
				<li class="nav-item choice">
					<a class="nav-link choice" href="airAdmin.do"> 
						<Strong>항공사 관리</Strong>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="airAdminNOC.do"> 
						<Strong>국가 및 공항 관리</Strong>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link " href="airAdminAirplane.do"> 
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
				<div id="mainTab" class="container-fluid p-3 tab-pane active">
					<br>
					<div class="row">
						<div class="col-9">
							<h3>
								항공사 리스트
								<button class="btn btn-warning btn-sm" id="airlineAddBtn"><i class="fa fa-plus mr-2"></i>add</button>
							</h3>
							<table class="table text-center">
								<tr>
									<th>항공사</th>
									<th>항공사 이름</th>
									<th>항공사 영문</th>
									<th>항공사 이메일</th>
									<th>항공사 소속국가</th>
									<th>항공사 고유번호</th>
								</tr>
								<c:forEach items="${list }" var="vo">
									<tr class="dataRow" data-airlineno="${vo.airlineNo }">
										<td><img src="${vo.photo }" class="" style="width:130px;"></td>
										<td class="airlineKor">${vo.airlineKor }</td>
										<td class="airlineEng">${vo.airlineEng }</td>
										<td class="email">${vo.email }</td>
										<td class="countryKor" data-countrycode="${vo.countryCode }">${vo.countryKor }</td>
										<td class="airlineNo">${vo.airlineNo }</td>
									</tr>
								</c:forEach>
							</table>
						
						</div>
						<div class="col-3">
							<h3>
								항공사 정보
								<small><span id="detailAirlineKor"></span></small>
								<button class="btn btn-secondary btn-sm float-right" id="airlineEditBtn">edit</button>
							</h3>
							<div id="airlineInfo">
								<table class="table text-center">
									<tr>
										<th style="width:50%;">운항 노선 수</th>
										<td></td>
									</tr>
									<tr>
										<th>보유 기종 수</th>
										<td></td>
									</tr>
									<tr>
										<th>금일 운항</th>
										<td></td>
									</tr>
									<tr>
										<th>운항 예정</th>
										<td></td>
									</tr>
									<tr>
										<th>운항 종료</th>
										<td></td>
									</tr>
									<tr>
										<th>총 운항 수</th>
										<td></td>
									</tr>
								</table>
							</div>
						</div>
					
					</div>
				</div>
			</div>

		</div>
		<div class="card-footer">
			<div>
				<pagNav:pageNav listURI="airAdmin.do" pageObject="${pageObject }"></pagNav:pageNav>
			</div>
		</div>
	</div>
</div>

<!-- 항공사 등록 모달 -->
<div class="modal" id="airlineModal">
  <div class="modal-dialog modal-ml modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">항공사 등록</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <form id="airlineForm">
	      <div class="modal-body">
	      	<div class="form-inline">
	        	<label class="mr-3"><strong>아이디 선택</strong></label>
        		<select class="form-control float-right" id="emailList">
        			<option></option>
        		</select>
	      	</div>
        		<input id="email" name="email" class="form-control mb-3" readonly>
<!-- 	        	<div class="form-check ml-3"> -->
<!-- 		        	<label class="form-check-label"> -->
<!-- 					    <input type="checkbox" class="form-check-input" value="">검색 -->
<!-- 					</label> -->
<!-- 				</div> -->
	        	<label class="mr-3"><strong>항공사 한글</strong></label>
	        	<input class="form-control mb-3" name="airlineKor" id="airlineKor">
	        	<label class="mr-3"><strong>항공사 영문</strong></label>
	        	<input class="form-control mb-3" name="airlineEng" id="airlineEng">
	        <div class="form-inline">
	        	<label class="mr-3"><strong>소속 국가</strong></label>
        		<select class="form-control float-right" id="nocList">
        			<option></option>
        		</select>
        	</div>
        		<input id="countryCode" name="countryCode" class="form-control mb-3" readonly>
        		<input id="airlineNo" name="airlineNo" type="hidden">
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-warning" id="modalSubmitBtn">Add</button>
	        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	      </div>
      </form>

    </div>
  </div>
</div>

</body>
</html>