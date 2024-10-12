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
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

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

<script>
$(function () {
	
	$(".btnReservation").click(function () {
		let x = uuidv4();

		$(".reservationLabel").val(x);
		console.log(x);

	});
	
	
	
	$(".datepicker").datepicker({
	     dateFormat: "yy-mm-dd" // Format as needed
	 });

	
    // Populate nationality dropdown
    $.getJSON("/ajax/getCountry.do")
        .done(function(data) {
            let countryList = data.countryList;
            if (Array.isArray(countryList)) {
                let options = '<option value="">선택하세요</option>';
                countryList.forEach(function(vo) {
                    options += '<option value="' + vo.countryCode + '">' + vo.countryEng + '</option>';
                });
                $('select[id^="nationality-"]').each(function() {
                    $(this).html(options);
                });
            } else {
                console.error('Expected an array but got:', countryList);
            }
        })
        .fail(function(xhr, status, err) {
            console.error("AJAX 오류:", xhr, status, err);
            alert("국가 리스트 데이터를 가져오는 중 오류 발생");
        });


});

function addBaggage() {
    let container = document.getElementById('baggage-container');
    let index = container.children.length;
    let baggageItem = document.createElement('div');

    baggageItem.classList.add('baggage-item');
    baggageItem.id = `baggage-item-\${index}`;

    baggageItem.innerHTML = `
        <h3>수하물\${index + 1}</h3>
        <div class="form-group">
            <label for="baggageTypeID-\${index}">수하물 종류:</label>
            <select class="form-control" name="baggages[\${index}].baggageTypeID" id="baggageTypeID-\${index}" style="margin: 0 10px;" onchange="updateBaggageDescription(${index})">
                <option value="">선택하세요</option>
                <!-- Options will be added here -->
            </select>
        </div>
        <div class="form-group">
            <label for="baggage-description-\${index}">수하물 설명:</label>
            <input type="text" class="form-control" name="baggages[\${index}].description" id="baggage-description-\${index}" value="" readonly>
        </div>
        <div class="form-group">
            <label for="baggage-weight-\${index}">무게 (kg):</label>
            <input type="number" id="baggage-weight-\${index}" placeholder="예: 20" min="0" oninput="validateBaggageWeight(\${index})" name="baggages[\${index}].baggage_weight">
            <div id="additionalCost-\${index}" style="color:blue;"></div>
        </div>
        <button type="button" onclick="removeBaggage(this)" class="btn">제거</button>
    `;

    container.appendChild(baggageItem);

    // 서버에서 수하물 종류 데이터를 가져와 옵션을 추가합니다.
    $.getJSON("/ajax/getBaggageType.do")
    .done(function(data) {
        let baggageList = data.baggageTypeList;
        if (Array.isArray(baggageList)) {
            let options = '<option value="">선택하세요</option>';
            baggageList.forEach(function(vo) {
                options += '<option value="' + vo.baggageTypeID + '">' + vo.baggage_Type + '</option>';
            });
            $('#baggageTypeID-' + index).html(options);
        } else {
            console.error('배열이 예상되었지만:', baggageList);
        }
    })
    .fail(function(xhr, status, err) {
        console.error("AJAX 오류:", xhr, status, err);
        alert("수하물 종류 리스트 데이터를 가져오는 중 오류 발생");
    });
    
    populateBaggageTypes();
}



function removeBaggage(button) {
    button.parentElement.remove();
}

