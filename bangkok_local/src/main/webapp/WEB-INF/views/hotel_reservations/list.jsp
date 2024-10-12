<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호텔 예약 내역</title>
<link rel="stylesheet" href="/css/hotelRe/empty.css">
<link rel="stylesheet" href="/css/star.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style type="text/css">


.title {
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	color: #333;
	display: -webkit-box;
	line-height: 29px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: pre-line;
	word-break: keep-all;
	margin-top: 30px;
	color: #333333;
	margin-bottom: 25px;
	font-size: 24px;
	font-weight: 700;
}

.line {
	border: 1px solid rgba(0, 0, 0, 0.1); /* 테두리 두께를 0.5px로 설정하여 얇게 */
	margin-bottom: 30px;
}

.hotelImage {
	width: 430px;
	height: 350px;
}

.imageCol {
	padding: 0;
}

.completionDiv {
	margin-top: 30px;
	margin-bottom: 100px;
}

.D-day {
	color: #1273e4;
	font-size: 18px;
}

.horizontal-line {
	width: 99%; /* 선의 길이 조절 */
	margin: 0 auto; /* 중앙 정렬 */
	border-top: 1px solid rgba(0, 0, 0, 0.1); /* 매우 희미한 선 */
	margin-top: 20px;
	margin-bottom: 20px;
}

#copyText {
	display: none;
}

.checkInDay, .checkOutDay {
	margin-top: 10px;
}

.vertical-line {
	height: 99%; /* 선의 높이 조절 */
	margin: 0 auto; /* 중앙 정렬 */
	border-left: 1px solid rgba(0, 0, 0, 0.1); /* 매우 희미한 세로 선 */
	margin-left: 20px;
	margin-right: 20px;
	margin-top: 10px;
}

.completionImage {
	border: 1px solid rgba(0, 0, 0, 0.1); /* 테두리 두께를 0.5px로 설정하여 얇게 */
	border-radius: 10px; /* 모서리 둥글게 */
}

.
.horizontal-line {
	width: 99%; /* 선의 길이 조절 */
	margin: 0 auto; /* 중앙 정렬 */
	border-top: 1px solid rgba(0, 0, 0, 0.1); /* 매우 희미한 선 */
}
/* 모달 닫기 버튼 스타일 */
.custom-close {
	display: flex; /* 버튼 내부 정렬을 위한 설정 */
}
/* 모달 헤더에 relative positioning을 추가하여 닫기 버튼의 위치 조정 */
.modal-header {
	position: relative;
}
/* 제목을 중앙에 배치하고 글씨 크기 조정 */
.modal-header .modal-title {
	text-align: center; /* 제목 중앙 정렬 */
	font-size: 1.5rem; /* 제목 글씨 크기 조정 */
	flex: 1; /* 버튼과의 공간을 조정하기 위해 */
}

/* 닫기 버튼의 크기 조정 및 위치 이동 */
.custom-close {
	font-size: 1.5rem; /* 버튼 크기 조정 */
	padding: 0.5rem; /* 버튼 주변 여백 */
	position: absolute; /* 버튼을 모달 헤더의 절대 위치로 이동 */
	top: 15px; /* 상단 여백 조정 */
	left: 15px; /* 왼쪽 여백 조정 */
	color: #000; /* 버튼 색상 */
}
/*별점 스타일*/
.star {
	font-size: 24px;
	color: #ccc;
}

.star:hover {
	cursor: pointer;
}

.star.active {
	color: #f39c12;
}

.star.half::before {
	content: '\2605'; /* Full star */
	color: #f39c12;
	position: absolute;
	width: 50%;
	overflow: hidden;
}

.stars {
	position: relative;
	display: inline-block;
}

