<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>항공 예약 폼</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/uuid/8.1.0/uuidv4.min.js"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap"
	rel="stylesheet">
<style type="text/css">
body {
	font-family: 'Roboto', sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f1f5f9;
	color: #333;
}

.container {
	max-width: 1200px;
	margin: 50px auto;
	padding: 20px;
	background-color: #fff;
	border-radius: 12px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	display: flex;
	gap: 20px;
	flex-direction: column;
}

.header {
	text-align: center;
	background-color: #004d99;
	color: #fff;
	padding: 20px;
	border-radius: 12px 12px 0 0;
}

.header h1 {
	margin: 0;
	font-size: 28px;
}

.header p {
	margin: 10px 0 0;
	font-size: 14px;
	color: #e0e0e0;
}

.left-section, .right-section {
	width: 100%;
}

section {
	margin-bottom: 30px;
}



h2 {
	margin-top: 0;
	color: #004d99;
	font-size: 22px;
}

.details div, .fare-details div {
	margin: 8px 0;
	font-size: 16px;
}

.fare-details .total {
	font-weight: bold;
	font-size: 20px;
	color: #004d99;
}

.form-group {
	margin-bottom: 20px;
}

.form-group label {
	display: block;
	font-weight: 700;
	margin-bottom: 5px;
}

.form-group input, .form-group select {
	width: 100%;
	padding: 10px;
	border: 1px solid #d0d0d0;
	border-radius: 6px;
	font-size: 16px;
	background-color: #fff;
}

.form-group input:focus, .form-group select:focus {
	border-color: #004d99;
	outline: none;
}

