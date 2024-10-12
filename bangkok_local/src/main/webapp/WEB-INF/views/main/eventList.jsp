<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>

<style>
/* 기존 스타일 유지 */
.lineDiv {
	background: #f2f2f2;
	padding: 10px;
	border-radius: 30px;
	margin-bottom: 10px;
	width: 100%;
	display: flex;
	align-items: center;
	justify-content: center; /* 이미지들을 가운데 정렬 */
	overflow: hidden;
	gap: 15px;
	margin-top: 50px;
}

.lineDiv img {
	border-radius: 10px;
	width: 100px;
	height: auto;
}

.dataRow {
	width: calc(33.333% - 40px);
	display: inline-block;
	vertical-align: top;
	text-align: center;
	padding: 5px;
	cursor: default; /* 기본 커서 */
	position: relative;
}

.dataRow img {
	cursor: pointer; /* 이미지에만 포인터 커서 설정 */
}

.dataRow:last-child {
	margin-right: 0; /* 마지막 dataRow는 오른쪽에 여백을 두지 않음 */
}

.rounded {
	margin-right: 20px;
	max-width: 100%;
	max-height: 100%;
	object-fit: cover;
}

.eventTitle {
	font-size: 16px;
	margin-top: 10px;
	text-align: center; /* 제목도 가운데 정렬 */
	color: white;
	font-family: 'Pretendard-Regular';
	font-weight: 500;
}

.dateRange {
	margin-top: 10px;
	text-align: center; /* 날짜도 가운데 정렬 */
}

.dataRow:hover {
	cursor: pointer;
}

.no-events {
	display: none;
	text-align: center;
	padding: 20px;
	font-size: 1.2em;
	color: #888;
}

.container-event {
	display: flex;
	justify-content: center;
	width: 65%;
	position: relative;
	background-color: #FF7F50;
	border-radius: 30px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
	margin: 0 auto;
}

.carousel-wrapper {
	width: 100%;
	max-width: 1200px;
	overflow: hidden;
	display: flex;
	justify-content: center; /* 캐러셀 내부를 가운데 정렬 */
}

.carousel {
	display: flex;
	justify-content: center; /* 슬라이드들을 가운데 정렬 */
	transition: transform 0.5s ease;
	max-height: 600px;
	padding: 10px 0; /* 위아래 여백 줄이기 */
	margin: 0; /* 필요시 추가: 여백을 없애기 */
}

.arrow {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	background-color: white; /* 배경색을 하얗게 */
	color: black; /* 화살표 색상을 검정색으로 */
	border: none;
	border-radius: 50%; /* 동그랗게 만들기 */
	width: 40px; /* 너비 조정 */
	height: 40px; /* 높이 조정 */
	display: flex; /* 중앙 정렬을 위해 flex 사용 */
	align-items: center; /* 수직 중앙 정렬 */
	justify-content: center; /* 수평 중앙 정렬 */
	cursor: pointer;
	z-index: 10;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2); /* 그림자 추가 (선택 사항) */
}

.arrow.left {
	left: 10px;
}

.arrow.right {
	right: 10px;
}
</style>

<script type="text/javascript">
	$(function() {
		// 공지사항 글 보기 이동 처리
		$(".dataRow").each(function(index) {
			if ((index + 1) % 3 === 0) {
				$(this).css('margin-right', '0');
			} else {
				$(this).css('margin-right', '40px');
			}
		});

		$(".dataRow").click(function() {
			let eventNo = $(this).data("event-no");
			location = "/event/view.do?eventNo=" + eventNo;
		});

		$(".dataRow img").click(function(event) {
			event.stopPropagation(); // 부모 클릭 이벤트를 중지
			let eventNo = $(this).closest(".dataRow").data("event-no");
			location = "/event/view.do?eventNo=" + eventNo;
		});
	});

	// 캐러셀 슬라이드 이동 처리
	let currentSlide = 0;

	function moveSlide(direction) {
		const carousel = document.querySelector('.carousel');
		const slideWidth = 300 + 20; // 슬라이드 너비 (300px) + 여백(20px)
		const maxSlides = document.querySelectorAll('.dataRow').length;
		const visibleSlides = 3; // 한 번에 보이는 슬라이드 개수

		currentSlide += direction;

		// 슬라이드의 처음과 끝을 넘어가지 않도록 제한
		if (currentSlide < 0) {
			currentSlide = maxSlides - visibleSlides;
		} else if (currentSlide > maxSlides - visibleSlides) {
			currentSlide = 0;
		}

		carousel.style.transform = `translateX(-${currentSlide * slideWidth}px)`;
	}
</script>
<br><br>
<h4
	style="margin-left: 18%; font-family: 'Pretendard-Regular'; margin-bottom: 20px;">이벤트
	&#183; 혜택</h4>
<div class="container-event">
	<div class="carousel-wrapper">
		<button class="arrow left" onclick="moveSlide(-1)">&#10094;</button>
		<div class="carousel">
			<c:forEach items="${eventList}" var="vo">
				<div class="dataRow" data-event-no="${vo.eventNo}">
					<div class="lineDiv">
						<img class="rounded sub_image" src="${vo.sub_image}"
							alt="Event Image"> <img class="rounded image"
							src="${vo.image}" alt="Event Image">
					</div>
					<p class="eventTitle">${vo.title}</p>
				</div>
			</c:forEach>
		</div>
		<button class="arrow right" onclick="moveSlide(1)">&#10095;</button>
	</div>
</div>
