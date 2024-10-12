<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <%@ taglib prefix="pagNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List</title>
<style type="text/css">
.box {
	padding: 10px; 
	border: 1px solid #e0e0e0; 
	border-radius:10px; 
	box-shadow:0px 0px 5px 3px; 
	margin-bottom:10px;
}
.seat-box {
	text-align: center;
	width: 50px;
    height: 70px;
    line-height: 50px;
    padding: 5px;
/*     border: 1px solid #000;  */
}
.rounded-lg {
    display: inline-block;
    width: 60px;
    height: 60px;
    line-height: 60px;
    background-color: white;
    border: 2px solid #FF8533;
}
.seat-box-small {
	text-align: center;
	width: 20px;
    height: 30px;
    line-height: 30px;
    padding: 2px;
/*     border: 1px solid #000;  */
}
.rounded-lg-small {
    display: inline-block;
    width: 30px;
    height: 30px;
    line-height: 30px;
    background-color: white;
    border: 2px solid #FF8533;
    border-radius:5px;
}
.box-title {
	font-size: 25px;
	font-weight: bold;
}
.kitchen {
	background-color: #e0e0e0;
	border-radius:5px;
}
.binder {
	margin-bottom:10px;
}
.toilet {
	background-color: #e0e0e0;
	border-radius:5px;
}
.toilet > img{
	width: 40px;
	height:40px;
}
.open:hover {
	background-color:#FDF3D8;
	border: 2px solid #FF8533;
	cursor:pointer;
}
.close {
	background-color: #e0e0e0;
	border: 2px solid #000;
}
.choose {
	background-color: #FF8533;
	border: 2px solid #FF8533;
	color:white;
}
</style>
<script type="text/javascript">
$(function() {
	
	// 탑승객 수 받아오기
	let passengerCnt = 2;
	let seatCnt = 1;
	let canceledSeats = []; // 취소된 좌석 번호를 저장할 배열
	
	// 좌석 선택 이벤트
	$(".rounded-lg").click(function() {
		
		// 좌석 데이터 수집
		let seatNum = $(this).closest(".seat-box").data("seatnum");
		
		// x 아이콘
		let xIcon = '<i class="fa fa-close" style="font-size:30px;"></i>'
		// alert(seatNum);
		
		// 선택한 좌석 표시하기
		let selectedSeatPre =	'<span class="choose">';
		let selectedSeatEnd =	'</span>';
		
		// 선택좌석 총 개수
		let chosenSeatsCount = $(".choose").length;
		
		// 현재 클릭한 좌석이 open 상태인지 확인
	    if ($(this).hasClass("open")) {
	        if (seatCnt <= passengerCnt || chosenSeatsCount <= passengerCnt) {
	            $(this).removeClass("open").addClass("choose");

	            // 취소된 좌석 번호가 있는 경우 그 번호 사용
	            if (canceledSeats.length > 0) {
	                let reuseSeat = canceledSeats.shift(); // 첫 번째 취소된 번호 사용
	                $(this).text(reuseSeat); // 좌석에 숫자 표시
	                $(".passenger" + reuseSeat).html(selectedSeatPre + seatNum + selectedSeatEnd);
	            } else {
	                $(this).text(seatCnt); // 좌석에 새로운 번호 표시
	                $(".passenger" + seatCnt).html(selectedSeatPre + seatNum + selectedSeatEnd);
	                seatCnt++; // 좌석 수 증가
	            }
	        } else {
	            alert("더 이상 좌석을 선택할 수 없습니다.");
	            return false;
	        }
	    } 
	    // 클릭한 좌석이 이미 choose 상태일 때
	    else if ($(this).hasClass("choose")) {
	        $(this).removeClass("choose").addClass("open");
	        
	        let canceledSeat = parseInt($(this).text()); // 취소된 좌석 번호 저장
	        canceledSeats.push(canceledSeat); // 취소된 번호를 배열에 추가
	        canceledSeats.sort((a, b) => a - b); // 번호 순서대로 정렬

	        $(this).text(""); // 좌석 번호 제거
	        $(".passenger" + canceledSeat).html("");
	        if (seatCnt < 1) {
	        	return false;
	        } else {
	        	seatCnt--; // 좌석 수 감소
	        }
	    }
		// 선택 불가능 좌석
// 		$(this).addClass("close");
// 		$(this).html(xIcon);
		
	});
	
	
});
</script>

