<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav"  tagdir="/WEB-INF/tags"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 글등록</title>
 <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
 <script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
<style type="text/css">
.start{
	display: none;
}
.end{
	display: none;	
}
</style>
<script type="text/javascript">
$(function(){
	
	// 날짜 입력 설정 - datepicker : 전체 날짜 입력 형태
	let now = new Date();
    let startYear = now.getFullYear();
    let yearRange = startYear +":" + (startYear + 10) ;
	$(".datepicker").datepicker({
		// 입력란의 데이터 포맷 
		dateFormat: "yy-mm-dd",
		// 월 선택 입력 추가
		changeMonth: true,
		// 년 선택 입력 추가
		changeYear: true,
		// 월 선택할 때의 이름 - 원래는 영어가 기본
		monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
		// 달력의 요일 표시
		dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
		// 선택 년도의 범위 - 현재 부터 10년 이후까지 년도 검색
		yearRange: yearRange,
	});
	
	   $("#startDate").datepicker("option",
	   {
	      "minDate" : now,
	      onClose : function( selectedDate ) {
	    	  if($(this).val() != "")
	         	$( "#endDate" ).datepicker( "option", "minDate", selectedDate );
	      }
	   });
	   
		$("#endDate").datepicker("option", 
	   {
	      "minDate" : now,
	      onClose : function( selectedDate ) {
	    	  if($(this).val() != "")
	         	$( "#startDate" ).datepicker( "option", "maxDate", selectedDate );
	      }
	   });
	
}); // $(function())의 끝
</script>
<script type="text/javascript">
$(function(){
	let startDay = $(".start").text();
	let endDay = $(".end").text();
	console.log(startDay);
	$("#startDate").val(startDay);
	$("#endDate").val(endDay);
});

</script>
</head>
<body>

<div class="container">

	<h1>이벤트 수정</h1>
	<form action="update.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="page" value="${param.page }">
		<input type="hidden" name="perPageNum" value="${param.perPageNum }">
		<input type="hidden" name="key" value="${param.key }">
		<input type="hidden" name="word" value="${param.word }">
		<table class="table">
			<!-- tr : table row - 테이블 한줄 -->
			<!-- 게시판 데이터의 제목 -->
			<tr>
				<th>번호</th>
				<td>
					<input id="eventNo" name="eventNo" required readonly
						class="form-control" value="${vo.eventNo }">
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input value="${vo.title}" id="title" name="title" required 
						class="form-control" maxlength="100"
						pattern="^[^ .].{2,99}$"
						title="맨앞에 공백문자 불가. 3~100자 입력"
						placeholder="제목 입력 : 3자 이상 100자 이내"
						>
				</td>
			</tr>
			<tr>
				<th>이미지</th>
				<td>
					<input type="file" name="files" >
				</td>
			</tr>
			<tr>
				<th>글 이미지</th>
				<td>
					<input type="file" name="files" >
				</td>
			</tr>
			<tr>
			    <th>이벤트 시작일</th>
			    <td>
					<input  id="startDate" name="startDay" required autocomplete="off"
						class="form-control datepicker"  
					>
				</td>
		  	</tr>
		  	<tr>
			    <th>이벤트 종료일</th>
			    <td>
					<input id="endDate" name="endDay" required autocomplete="off"
						class="form-control datepicker" 
					>
				</td>
		  	</tr>
			<tr>
				<td colspan="2">
					<!-- a tag : 데이터를 클릭하면 href의 정보를 가져와서 페이지 이동시킨다. -->
					<button class="btn btn-outline-warning">등록</button>
					<button type="reset" class="btn btn-outline-warning">다시입력</button>
					<button type="button" onclick="history.back();" class="btn btn-outline-warning">취소</button>
				</td>
			</tr>
		</table>
	</form>
</div>
               <span class="start"><fmt:formatDate value="${vo.startDay}" pattern="yyyy-MM-dd"/></span>
                <span class="end"><fmt:formatDate value="${vo.endDay}" pattern="yyyy-MM-dd"/></span>
</body>
</html>