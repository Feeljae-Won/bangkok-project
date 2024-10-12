<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>사업장 수정</title>
<style>
body {
	font-family: 'goorm-sans-code';
	margin: 0;
	padding: 0;
	background-color: #f5f5f5;
}

.container {
	max-width: 600px;
	margin: 20px auto;
	padding: 20px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	text-align: center; /* 모든 내용을 중앙 정렬 */
}

h2 {
	text-align: center;
	margin-bottom: 30px;
	color: #333;
}


.info-grid div label {
	font-weight: bold;
	display: block;
	margin-bottom: 5px;
	color: #555;
}

.info-grid div input {
	width: 80%;
	padding: 8px;
	box-sizing: border-box;
	border-radius: 5px;
	border: 1px solid #ddd;
	font-size: 16px;
}

/* 버튼 중앙 배치 */
.btn-group {
	display: flex;
	justify-content: center;
	margin-top: 30px;
}

.btn-group form {
	margin: 0 10px;
}

.info-grid .form-group {
	display: flex;
	flex-direction: column;
}
.info-grid .form-group label {
	font-weight: bold;
	margin-bottom: 5px;
	color: #555;
	text-align: left; /* 라벨 왼쪽 정렬 */
	margin-left:5%;
}

.info-grid .form-group input {
	width: 80%; /* 너비를 80%로 줄임 */
	padding: 8px;
	box-sizing: border-box;
	border-radius: 5px;
	border: 1px solid #ddd;
	font-size: 16px;
	margin: 0 auto; /* 가운데 정렬 */
}
</style>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						var addr = '';
						var extraAddr = '';

						if (data.userSelectedType === 'R') {
							addr = data.roadAddress;
						} else {
							addr = data.jibunAddress;
						}

						if (data.userSelectedType === 'R') {
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}
						}

						document.getElementById('sample6_postcode').value = data.zonecode;
						document.getElementById('sample6_address').value = addr
								+ extraAddr;
						document.getElementById('sample6_detailAddress')
								.focus();

						document.getElementById("sample6_address").disabled = false;
						document.getElementById("sample6_detailAddress").disabled = false;
						document.getElementById("sample6_postcode").disabled = false;
					}
				}).open();
	}

	window.onload = function() {
		document.getElementById("sample6_postcode").disabled = true;
		document.getElementById("sample6_address").disabled = true;
		document.getElementById("sample6_detailAddress").disabled = true;

		// 초기 상태 설정
		toggleBusinessAddress();
	};

	function toggleBusinessAddress() {
		var isBusiness = document.getElementById('bissnice').checked;
		var businessAddressFields = document
				.getElementById('businessAddressFields');
		if (isBusiness) {
			businessAddressFields.classList.remove('hidden');
		} else {
			businessAddressFields.classList.add('hidden');
		}
	}
</script>
</head>
<body>
	<div class="container">
		<h2 class="mt-3">Office Update</h2>
		<form action="bisUpdate.do" method="post">
		<!-- 사용자 정보 그리드 -->
			<div class="info-grid">
			 <!-- 사용자 정보 그리드 --> <input type="hidden"
				value="${vo.business_no}" name="business_no"> <input
				type="hidden" value="${vo.email }" name="email">
				<div id="businessAddressFields" class="form-group hidden">
					<label for="address">사업장 주소:</label>
					<div
						style="display: flex; justify-content: space-between; width: 80%; margin: 0 auto;">
						<input type="text" id="sample6_postcode" class="form-control post"
							name="post_code" disabled placeholder="우편번호"> <input 
							type="button" onclick="sample6_execDaumPostcode()"
							value="우편번호 찾기" class="btn btn-secondary btn-sm post" name="post_code">
					</div>
					<input type="text" id="sample6_address" class="form-control"
						name="office_adr" placeholder="주소" disabled> <input
						type="text" id="sample6_detailAddress" class="form-control"
						name="detail_adr" placeholder="상세주소" disabled><br>
					<div class="form-group">
						<label for="office_num" class="label"> 사업자 번호: </label> <input
							type="text" class="form-control" placeholder="'-'포함 입력"
							id="office_num" name="office_num">
					</div>
					<div class="form-group">
						<label for="office_Name" class="label"> 사업장 명: </label> <input
							type="text" class="form-control" placeholder="사업장 명 입력"
							id="office_Name" name="office_name">
					</div>
				</div> <!-- 버튼 중앙 배치 --> <span class="btn-group text-center" role="group">
					<button class="btn btn-sm" id="updateBtn" type="submit"
						style="background: orange; color: white; max-width:50px;">수정</button>
			</span>
			</div>
		</form>
	</div>
</body>
</html>
