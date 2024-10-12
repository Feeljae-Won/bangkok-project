<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제목</title>
<style type="text/css">
.img {
    display: block;
    margin: 0 auto;
    width: 100%; /* 원본 크기의 150%로 설정 */
    height: auto; /* 비율을 유지하면서 확대 */
    object-fit: contain; /* 이미지 비율을 유지하면서 컨테이너에 맞게 조절 */
}
.material-icons{
	margin-right: 30px;
}
.back {
    display: inline-block; /* 인라인 블록으로 변경하여 margin-top/bottom 적용 가능 */
    margin-bottom: 20px;
}
#back:hover{
	cursor:pointer;
}
</style>
<script type="text/javascript">
$(function(){
	$("#back").click(function(){
		//alert("i 클릭");
		location = "list.do?page="+${param.page}+"&perPageNum="+${param.perPageNum};
	});
	$(".deleteBtn").click(function(){
		if (confirm("정말 삭제하시겠습니까?")) {
			let eventNo = $(".back").data("event-no");
			//alert(eventNo);
			location = "delete.do?eventNo="+eventNo;
		    // 사용자가 '확인'을 클릭했을 때 실행되는 코드
		    
		}
	});
});
</script>

</head>
<body>

<div class="container">
	<div class="card">
	  <div class="card-header"><h2>이벤트 상세보기</h2></div>
	  <div class="card-body">
	  	<span class="back" data-event-no="${vo.eventNo }">
	  	<i class="material-icons" style="font-size:30px" id="back">arrow_back </i><b style="font-size:30px; font-weight: 510;" class="bTitle">${vo.title }</b>
	  	
	  	</span>
	  	<img alt="이미지가 없습니다" src="${vo.image }" class="img">
	  </div>
	  	  <div class="card-footer">
		<a href="updateForm.do?no=${vo.eventNo }&page=${param.page }&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}" class="btn btn-outline-warning">수정</a>
		<a class="btn btn-outline-warning deleteBtn">삭제</a>
	  </div>
	</div>
</div>
</body>
</html>