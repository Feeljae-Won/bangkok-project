<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>

<style>
  .card {
    width: 300px; /* 카드 너비 고정 */
    margin: 15px;
    position: relative;
    overflow: hidden; /* 자식 요소가 카드 밖으로 나가지 않도록 설정 */
}

.imageDiv {
    position: relative; /* 자식 요소의 절대 위치를 설정하기 위해 */
}

.card-img-top {
    width: 100%;
    height: 200px; /* 이미지 높이 고정 */
    object-fit: cover; /* 이미지 비율 유지 */
}

.card-title {
    position: absolute;
    left: 50%; /* 중앙 정렬을 위한 위치 설정 */
    top: 50%; /* 중앙 정렬을 위한 위치 설정 */
    transform: translate(-50%, -50%); /* 중앙 정렬을 위한 변환 */
    text-align: center;
    font-size: xx-large;
    font-family: 'goorm-sans-code';
    color: white; /* 텍스트 색상 */
    text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.7); /* 그림자 효과 */
    padding: 5px; /* 패딩 추가 */
}

</style>

<script type="text/javascript">
    $(function() {
        // 추가 JavaScript 코드
    });
</script>

<h4 style="margin-left: 18%; font-family: 'Pretendard-Regular'; margin-bottom: 20px;">여행정보</h4>
<div class="container">
    <c:forEach items="${infoList}" var="vo" varStatus="vs">
        <div class="col-md-4 dataRow" data-no="${vo.no}">
            <div class="card">
                <div class="imageDiv text-center align-content-center">
                    <img class="card-img-top" src="${vo.imageFile}">
                    <div class="card-title">
                        <span>${vo.cityname}</span>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
