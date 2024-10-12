<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
 <!-- Font Awesome CSS 추가 -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <meta charset="UTF-8">
  <title>후기 상세</title>


<style>

  .rating-section {
    margin: 20px 0;
  }
  .rating-section div {
    margin-bottom: 10px;
  }
  .stars {
    display: flex;
    justify-content: center;
  }
  .stars i {
    margin-right: 5px;
    font-size: 30px; /* 적절한 크기로 조정 */
    background: linear-gradient(to right, red, orange, yellow, green, blue, indigo, violet);
    -webkit-background-clip: text;
    color: transparent;
  }
  .review-section {
    text-align: center;
  }
  .review-section h6 {
    font-weight: bold;
    margin-top: 15px;
  }
  .review-section div {
    padding: 10px 0;
  }
</style>

<script type="text/javascript">
$(document).ready(function() {
    // 별점 설정 함수
    function setStars(starId, value) {
        let starsHtml = '';
        for (let i = 0; i < 5; i++) {
            if (i < value) {
                starsHtml += '<i class="fas fa-star" style="color: lemonchiffon;"></i>'; // 채워진 별
            } else {
                starsHtml += '<i class="far fa-star" style="color: lemonchiffon;"></i>'; // 빈 별
            }
        }
        $('#' + starId).html(starsHtml);
    }

    // 모달이 열릴 때 별점을 설정
    $('#reviewDetailModal').on('show.bs.modal', function () {
        setStars('star-service', 4);
        setStars('star-cleanliness', 3);
        setStars('star-facilities', 5);
        setStars('star-equipment', 2);
    });
});
</script>

</head>
<body>

<!-- 후기 상세 모달 버튼 -->
<div class="container text-center">
<button type="button" class="btn btn-primary" 
  data-toggle="modal" 
  data-target="#reviewDetailModal">
  후기 상세 보기
</button>
</div>

<!-- 후기 상세 모달 -->
<div class="modal fade" id="reviewDetailModal" tabindex="-1" role="dialog" aria-labelledby="reviewDetailModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        신라호텔 - 스탠다드
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <!-- 별점 섹션 -->
        <div class="rating-section">
          <div>
            <span>서비스 & 친절도: </span>
            <span class="stars" id="star-service"></span>
          </div>
          <div>
            <span>숙소 & 객실 청결도: </span>
            <span class="stars" id="star-cleanliness"></span>
          </div>
          <div>
            <span>시설 & 편의성: </span>
            <span class="stars" id="star-facilities"></span>
          </div>
          <div>
            <span>비품 & 용품 만족도: </span>
            <span class="stars" id="star-equipment"></span>
          </div>
        </div>
        
        <!-- 리뷰 제목 및 내용 -->
        <div class="review-section">
          <h6>리뷰 제목</h6>
          <div id="customReviewTitle">여기에 제목이 들어갑니다.</div>
          <h6>리뷰 내용</h6>
          <div id="customReviewContent">여기에 리뷰 내용이 들어갑니다.</div>
        </div>
      </div>
    </div>
  </div>
</div>

</body>
</html>
