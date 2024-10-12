<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!-- 부트스트랩 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>

<!-- Popper.js (부트스트랩 모달에 필요) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>

<!-- 부트스트랩 JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<!-- 모달 구조 -->
<div class="modal fade" id="cancelModal" tabindex="-1" role="dialog" aria-labelledby="cancelModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content custom-modal"> <!-- 모달 스타일 적용 -->
      <div class="modal-body text-center"> <!-- 텍스트와 버튼을 중앙 정렬 -->
        <p>예약 내용을 정말 취소하시겠습니까?</p>
      </div>
      <div class="modal-footer justify-content-center"> <!-- 버튼을 중앙에 배치 -->
      <form action="delete.do" method="post" id="deleteForm">
     	<input type="hidden" value="${vo.reservation_no }" name="reservation_no">
        <button type="button" class="btn btn-secondary btn-lg mx-2" data-dismiss="modal" style="width: 120px;">취소</button>
        <button type="button" class="btn btn-primary btn-lg mx-2" id="cancelBtn"style="width: 120px;">확인</button>
        </form>
      </div>
    </div>
  </div>
</div>