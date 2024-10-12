<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
</head>
<body>
    <h1>비밀번호 재설정</h1>
<form action="/member/resetPw.do" method="post">
    <input type="hidden" name="token" value="${token}"/>
    새 비밀번호: <input type="password" name="pw" required/><br/>
    <input type="submit" value="비밀번호 변경"/>
</form>
    <div>${msg}</div> <!-- 메시지 표시 -->
</body>
</html>