function populateBaggageTypes() {
    let baggageTypes = []; // Placeholder for baggage type data

    // Fetch baggage type data from server
    $.getJSON("/ajax/getBaggageType.do")
        .done(function(data) {
            baggageTypes = data.baggageTypeList.map(item => ({
                id: item.baggageTypeID,
                description: item.description,
                maxWeight: item.maxweight,
                price: item.price,
                baggageType: item.baggage_Type
            }));

            // Populate baggage types in select elements
            document.querySelectorAll('select[id^="baggageTypeID-"]').forEach(select => {
                select.innerHTML = '<option value="0">선택하세요</option>'; // Reset options
                baggageTypes.forEach(vo => {
                    let option = document.createElement('option');
                    option.value = vo.id;
                    option.textContent = vo.baggageType + '(최대 무게:' + vo.maxWeight + 'kg)';
                    select.appendChild(option);
                });
            });

            // Event listener for baggage type change
            document.querySelectorAll('select[id^="baggageTypeID-"]').forEach(select => {
                select.addEventListener('change', function() {
                    let baggageItem = this.closest('.baggage-item');
                    let descriptionDiv = baggageItem.querySelector('.baggage-description');
                    let additionalCostDiv = baggageItem.querySelector(`#additionalCost-\${baggageItem.id.split('-')[2]}`);
                    let weightInput = baggageItem.querySelector(`input[id^="baggage-weight-"]`);
                    let selectedBaggage = baggageTypes.find(item => item.id == this.value);

                    if (selectedBaggage) {
                        descriptionDiv.textContent = selectedBaggage.description;
                        weightInput.value = ''; // Clear weight input
                        additionalCostDiv.textContent = ''; // Clear additional cost message
                        updateTotalWeight();
                    }
                });
            });

            // Event listener for weight input
            document.querySelectorAll('input[id^="baggage-weight-"]').forEach(weightInput => {
                weightInput.addEventListener('input', function() {
                    let baggageItem = this.closest('.baggage-item');
                    let select = baggageItem.querySelector('select[id^="baggageTypeID-"]');
                    let descriptionDiv = baggageItem.querySelector('.baggage-description');
                    let additionalCostDiv = baggageItem.querySelector(`#additionalCost-\${baggageItem.id.split('-')[2]}`);
                    let selectedBaggage = baggageTypes.find(item => item.id == select.value);

                    if (isNaN(this.value) || this.value < 0) {
                        additionalCostDiv.textContent = '유효한 무게를 입력해 주세요.';
                        return;
                    }

                    if (selectedBaggage) {
                        let weight = parseFloat(this.value);
                        if (weight > selectedBaggage.maxWeight) {
                            let newBaggage = baggageTypes.find(item => item.maxWeight >= weight);
                            if (newBaggage) {
                                select.value = '0'; // Reset to "선택하세요"
                                descriptionDiv.textContent = '';
                                additionalCostDiv.textContent = '규정된 무게를 초과했습니다. 적절한 수하물 종류를 선택해 주세요.';
                                weightInput.value = '';
                            } else {
                                select.value = '0'; // Set to "선택하세요" option
                                descriptionDiv.textContent = '';
                                additionalCostDiv.textContent = '모든 수하물 종류의 무게를 초과했습니다. 적절한 수하물 종류를 선택해 주세요.';
                            }
                        } else {
                            additionalCostDiv.textContent = ''; // Clear additional cost message
                        }
                    }
                    updateTotalWeight();
                });
            });

            function updateTotalWeight() {
                // Implement the total weight update logic if necessary
                // This function could update the total weight displayed on the page.
            }
        })
        .fail(function(xhr, status, err) {
            console.error("AJAX 오류:", xhr, status, err);
            alert("수하물 종류 리스트 데이터를 가져오는 중 오류 발생. 잠시 후 다시 시도해 주세요.");
        });
    
}




</script>


