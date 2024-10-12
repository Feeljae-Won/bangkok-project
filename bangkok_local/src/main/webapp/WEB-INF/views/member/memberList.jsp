<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 리스트</title>
<style>
body {
	background-color: #f4f4f9;
	margin: 0;
	padding: 0;
}

.container {
	width: 90%;
	max-width: 1200px;
	margin: 20px auto;
	padding: 20px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

h3 {
	margin-top: 0;
	font-size: 24px;
	color: #333;
}

.search-form {
	margin-bottom: 20px;
}

.search-form .input-group {
	width: 100%;
}

.input-group-prepend select, .input-group-append button {
	border-radius: 4px;
	border: 1px solid #ddd;
}

.input-group input {
	border-radius: 4px;
	border: 1px solid #ddd;
	flex: 1;
}

.list-group {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
	gap: 20px;
}

.card {
	display: flex;
	align-items: center;
	border: 1px solid #ddd;
	border-radius: 8px;
	padding: 15px;
	background-color: #fff;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.card img {
	width: 70px;
	height: 70px;
	object-fit: cover;
	border-radius: 50%;
	margin-right: 15px;
}

.card-details {
	display: flex;
	flex-direction: column;
	justify-content: center;
}

.card-details span {
	margin-bottom: 5px;
	font-size: 14px;
	color: #555;
}

.card-details .email {
	font-weight: bold;
	color: #222;
}

.card-details .status {
	color: #777;
}

.card-details .gradeName {
	color: #007bff;
}

.pagination-container {
	margin-top: 20px;
	text-align: center;
}

@media ( max-width : 768px) {
	.list-group {
		grid-template-columns: 1fr; /* 모바일에서는 1열로 표시 */
	}
}
</style>
<script>
	$(document).ready(function() {
		// 검색 옵션이 설정되어 있으면 해당 옵션을 선택
		let keyValue = "${pageObject.key}";
		if (keyValue) {
			$("#key").val(keyValue);
		}

		// 페이지 당 항목 수 변경 시 폼 제출
		$("#perPageNum").change(function() {
			$("#searchForm").submit();
		});

		// 페이지 당 항목 수 설정
		let perPageNumValue = "${pageObject.perPageNum}";
		if (perPageNumValue) {
			$("#perPageNum").val(perPageNumValue);
		}
	});
</script>

</head>
<body>
	<div class="container">
		<h1 class="mt-5 mb-5 text-center">[ Member List ]</h1>
		<!-- 검색란의 시작 -->
		<form action="memberList.do" id="searchForm"
			enctype="multipart/form-data" class="search-form">
			<input name="page" value="1" type="hidden">
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<select name="key" id="key" class="form-control">
						<option value="name">이름</option>
						<option value="email">이메일</option>
						<!-- 추가 검색 옵션이 있다면 여기에 추가 -->
					</select>

				</div>
				<input type="text" class="form-control" placeholder="검색" id="word"
					name="word" value="${pageObject.word}" style="max-width: 30%;">
				<div class="input-group-append">
					<button class="btn btn-outline-primary">
						<i class="fa fa-search"></i>
					</button>
				</div>
			</div>
		</form>

		<!-- 회원 리스트 -->
		<div class="list-group">
			<c:forEach var="vo" items="${list}">
				<div class="card dataRow">
					<img src="${vo.photo}" alt="${vo.name}'s photo">
					<div class="card-details">
						<span class="email">${vo.email}</span> <span>이름 :
							${vo.name}</span> <span>연락처 : ${vo.tel}</span> <span> 생년월일 : <fmt:formatDate
								value="${vo.birth }" pattern="yyyy-MM-dd" /></span> <span> 가입일
							: <fmt:formatDate value="${vo.regDate }" pattern="yyyy-MM-dd" />
						</span><span> 최근접속일 : <fmt:formatDate value="${vo.conDate }"
								pattern="yyyy-MM-dd" /></span><span class="status">상태 :
							${vo.status}</span> <span class="gradeName">등급 : ${vo.gradeName}</span>

						<form action="updateMember.do" method="post" class="form-inline">
							<input type="hidden" name="email" value="${vo.email}">

							<!-- 상태 수정 -->
							<div class="form-group mx-sm-3 mb-2">
								<label for="status-${vo.email}" class="sr-only">상태</label> <select
									id="status-${vo.email}" name="status" class="form-control">
									<option value="정상" ${vo.status == '정상' ? 'selected' : ''}>정상</option>
									<option value="강퇴" ${vo.status == '강퇴' ? 'selected' : ''}>강퇴</option>
								</select>
							</div>

							<!-- 등급 수정 -->
							<div class="form-group mx-sm-3 mb-2">
								<label for="grade-${vo.email}" class="sr-only">등급</label> <select
									id="grade-${vo.email}" name="gradeNo" class="form-control">
									<option value="1" ${vo.gradeName == '일반회원' ? 'selected' : ''}>일반회원</option>
									<option value="5" ${vo.gradeName == '사업자' ? 'selected' : ''}>사업자</option>
									<option value="9" ${vo.gradeName == '관리자' ? 'selected' : ''}>관리자</option>
								</select>
							</div>

							<button type="submit" class="btn btn-primary mb-2">변경</button>
						</form>


					</div>
				</div>
			</c:forEach>
		</div>

		<!-- 페이지네이션 -->
		<div class="pagination-container">
			<pageNav:pageNav listURI="memberList.do" pageObject="${pageObject}" />
		</div>
	</div>
</body>
</html>
