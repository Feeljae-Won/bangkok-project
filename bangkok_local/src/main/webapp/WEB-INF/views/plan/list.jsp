<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>plan main</title>

<style type="text/css">

.myTrip, #tripWriteBtn, .tripThema {
	color: #6c757d;
}
#tripWriteBtn:hover {
	color: #ffffff;
	cursor: pointer;
}
#citySearch .cityList:hover {
	cursor: pointer;
	border: 2px solid #fd7e14;
}
.tripThema:hover {
	text-decoration: underline;
	cursor: pointer;
}
.card {
	height: 140px;
	margin-bottom: 30px;
}
.trip {
	float: left;
	margin-right: 10px; 
}
.orderBlock:hover {
	cursor: pointer;
}
.orderBlock {
    user-select: none; /* 모든 브라우저에서 텍스트 선택을 방지합니다 */
}
.tripDeleteBtn {
	width: 40px; height: 40px;
	padding: 7px;
	float: right; text-align: center;
}
.tripDeleteBtn:hover {
	cursor: pointer;
	border-radius: 50%;
}
.tripDeleteBtn:active {
	background: #e0e0e0;	
}

</style>

<script type="text/javascript">

$(function(){
	// 이벤트 처리
	// 뷰 이동
	$(".tripThema").click(function(){
		let tno = $(this).find(".tno").val();
		// alert(tno);
		location = "view.do?tno=" + tno;
		// return false;
	});
	
	// 여행 리스트 정렬 방식
	$(".dropdown-item").click(function(event){
		event.preventDefault(); // 기본 링크 클릭 동작 방지
        // Get the text of the clicked item
        let order = $(this).text();
        // Update the span with the selected text
        $('.orderList').text(order);
	});
	
	// 여행 시작일과 종료일은 현재 날짜 이후만 입력 가능
	$("#tripStartDate, #tripEndDate")
	.datepicker("option", {"minDate" : new Date()});

	
	// 여행 등록 - 1. 등록 모달 출력
	$("#tripWriteBtn").click(function(){
		// action 위치 지정
		$("#tripPlanModal").find("form").attr("action", "write.do");
		// 모달 출력
		$("#tripPlanModal").modal("show");
	});
	
	// 여행 등록 - 2. 기간 선택
	$("#tripPeriodBtn").click(function(){
		alert('여행 기간 선택');
	});
	
	// 여행 등록 - 3. 도시 검색창 보이기
	$("#citySearchBtn").click(function(){
		// alert('여행지 검색창');
		// 원래 입력란 지우기
		$("#tripPlanModal").hide();
		// 검색 창 보이기
		$("#citySearch").show();
		$("#citySearch").find("#citySearchModal").modal("show");
		
		let cityName = $(this).val();
		// alert(cityName);
	});
	
	// 여행 등록 - 4. 도시선택
	$("#citySearchModal").on("click", ".cityList", function(){
		// alert("여행지 선택");
		// 여행지 번호 조회
		let cityNum = $(this).find("#cityNum").val(); // this - cityList class
		// 여행지명 조회
		let tripPlace = $(this).find("#tripPlace").text();
		// alert("cityNum : " + cityNum + ", tripPlace : " + tripPlace);
		// 여행지 번호를 tripPlanModal 의 cityNum input 에 저장
		$("#tripPlanModal").find("#cityNum").val(cityNum);
		// 여행지명을 버튼에 저장
		$("#tripPlanModal").find("#citySearchBtn span").text(tripPlace);
		// 검색 창 지우기
		$("#citySearch").hide();
		// 원래 입력란 보이기
		$("#tripPlanModal").show(); 
		
	});
	
	// 도시 검색 -> 등록 창으로 돌아가기
	$("#citySearchModal .cancelBtn").click(function(){
		// 검색 창 지우기
		$("#citySearch").hide();
		// 원래 입력란 보이기
		$("#tripPlanModal").show();
	})
	
	// tripPeriodBtn 버튼 클릭 시 달력 보이기
// 	$("#tripPeriodBtn").click(function(){
// 		// alert('달력 클릭');
// 		// datepicker 설정
// 		$(".datepicker").datepicker({
// 			numberOfMonths: [1,2],
// 			changeMonth: true,
// 			changeYear: true,
// 			dateFormat: "yy.mm.dd",
// 			dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
// 			monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ]
// 		});

// 	});
	
	// 시작일 종료일
// 	$("#tripStartDate").change(function(){
// 		//alert($(this).val());
// 		$("#tripEndDate").datepicker("option", "minDate", $(this).val());
// 	});
	
// 	$("#tripEndDate").change(function(){
// 		//alert($(this).val());
// 		$("#tripStartDate").datepicker("option", "maxDate", $(this).val());
// 	});
	
	// 여행 삭제 모달 표시
	$(".tripDeleteBtn").click(function(){
		// 여행 등록 번호 가져오기
		let tno = $(this).closest(".row").find(".tno").val();
		// alert(tno);
		let tripThema = $(this).closest(".row").find(".tripThema").text();
		// alert(tripThema);
		// action 위치 지정
		$("#tripPlanModal").find("form").attr("action", "delete.do");
		// 모달 중앙 배치
		$("#tripPlanModal").find(".modal-dialog").addClass("modal-dialog-centered");
		// 모달 제목 변경
		$("#tripPlanModal").find(".modal-title").text("여행을 삭제할까요?");
		// 모달 내용 지우기
		$("#tripPlanModal").find(".modal-body .form-group").remove();
		
		// 내용 채우기
		$("#tripPlanModal").find(".modal-body").addClass("text-center")
			.text("여행을 삭제하면 복구할 수 없습니다. [" + tripThema + "]을(를) 삭제하시겠어요?");
		
		// input 태그 만들기
		let tnoInput = $("#tripPlanModal").find("form");
		tnoInput.append("<input type='hidden' value='" + tno + "' name=tno>")
		
		// $("#tripPlanModal").find("form").add("form input").val(tno);
		
		// 삭제 버튼 만들기
		$(".modal-footer").find("#modalMultiBtn").removeClass("btn-dark")
			.addClass("btn-danger").text("remove");
		
		$("#tripPlanModal").modal("show");
	});
	
	// datepicker 함수
	function tripPeriodBtnPicker(){
		
	}
	
});

