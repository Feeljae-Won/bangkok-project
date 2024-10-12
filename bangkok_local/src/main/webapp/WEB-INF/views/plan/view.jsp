<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>trip plan view</title>

<style type="text/css">

.themaDiv {
	height: 240px;
}
.tripDetailDiv:first-child {
	width: 40px; height: 40px;
	padding: 4px; float:left; text-align: center;
}
.tripDetailDiv {
	width: 40px; height: 40px;
	padding: 4px; float:right; text-align: center;
}
.tripDetailDiv:hover {
	cursor: pointer;
}
.tripDetailDiv:active {
	border: 0 solid #6c757d; border-radius: 50%;
	background: #e0e0e0;	
}
#citySearchModal .cityList:hover {
	cursor: pointer;
	border: 2px solid #fd7e14;
}
.themaDiv > .card-body {
	position: absolute;
    bottom: 0; /* 컨테이너의 하단에 정렬 */
    margin: 0; /* 필요에 따라 마진 조정 */
}
.tripThema, .tripDate {
	font-weight: bolder;
}
.tripDate {
	Padding: 5px;
}
.tripPeriod, .tripPlace {
	float: left;
	margin-right: 10px; 
	margin-bottom: 0
}
.tripDateBtn {
	margin: 10px 10px 15px 0;
}
.tripDateBtn:last-child {
	margin-right: 0;
}
.tripDateDiv {
	padding: 10px 0;
	border-top: 1px solid #343a40;
}
.tripDateDiv:last-child {
	border-bottom: 1px solid #343a40;
}
.planListDiv { 
	padding: 15px 50px;
	margin: 0 auto;
} 
.planListDiv .planList {
	display: none;
}
.tripPlace p {
	margin-bottom: 8px;
}

</style>
<!-- 구글 지도 api -->
<!-- <script defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBKx6hwWeIT3qTG3uNkPVFbIkob4joaPcY&callback=initMap&v=weekly&libraries=marker""></script> -->
<!-- 지도 스크립트 부분 -->
<script type="text/javascript">
// $(function(){
// 	let map = google.maps.Map;
// 	async function initMap() {
// 	    const { Map } = await google.maps.importLibrary("maps");
// 	    // 마커 생성 부분
// 	    const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");
// 	    const map = new Map(document.getElementById("map"), {
// 	        // 중심지의 위도/경도
// 	    	center: { lat: 37.738835, lng: 127.045888 },
// 	        zoom: 14,
// 	        mapId: "4504f8b37365c3d0",
// 	    });
// 	    const marker = new AdvancedMarkerElement({
// 	      map,
// 	      position: { lat: 37.738835, lng: 127.045888 },
// 	    });
// 	}
	
