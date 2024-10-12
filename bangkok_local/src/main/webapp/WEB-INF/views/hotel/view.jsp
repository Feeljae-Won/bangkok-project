<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>호텔 상세보기</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<style>
.container {
	margin-top: 20px;
}

.hotel-header {
	font-size: 2.5rem; /* 제목을 크게 설정 */
	font-weight: bold;
	margin: 0; /* 여백 제거 */
}

.hotel-subheader {
	font-size: 1rem; /* 작은 글씨 크기 */
	font-weight: lighter; /* 연한 글씨 */
	color: #6c757d; /* 회색으로 변경 */
	margin-top: 5px; /* 제목과 등급 사이의 간격 */
}

.main-image {
	max-width: 100%;
	height: auto;
	border-radius: 10px;
}

.smallImage {
	width: 100px;
	height: 100px;
	margin-right: 10px;
	border-radius: 5px;
	cursor: pointer;
	object-fit: cover;
}

.smallImageDiv {
	display: flex;
	margin-top: 10px;
	flex-wrap: wrap;
}

.card {
	margin-top: 20px;
}

.card-header {
	background-color: #f8f9fa;
	font-size: 1.5rem;
	font-weight: bold;
}

.card-body p {
	font-size: 1rem;
	line-height: 1.5;
}

.horizontal-card {
	display: flex; /* Flexbox를 사용하여 가로로 배치 */
	flex-direction: row; /* 기본 값은 row이므로 생략 가능 */
	border: 1px solid #ddd;
	border-radius: 8px;
	overflow: hidden; /* 내용이 넘칠 경우 처리 */
}

.horizontal-card .card-header, .horizontal-card .card-footer {
	flex: 1; /* 헤더와 푸터가 동일한 크기를 가짐 */
	background-color: #f8f9fa;
	padding: 15px;
	display: flex;
	align-items: center; /* 수직 가운데 정렬 */
	justify-content: center; /* 수평 가운데 정렬 */
}

.horizontal-card .card-body {
	flex: 3; /* 본문 영역이 더 넓어짐 */
	padding: 15px;
	display: flex;
	align-items: center;
	justify-content: center;
	background-color: #fff;
}
</style>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		// 바로 편의시설의 데이터를 세팅한다.
		let rno = $(".hotelRoomList").find(".rno").val();
	    $(".roomImageImg").load("/ajax/getRoomImageList.do?rno=" + rno);
		
		// 작은 이미지를 클릭하면 큰 이미지로 변경
		$(".smallImage").click(function() {
			var newSrc = $(this).attr("src");
			$(".main-image").attr("src", newSrc);
		});
	});
</script>

</head>
<body>

	<div class="container">
		<div class="row">
			<!-- 작은 이미지들 -->
			<div class="col-md-4">
				<div class="smallImageDiv" id="smallImageDiv">
					<img src="${vo.detail_image_name}" class="smallImage img-thumbnail"
						alt="호텔 이미지">
					<c:if test="${!empty hotelImageList}">
						<c:forEach items="${hotelImageList}" var="hotelImageVO">
							<img src="${hotelImageVO.hotel_image_name}"
								class="smallImage img-thumbnail" alt="호텔 이미지">
						</c:forEach>
					</c:if>
				</div>
			</div>

			<!-- 메인 이미지 -->
			<div class="col-md-8">
				<div class="bigImageDiv" id="bigImageDiv">
					<img src="${vo.detail_image_name}" alt="호텔 이미지" class="main-image"
						width="700" height="500">
				</div>
			</div>
		</div>

		<!-- 연한 줄 -->
		<hr style="border: 0.5px solid #ddd; margin: 20px 0;">

		<!-- 호텔 정보 카드 -->
		<div>
			<h2 class="hotel-header">${vo.title}</h2>
			<p class="hotel-subheader">${vo.rating}성급</p>

			<div>
				<p>호텔 소개: ${vo.content}</p>
			</div>
			<div>
				<p>전화번호 : ${vo.tel }</p>
			</div>
			<div>
				<p>공지사항 : ${vo.notice }</p>
			</div>
			<div>
				<p>주소 : ${vo.address }</p>
			</div>
			<div>
				<p>숙소분류 : ${vo.accommodations }</p>
			</div>
		</div>

		<!-- 연한 줄 -->
		<hr style="border: 0.5px solid #ddd; margin: 20px 0;">

		<div>
			<b style="font-size: 14pt;">[편의시설]</b>
			<ul>
				<c:forEach items="${amenitiesList}" var="amenitiesVO">
					<li>${amenitiesVO.amenitiesName}</li>
				</c:forEach>
			</ul>
		</div>

		<!-- 연한 줄 -->
		<hr style="border: 0.5px solid #ddd; margin: 20px 0;">

		<c:forEach items="${hotelRoomList}" var="roomVO">
			<div class="card hotelRoomList mb-4 shadow-sm">
			 <input type="hidden" name="rno" value="${roomVO.rno }" class="rno">
				<div class="card-header">
					<h5 class="mb-0">객실명: ${roomVO.room_type} ${roomVO.room_title}</h5>
				</div>
				<div class="card-body d-flex">
					<div>
						<img src="${roomVO.room_image_name }" class="img-thumbnail roomImageImg" width="400px"
						height="250px">
						<div class="roomImageImg"></div>
					</div>
				<div>
				
				</div>
					<div class="info-container ml-3">
						<p>
							<strong>객실 정보:</strong> ${roomVO.room_content}
						</p>
						<p>
							<strong>가격:</strong> ${roomVO.price} 원
						</p>
						<p>
							<strong>인원수:</strong> ${roomVO.people} 명
						</p>
						<p>
							<strong>남은 객실:</strong> ${roomVO.room_number} 개
						</p>
					</div>
				</div>
				<div class="card-footer text-muted">객실 상세보기</div>
			</div>

		</c:forEach>

	</div>

</body>
</html>
