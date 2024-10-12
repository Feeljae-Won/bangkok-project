<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>내 정보 보기</title>

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

/* 프로필 사진 */
.profile-img {
    display: block;
    margin: 0 auto;
    width: 150px;
    height: 150px;
    object-fit: cover;
    border-radius: 50%; /* 원형 이미지로 만들기 */
    border: 4px solid #ddd;
}

/* 정보 그리드 */
.info-grid {
    display: grid;
    grid-template-columns: 1fr 1fr; /* 2열 그리드 */
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
    display: block;
    margin-bottom: 5px;
    color: #555;
}

.info-grid div span {
    display: block;
    font-size: 16px;
    color: #333;
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

/* 반응형 미디어 쿼리 */
@media ( max-width : 768px) {
    .info-grid {
        grid-template-columns: 1fr; /* 1열로 변경 */
    }
}
</style>
</head>
<body>
    <div class="container">
        <h2 class="mt-3">Profile</h2>

        <!-- 프로필 사진 -->
        <img src="${vo.photo}" alt="프로필 사진" class="profile-img">

        <!-- 사용자 정보 그리드 -->
        <div class="info-grid">
            <div>
                <label>이메일</label> <span>${vo.email}</span>
            </div>
            <div>
                <label>닉네임</label> <span>${vo.nickName}</span>
            </div>
            <div>
                <label>이름</label> <span>${vo.name}</span>
            </div>
            <div>
                <label>생년월일</label> <span><fmt:formatDate value="${vo.birth}"
                        pattern="yyyy-MM-dd" /></span>
            </div>
            <div>
                <label>연락처</label> <span>${vo.tel}</span>
            </div>
            <div>
                <label>가입일</label><span><fmt:formatDate value="${vo.regDate}"
                        pattern="yyyy-MM-dd" /></span>
            </div>
            <div>
                <label>성별</label> <span>${vo.gender}</span>
            </div>
        </div>

            <div class="btn-group">
                <form class="form-group" action="/member/updateForm.do" method="get">
                    <input type="hidden" name="email" value="${vo.email}">
                    <button class="btn" id="updateBtn"
                        style="background: orange; color: white;">수정</button>
                </form>

                <form class="form-group-inline" action="delete.do" method="post">
                    <input type="hidden" name="email" value="${vo.email}">
                    <button class="btn" id="deleteBtn" type="submit"
                        style="background: red; color: white;">탈퇴</button>
                </form>
            </div>
    </div>
</body>
</html>
