<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>사업자 정보</title>
<style>
body {
	font-family: 'goorm-sans-code', sans-serif;
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
}

h2 {
	text-align: center;
	margin-bottom: 30px;
	color: #333;
}

.info-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
	margin-top: 20px;
}

.info-grid div {
	padding: 15px;
	background-color: #f9f9f9;
	border-radius: 5px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.info-grid div label {
	font-weight: bold;
	color: #555;
}

.info-grid div span {
	display: block;
	font-size: 16px;
	color: #333;
}

.btn-group {
	display: flex;
	justify-content: center;
	margin-top: 30px;
}

.btn-group button {
	background: orange;
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
}

.btn-group button:hover {
	background: #e07b00;
}

@media (max-width: 768px) {
	.info-grid {
		grid-template-columns: 1fr;
	}
}
</style>
</head>
<body>
	<div class="container">
		<h2 class="mt-4 mb-5">사업자 정보</h2>

		<!-- 사용자 정보 그리드 -->
		<div class="info-grid">
			<input type="hidden" value="${vo.business_no}" name="business_no">
			<div>
				<label>사업장명</label>
				<span>${vo.office_name}</span>
			</div>
			<div>
				<label>우편번호</label>
				<span>${vo.post_code}</span>
			</div>
			<div>
				<label>사업장 주소</label>
				<span>${vo.office_adr}</span>
			</div>
			<div>
				<label>사업장 상세주소</label>
				<span>${vo.detail_adr}</span>
			</div>
			<div>
				<label>사업자 번호</label>
				<span>${vo.office_num}</span>
			</div>

			<!-- 버튼 중앙 배치 -->
			<span class="btn-group">
				<form action="/member/bisUpdateForm.do" method="get">
					<input type="hidden" name="email" value="${vo.email}">
					<button type="submit">수정</button>
				</form>
			</span>
		</div>
	</div>
</body>
</html>