#average-stars {
	font-size: 24px;
	color: #f39c12;
}
</style>
<!-- 검색 처리 및 출력 -->
<script type="text/javascript">
// $(function(){
// 	$(".searchModal").load();
// });
</script>
<!-- 날짜 출력하는 스크립트 부분 + 클립보드 처리 -->
<script type="text/javascript">
$(function(){
    var today = new Date();
    let dayOfMonth = today.getDate();

    // 모든 checkIn 요소에 대해 반복 처리
    $(".checkIn").each(function() {
        let checkin = $(this).data("check"); // 각 .checkIn의 data-check 속성 값을 가져옴
        if (checkin) {
            // 날짜 문자열에서 일(day)만 추출
            let Dday = checkin.slice(8, 11); 
            Dday =   Dday -dayOfMonth; // D-day 계산
	
//            console.log("Check-In Date:", checkin);
//             console.log("D-day:", Dday);

            // D-day가 0 이상일 때만 출력
            if (Dday >= 0) {
                // .D-day 클래스에 D-day 값을 추가
                $(this).find(".D-day").text("D-" + Dday);
            } else {
                // 음수일 경우 D-day를 빈 값으로 설정하거나 다른 처리를 할 수 있음
                $(this).find(".D-day").text("");
            }
        }
    });

    // 텍스트를 클립보드에 복사하는 함수
    $('.clip').click(function() {
        var copyText = $('#copyText').val(); // 복사할 텍스트 가져오기
        navigator.clipboard.writeText(copyText).then(function() {
            alert("주소가 클립보드에 복사되었습니다!"); // 복사가 성공하면 알림 메시지를 보여줌
        });
    });
});
</script>
<script type="text/javascript">
$(function() {
    // 모든 .btn-outline-warning 클릭 이벤트 핸들러 설정
    $(document).on('click', '.btn-outline-warning', function() {
        var title = $(this).closest('.row').find('div[style*="font-size: 20px; font-weight: 900"]').text();
        var roomType = $(this).closest('.row').find('div[style*="margin-bottom: 10px;"]').text();
        // 모달에 데이터 설정
        $('#review .modal-body #modalHotelName').text(title);
        $('#review .modal-body #modalRoomType').text(roomType);
    });
});