// 	initMap();
// });
</script>
<!-- 여행 계획 스크립트 부분 -->
<script type="text/javascript">
	$(function(){
		// 이벤트 처리
		// 여행 등록 번호 가져오기
		let tno = $(".tripPlanDiv").find("#tno").val();
		
		// 도시 항목 로드하기 by. ajax
		$(".planListDiv").load("/plan/planList.do?tno=" + tno);
		
		// 핵심 코드 - 1		
		// 여행 날짜를 저장할 Set 객체 생성
	    let tripDates = new Set();
	    // 모든 tripDateBtn을 순회하여 중복된 항목 제거
	    $(".tripDateBtn").each(function() {
	        // 현재 버튼의 tripDate 값을 가져옴
	        let tripDate = $(this).data("tripdate");

	        // Set에 tripDate가 이미 존재하는지 확인
	        if (tripDates.has(tripDate)) {
	            // 이미 존재하면 해당 요소의 planList 및 tripDateDiv 제거
	            $(this).closest(".tripDateDiv").next(".planList").remove();
	            $(this).closest(".tripDateDiv").remove();
	        } else {
	            // 존재하지 않으면 Set에 추가
	            tripDates.add(tripDate);
	        }
	    });
		
		// 여행 수정 - 1. 수정 모달 출력
		$("#tripUpdateDiv").click(function(){
			// action 위치 지정
			$("#tripPlanModal").find("form").attr("action", "update.do");
			// 제목 변경
			$("#tripPlanModal").find(".modal-title").text("여행 상세 정보 수정");
			
			// input 태그 만들기
			let tnoInput = $("#tripPlanModal").find("form");
			tnoInput.append("<input type='hidden' value='" + tno + "' name=tno>")
			
			// $("#tripPlanModal").find("form").add("form input").val(tno);
			
			// 여행 기간 유지 -1. 버튼 텍스트 유지
			$("#tripPlanModal").find("#tripPeriodBtn span")
				.text($(".card-body").find(".tripPeriod").text());
			// 여행 기간 유지 -2. input 값 유지
			// 시작일
// 			$("#tripPlanModal").find("#tripStartDate")
// 				.val($(".tripPeriod").find(".tripStartDateVal").val());
			// 종료일
// 			$("#tripPlanModal").find("#tripEndDate")
// 				.val($(".tripPeriod").find(".tripEndDateVal").val());
			// 이름 유지
			$("#tripPlanModal").find("#tripThema").val($(".tripThema").text());
			// 여행지 유지
			// -1. 여행지 번호 유지
			$("#tripPlanModal").find("#cityNum")
				.val($(".tripPlanDiv").find("#cityNum").val());
			// -2. 여행지명 유지
			$("#tripPlanModal").find("#citySearchBtn span")
				.text($(".card-body").find(".tripPlace").text());
			// 상세 설명 유지
			if($(".tripCommentVal") != null && $(".tripCommentVal").val() != '') {
				$("#tripPlanModal").find("#tripComment").text($(".tripCommentVal").val());
			} 
			else {
				$("#tripPlanModal").find("#tripComment").text('');
			}
			// 모달창 출력
			$("#tripPlanModal").modal("show");
		});
		
		// 여행 수정 - 2. 도시 검색 모달 출력
		$("#tripPlanModal #citySearchBtn").click(function(){
			// alert("여행지 검색");
			$("#tripPlanModal").hide();
			$("#citySearchModal").modal("show");
		});
		
		// 여행 수정 - 3. 도시선택
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
			$("#citySearchModal").hide();
			// 원래 입력란 보이기
			$("#tripPlanModal").show(); 
			
		});
		
		// 일정(계획 보이기) >> planDetail list
		$(".tripDateDiv .tripDateBtn").click(function(){
			// alert("버튼 클릭");
			// 현재 일정
			// let thisPlan = $(this).closest(".tripDateDiv").next(".planList");
			$(this).closest(".tripDateDiv").next(".planList").toggle();
			$(".planList")
				.not($(this).closest(".tripDateDiv").next(".planList")).hide();
		});
		
		// 일정 상세보기
// 		$(".planListDiv").on("click", ".planDetailList", function(){
// 			let pno = $(this).find(".pno").val();
// 			location="view.do?tno=" + tno +"&pno" + pno;
			
// 		});
		// 여행 정보 수정
	});

</script>

</head>
<body>

<div class="container">

