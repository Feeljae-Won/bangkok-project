<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호텔 예약 등록</title>
<style type="text/css">
.rno{
	display: none;
}
.material-icons {
	margin-right: 20px;
}

.back {
	display: inline-block; /* 인라인 블록으로 변경하여 margin-top/bottom 적용 가능 */
	margin-bottom: 20px;
}

#back:hover {
	cursor: pointer;
}

.member_data,.pay {
	margin-top: 20px;
	margin-bottom: 20px;
}

.lastName, .fastName {
	max-width: 150px; /* 최대 너비를 150px로 설정 */
}

.email {
	max-width: 337px; /* 최대 너비를 150px로 설정 */
}

.tel {
	max-width: 337px;
	margin-bottom: 100px;
}

.FontEmail, .FontTel {
	margin-top: 30px;
}

.line {
	border: 1px solid rgba(0, 0, 0, 0.1); /* 테두리 두께를 0.5px로 설정하여 얇게 */
	padding: 20px; /* 내부 여백 */
	border-radius: 10px; /* 모서리 둥글게 */
}

.hotelTitle {
	margin-top: 30px;
	margin-bottom: 20px;
	margin-right: 100px;
}

.hotelImage {
	margin-bottom: 20px;
}

.leftB {
	margin-right: 80px;
}

.leftBGO {
	margin-right: 112px;
}

.leftA {
	margin-right: 60px;
}