$(document).ready(function() {
    var ratings = {
        service: 0,
        cleanliness: 0,
        facilities: 0,
        amenities: 0
    };

    $('.star').on('click', function() {
        var $this = $(this);
        var category = $this.closest('.rating-category').data('category');
        var $starsInCategory = $this.closest('.rating-category').find('.star');
        var index = $starsInCategory.index($this) + 1;

        // 카테고리별 별점 초기화 및 업데이트
        $starsInCategory.each(function(i) {
            $(this).toggleClass('active', i < index);
        });

        // 카테고리별 별점 설정
        ratings[category] = index;

        // 입력 필드 업데이트
        $('#'+category+'-rating').val(index);

        // 평균 별점 계산 및 표시
        var average = (ratings.service + ratings.cleanliness + ratings.facilities + ratings.amenities) / 4;
        $('#average-rating').text(average.toFixed(1));
        
        // 평균 별점에 따라 별점 표시 업데이트
        updateAverageStars(average);
    });

    // 평균 별점에 따라 별점 표시 업데이트 함수
    function updateAverageStars(average) {
        var $averageStars = $('#average-rating-stars .star');
        var fullStars = Math.floor(average);
        var hasHalfStar = (average % 1) >= 0.5;

        $averageStars.each(function(index) {
            if (index < fullStars) {
                $(this).addClass('active').removeClass('half-active');
            } else if (index === fullStars && hasHalfStar) {
                $(this).addClass('half-active').removeClass('active');
            } else {
                $(this).removeClass('active half-active');
            }
        });
    }
    $(document).on('click', '.btn-outline-warning', function() {
        // 클릭한 버튼과 같은 row에 있는 room-type 요소를 찾아서 reservation_no 값을 가져옴
        var reservationNo = $(this).closest('.row').find('.room-type').data('no');
        
        // 숨겨진 input에 reservation_no 값을 설정
        $('input[name="reservations_no"]').val(reservationNo);
        
        console.log("예약 번호: " + reservationNo);
    });
});
</script>
<script type="text/javascript">
$(function(){
		$(".reviewsCancelBtn").click(function(){
			if (confirm("정말 삭제하시겠습니까?")) {
				 var reservationNo = $(this).closest('.row').find('.room-type').data('no');
// 				alert(reservationNo);
				location = "/reviews/delete.do?reservations_no="+reservationNo;
			    // 사용자가 '확인'을 클릭했을 때 실행되는 코드
			    
			}
		});
});
</script>
<!-- 리뷰 상세보기 페이지 -->
<script type="text/javascript">
$(document).ready(function() {
    // 별점 설정 함수
    function setStars(starId, value) {
        let starsHtml = '';
        for (let i = 0; i < 5; i++) {
            if (i < value) {
                starsHtml += '<i class="fas fa-star" style="color: lemonchiffon;"></i>'; // 채워진 별
            } else {
                starsHtml += '<i class="far fa-star" style="color: lemonchiffon;"></i>'; // 빈 별
            }
        }
        $('#' + starId).html(starsHtml);
    }


    // 리뷰 보기 버튼 클릭 시 AJAX 요청
    $(document).on('click', '.reviewView', function() {
        var reservationNo = $(this).closest('.row').find('.room-type').data('no');
        
        $.ajax({
            url: '/reviews/view.do',
            type: 'GET',
            data: { reservations_no: reservationNo },
            success: function(response) {
//                 console.log('Success:', response);
//                 console.log('Service Rating:', response.service_Rating);
//                 console.log('Cleanliness Rating:', response.cleanliness_Rating);
//                 console.log('convenience_Rating:', response.convenience_Rating);
//                 console.log('amenities_Rating:', response.amenities_Rating);

                // 별점 및 리뷰 내용 업데이트
                setStars('star-service', response.service_Rating || 0);
                setStars('star-cleanliness', response.cleanliness_Rating || 0);
                setStars('star-facilities', response.convenience_Rating || 0);
                setStars('star-equipment', response.amenities_Rating || 0);

                $('#customReviewTitle').text(response.reviewTitle || '제목 없음');
                $('#hotelName').text(response.title || '호텔명 없음');
                $('#hotel_roomName').text(response.room_type || '객실명 없음');
                $('#customReviewContent').text(response.reviewContent || '내용 없음');
                
                $('#reviewModals').modal('show');
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
                alert('리뷰를 불러오는 데 실패했습니다.');
            }
        });
    });
});
</script>