</head>
<body>
<body>
<div class="container-fluid">
	<div style="border-bottom:1px solid #e0e0e0;" class="mb-3">
		<h4>항공 좌석 선택</h4>
		<!-- Nav tabs -->
		<p>아래 여정마다 좌석을 선택할 수 있습니다.</p>
		<ul class="nav nav-pills nav-justified">
			<li class="nav-item">
				<a class="nav-link active" href="#">가는 편</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="#">돌아오는 편</a>
			</li>
		</ul>
	</div>
	<div class="row">
		<!-- 왼쪽 좌석 정보 -->
		<div class="col-sm-2">
			<div class="p-4" style="border: 1px solid #e0e0e0; border-radius:10px;">
				<h5><strong>구분</strong></h5>
				<hr>
				<div class="form-inline">
					<div class="seat-box-small mr-4"><span class="rounded-lg-small open"></span></div>
					<span>  : 선택 가능 좌석</span>
				</div>
				<br>
				<div class="form-inline">
					<div class="seat-box-small mr-4"><span class="rounded-lg-small  choose"></span></div>
					<span>  : 선택한 좌석</span>
				</div>
				<br>
				<div class="form-inline ml-3">
					<div class="seat-box-small mr-2"><span class="rounded-lg-small close "><i class="fa fa-close" style="font-size:20px;"></i></span></div>
					<span>  : 선택 불가</span>
				</div>
				<br>
				<div class="form-inline ml-2">
					<i class="material-icons mr-3" style="font-size:24px; color:red;">directions_run</i>
					<span>  : 비상구</span>
				</div>
				<br>
				<div class="form-inline ml-2">
					<img src="/upload/air/toilet.png" style="width:24px;" class="mr-3">
					<span>  : 화장실</span>
				</div>
			</div>
		</div>
		<!-- 가운데 좌석 선택 -->
		<div class="col-sm-7">
			 <div class="alert alert-warning text-center">
				<strong>All seats are equipped with :</strong> 
				<span class="ml-4"><i class="material-icons" style="font-size:16px;">power</i> 110V AC</span>
				<span class="ml-4"><i class="material-icons" style="font-size:16px;">tv</i> 10.6-inch LCD screen</span>
			</div>
			
			<div class="box">
				<div class="row box-title">
					<div class="col seat-box"></div>
					<div class="col seat-box"></div>
					<div class="col seat-box">A</div>
					<div class="col seat-box">B</div>
					<div class="col seat-box"></div>
					<div class="col seat-box">C</div>
					<div class="col seat-box">D</div>
					<div class="col seat-box"></div>
					<div class="col seat-box">E</div>
					<div class="col seat-box">F</div>
					<div class="col seat-box"></div>
					<div class="col seat-box"></div>
				</div>
				<div class="row binder">
					<div class="col seat-box"></div>
					<div class="col seat-box"><i class="material-icons" style="font-size:24px; color:red;">directions_run</i></div>
					<div class="col-2 seat-box kitchen">주방</div>
					<div class="col seat-box"></div>
					<div class="col-2 seat-box kitchen">주방</div>
					<div class="col seat-box"></div>
					<div class="col-2 seat-box kitchen">주방</div>
					<div class="col seat-box"><i class="material-icons" style="font-size:24px; color:red;">directions_run</i></div>
					<div class="col seat-box"></div>
				</div>
				<c:forEach var="i" begin="9" end="30">
				    <div class="row">
				        <div class="col seat-box">${i}</div> <!-- 좌석 번호 -->
				        <div class="col seat-box"></div>
				        <div class="col seat-box" id="seatA${i}" data-seatnum="A${i}"><span class="rounded-lg open"></span></div> <!-- 좌석 A -->
				        <div class="col seat-box" id="seatB${i}" data-seatnum="B${i}"><span class="rounded-lg open"></span></div> <!-- 좌석 B -->
				        <div class="col seat-box"></div>
				        <div class="col seat-box" id="seatC${i}" data-seatnum="C${i}"><span class="rounded-lg open"></span></div> <!-- 좌석 C -->
				        <div class="col seat-box" id="seatD${i}" data-seatnum="D${i}"><span class="rounded-lg open"></span></div> <!-- 좌석 D -->
				        <div class="col seat-box"></div>
				        <div class="col seat-box" id="seatE${i}" data-seatnum="E${i}"><span class="rounded-lg open"></span></div> <!-- 좌석 E -->
				        <div class="col seat-box" id="seatF${i}" data-seatnum="F${i}"><span class="rounded-lg open"></span></div> <!-- 좌석 F -->
				        <div class="col seat-box"></div>
				        <div class="col seat-box">${i}</div> <!-- 좌석 번호 -->
				    </div>
				</c:forEach>
				<div class="row binder">
					<div class="col seat-box"></div>
					<div class="col seat-box"></div>
					<div class="col-2 seat-box toilet"><img src="/upload/air/toilet.png"></div>
					<div class="col seat-box"></div>
					<div class="col-2 seat-box toilet"><img src="/upload/air/toilet.png"></div>
					<div class="col seat-box"></div>
					<div class="col-2 seat-box toilet"><img src="/upload/air/toilet.png"></div>
					<div class="col seat-box"></div>
					<div class="col seat-box"></div>
				</div>
				<div class="row box-title">
					<div class="col seat-box"></div>
					<div class="col seat-box"><i class="material-icons" style="font-size:24px; color:red;">directions_run</i></div>
					<div class="col seat-box">A</div>
					<div class="col seat-box">B</div>
					<div class="col seat-box"></div>
					<div class="col seat-box">C</div>
					<div class="col seat-box">D</div>
					<div class="col seat-box"></div>
					<div class="col seat-box">E</div>
					<div class="col seat-box">F</div>
					<div class="col seat-box"><i class="material-icons" style="font-size:24px; color:red;">directions_run</i></div>
					<div class="col seat-box"></div>
				</div>
				<c:forEach var="i" begin="31" end="50">
				    <div class="row">
				        <div class="col seat-box">${i}</div> <!-- 좌석 번호 -->
				        <div class="col seat-box"></div>
				        <div class="col seat-box" id="seatA${i}" data-seatnum="A${i}"><span class="rounded-lg open"></span></div> <!-- 좌석 A -->
				        <div class="col seat-box" id="seatB${i}" data-seatnum="B${i}"><span class="rounded-lg open"></span></div> <!-- 좌석 B -->
				        <div class="col seat-box"></div>
				        <div class="col seat-box" id="seatC${i}" data-seatnum="C${i}"><span class="rounded-lg open"></span></div> <!-- 좌석 C -->
				        <div class="col seat-box" id="seatD${i}" data-seatnum="D${i}"><span class="rounded-lg open"></span></div> <!-- 좌석 D -->
				        <div class="col seat-box"></div>
				        <div class="col seat-box" id="seatE${i}" data-seatnum="E${i}"><span class="rounded-lg open"></span></div> <!-- 좌석 E -->
				        <div class="col seat-box" id="seatF${i}" data-seatnum="F${i}"><span class="rounded-lg open"></span></div> <!-- 좌석 F -->
				        <div class="col seat-box"></div>
				        <div class="col seat-box">${i}</div> <!-- 좌석 번호 -->
				    </div>
				</c:forEach>
				<div class="row binder mb-5">
					<div class="col seat-box"></div>
					<div class="col seat-box"></div>
					<div class="col-2 seat-box toilet"><img src="/upload/air/toilet.png"></div>
					<div class="col seat-box"></div>
					<div class="col-2 seat-box toilet"><img src="/upload/air/toilet.png"></div>
					<div class="col seat-box"></div>
					<div class="col-2 seat-box toilet"><img src="/upload/air/toilet.png"></div>
					<div class="col seat-box"></div>
					<div class="col seat-box"></div>
				</div>
			</div>
			
		</div>
		
		<!-- 오른쪽 탑승객 정보 -->
		<div class="col-sm-3">
			<div class="alert" style="background-color: #FF8533; color:white">
				<h5><strong>여정 정보</strong></h5>
				<span> ICN</span> ~ <span> NRT</span>
				<br>
				<span> 2024년 10월 1일</span><span> 09:00 ~ 11:30</span>
				<br>
				<span> KE5744 </span>
			</div>
			<div class="p-3" style="border:1px solid #e0e0e0;border-radius:10px;">
				<h5><strong>탑승객 정보</strong></h5>
				<!-- 탑승객 1인당 alert div 하나 -->
				<div class="alert alert-warning ">
					<div class="float-right passenger1">
					</div>
					<span>1</span>. <strong>FEEL JAE WON (M)</strong> - <small>ADULT</small>
				</div>
				<!-- 탑승객 1인당 alert div 하나 -->
				<div class="alert alert-warning ">
					<div class="float-right passenger2">
					</div>
					<span>2</span>. <strong>MIN SEON KIM (F)</strong> - <small>ADULT</small>
				</div>
			</div>
			<div class="float-right mt-2">
				<button class="btn btn-warning">저장 후 다음 항공편 좌석 선택</button>
				<button class="btn btn-secondary">다시 선택</button>
			</div>
		</div>
	</div>
</div>
</body>
</html>