#wrapper #content-wrapper {
	background-color: white;
	width: 100%;
	overflow-x: hidden;
}
.priceB,.priceBA{
	font-size: 20px;
}
.priceBA{
	 font-weight: 100;
}
.horizontal-line {
    width: 99%; /* 선의 길이 조절 */
    margin: 0 auto; /* 중앙 정렬 */
    border-top: 1px solid rgba(0, 0, 0, 0.1); /* 매우 희미한 선 */
}
.lins{
	margin-top: 20px;
	margin-bottom: 20px;
}
.totalB{
	font-size: 20px;
}
.totalPriceB{
	color: #ff0000; /* 폰트 색상을 빨간색으로 설정 */
	font-size: 25px;
}
 .agreement-container {
    max-width: 600px;
    margin: 20px auto;
  }

  .agreement-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    background-color: #f5f5f5; /* 배경색 */
    padding: 15px;
    margin-bottom: 10px;
    border-radius: 10px; /* 둥근 모서리 */
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 */
    cursor: pointer;
    width: 100%;
  }

  .agreement-item label {
    flex-grow: 1;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
  }

  .agreement-item input[type="checkbox"] {
    margin-right: 10px;
    transform: scale(1.3); /* 체크박스 크기 조절 */
  }

  .dropdown-arrow {
    font-size: 16px;
  }
  /* 전체 동의 스타일 */
  .agreement-all {
    font-weight: bold;
    font-size: 18px;
  }

  .agreement-all .agreement-item {
    background-color: #f5f5f5;
    padding: 20px;
  }

  .items{
  display: none;
  }
  .order{
  display: none;
  }
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {
  main();

  async function main() {
    const button = document.getElementById("payment-button");
	//가격 가져오기 
    let priceB = $(".priceB").text();
    // 특정 문자를 제거
    let price = priceB.replace('원', '');
    // 결과 출력
    console.log(price);
    
    let checkInDate =$(".checkIn").text();
    //console.log(checkInDate);
    let  checkIn = checkInDate.slice(9, 19);
    console.log("추출된 날짜:", checkIn);    

    
    
    let checkOutDate =$(".checkOut").text();
    //console.log(checkOutDate);
    let checkOut = checkOutDate.slice(7, 17);
    console.log("추출된 날짜:", checkOut);    

    
    let rno =$(".rno").text()
      rno = Number(rno);
    console.log("객실 번호:", rno);    
    let name = $("#lastName").find(".lastName").val();
    console.log(name);
    let tel = $(".FontTel").find(".tel").val();
    tel = tel.replace(/-/g, '');  // 하이픈을 빈 문자열로 대체
    console.log(tel);
    let orders = $(".order").text();
    console.log(orders);
    let people = $(".people").text();
    people = Number(people);
    console.log(people);
    // ------  결제위젯 초기화 ------
    const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
    const tossPayments = TossPayments(clientKey);
    // 회원 결제
    const customerKey = "D0AZeFYmq0kSdALWrTDOz";
    const widgets = tossPayments.widgets({
      customerKey,
    });
    // 비회원 결제
    // const widgets = tossPayments.widgets({ customerKey: TossPayments.ANONYMOUS });

    // ------ 주문의 결제 금액 설정 ------
    await widgets.setAmount({
      currency: "KRW",
      value: Number(price),
    });

    await Promise.all([
      // ------  결제 UI 렌더링 ------
      widgets.renderPaymentMethods({
        selector: "#payment-method",
        variantKey: "DEFAULT",
      }),
      // ------  이용약관 UI 렌더링 ------
      widgets.renderAgreement({
        selector: "#agreement",
        variantKey: "AGREEMENT",
      }),
    ]);

    // UUID 랜덤 생성
    function generateCustomUUID() {
      const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_';
      let result = '';
      for (let i = 0; i < 22; i++) {
        const randomIndex = Math.floor(Math.random() * characters.length);
        result += characters[randomIndex];
      }
      return result;
    }

    // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
    button.addEventListener("click", async function () {
      const orderId = generateCustomUUID(); // 여기서 주문 ID 생성

      await widgets.requestPayment({
        orderId: orderId, // 생성된 주문 ID 사용
        orderName: orders,
        customerEmail: "skxowns222@naver.com",
        customerName: name,
        customerMobilePhone: tel,
        successUrl: window.location.origin + "/resources/hotelSuccess.html?people="+people+"&rno="+rno,
        	//checkOut="+checkOut+"&checkIn="+checkIn+"
        failUrl: window.location.origin + "/resources/Hotelfail.html",
      });
    });
  }
});
</script>
<script type="text/javascript">
$(function(){
	let name = $("#lastName").find(".lastName").val();
	let fastName =name.charAt(0);
	let lastName = name.length > 1 ? name.substring(1) : "";
	//console.log(lastName,fastName);
	
	$("#lastName").find(".lastName").val(lastName);
	$("#fastName").find(".fastName").val(fastName);
	
	
});
$(function() {
	  // 드롭다운 열기/닫기 함수
	  function toggleDropdown(element) {
	    // 현재 항목에 'open' 클래스를 추가하거나 제거
	    $(element).toggleClass('open');
	  
	    // 화살표 방향을 토글 (열리면 위, 닫히면 아래)
	    const $arrow = $(element).find('.dropdown-arrow');
	    if ($(element).hasClass('open')) {
	      $arrow.text('▲');
	    } else {
	      $arrow.text('▼');
	    }
	  }
	  
	  // 드롭다운 클릭 시
	  $(".dropdown-arrow").click(function() {
	    // 부모 요소를 찾아서 드롭다운을 토글
	    toggleDropdown($(this).closest('.dropdown'));
	    // 모든 항목을 보여줍니다.
	    $(".items").toggle();
	  });
	  
	  // 약관 전체 동의 체크박스 제어
	  $('#agreeAll').change(function() {
	    const isChecked = $(this).is(':checked');
	    
	    // 모든 개별 체크박스도 함께 체크/체크해제
	    $('.agreement-item input[type="checkbox"]').prop('checked', isChecked);
	  });
	});
