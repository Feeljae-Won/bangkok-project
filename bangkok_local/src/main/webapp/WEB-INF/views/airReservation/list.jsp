<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>예약 목록 페이지</title>

<style>
@import
	url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap')
	;

.container {
	max-width: 1200px;
	width: 100%;
	background-color: #ffffff;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
	border-radius: 12px;
	padding: 20px;
	animation: fadeIn 1s ease-in-out;
	max-height: 90vh;
	overflow-y: auto;
}

h2 {
	font-size: 28px;
	color: #34495e;
	text-align: center;
	margin-bottom: 20px;
	font-weight: 700;
}

.reservation-list {
	display: flex;
	flex-direction: column;
	gap: 20px;
}

.reservation-card {
	background-color: #ffffff;
	border-radius: 8px;
	padding: 20px;
	cursor: pointer;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	transition: all 0.3s ease;
	position: relative;
	border: 1px solid #e0e0e0;
}

.reservation-card:hover {
	transform: scale(1.03);
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}

.reservation-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-size: 20px;
	color: #2c3e50;
	margin-bottom: 15px;
}

.highlight {
	color: #e74c3c;
	font-weight: bold;
}

.arrow {
	transition: transform 0.3s ease;
	font-size: 16px;
}

.rotate {
	transform: rotate(180deg);
}

.info-row {
	display: flex;
	justify-content: space-between;
	margin-bottom: 10px;
}

.info-row div {
	width: 48%;
	font-size: 14px;
}

.summary {
	margin-top: 15px;
	font-weight: bold;
	color: #2980b9;
	font-size: 16px;
	cursor: pointer;
}

.additional-details {
	display: none;
	margin-top: 20px;
	background-color: #f8f9fa;
	border-radius: 8px;
	padding: 15px;
	animation: slideDown 0.5s ease-in-out forwards;
	font-size: 14px;
}

.additional-details p {
	margin: 5px 0;
}

.buttons {
	display: flex;
	justify-content: space-between;
	margin-top: 20px;
}

.button {
	background-color: #003366;
	color: #fff;
	border: none;
	border-radius: 8px;
	padding: 10px 20px;
	font-size: 14px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.button.refund {
	background-color: #003366;
}

.button:hover {
	background-color: #2980b9;
}

.button.refund:hover {
	background-color: #c0392b;
}

@
keyframes fadeIn { 0% {
	opacity: 0;
	transform: translateY(20px);
}

100
%
{
opacity
:
1;
transform
:
translateY(
0
);
}
}
@
keyframes slideDown { 0% {
	max-height: 0;
	opacity: 0;
}
100
%
{
max-height
:
500px;
opacity
:
1;
}
}
</style>
</head>
<body>

	<div class="container">
		<h2>예약 목록</h2>
		<div class="reservation-list">

			<!-- 예약 카드 1 -->
			<c:forEach items="${list }" var="vo">

				<div class="reservation-card" onclick="toggleDetails(this)">
					<div class="reservation-header">
						<h2>
							<span class="highlight">${vo.email }</span>님의 예약번호는 <input
								type="hidden" name="reservationNo" value="${vo.reservationNo }"
								id="reservationNo"> <span class="highlight"
								name="reservationLabel">${vo.reservationLabel }</span>입니다.
						</h2>
						<div class="arrow">▼</div>
					</div>
					<div class="info-row">
						<div>
							<span>출발:</span> ${vo.firstDeparture }
						</div>
						<div>
							<span>도착:</span> ${vo.firstArrival }
						</div>
					</div>
					<div class="info-row">
						<div>
							<span>항공사:</span> ${vo.flightName }
						</div>
					</div>
					<div class="info-row">
						<div>
							<span>출발날짜:</span> ${vo.departureTime }
						</div>
						<div>
							<span>도착날짜:</span> ${vo.arrivalTime }
						</div>
					</div>
					<div class="summary" onclick="event.stopPropagation()">총 결제
						금액: ${vo.total_Price }원</div>
					<div class="buttons">
						<button class="button refund" onclick="handleRefund(event)">환불</button>
						<button class="button update">예약 수정</button>
					</div>
					<div class="additional-details">
						<p>
							<strong>출발:</strong> ${vo.firstDeparture }
						</p>
						<p>
							<strong>도착:</strong> ${vo.firstArrival }
						</p>
						<p>
							<strong>항공사:</strong> ${vo.flightName }
						</p>
						<p>
							<strong>왕복 / 편도:</strong> ${vo.type }
						</p>
						<p>
							<strong>좌석 등급:</strong> ${vo.seatClass }
						</p>
						<p>
							<strong>좌석 번호:</strong> ${vo.seatIDs }
						</p>
						<p>
							<strong>탑승객 수:</strong> ${vo.passenger_cnt }
						</p>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

	<script>
		$(function() {
			$(".update").click(function() {

				alert('예약 수정 버튼 클릭됨');
				
				let reservationNo = $("#reservationNo").val();

				location = "updateForm.do?reservationNo=" + reservationNo
			})
		})

		function toggleDetails(card) {
			const details = card.querySelector('.additional-details');
			const arrow = card.querySelector('.arrow');
			if (details.style.display === 'none'
					|| details.style.display === '') {
				details.style.display = 'block';
				arrow.classList.add('rotate');
			} else {
				details.style.display = 'none';
				arrow.classList.remove('rotate');
			}
		}

		function handleRefund(event) {
			event.stopPropagation();
			alert('환불 버튼 클릭됨');
		}
	</script>

</body>
</html>
