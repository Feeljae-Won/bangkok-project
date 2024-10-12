<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hotel</title>
<style type="text/css">
/* CSS 스타일 */
.dataRow:hover {
	opacity: 0.7; /* 투명도 */
	cursor: pointer;
}

.imageDiv {
	background: black;
	overflow: hidden; /* 카드 내부를 넘지 않도록 설정 */
}

.imageDiv img {
	width: 100%;
	height: 200px; /* 원하는 이미지 높이 설정 */
	object-fit: cover; /* 이미지 비율 유지하며 카드에 맞추기 */
}

.title {
	text-overflow: ellipsis;
	overflow: hidden;
	display: -webkit-box;
	-webkit-box-orient: vertical;
	-webkit-line-clamp: 2;
}
</style>
<script type="text/javascript">
$(function(){
	// 이벤트 처리
	$(".dataRow").click(function(){
		let no = $(this).find(".no").val();
		console.log("no = " + no);
		location = "view.do?no=" + no + "&inc=1&" + "${pageObject.pageQuery}";
	});
});
</script>
</head>
<body>
	<div class="container">
		<h2>Hotel</h2>
		<form>
			<input name="page" value="1" type="hidden"> 
			<input id="pageQuery" name="pageQuery" value="${pageObject.perPageNum }" type="hidden">
			<div class="custom-control custom-switch">
				<input type="checkbox" class="custom-control-input" id="switch1">
				<label class="custom-control-label" for="switch1">Toggle me</label>
			</div>
		</form>
		<c:if test="${empty list }">
			<div class="jumbotron">
				<h4>데이터가 존재하지 않습니다.</h4>
			</div>
		</c:if>
		<c:if test="${!empty list }">
			<div class="row">
				<!-- 이미지의 데이터가 있는 만큼 반복해서 표시하는 처리 시작 -->
				<c:forEach items="${list }" var="vo" varStatus="vs">
					<!-- 줄바꿈처리 - 찍는 인덱스 번호가 3의 배수이면 줄바꿈을 한다. -->
					<c:if test="${(vs.index != 0) && (vs.index % 3 == 0) }">
                    ${"</div>"}
                    ${"<div class='row'>"}
                </c:if>
					<!-- 데이터 표시 시작 -->
					<div class="col-md-4 dataRow">
						<div class="card" style="width: 100%">
							<div>
								<input class="no" type="hidden" value="${vo.no }">
							</div>
							<div class="imageDiv text-center">
								<img class="card-img-top" src="${vo.image_name }" alt="image">
							</div>
							<div class="card-body">
								<strong class="card-title"> ${vo.title } </strong>
								<p class="card-text title">
								<div>
									<span class="rating">${vo.rating }성급</span>
								</div>
								<div>
									<fmt:formatNumber value="${vo.price }" />
									원
								</div>
								<div>
									<span class="address">${vo.address }</span>
								</div>
								</p>
							</div>
						</div>
					</div>
					<!-- 데이터 표시 끝 -->
				</c:forEach>
				<!-- 이미지의 데이터가 있는 만큼 반복해서 표시하는 처리 끝 -->
			</div>

			<!-- 페이지 네이션 처리 -->
			<div>
				<pageNav:pageNav listURI="list.do" pageObject="${pageObject }" />
			</div>

		</c:if>
		<!-- 리스트 데이터 표시의 끝 -->
		<a href="writeForm.do?perPageNum=${pageObject.perPageNum }"
			class="btn btn-primary">등록</a>
	</div>
</body>
</html>