</head>
<body>
	<div class="container">
		<form action="write.do" method="post">
		<input type ="hidden" name = "reservationLabel" class = "reservationLabel">
			<input type="hidden" name="scheduleID[0]" value="${list.scheduleId_a}">
		    <input type="hidden" name="scheduleID[1]" value="${list.scheduleId_d}">
		    <input type="hidden" name="apassengers[0].adultCount" value="${param.aPassenger}">
		    <input type="hidden" name="cpassengers[0].childCount" value="${param.cPassenger}">
		    <input type="hidden" name="ipassengers[0].infantCount" value="${param.iPassenger}">
		    <input type="hidden" name="aPassenger" value="${param.aPassenger}">
		    <input type="hidden" name="cPassenger" value="${param.cPassenger}">
		    <input type="hidden" name="iPassenger" value="${param.iPassenger}">
		    <input type="hidden" name="type" value="${list.type}">
		    <input type="hidden" name="firstDeparture" value="${list.firstDeparture}">
		    <input type="hidden" name="firstArrival" value="${list.firstArrival}">
		    <input type="hidden" name="departPrice" value="${list.departPrice}">
		    <input type="hidden" name="secondDeparture" value="${list.secondDeparture}">
		    <input type="hidden" name="secondArrival" value="${list.secondArrival}">
		    <input type="hidden" name="arrivePrice" value="${list.arrivePrice}">
		    <input type="hidden" name="seatGrade" value="${list.seatGrade}">
			<!-- Header Section -->
			<header class="header">
				<h1>인천 ${list.firstDeparture } → 후쿠오카 ${list.firstArrival }</h1>
				<p>${list.type}
					|
					<c:if test="${param.aPassenger != null && param.aPassenger != 0}">
                ${param.aPassenger} 성인
            </c:if>
					<c:if test="${param.cPassenger != null && param.cPassenger != 0}">
                , ${param.cPassenger} 어린이
            </c:if>
					<c:if test="${param.iPassenger != null && param.iPassenger != 0}">
                , ${param.iPassenger} 유아
            </c:if>
					| 좌석 등급: ${list.seatGrade }
				</p>
			</header>

			<!-- Journey Information Section -->
			<div class="left-section">
				<section class="journey-info">
					<h2>여정 정보</h2>
					<div class="details">
						<c:if test="${list.type == '왕복'}">
							<div>
								<strong>출발 : </strong> ${list.firstDeparture }
							</div>
							<div>
								<strong>도착 : </strong> ${list.firstArrival }
							</div>
							<div>
								<strong>좌석등급: </strong>${list.seatGrade }</div>
							<div>
								<strong>가격 : </strong>${list.departPrice + list.arrivePrice }</div>
						</c:if>
						<c:if test="${list.type == '편도'}">
							<div class="row">
								<div class="col-md-6">
									<div>
										<strong>출발 : </strong> ${list.firstDeparture }
									</div>
									<div>
										<strong>도착 : </strong> ${list.firstArrival }
									</div>
									<div>
										<strong>좌석등급: </strong>${list.seatGrade }</div>
									<div>
										<strong>가격 : </strong>${list.departPrice }</div>
								</div>
								<div class="col-md-6">
									<div>
										<strong>출발 : </strong> ${list.secondDeparture }
									</div>
									<div>
										<strong>도착 : </strong> ${list.secondArrival }
									</div>
									<div>
										<strong>좌석등급 : </strong>${list.seatGrade }</div>
									<div>
										<strong>가격 : </strong> ${list.arrivePrice }
									</div>
								</div>
							</div>
						</c:if>
					</div>
				</section>
			</div>

			<!-- Booking Information Section -->
			<section class="booking-info">
				<h2>예약자 정보 입력</h2>

				<div class="form-group">
					<label for="name">이름:</label> <input id="name" name="name"
						value="${param.name }">
				</div>
				<div class="form-group">
					<label for="email">이메일:</label> <input type="email" id="email"
						value="${param.email }">
				</div>
				<div class="form-group">
					<label for="phone">휴대폰:</label> <input type="tel" id="phone"
						value="${param.tel }">
				</div>
			</section>

			<!-- Passenger Information Section -->
			<section class="booking-info">
				<h2>탑승자 정보 입력</h2>
				<div id="passenger-container">
					<c:forEach var="i" begin="1" end="${param.aPassenger}">
						<div class="passenger-item">
							<h3>성인 ${i}</h3>
							<div class="form-group">
								<label for="last-name-${i}">성:</label> <input type="text"
									id="last-name-${i}" placeholder="예: 홍"
									name="apassengers[${i-1}].lastName">
							</div>
							<div class="form-group">
								<label for="first-name-${i}">이름:</label> <input type="text"
									id="first-name-${i}" placeholder="예: 길동"
									name="apassengers[${i-1}].firstName">
							</div>
							<div class="form-group">
								<label for="gender-${i}">성별:</label> <select id="gender-${i}"
									name="apassengers[${i-1}].gender">
									<option value="M">남성</option>
									<option value="F">여성</option>
								</select>
							</div>
							<div class="form-group">
								<label for="dob-${i}">생일:</label> <input class="datepicker"
									name="apassengers[${i-1}].birth" id="dob-${i}-a">
							</div>
							<div class="form-group">
								<label for="nationality-${i}">국적:</label> <select
									class="form-control nationality-${i}"
									name="apassengers[${i-1}].nationality" id="nationality-${i}"
									style="margin: 0 10px;">
									<!-- ajax를 이용한 중분류 option 로딩하기 -->
								</select>
							</div>
							<div class="form-group">
								<label for="passport-number-${i}">여권 번호:</label> <input
									type="text" id="passport-number-${i}-a" placeholder="여권 번호"
									name="apassengers[${i-1}].passport_number">
							</div>
							<div class="form-group">
								<label for="passport-expiry-${i}">여권 만료일:</label> <input
									class="datepicker" id="passport-expiry-${i}-a"
									name="apassengers[${i-1}].passportEndDate">
							</div>
							<hr class="sidebar-divider my-0 mb-3 mt-5">
						</div>

					</c:forEach>
				</div>


				<div id="passenger-container">
					<c:forEach var="i" begin="1" end="${param.cPassenger}">
						<div class="passenger-item">
							<h3>어린이 ${i}</h3>
							<!-- 어린이 폼은 성인 폼과 동일 -->
							<div class="form-group">
								<label for="last-name-${i}">성:</label> <input type="text"
									id="last-name-${i}" placeholder="예: 홍"
									name="cpassengers[${i-1}].lastName">
							</div>
							<div class="form-group">
								<label for="first-name-${i}">이름:</label> <input type="text"
									id="first-name-${i}" placeholder="예: 길동"
									name="cpassengers[${i-1}].firstName">
							</div>
							<div class="form-group">
								<label for="gender-${i}">성별:</label> <select id="gender-${i}"
									name="cpassengers[${i-1}].gender">
									<option value="M">남성</option>
									<option value="F">여성</option>
								</select>
							</div>
							<div class="form-group">
								<label for="dob-${i}">생일:</label> <input class="datepicker"
									name="cpassengers[${i-1}].birth" id="dob-${i}-c">
							</div>
							<div class="form-group">
								<label for="nationality-${i}">국적:</label> <select
									class="form-control nationality-${i}"
									name="cpassengers[${i-1}].nationality" id="nationality-${i}"
									style="margin: 0 10px;">
									<!-- ajax를 이용한 중분류 option 로딩하기 -->
								</select>
							</div>
							<div class="form-group">
								<label for="passport-number-${i}">여권 번호:</label> <input
									type="text" id="passport-number-${i}" placeholder="여권 번호"
									name="cpassengers[${i-1}].passport_number">
							</div>
							<div class="form-group">
								<label for="passport-expiry-${i}">여권 만료일:</label> <input
									class="datepicker" id="passport-expiry-${i}-c"
									name="cpassengers[${i-1}].passportEndDate">
							</div>
					</c:forEach>
				</div>
				<div id="passenger-container">
					<c:forEach var="i" begin="1" end="${param.iPassenger}">
						<div class="passenger-item">
							<h3>유아 ${i}</h3>
							<!-- 유아 폼은 성인 폼과 동일 -->

							<div class="form-group">
								<label for="last-name-${i}">성:</label> <input type="text"
									id="last-name-${i}" placeholder="예: 홍"
									name="ipassengers[${i-1}].lastName">
							</div>
							<div class="form-group">
								<label for="first-name-${i}">이름:</label> <input type="text"
									id="first-name-${i}" placeholder="예: 길동"
									name="ipassengers[${i-1}].firstName">
							</div>
							<div class="form-group">
								<label for="gender-${i}">성별:</label> <select id="gender-${i}"
									name="ipassengers[${i-1}].gender">
									<option value="M">남성</option>
									<option value="F">여성</option>
								</select>
							</div>
							<div class="form-group">
								<label for="dob-${i}">생일:</label> <input class="datepicker"
									name="ipassengers[${i}].birth" id="dob-${i}-i">
							</div>
							<div class="form-group">
								<label for="nationality-${i}">국적:</label> <select
									class="form-control nationality-${i}"
									name="ipassengers[${i-1}].nationality" id="nationality-${i}"
									style="margin: 0 10px;">
									<!-- ajax를 이용한 중분류 option 로딩하기 -->
								</select>
							</div>
							<div class="form-group">
								<label for="passport-number-${i}">여권 번호:</label> <input
									type="text" id="passport-number-${i}" placeholder="여권 번호"
									name="ipassengers[${i-1}].passport_number">
							</div>
							<div class="form-group">
								<label for="passport-expiry-${i}">여권 만료일:</label> <input
									class="datepicker" id="passport-expiry-${i}-i"
									name="ipassengers[${i-1}].passportEndDate">
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
						<div>
							<strong>출발 요금: </strong> ${list.departPrice }
						</div>
						<div>
							<strong>도착 요금: </strong> ${list.arrivePrice }
						</div>
						<div></div>
						<div class="total">
							<strong>총액: </strong> <input type="hidden"
								name="total_Price"
								value="${list.departPrice + list.arrivePrice}">
							${list.departPrice + list.arrivePrice}
						</div>
					</div>
				</section>
			</div>
			<button class="btnReservation">예약 완료</button>
		</form>
	</div>
</body>
</html>