</script>

</head>
<body>

<div class="container">
	
<h2 class="myTrip mt-4">내 여행</h2>

<button class="btn btn-outline-dark btn-block" id="tripWriteBtn"
	style="margin: 30px 0; padding: 15px 10px; font-size: 17px;">
	<i class="fa fa-plus"></i> 새로운 여행 떠나기
</button>

<div class="orderBlock dropdown text-right" 
	style="margin-bottom: 16px;">
	<p class="dropdown-toggle" data-toggle="dropdown">
		정렬기준 : <span class="orderList">마지막 수정일</span>
	</p>
	<div class="dropdown-menu dropdown-menu-right">
		<a class="dropdown-item" href="list.do?order=asc">작성일</a>
		<a class="dropdown-item" href="list.do?order=desc">마지막 수정일</a>
    </div>
</div>

<!-- start of 여행 테마 리스트 -->
<c:forEach items="${tripList }" var="vo">
	<div class="card">
		<div class="card-body">
			<div class="row">
				<div class="col-md-3">사진</div> <!-- from. 여행정보 게시판 -->
				<div class="col-md-9">
					<div class="row">
						<div class="col-9 tripThema">
							<h4 class="card-title font-weight-bolder">
								<input type="hidden" name="tno" class="tno" value="${vo.tno }">
								${vo.tripThema }
							</h4>
						</div>
						<div class="col-3">
							<!-- 여행 삭제 버튼 -->
							<div class="tripDeleteBtn">
								<h4 class="m-0">
									<i class="fa fa-ellipsis-v"></i>
								</h4>
							</div>
						</div>
					</div>
					<p class="card-text trip">
						<i class="fa fa-calendar-o"></i> 
						<fmt:formatDate value="${vo.tripStartDate }" pattern="yyyy.MM.dd" /> 
						→ <fmt:formatDate value="${vo.tripEndDate }" pattern="yyyy.MM.dd" />
					</p>
					<p class="card-text"><i class="fa fa-map-marker"></i> ${vo.countryKor }, ${vo.cityName}</p>
				</div>
			</div>
		</div>
	</div>
</c:forEach>
<!-- end of 여행 테마 리스트 -->
</div> 
<!-- end of container -->
<!-- start to modal -->
<div class="modal" id="tripPlanModal">
	<div class="modal-dialog">
		<div class="modal-content">
		
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">여행 떠나기</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			
			<form method="post">
				<!-- Modal body -->
				<div class="modal-body">
					<!-- 여행 기간 설정 -->
					<div class="form-group">
						<label for="tripCity">날짜 또는 여행 기간</label>
						<button type="button" class="btn btn-block" id="tripPeriodBtn" 
							style="border:1px solid #d1d3e2; text-align: left">
							<span>여행 기간이 어떻게 되시나요?</span>
						</button>
<!-- 						<div class="datepicker"> -->
<!-- 							<input id="tripStartDate" name="tripStartDate" type="hidden"> -->
<!-- 							<input id="tripEndDate" name="tripEndDate" type="hidden"> -->
<!-- 						</div> -->
					</div>
					<div class="form-group">
						<label for="tripThema">여행 이름</label>
						<input class="form-control" placeholder="ex.파리로 떠나는 가을 휴가" 
							id="tripThema" name="tripThema" required maxlength="80">
					</div>
					<!-- 여행지 검색 구간 -->
					<div class="form-group">
						<label for="cityNum">여행지</label>
						<button type="button" class="btn btn-block" id="citySearchBtn" 
							style="border:1px solid #d1d3e2; text-align: left">
							<span>여행을 어디로 떠나시나요?</span>
						</button>
						<input type="hidden" id="cityNum" name="cityNum" value="">
						<!-- 여행 도시 게시판 리스트 + 버튼 추가 -->
						<!-- Ajax 로 로드하기 -->
					</div>
					<div class="form-group">
						<label for="tripComment">설명(선택사항)</label>
						<textarea class="form-control" id="tripComment" name="tripComment" maxlength="1000"
							rows="2"></textarea>
					</div>
				</div>
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="submit" class="btn btn-dark" 
						style="width: 80px;" id="modalMultiBtn">Go</button>
					<button type="button" class="btn btn-outline-secondary" 
						style="width: 80px;" data-dismiss="modal">cancel</button>
				</div>
			</form>
		
		</div>
	</div>
</div>
<!-- end of modal -->
<div id="citySearch" style="display: none;">
	<jsp:include page="cityList.jsp" />
</div>

</body>
</html>