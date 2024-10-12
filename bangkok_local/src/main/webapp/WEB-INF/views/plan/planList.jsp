<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   

<style>
.planDetailList {
	cursor: pointer;
}
</style>

<script>
	$(function(){
		// pno 수집
		let pno = $(".planDetailList").find(".pno").val()
		
		// planView 로드 - ajax
		$(".planViewDiv").load("/ajax/planView.do?pno=" + pno);
		
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
	});
</script>

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

<!-- start to planViewDiv >> load -->
<div class="planViewDiv">
</div>
<!-- end of modal -->