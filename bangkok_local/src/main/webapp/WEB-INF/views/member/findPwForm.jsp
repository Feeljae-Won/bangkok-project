<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>비밀번호 찾기</title>
<style>
.container {
    max-width: 500px;
    margin: 100px auto;
    background-color: #fff;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #333;
}

label {
    display: block;
    margin-bottom: 10px;
    font-weight: bold;
    color: #555;
}

input[type="text"],
input[type="email"],
input[type="tel"] {
    width: 100%;
    padding: 10px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
}

button {
    width: 100%;
    padding: 12px;
    background-color: #ff6600;
    border: none;
    border-radius: 5px;
    color: white;
    font-size: 16px;
    cursor: pointer;
}

button:hover {
    background-color: #e65c00;
}

.btn-cancel {
    background-color: #ccc;
    margin-top: 10px;
}

.btn-cancel:hover {
    background-color: #b3b3b3;
}
</style>
</head>
<body>

<div class="container">
    <h2>비밀번호 찾기</h2>
    <form action="/member/findPw.do" method="post">
        <div>
            <label for="name">이름</label>
            <input type="text" id="name" name="name" required>
        </div>
        <div>
            <label for="email">이메일</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div>
            <label for="tel">전화번호</label>
            <input type="text" id="tel" name="tel" required>
        </div>
        <button type="submit">비밀번호 찾기</button>
        <button type="button" class="btn-cancel" onclick="window.location.href='/main/main.do'">취소</button>
    </form>
    <div>${msg}</div> <!-- 결과 메시지 표시 -->
</div>

</body>
</html>