.btn {
	display: block;
	width: 100%;
	padding: 12px;
	background-color: #004d99;
	color: #fff;
	border: none;
	border-radius: 6px;
	font-size: 18px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.btn:hover {
	background-color: #006bb3;
}

.baggage-item {
	margin-bottom: 20px;
}

.baggage-item:last-child {
	margin-bottom: 0;
}

@media ( max-width : 768px) {
	.container {
		flex-direction: column;
		padding: 10px;
	}
	.journey-info, .booking-info, .fare-info, .baggage-info {
		padding: 15px;
	}
	.header h1 {
		font-size: 24px;
	}
	.header p {
		font-size: 12px;
	}
}
</style>



</head>
<body>
	<div class="container">
		<form action="write.do" method="post">
		   <input type = "hidden" name = "reservationNo" value = "${vo.reservationNo }">
		   <input type = "hidden" name = "email" value = "${vo.email }">
			<!-- Header Section -->
			<header class="header">
				<h1>인천 ${vo.firstDeparture } → 후쿠오카 ${vo.firstArrival }</h1>
				<p>${list.type}
					|
					<c:if test="${vo.aPassenger != null && vo.aPassenger != 0}">
                ${vo.aPassenger} 성인
            </c:if>
					<c:if test="${vo.cPassenger != null && vo.cPassenger != 0}">
                , ${vo.cPassenger} 어린이
            </c:if>
					<c:if test="${vo.iPassenger != null && vo.iPassenger != 0}">
                , ${vo.iPassenger} 유아
            </c:if>
					| 좌석 등급: ${vo.seatGrade }
				</p>
			</header>

			<!-- Journey Information Section -->
			<div class="left-section">
				<section class="journey-info">
					<h2>여정 정보</h2>
					<div class="details">
						<c:if test="${vo.type == '왕복'}">
							<div>
								<strong>출발 : </strong> ${vo.firstDeparture }
							</div>
							<div>
								<strong>도착 : </strong> ${vo.firstArrival }
							</div>
							<div>
								<strong>좌석등급: </strong>${vo.seatGrade }</div>
							<div>
								<strong>가격 : </strong>${vo.departPrice + vo.arrivePrice }</div>
						</c:if>
						<c:if test="${vo.type == '편도'}">
							<div class="row">
								<div class="col-md-6">
									<div>
										<strong>출발 : </strong> ${vo.firstDeparture }
									</div>
									<div>
										<strong>도착 : </strong> ${vo.firstArrival }
									</div>
									<div>
										<strong>좌석등급: </strong>${vo.seatGrade }</div>
									<div>
										<strong>가격 : </strong>${vo.departPrice }</div>
								</div>
								<div class="col-md-6">
									<div>
										<strong>출발 : </strong> ${vo.secondDeparture }
									</div>
									<div>
										<strong>도착 : </strong> ${vo.secondArrival }
									</div>
									<div>
										<strong>좌석등급 : </strong>${vo.seatGrade }</div>
									<div>
										<strong>가격 : </strong> ${vo.arrivePrice }
									</div>
								</div>
							</div>
						</c:if>
					</div>
				</section>
			</div>
			<!-- Passenger Information Section -->
			<section class="booking-info">
				<h2>탑승자 정보 입력</h2>
				<div id="passenger-container">
					<c:forEach var="i" begin="1" end="${vo.aPassenger}">
						<div class="passenger-item">

							<h3>성인 ${i}</h3>
							<div class="form-group">
								<label for="last-name-${i}">성:</label> <input type="text"
									id="last-name-${i}" placeholder="예: 홍"
									name="passengers[${i-1}].lastName">
							</div>
							<div class="form-group">
								<label for="first-name-${i}">이름:</label> <input type="text"
									id="first-name-${i}" placeholder="예: 길동"
									name="passengers[${i-1}].firstName">
							</div>
							<div class="form-group">
								<label for="gender-${i}">성별:</label> <select id="gender-${i}"
									name="passengers[${i-1}].gender">
									<option value="M">남성</option>
									<option value="F">여성</option>
								</select>
							</div>
							<div class="form-group">
								<label for="dob-${i}">생일:</label> <input type="date"
									name="passengers[${i-1}].birth" id="dob-${i}">
							</div>
							<div class="form-group">
								<label for="nationality-${i}">국적:</label> <select
									class="form-control nationality-${i}"
									name="passengers[${i-1}].nationality" id="nationality-${i}"
									style="margin: 0 10px;">
									<!-- ajax를 이용한 중분류 option 로딩하기 -->
								</select>
							</div>
							<div class="form-group">
								<label for="passport-number-${i}">여권 번호:</label> <input
									type="text" id="passport-number-${i}" placeholder="여권 번호"
									name="passengers[${i-1}].passport_number">
							</div>
							<div class="form-group">
								<label for="passport-expiry-${i}">여권 만료일:</label> <input
									type="date" id="passport-expiry-${i}"
									name="passengers[${i-1}].passportEndDate">
							</div>
							<hr class="sidebar-divider my-0 mb-3 mt-5">
						</div>

					</c:forEach>
				</div>


				<div id="passenger-container">
					<c:forEach var="i" begin="1" end="${vo.cPassenger}">
						<div class="passenger-item">
							<h3>어린이 ${i}</h3>
							<!-- 어린이 폼은 성인 폼과 동일 -->
							<div class="form-group">
								<label for="last-name-${i}">성:</label> <input type="text"
									id="last-name-${i}" placeholder="예: 홍"
									name="passengers[${i-1}].lastName">
							</div>
							<div class="form-group">
								<label for="first-name-${i}">이름:</label> <input type="text"
									id="first-name-${i}" placeholder="예: 길동"
									name="passengers[${i-1}].firstName">
							</div>
							<div class="form-group">
								<label for="gender-${i}">성별:</label> <select id="gender-${i}"
									name="passengers[${i-1}].gender">
									<option value="M">남성</option>
									<option value="F">여성</option>
								</select>
							</div>
							<div class="form-group">
								<label for="dob-${i}">생일:</label> <input type="date"
									name="passengers[${i-1}].birth" id="dob-${i}">
							</div>
							<div class="form-group">
								<label for="nationality-${i}">국적:</label> <select
									class="form-control nationality-${i}"
									name="passengers[${i-1}].nationality" id="nationality-${i}"
									style="margin: 0 10px;">
									<!-- ajax를 이용한 중분류 option 로딩하기 -->
								</select>
							</div>
							<div class="form-group">
								<label for="passport-number-${i}">여권 번호:</label> <input
									type="text" id="passport-number-${i}" placeholder="여권 번호"
									name="passengers[${i-1}].passport_number">
							</div>
							<div class="form-group">
								<label for="passport-expiry-${i}">여권 만료일:</label> <input
									type="date" id="passport-expiry-${i}"
									name="passengers[${i-1}].passportEndDate">
							</div>
					</c:forEach>
				</div>
				<div id="passenger-container">
					<c:forEach var="i" begin="1" end="${vo.iPassenger}">
						<div class="passenger-item">
							<h3>유아 ${i}</h3>
							<!-- 유아 폼은 성인 폼과 동일 -->

							<div class="form-group">
								<label for="last-name-${i}">성:</label> <input type="text"
									id="last-name-${i}" placeholder="예: 홍"
									name="passengers[${i-1}].lastName">
							</div>
							<div class="form-group">
								<label for="first-name-${i}">이름:</label> <input type="text"
									id="first-name-${i}" placeholder="예: 길동"
									name="passengers[${i-1}].firstName">
							</div>
							<div class="form-group">
								<label for="gender-${i}">성별:</label> <select id="gender-${i}"
									name="passengers[${i-1}].gender">
									<option value="M">남성</option>
									<option value="F">여성</option>
								</select>
							</div>
							<div class="form-group">
								<label for="dob-${i}">생일:</label> <input type="date"
									name="passengers[${i}].birth" id="dob-${i}">
							</div>
							<div class="form-group">
								<label for="nationality-${i}">국적:</label> <select
									class="form-control nationality-${i}"
									name="passengers[${i-1}].nationality" id="nationality-${i}"
									style="margin: 0 10px;">
									<!-- ajax를 이용한 중분류 option 로딩하기 -->
								</select>
							</div>
							<div class="form-group">
								<label for="passport-number-${i}">여권 번호:</label> <input
									type="text" id="passport-number-${i}" placeholder="여권 번호"
									name="passengers[${i-1}].passport_number">
							</div>
							<div class="form-group">
								<label for="passport-expiry-${i}">여권 만료일:</label> <input
									type="date" id="passport-expiry-${i}"
									name="passengers[${i-1}].passportEndDate">
							</div>
					</c:forEach>
				</div>
			</section>

			<!-- Baggage Information Section -->
			<section class="baggage-info">
				<h2>수하물 정보</h2>
				<div id="baggage-container">
					<!-- Baggage items will be added dynamically here -->
				</div>
				<button type="button" class="btn baggageBtn" onclick="addBaggage()"
					name="">수하물 추가</button>
			</section>

			<!-- Fare Section -->
			<div class="right-section">
				<section class="fare-info">
					<h2>요금 정보</h2>
					<div class="fare-details">
						<div class="total">
							<strong>총액: </strong> <input type="hidden"
								name="total_Price"
								value="${list.departPrice + list.arrivePrice}">
							${list.departPrice + list.arrivePrice}
						</div>
					</div>
				</section>
			</div>
			<button type="submit" class="btnReservation">예약 수정 완료</button>
		</form>
	</div>
</body>
</html>