</head>
<body>
	<div class="container">
		<!-- 사업자 리스트 버튼 -->
		<c:if test="${check.gradeno == 5 }">
		<button type="button" class="btn btn-outline-primary float-right"
			data-toggle="modal" data-target="#businessListModal">사업자 리스트
		</button>
		</c:if>
		<h3 class="title">예약내역</h3>
		<div class="row md-5">
			<ul class="nav nav-tabs">
				<li class="nav-item"><a class="nav-link active"
					data-toggle="tab" href="#home">국내 숙소</a></li>
				<li class="nav-item"><a class="nav-link" data-toggle="tab"
					href="#menu1">해외 숙소</a></li>
			</ul>
		</div>
		<!-- Tab panes -->
		<!-- 국내  -->
		<div class="tab-content">
			<h3 class="title"
				style="font-weight: 700; font-size: 20px; margin-bottom: 0;">이용 전</h3>
			<div id="home" class="container tab-pane active">

				<br>
				<!-- 국내 숙소가 없으면 실행 및 상태가 ('예약 완료','미 입실','입실 전')  -->
				<c:if test="${empty list }">
					<div class="no-schedule">
						<h1>예정된 여행이 없습니다.</h1>
						<p>지금 새로운 예약을 진행해보세요.</p>
						<a href="/" class="btn btn-primary">여행지 찾아보기</a> <img
							src="https://via.placeholder.com/100" alt="icon" class="icon">
					</div>
				</c:if>
				<!-- 국내 숙소가 있으면 실행 -->
				<c:if test="${!empty list }">
					<c:forEach items="${list }" var="vo">
						<div class="line">
							<div class="row-md">
								<div class="col-md-7 float-right">
									<br> <b style="font-size: 20px;">${vo.paymentStatus}</b>
									<div class="checkIn" data-check=" ${vo.checkIn }">
										<b class="D-day"></b>
										<div class="horizontal-line"></div>
										<!-- 얇은 선  -->
										<div>
											<h4  style="font-weight: 800;">${vo.title }</h4>
										</div>
										<div>
											<p style="font-size: 20px; margin-bottom: 5px;">${vo.room_type }</p>
										</div>
										<b style="font-size: 15px;">${vo.address }<i
											class="fa fa-clipboard clip"
											style="margin-left: 10px; color: #1273e4; cursor: pointer;">주소
												복사</i></b>
									</div>
									<div class="row">
										<div class="col-md-3 checkInDay">
											체크인<br>
											<fmt:formatDate value="${vo.checkIn }"
												pattern="MM-dd(EEE)HH:mm" />
										</div>
										<!-- 세로 선 -->
										<div class="vertical-line col-md-1" style="height: 50px;"></div>

										<div class="col checkOutDay">
											체크아웃<br>
											<fmt:formatDate value="${vo.checkOut }"
												pattern="MM-dd(EEE)HH:mm" />
										</div>
									</div>
									<a class="btn btn-outline-warning" style="margin-top: 10px;"
										href="view.do?reservation_no=${vo.reservation_no}">예약 상세</a>
								</div>
								<div class="col-md-5 imageCol">
									<img class="hotelImage" alt="이미지가 없습니다."
										src="${vo.room_image_name}">
								</div>
							</div>
						</div>
						<!-- 복사할 텍스트를 포함한 입력 필드 -->
						<input type="text" id="copyText" value="${vo.address }" />
					</c:forEach>
				</c:if>



				<div class="completionDiv">
					<h3 class="title"
						style="font-weight: 700; font-size: 20px; margin-bottom: 35px;">퇴실완료 및 예약 취소</h3>
					<!-- 국내 숙소가 없으면 실행 및 상태가 ('퇴실 완료','예약 취소')  -->
					<c:if test="${empty listCompletion}">
						<div class="no-schedule-completion">해당되는 예약 내역이 없습니다.</div>
					</c:if>
					<!-- 상태가 있으면 ('퇴실 완료','예약 취소')  -->
					<c:if test="${!empty listCompletion}">
						<c:forEach items="${listCompletion }" var="vo">
							<div class="row">
								<div class="col-md-2">
									<img alt="이미지가 존재하지 않습니다." src="/upload/test/test1.png"
										style="width: 140px; height: 140px;" class="completionImage">
								</div>
								<div class="col" style="padding: 0;">
									<!-- 예약 취소 부분 -->
									<c:if test="${vo.paymentStatus =='예약 취소'}">
										<div
											style="color: red; font-weight: 700; margin-bottom: 10px;">
											<!-- 예약 취소 -->
											${vo.paymentStatus}
										</div>
										<div style="font-size: 20px; font-weight: 900;">${vo.title }</div>
										<div style="margin-bottom: 10px;">${vo.room_type }</div>
										<a class="btn btn-outline-warning" href="#">다시 예약</a>
										<a class="btn btn-outline-warning" href="#">취소 상세</a>
									</c:if>

									<c:if test="${vo.paymentStatus =='퇴실 완료'}">
										<div style="color: black; font-weight: 700">
											${vo.paymentStatus}</div>
										<div style="font-size: 20px; font-weight: 900;"
											class="hotel-title">${vo.title}</div>
										<div style="margin-bottom: 10px;" class="room-type"
											data-no=${vo.reservation_no }>${vo.room_type}</div>
										<a class="btn btn-outline-warning" data-toggle="modal"
											data-target="#review">후기 등록</a>
										<c:if test="${vo.has_review =='N'}">
										<button type="button"
											class="reviewsCancelBtn btn btn-outline-danger">후기
											삭제</button>
										<!-- 후기 상세 모달 버튼 -->
										<button type="button" class="btn btn-outline-primary reviewView"
											data-toggle="modal" data-target="#reviewModals">후기
											상세 보기</button>
											</c:if>
										<!-- 리뷰 등록 -->
									</c:if>
								</div>
							</div>
							<div class="horizontal-line"
								style="margin-top: 30px; margin-bottom: 30px;"></div>
							<!-- 얇은 선  -->
						</c:forEach>
					</c:if>
				</div>
			</div>

			<!-- 해외 숙소 -->
			<div id="menu1" class="container tab-pane fade">
				<br> hi
			</div>
		</div>
	</div>
	<!-- The Modal -->
	<div class="modal" id="review">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h1 class="modal-title">후기 남기기</h1>
					<button type="button" class="close custom-close"
						data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>

				<!-- Modal body -->
				<form action="/reviews/write.do" method="post"
					enctype="multipart/form-data">
					<div class="modal-body">
						<p>
							<strong>호텔명:</strong> <span id="modalHotelName"></span>
						</p>
						<p>
							<strong>객실 타입:</strong> <span id="modalRoomType"></span>
						</p>
						<div class="horizontal-line"
							style="margin-top: 30px; margin-bottom: 30px;"></div>
						<!-- 얇은 선  -->
						<!-- 별점 입력 필드 추가 -->
						<input type="hidden" id="service-rating" name="service_Rating"
							value="0"> <input type="hidden" id="cleanliness-rating"
							name="cleanliness_Rating" value="0"> <input type="hidden"
							id="facilities-rating" name="convenience_Rating" value="0">
						<input type="hidden" id="amenities-rating" name="Amenities_Rating"
							value="0"> <input type="hidden" class="reNo"
							name="reservations_no">
						<h2 style="font-size: 19px;">이곳에서의 경험은 어떠셨나요?</h2>
						<div id="average-rating-stars">
							<span class="star">&#9733;</span> <span class="star">&#9733;</span>
							<span class="star">&#9733;</span> <span class="star">&#9733;</span>
							<span class="star">&#9733;</span>
						</div>
						<span id="average-rating" style="margin-bottom: 30px;">0</span>
					</div>
					<h2 style="font-size: 19px;" class="col-md">생생한 평가를 해주세요.</h2>
					<div class="rating-container">
						<div class="rating-category row" data-category="service">
							<b class="col-md-6" style="margin-left: 10px; font-size: 19px;">서비스
								& 친절도</b>
							<div class="stars">
								<span class="star " style="margin-left: 10px;">&#9733;</span> <span
									class="star" style="margin-left: 10px;">&#9733;</span> <span
									class="star" style="margin-left: 10px;">&#9733;</span> <span
									class="star" style="margin-left: 10px;">&#9733;</span> <span
									class="star" style="margin-left: 10px;">&#9733;</span>
							</div>
						</div>
						<div class="rating-category row" data-category="cleanliness">
							<b class="col-md-6" style="margin-left: 10px; font-size: 19px;">숙소
								& 객실 청결도</b>
							<div class="stars">
								<span class="star" style="margin-left: 10px;">&#9733;</span> <span
									class="star" style="margin-left: 10px;">&#9733;</span> <span
									class="star" style="margin-left: 10px;">&#9733;</span> <span
									class="star" style="margin-left: 10px;">&#9733;</span> <span
									class="star" style="margin-left: 10px;">&#9733;</span>
							</div>
						</div>
						<div class="rating-category row" data-category="facilities">
							<b class="col-md-6" style="margin-left: 10px; font-size: 19px;">시설
								& 편의성</b>
							<div class="stars">
								<span class="star" style="margin-left: 10px;">&#9733;</span> <span
									class="star" style="margin-left: 10px;">&#9733;</span> <span
									class="star" style="margin-left: 10px;">&#9733;</span> <span
									class="star" style="margin-left: 10px;">&#9733;</span> <span
									class="star" style="margin-left: 10px;">&#9733;</span>
							</div>
						</div>
						<div class="rating-category row" data-category="amenities">
							<b class="col-md-6" style="margin-left: 10px; font-size: 19px;">비품
								& 용품 만족도</b>
							<div class="stars">
								<span class="star" style="margin-left: 10px;">&#9733;</span> <span
									class="star" style="margin-left: 10px;">&#9733;</span> <span
									class="star" style="margin-left: 10px;">&#9733;</span> <span
									class="star" style="margin-left: 10px;">&#9733;</span> <span
									class="star" style="margin-left: 10px;">&#9733;</span>
							</div>
						</div>
					</div>
					<div class="horizontal-line"
						style="margin-top: 30px; margin-bottom: 30px;"></div>
					<!-- 얇은 선  -->
					제목<input class="form-control" name="reviewTitle"
						placeholder="후기 제목을 입력해주세요.(4자 이상 입력해주세요)" pattern=".{4,500}"
						title="제목은 최소 4자에서 최대 500자까지 가능합니다." required>
					<div class="average-rating">
						내용
						<textarea cols="3" class="form-control" name="reviewContent"
							placeholder="이곳에 머물렀던 기억을 자세히 말해줄 수 있나요(4자 이상 작성해주세요)"
							minlength="4" maxlength="1500" required></textarea>
					</div>
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-primary submitBtn">Submit
							Review</button>
					</div>
				</form>

			</div>
		</div>
	</div>
	<!-- 모달 -->
	<div class="modal fade" id="businessListModal" tabindex="-1"
		role="dialog" aria-labelledby="businessListModalLabel"
		aria-hidden="true">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="businessListModalLabel">사업자 리스트</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
				<div class="searchModal"></div>
					<!-- 여기에 원하는 테이블이나 내용을 추가하세요 -->
					<table class="table" style="font-size: 15px;">
						<thead>
							<tr>
								<th>예약 번호</th>
								<th>이름</th>
								<th>연락처</th>
								<th>예약자 정보</th>
								<th>가격</th>
								<th>예약 상태</th>
								<th>결제 방식</th>
								<th>주문금액</th>
								<th>숙소/침실 타입</th>
								<th>호텔 이름</th>
								<th>객실 이름</th>
								<th>인원 수</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>1</td>
								<td>우성진</td>
								<td>010-2232-1312</td>
								<td>주소정</td>
								<td>준비</td>
								<td>계좌이체</td>
								<td>54000</td>
								<td>확인</td>
								<td>미사용</td>
								<td>호텔 A</td>
								<td>객실 1</td>
								<td>0</td>
							</tr>
							<!-- 추가 항목을 넣을 수 있습니다 -->
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>


	<!-- 후기 상세 모달 -->
	<div class="modal fade" id="reviewModals" tabindex="-1" role="dialog"
		aria-labelledby="reviewDetailModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<b id="hotelName"></b>-<b id="hotel_roomName"></b>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<!-- 별점 섹션 -->
					<div class="rating-section">
						<div>
							<span>서비스 & 친절도: </span> <span class="stars" id="star-service"></span>
						</div>
						<div>
							<span>숙소 & 객실 청결도: </span> <span class="stars"
								id="star-cleanliness"></span>
						</div>
						<div>
							<span>시설 & 편의성: </span> <span class="stars" id="star-facilities"></span>
						</div>
						<div>
							<span>비품 & 용품 만족도: </span> <span class="stars"
								id="star-equipment"></span>
						</div>
					</div>

					<!-- 리뷰 제목 및 내용 -->
					<div class="review-section">
						<h6>리뷰 제목</h6>
						<div id="customReviewTitle">여기에 제목이 들어갑니다.</div>
						<h6>리뷰 내용</h6>
						<div id="customReviewContent">여기에 리뷰 내용이 들어갑니다.</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>