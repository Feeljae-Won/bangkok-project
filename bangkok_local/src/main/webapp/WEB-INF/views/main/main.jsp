<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
<link rel="stylesheet" href="/css/main.css">
<script src="/js/main.js"></script>
</head>
<body>
<!-- 	<!-- 비디오와 오버레이를 포함하는 컨테이너 -->
<!-- 	<div class="container"> -->
<!-- 		<video autoplay loop muted playsinline class="media video-size"> -->
<!-- 			<source src="/uploads/hongkong.mp4" type="video/mp4"> -->
<!-- 		</video> -->
<!-- 		<div class="overlay-video"> -->
<!-- 			<h3>홍콩, 아시아의 세계 도시를 만나는 특별한 순간을 경험하세요.</h3> -->
<!-- 		</div> -->
<!-- 	</div> -->
	<br>


	<!-- 공항 및 항공권 예약 관련 내용 -->
	<div class="searchAir">
		<div class="selectType float-right">
			<span class="type active" id="typeGoBack"><strong>왕복</strong></span>
			<span class="type" id="typeGo"><strong>편도</strong></span> <span
				class="type" id="typeGoMany"><strong>다구간</strong></span>
		</div>
		<h5>
			<b>어디로 여행하세요?</b>
		</h5>
		<div class="row justify-content-center align-items-center m-0">

			<!-- 출발 공항 클릭 시 히든 창 열기 -->
			<div class="col-sm d-flex justify-content-around align-items-center">
				<button class="airport p-2" id="departureAirport">
					<span> <i class="material-icons mb-0"
						style="font-size: 30px">flight_takeoff</i>
					</span> <br> <span id="departure"> FROM </span> <br> <span
						id="departureKor"> 출발지 </span>
				</button>

				<!-- 공항 변환 아이콘 -->
				<span class="swap-button mt-4"> <i class="material-icons"
					style="font-size: 48px; color: #E37027;">swap_horizontal_circle</i>
				</span>

				<!-- 도착 공항 클릭 시 히든 창 열기 -->
				<button class="airport p-2" id="arrivalAirport">
					<span> <i class="material-icons mb-0"
						style="font-size: 30px">flight_land</i>
					</span> <br> <span id="arrival"> TO </span> <br> <span
						id="arrivalKor"> 도착지 </span>
				</button>
			</div>
			<div class="col-sm ml-3 mr-3 mt-3" style="width: 300px;">
				<p style="font-size: 13px; font-weight: bold; margin-bottom: 20px;">
					여행 일정</p>
				<span class="d-flex align-items-center" id="inputDate"
					data-toggle="modal" data-target="#datePickerModal"> <i
					class="material-icons mr-3" style="font-size: 22px">date_range</i>
					<b><span id="dateRange">가는 날 ~ 오는 날</span></b>

				</span>
			</div>
			<div class="col-sm ml-3 mr-3 mt-3">
				<p style="font-size: 13px; font-weight: bold; margin-bottom: 20px;">
					탑승객</p>
				<span class="d-flex align-items-center" id="passenger"
					data-toggle="modal" data-target="#passengerModal"> <i
					class="fa fa-user mr-3" style="font-size: 24px"></i> <b><span
						id="totalPassenger">성인 1명</span></b>
				</span>
			</div>
			<div class="col-sm ml-3 mr-3 mt-3">
				<p style="font-size: 13px; font-weight: bold; margin-bottom: 20px;">
					좌석 등급</p>
				<span class="d-flex align-items-center" id="inputSeat"> <i
					class="material-icons mr-3" style="font-size: 24px">airline_seat_recline_extra</i>
					<b><span id="selectedSeat">일반석</span></b>
				</span>
				<div id="seatInfo" class="seat-info">
					<h5>좌석 등급 선택</h5>
					<hr>
					<div class="btn-group btn-group-lg">
						<button class="btn btn-light seatBtn active" id="ecoSeat"
							data-seatgrade="일반석">일반석</button>
						<button class="btn btn-light seatBtn" id="bisSeat"
							data-seatgrade="비즈니스석">비즈니스석</button>
						<button class="btn btn-light seatBtn" id="fstSeat"
							data-seatgrade="일등석">일등석</button>
					</div>
				</div>
			</div>
		</div>
		<form action="/air/selectFlight-D.do" method="post">
			<input type="hidden" id="tripType" name="type" value="왕복"> <input
				type="hidden" id="dCode" name="departure"> <input
				type="hidden" id="aCode" name="arrival"> <input
				type="hidden" id="dDate" name="departureTime"> <input
				type="hidden" id="aDate" name="arrivalTime"> <input
				type="hidden" id="aPassenger" name="aPassenger" value="1"> <input
				type="hidden" id="cPassenger" name="cPassenger"> <input
				type="hidden" id="iPassenger" name="iPassenger"> <input
				type="hidden" id="seatGrade" name="seatGrade" value="일반석">

			<button
				style="background-color: #E37027; padding: 10px; border-radius: 5px; color: white; font-weight: bold; width: 100%; text-align: center; margin-top: 15px; box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.5); border: 1px solid rgba(255, 255, 255, 0);"
				id="searchBtn">항공권 검색</button>
		</form>
	</div>
	</div>
	</div>

	<!-- 공항 검색 -->
	<div id="airportList">
		<h5>
			<strong>출발지 검색</strong>
		</h5>
		<input class="form-control mt-3" placeholder="공항 또는 도시 검색"
			id="searchAirport" autocomplete="off">

		<!-- 검색 결과 출력 -->
		<div id="airportListResults" class="mt-3"></div>

		<p class="mt-5">
			<button class="btn btn-light btn-sm" id="allAirportBtn">
				<i class="material-icons" style="font-size: 18px; color: #E37027">place</i>
				<strong>모든 공항 보기</strong>
			</button>
		</p>
	</div>

	<!-- 모든 공항 리스트 -->
	<div class="modal" id="allAirportModal">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">공항 리스트</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<!-- 대륙별 리스트 -->
					<!-- 아시아  -->
					<h6>
						<strong><i class="material-icons"
							style="font-size: 20px; color: #E37027;">flag</i> 아시아 (Asia)</strong>
					</h6>
					<ul class="list-group ml-3">
						<c:forEach items="${asia }" var="vo">
							<li class="list-group-item" data-pan="${vo.pan }"
								data-countrykor="${vo.countryKor }"
								data-countryeng="${vo.countryEng }"
								data-countrycode="${vo.countryCode }"><b>${vo.countryKor }</b>
								<small>${vo.countryEng }</small> - 국가 코드 : <b>${vo.countryCode }</b>
								<button class="btn btn-light btn-sm airportListBtn ml-3"
									data-countrycode="${vo.countryCode }"
									id="airportListBtn${vo.countryCode }">[ 공항 리스트 ]</button>

								<div id="airportList${vo.countryCode }"
									class="collapse airportList p-3 ml-3">
									<div class="airList">
										<ul>
											<li>인천 국제 공항</li>
										</ul>
									</div>
								</div></li>
						</c:forEach>

					</ul>
					<hr>
					<h6>
						<strong><i class="material-icons"
							style="font-size: 20px; color: #E37027;">flag</i> 북미 (North
							Ameirca)</strong>
					</h6>
					<ul class="list-group ml-3">
						<c:forEach items="${northAmerica }" var="vo">
							<li class="list-group-item" data-pan="${vo.pan }"
								data-countrykor="${vo.countryKor }"
								data-countryeng="${vo.countryEng }"
								data-countrycode="${vo.countryCode }"><b>${vo.countryKor }</b>
								<small>${vo.countryEng }</small> - 국가 코드 : <b>${vo.countryCode }</b>
								<button class="btn btn-light btn-sm airportListBtn ml-3"
									data-countrycode="${vo.countryCode }"
									id="airportListBtn${vo.countryCode }">[ 공항 리스트 ]</button>

								<div id="airportList${vo.countryCode }"
									class="collapse airportList p-3 ml-3">
									<div class="airList">
										<ul>
											<li>인천 국제 공항</li>
										</ul>
									</div>
								</div></li>
						</c:forEach>
					</ul>
					<hr>
					<h6>
						<strong><i class="material-icons"
							style="font-size: 20px; color: #E37027;">flag</i> 남미 (South
							America)</strong>
					</h6>
					<ul class="list-group ml-3">
						<c:forEach items="${southAmerica }" var="vo">
							<li class="list-group-item" data-pan="${vo.pan }"
								data-countrykor="${vo.countryKor }"
								data-countryeng="${vo.countryEng }"
								data-countrycode="${vo.countryCode }"><b>${vo.countryKor }</b>
								<small>${vo.countryEng }</small> - 국가 코드 : <b>${vo.countryCode }</b>
								<button class="btn btn-light btn-sm airportListBtn ml-3"
									data-countrycode="${vo.countryCode }"
									id="airportListBtn${vo.countryCode }">[ 공항 리스트 ]</button>

								<div id="airportList${vo.countryCode }"
									class="collapse airportList p-3 ml-3">
									<div class="airList">
										<ul>
											<li>인천 국제 공항</li>
										</ul>
									</div>
								</div></li>
						</c:forEach>
					</ul>
					<hr>
					<h6>
						<strong><i class="material-icons"
							style="font-size: 20px; color: #E37027;">flag</i> 유럽 (Europe)</strong>
					</h6>
					<ul class="list-group ml-3">
						<c:forEach items="${europe }" var="vo">
							<li class="list-group-item" data-pan="${vo.pan }"
								data-countrykor="${vo.countryKor }"
								data-countryeng="${vo.countryEng }"
								data-countrycode="${vo.countryCode }"><b>${vo.countryKor }</b>
								<small>${vo.countryEng }</small> - 국가 코드 : <b>${vo.countryCode }</b>
								<button class="btn btn-light btn-sm airportListBtn ml-3"
									data-countrycode="${vo.countryCode }"
									id="airportListBtn${vo.countryCode }">[ 공항 리스트 ]</button>

								<div id="airportList${vo.countryCode }"
									class="collapse airportList p-3 ml-3">
									<div class="airList">
										<ul>
											<li>인천 국제 공항</li>
										</ul>
									</div>
								</div></li>
						</c:forEach>
					</ul>
					<hr>
					<h6>
						<strong><i class="material-icons"
							style="font-size: 20px; color: #E37027;">flag</i> 오스트레일리아
							(Australia)</strong>
					</h6>
					<ul class="list-group ml-3">
						<c:forEach items="${australia }" var="vo">
							<li class="list-group-item" data-pan="${vo.pan }"
								data-countrykor="${vo.countryKor }"
								data-countryeng="${vo.countryEng }"
								data-countrycode="${vo.countryCode }"><b>${vo.countryKor }</b>
								<small>${vo.countryEng }</small> - 국가 코드 : <b>${vo.countryCode }</b>
								<button class="btn btn-light btn-sm airportListBtn ml-3"
									data-countrycode="${vo.countryCode }"
									id="airportListBtn${vo.countryCode }">[ 공항 리스트 ]</button>

								<div id="airportList${vo.countryCode }"
									class="collapse airportList p-3 ml-3">
									<div class="airList">
										<ul>
											<li>인천 국제 공항</li>
										</ul>
									</div>
								</div></li>
						</c:forEach>
					</ul>
					<hr>
					<h6>
						<strong><i class="material-icons"
							style="font-size: 20px; color: #E37027;">flag</i> 아프리카 (Africa)</strong>
					</h6>
					<ul class="list-group ml-3">
						<c:forEach items="${africa }" var="vo">
							<li class="list-group-item" data-pan="${vo.pan }"
								data-countrykor="${vo.countryKor }"
								data-countryeng="${vo.countryEng }"
								data-countrycode="${vo.countryCode }"><b>${vo.countryKor }</b>
								<small>${vo.countryEng }</small> - 국가 코드 : <b>${vo.countryCode }</b>
								<button class="btn btn-light btn-sm airportListBtn ml-3"
									data-countrycode="${vo.countryCode }"
									id="airportListBtn${vo.countryCode }">[ 공항 리스트 ]</button>

								<div id="airportList${vo.countryCode }"
									class="collapse airportList p-3 ml-3">
									<div class="airList">
										<ul>
											<li>인천 국제 공항</li>
										</ul>
									</div>
								</div></li>
						</c:forEach>
					</ul>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>

	<!-- 모달 창 -->
	<div class="modal" id="datePickerModal">
		<div class="modal-dialog modal-xl modal-dialog-centered dateModal"
			role="document">
			<div class="modal-content">
				<div class="modal-header">

					<h5 class="modal-title" id="datePickerModalLabel">
						<strong>여정 일자 선택</strong>
					</h5>

					<div id="modalType" class="selectType justify-content-center">
						<span class="type active" id="modalTypeGoBack"><strong>왕복</strong></span>
						<span class="type" id="modalTypeGo"><strong>편도</strong></span> <span
							class="type" id="modalTypeGoMany"><strong>다구간</strong></span>
					</div>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<!-- 달력이 표시될 곳 -->
					<div class="row ">
						<div class="col goType">
							<div style="text-align: center;" class="mb-2">
								<i class="material-icons mb-0 mr-2"
									style="font-size: 18px; color: #E37027">flight_takeoff</i> <b>
									가는 날 선택</b>
							</div>
							<div id="departureCalendar" class="mb-3"></div>
						</div>
						<div class="col backType">
							<div style="text-align: center;" class="mb-2">
								<i class="material-icons mb-0 mr-2"
									style="font-size: 18px; color: #E37027">flight_land</i> <b>
									오는 날 선택</b>
							</div>
							<div id="arrivalCalendar" class="mb-3"></div>
						</div>
					</div>
				</div>
				<div class="modal-footer align-items-bottom">
					<div class="form-inline">
						<span class="goType"> <label for="selectedDepartDate"
							class="float-left"> <i class="material-icons mb-0 mr-2"
								style="font-size: 18px; color: #E37027">flight_takeoff</i> <b>
									가는 날</b>
						</label> <br> <input class="form-control mr-3 mb-3"
							id="selectedDepartDate" placeholder="가는 날" readonly>
						</span> <span class="mr-3 backType"> ~ </span> <span class="backType">
							<label for="selectedArriveDate" class="float-left"> <i
								class="material-icons mb-0 mr-2"
								style="font-size: 18px; color: #E37027">flight_land</i> <b>오는
									날</b>
						</label> <br> <input class="form-control mr-3 mb-3"
							id="selectedArriveDate" placeholder="오는 날" readonly>
						</span>
					</div>
					<button type="button" id="confirmDateBtn" class="btn btn-primary">일정
						선택 완료</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 인원 선택 -->
	<div class="modal" id="passengerModal">
		<div
			class="modal-dialog modal-md modal-dialog-centered passengerModal"
			role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="passengerModalLabel">
						<strong>탑승객 선택</strong>
					</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>

				<div class="modal-body">
					<div class="alert alert-danger">
						<strong>탑승객은 성인 1명을 포함해야 합니다.</strong>
					</div>
					<ul>
						<li class="mb-5 flex-container p-0">
							<div class="d-flex align-items-center">
								<i class="material-icons" style="font-size: 36px">person_pin_circle</i>
								<b style="font-size: 20px;">성인(Adult)</b> <a href="#"
									data-toggle="tooltip" data-placement="top"
									title="출발일 기준 만 12세 이상"> <i
									class="fa fa-question-circle ml-2"></i>
								</a>
							</div> <span
							class="d-flex justify-content-center align-items-center mr-5">
								<button class="btn btn-light btn-sm cntControl -sub" value="-1">
									<i class="fa fa-minus"></i>
								</button> <input class="inputPassenger form-control" id="adultCnt"
								type="number" value="1" min="0">
								<button class="btn btn-light btn-sm cntControl +add" value="+1">
									<i class="fa fa-plus"></i>
								</button>
						</span>
						</li>
						<li class="mb-5 flex-container">
							<div class="d-flex align-items-center">
								<i class="material-icons" style="font-size: 36px">person_pin_circle</i>
								<b style="font-size: 20px;">소아(Child)</b> <a href="#"
									data-toggle="tooltip" data-placement="top"
									title="출발일 기준 만 12세 미만"> <i class="fa fa-question-circle"
									style="font-size: 24px; color: #E37027;"></i>
								</a>
							</div> <span
							class="d-flex justify-content-center align-items-center mr-5">
								<button class="btn btn-light btn-sm cntControl -sub" value="-1">
									<i class="fa fa-minus"></i>
								</button> <input class="inputPassenger form-control" id="childCnt"
								type="number" value="0" min="0">
								<button class="btn btn-light btn-sm cntControl +add" value="+1">
									<i class="fa fa-plus"></i>
								</button>
						</span>
						</li>
						<li class="mb-5 flex-container">
							<div class="d-flex align-items-center">
								<i class="material-icons" style="font-size: 36px">person_pin_circle</i>
								<b style="font-size: 20px;">유아(Infant)</b> <a href="#"
									data-toggle="tooltip" data-placement="top"
									title="출발일 기준 만 2세 미만"> <i class="fa fa-question-circle"
									style="font-size: 24px; color: #E37027;"></i>
								</a>
							</div> <span
							class="d-flex justify-content-center align-items-center mr-5">
								<button class="btn btn-light btn-sm cntControl -sub" value="-1">
									<i class="fa fa-minus"></i>
								</button> <input class="inputPassenger form-control" id="infantCnt"
								type="number" value="0" min="0">
								<button class="btn btn-light btn-sm cntControl +add" value="+1">
									<i class="fa fa-plus"></i>
								</button>
						</span>
						</li>
					</ul>
				</div>

				<div class="modal-footer align-items-bottom">
					<button type="button" id="comfirmPassengerBtn"
						class="btn btn-primary">탑승객 선택 완료</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
			<h2 class="text-center"
		style="color: orange; font-weight: bold; font-family: 'goorm-sans-code'; margin-top: 20px; margin-bottom: 50px;">
		호텔과 항공을 한 번에, <strong>BANGKOK</strong>에서만 <span style="color: gray;"></span>
		최저가 예약 보장!
	</h2>
		<!-- 비디오와 오버레이를 포함하는 컨테이너 -->
	<div class="container">
		<video autoplay loop muted playsinline class="media video-size">
			<source src="/uploads/hongkong.mp4" type="video/mp4">
		</video>
		<div class="overlay-video">
			<h3>홍콩, 아시아의 세계 도시를 만나는 특별한 순간을 경험하세요.</h3>
		</div>
	</div><br><br>

		<!-- 여행정보 -->
		<jsp:include page="/WEB-INF/views/main/infoList.jsp" />
		<div class="footer">
	<!-- 이벤트 -->
		<jsp:include page="/WEB-INF/views/main/eventList.jsp" />
</div>
</body>
</html>