<div class="row" style="margin-top: 30px;">
	<div class="col-md-7"> <!-- 계획 영역 -->
		<div class="tripPlanDiv">
			<input type="hidden" value="${vo.tno }" name="tno" id="tno">
			<input type="hidden" value="${vo.cityNum }" name="cityNum" id="cityNum">
			<div class="card themaDiv">
				<!-- 여행 계획 수정 & 삭제 버튼 -->
				<div>
					<!-- 리스트로 돌아가기 버튼 -->
					<div class="float-left">
						<div class="mx-3 mt-3 mb-2 tripDetailDiv" onclick="location='list.do'">
							<i class="material-icons" style="font-size:30px;">arrow_back</i>
						</div>
					</div>
					<div class="float-right">
						<div class="mx-3 mt-3 mb-2 tripDetailDiv" id="tripUpdateDiv">
							<i class="fa fa-gear" style="font-size:30px;"></i>
						</div>
					</div>
				</div>
				<div class="card-body">
					<h2 class="card-title tripThema">${vo.tripThema }</h2>
					<p class="card-text tripPeriod">
						<!--시작일 / 종료일 저장 -->
						<input type="hidden" value="${vo.tripStartDate }" name="tripStartDate" class="tripStartDateVal">
						<input type="hidden" value="${vo.tripEndDate }" name="tripEndDate" class="tripEndDateVal">
						<!--시작일 / 종료일 출력 -->
						<i class="fa fa-calendar-o"></i> 
						<fmt:formatDate value="${vo.tripStartDate }" pattern="MM월 dd일" />
						→ <fmt:formatDate value="${vo.tripEndDate }" pattern="MM월 dd일" />
					</p>
					<p class="card-text tripPlace">
						<i class="fa fa-map-marker"></i> ${vo.countryKor }, ${vo.cityName}
					</p>
				</div>
			</div>
			<div class="commentDiv" style="margin-top:7px;">
				<input type="hidden" class="tripCommentVal" value="${vo.tripComment}">
				<input readonly style="width:100%; border: none; background: transparent;" class="tripComment"
					placeholder="${(!empty vo.tripComment)?vo.tripComment:'어떤 여행인가요? (선택사항)' }">
			</div>
		</div>
		<!-- 계획 리스트 -->
		<div class="btn-group">
			<button type="button" class="btn btn-outline-dark tripDateBtn" 
				style="border-radius: 30px;">1일차</button>
		</div>
		<!-- 날짜 버튼 리스트 출력 -->
		<!-- 일정별 리스트 출력 : 댓글 리스트 처럼 -->
		<div class="planListDiv px-0">
		<!-- start to forEach -->
		<c:forEach items="${planDetailList }" var="tdvo">
			<div>
			<div class="tripDateDiv">
				<button type="button" class="btn tripDateBtn my-1"
					data-tripdate="${tdvo.tripDate}" style="width: 100%;">
					<h4 class="card-title text-left tripDate mb-0">
						<fmt:formatDate value="${tdvo.tripDate }" pattern="yyyy.MM.dd"/> 
						<span class="float-right"><i class="fa fa-angle-down"></i></span>
					</h4>
				</button>
			</div>
			<div class="planList">
			<c:forEach items="${planDetailList }" var="vo">
				<c:if test="${tdvo.tripDate == vo.tripDate }">
					<div class="row">
					<!-- 일정 순서 아이콘 -->
					<div class="col-sm-1" style="padding-left: 0;">
						<div class="bg-dark text-white" 
							style="width:20px; height: 20px; margin: 0 auto; border-radius: 50px; font-weight: bolder;
							font-size:13px; text-align: center;">1</div>
						<div style="border-right:1px solid #343a40; width: 0; height: 100%; margin: 0 auto;"></div>
					</div>
					<!--일정 정보 -->
					<div class="col-sm-11" style="padding-left: 0;">
					<div class="card planDetailList mt-4 mb-3" style="height: 130px;">
						<input type="hidden" value="${vo.pno }" class="pno" name="pno">
						<div class="card-body" style="padding: 10px;">
							<!-- 여행지 사진 div -->
							<div class="img-thumbnail float-left">
								<img src="${vo.imageFile }" alt="placeImg" width="100" height="100">
							</div>
							<div class="float-left tripPlace"
								style="width: 70%; margin-left: 10px; padding-top:10px;">
								<p style="font-weight:bold; font-size:15px;">${vo.cate_name}</p>
								<p style="font-weight:bold; font-size:15px;">${vo.place}</p>
							</div>
						</div>
					</div> <!-- end of .card .planDetailList -->
					</div> <!-- end of .col-md-11 -->
					</div> <!-- end of row -->
				</c:if>
			</c:forEach>
			<div class="row">
				<div class="col-sm-1" style="padding-left: 0;">
					<div class="bg-dark text-white" 
						style="width:20px; height: 20px; margin: 0 auto; border-radius: 50px; font-weight: bolder;
						font-size:13px; text-align: center;">1</div>
					<div style="border-right:1px solid #343a40; width: 0; height: 83px; margin: 0 auto;"></div>
				</div>
				<!-- 여행지 추가 버튼 -->
				<div class="col-sm-11" style="padding-left: 0;">
					<button class="btn btn-outline-dark btn-block myTrip" 
						style="margin: 30px 0; padding: 15px 10px; font-size: 17px; border-style: dashed;">
						<i class="fa fa-plus"></i> 여행지 추가
					</button>
				</div>
			</div>
			</div> <!-- end of .planList -->
			</div>
		</c:forEach>
		<!-- end of forEach -->
		</div>
	</div>
	
	<div class="col-md-5"> <!-- 지도 영역 -->
		<div id="map" style="height: 800px; z-index: 0;"></div>
	</div>
</div>
</div> <!-- end of container -->


<!-- start to tripPlanModal -->
<jsp:include page="tripPlanModal.jsp" />
<!-- end of tripPlanModal -->

<!-- start to citySearchModal -->
<jsp:include page="cityList.jsp" />
<!-- end of citySearchModal -->

</body>
</html>