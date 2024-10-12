<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>로그인 폼</title>
<style>
body {
	margin: 0;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background-color: #f4f4f4; /* 페이지 배경을 연한 회색으로 설정 */
}

article {
	justify-content: center;
	align-items: center;
	padding-top: 50px;
}

.container {
	width: 100%;
	max-width: 400px; /* 폼의 최대 너비를 줄였습니다 */
	padding: 20px;
	border-radius: 12px; /* 모서리 둥글게 설정 */
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
	background-color: #ffffff; /* 배경색을 흰색으로 설정 */
	box-sizing: border-box; /* 테두리와 패딩을 포함한 전체 너비 계산 */
}

h1 {
	margin-bottom: 20px;
	font-size: 24px;
	color: #333;
}

.form-group {
	margin-bottom: 15px;
	text-align: left;
}

.form-group label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
	color: #555;
}

.form-control {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 14px;
	box-sizing: border-box;
}

.form-control:focus {
	border-color: #007bff;
	outline: none;
}

.loginBtn {
	width: 100%;
	padding: 10px;
	background-color: #007bff;
	color: #ffffff;
	border: none;
	border-radius: 5px;
	font-size: 16px;
	cursor: pointer;
}

.loginBtn:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
	<div class="container">
		<form action="login.do" method="post">
			<h1>Login</h1>
			<div class="form-group">
				<label for="id">ID:</label> <input type="text" class="form-control"
					placeholder="ID 입력" id="id" name="id" autocomplete="off">
			</div>
			<div class="form-group">
				<label for="pw">Password:</label> <input type="password"
					class="form-control" placeholder="Password 입력" id="pw" name="pw">
			</div>
			<button type="submit" class="loginBtn">Login</button>
		</form>
	</div>
</body>
</html>
