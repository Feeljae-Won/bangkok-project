<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<script type="text/javascript">
$(function(){
	    $(".dataRow").click(function(){
	        let eventNo = $(this).data("event-no");
	        location = "view.do?eventNo=" + eventNo+"&${pageObject.pageQuery}";
	});
});
$(document).ready(function() {
    let today = new Date(); // 현재 날짜를 구함

    $(".dataRow").each(function() {
        // 각 이벤트의 종료일을 가져와서 Date 객체로 변환
        let endDate = new Date($(this).find(".endDay").text().trim());
        // 날짜 차이를 밀리초로 계산하고, 이를 일 단위로 변환
        let diffTime = endDate - today;
        let diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)); // 밀리초 -> 일수로 변환
		
        // 차이가 5일 이내이면 '마감임박' 뱃지를 추가
        if (diffDays <= 5) {
            $(this).find(".eventTitle").append('<span class="badge badge-danger">마감임박</span>');
        }
    });
});

</script>
	<br>
    <c:forEach items="${hotel }" var="vo">
        <div class="dataRow" data-event-no="${vo.eventNo}">
            <div class="lineDiv">  <!-- 테두리 만듬 -->
                <img class="rounded sub_image" src="${vo.sub_image}" alt="Cinque Terre">
                <img class="rounded image" src="${vo.image}" alt="Cinque Terre">
            </div>
            <p class="eventTitle">${vo.title}</p>
            <div class="dateRange">
                <span><fmt:formatDate value="${vo.startDay}" pattern="yyyy-MM-dd"/></span> ~
                <span class="endDay"><fmt:formatDate value="${vo.endDay}" pattern="yyyy-MM-dd"/></span>
            </div>
        </div>
    </c:forEach>