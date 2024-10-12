<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>이메일 찾기 결과</title>
<style>
    body {
       font-family: 'goorm-sans-code';
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
    }

    .container {
        max-width: 500px;
        margin: 100px auto;
        background-color: #ffffff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        text-align: center;
    }

    h2 {
        margin-bottom: 20px;
        color: #333;
    }

    .result {
        font-size: 18px;
        margin-bottom: 30px;
        color: #555;
        border: 1px solid #ddd;
        padding: 15px;
        border-radius: 4px;
        background-color: #fafafa;
    }

    .btn {
        display: inline-block;
        width: 100%;
        padding: 12px;
        background-color: #ff6600;
        border: none;
        border-radius: 5px;
        color: white;
        font-size: 16px;
        cursor: pointer;
        text-decoration: none;
        margin-top: 10px;
    }

    .btn:hover {
        background-color: #e65c00;
    }

    .btn-cancel {
        background-color: #ccc;
        margin-top: 10px;
        color: #333;
    }

    .btn-cancel:hover {
        background-color: #b3b3b3;
    }
</style>
</head>
<body>

    <div class="container">
        <h2>이메일 찾기 결과</h2>
        <div class="result">
            <label for="email">이메일 :</label>
            <div id="email">${email}</div>
        </div>
        <a href="/main/main.do" class="btn">돌아가기</a>
    </div>

</body>
</html>