</script>
</head>
<body>
	<div class="container">
		<h2 style="font-weight: bold;">
			<i class="material-icons" style="font-size: 30px" id="back">arrow_back
			</i>예약 확인 및 결제
		</h2>
		<div class="row mb-5">

			<div class="col-md-7">
				<div class="member_data" style="font-size: 20px; font-weight: bold;">예약자
					정보</div>

				<div class="row">
					<div class="col-sm-2" id="lastName">
						<b>이름</b> <input type="text" class="form-control lastName"
							value="${hotel.name }" readonly>
					</div>
					<div class="col-sm-2" id="fastName">
						<b>성</b> <input type="text" class="form-control fastName" readonly>
					</div>
				</div>
				<div class="row">
					<div class="col FontEmail">
						<b>이메일</b> <input type="text" class="form-control email"
							value="${hotel.email }" readonly>
					</div>
				</div>
				<div class="row">
					<div class="col FontTel">
						<b>핸드폰 번호</b> <input type="text" class="form-control tel"
							value="${hotel.tel }" readonly>
					</div>
				</div>
			</div>
			<div class="col-md-5">
				<div class="line ">
					<div class="row">
						<div class="col">
							<h3 class="hotelTitle">${hotel.title }</h3>
						</div>
					</div>
					<div class="hotelImage">
					<!-- /upload/test/test1.png 샘플 데이터 -->
						<img alt="이미자가 없습니다." src="${hotel.hotel_image_name }"
							style="width: 350px; height: 200px;">
					</div>
					<div>
						<b class="leftB">객실</b>${hotel.room_type }
					</div>
					<div class="checkIn" >
						<b class="leftB">일정</b>2024-09-13(화) 14:00 ~
					</div>
					<div class="checkOut" >
						<b class="leftBGO checkOut"></b>2024-09-15(목) 12:00
					</div>
					<div>
						<b class="leftA">객실 수</b>객실 1개
					</div>
					<div>
						<b class="leftB">인원</b><span class="people">${hotel.people }</span>명
					</div>
				</div>
			</div>
	</div>

		<div class="row mb-5">
			<div class="col-md-7">
				<!--     결제 UI 시작 -->
				<div id="payment-method"></div>
				<!--     이용약관 UI -->
				<div id="agreement"></div>
				<!--      결제 UI 끝 -->
			</div>
			<div class="col-md-5">
				<div class="line ">
				<br>
				<h3 class="pay">결제 정보</h3>
				<b class="priceBA">객실 가격(1개)</b><b class="float-right priceB">${hotel.price }원</b>
				<div class="lins">
				<div class="horizontal-line"></div> <!-- 얇은 선  -->
				</div>
				<b class="totalB">총 결제 금액</b><b class="float-right totalPriceB">${hotel.price }원</b>
				<!-- 약관 동의 창 -->
					<div class="agreement-container">
					  <!-- 전체 동의 항목 -->
					  <div class="agreement-all">
					    <div class="agreement-item" onclick="toggleDropdown(this)">
					      <input type="checkbox" id="agreeAll">
					      <label for="agreeAll">약관 전체동의</label>
					      <span class="dropdown-arrow">▼</span>
					    </div>
					  </div>
					  <!-- 개별 동의 항목 1 -->
					  <div class="agreement-item items" onclick="toggleDropdown(this)">
					    <input type="checkbox" id="agree1">
					    <label for="agree1">숙소 이용규칙 및 취소/환불규정 동의 (필수)</label>
					  </div>
					  <!-- 개별 동의 항목 2 -->
					  <div class="agreement-item items" onclick="toggleDropdown(this)">
					    <input type="checkbox" id="agree2">
					    <label for="agree2">개인정보 수집 및 이용 동의 (필수)</label>
					  </div>
					
					  <!-- 개별 동의 항목 3 -->
					  <div class="agreement-item items" onclick="toggleDropdown(this)">
					    <input type="checkbox" id="agree3">
					    <label for="agree3">개인정보 제3자 제공 동의 (필수)</label>
					  </div>
					</div>
				<!-- 약관 동의 창 끝 -->
				<!--     결제하기 버튼 -->
				<button class="button btn btn-outline-warning" id="payment-button" style="width: 100%;"
					><b style="font-size: 20px;">${hotel.price }원 결제하기</b></button>
				</div>
			</div>
		</div>
	</div>
	<b class="rno">${hotel.rno}</b>
	<b class="order">${hotel.room_type}</b>
</body>
</html>