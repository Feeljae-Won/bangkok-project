<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>편의시설</title>

<style>
  .amenities-card {
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    padding: 10px;
    margin-bottom: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
  }
  
  .amenities-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 12px rgba(0, 0, 0, 0.2);
  }

  .btn-primary {
    background-color: #007bff;
    border-color: #007bff;
  }

  .add-category-btn {
    display: flex;
    justify-content: flex-end; /* 오른쪽 정렬 */
    align-items: center;
    font-size: 1.5rem;
    color: #007bff;
    cursor: pointer;
  }

  .add-category-btn i {
    margin-right: 8px; /* 아이콘과 텍스트 간격 추가 */
  }

  .add-category-btn:hover {
    color: #0056b3;
  }
</style>

<script type="text/javascript">
$(function() {
    // + 버튼 클릭 시 모달을 띄우고 카테고리 추가 기능 실행
    $("#addCategoryBtn").click(function() {
        openModal("편의시설 추가", 0, "", "write.do", "추가");
    });
    
 // 대분류 수정 버튼
	$(".updateBtn").click(function(){
		// alert("대분류 수정 버튼");
		
		// 데이터 수집
		let amenitiesCard = $(this).closest(".amenities-card");
        let amenitiesNo = amenitiesCard.find("h4").data("amenitiesNo");
        let amenitiesName = amenitiesCard.find("h4").text().trim();
		
		return openModal("편의시설 수정", amenitiesNo, amenitiesName,
				"update.do", "수정");

	});
 
	// 편의시설 삭제 버튼
	$(".deleteBtn").click(function(){
		// alert("대분류 삭제 버튼");
		
		// 데이터 수집
		let amenitiesCard = $(this).closest(".amenities-card");
        let amenitiesNo = amenitiesCard.find("h4").data("amenitiesNo");
        let amenitiesName = amenitiesCard.find("h4").text().trim();
		
		return openModal("편의시설 삭제", amenitiesNo, amenitiesName,
				"delete.do", "삭제");

	});
	
	$(".btn-secondary").click(function() {
	    $("#categoryModal").modal("hide");
	});

    // 모달 처리 함수
    function openModal(title, amenitiesNo, amenitiesName, url, btnName) {
        // 모달 제목 설정
        $("#categoryModal .modal-title").text(title);
        // 데이터 초기화
        $("#modalAmenitiesNo").val(amenitiesNo);
        $("#modalAmenitiesName").val(amenitiesName);
        
        // form action 설정
        $("#modalForm").attr("action", url);
        
        // 버튼 이름 설정
        $("#submitBtn").text(btnName);
        
        // 모달 창 표시
        $("#categoryModal").modal("show");
        
        return false;
    }
});
</script>

</head>
<body>
<div class="container">
    <!-- 페이지 상단: 편의시설 리스트 -->
	<div class="row">
	  <div class="col-12 text-center mb-4">
	    <h2>편의시설 리스트</h2>
	    <span class="add-category-btn" id="addCategoryBtn">
		  등록<i class="fa fa-plus"></i>
		</span>
	  </div>
	</div>
		<div class="row">
	  <c:forEach items="${list }" var="vo">
	  	<div class="col-md-4">
	  		<div class="amenities-card">
	  			<h4 class="card-title" data-amenities-no="${vo.amenitiesNo}">${vo.amenitiesName}</h4>
	  			<p class="card-text"><strong>번호:</strong> ${vo.amenitiesNo }</p>
	  			<button class="btn btn-dark btn-sm updateBtn">수정</button>
	  			<button class="btn btn-danger deleteBtn">삭제</button>
	  		</div>
	  	</div>
	  </c:forEach>
	</div>

    <!-- 카테고리 추가 버튼 -->
	<div class="row mt-4">
	  <div class="col-12 d-flex justify-content-between align-items-center">
		
	  </div>
	</div>
</div>

<!-- 카테고리 추가 모달 -->
<div class="modal fade" id="categoryModal" tabindex="-1" aria-labelledby="categoryModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- 모달 헤더 -->
      <div class="modal-header">
        <h5 class="modal-title" id="categoryModalLabel">편의시설 추가</h5>
      </div>

      <!-- 모달 폼 -->
      <form method="post" id="modalForm">
        <input type="hidden" name="amenitiesNo" id="modalAmenitiesNo" value="0">
        
        <!-- 모달 바디 -->
        <div class="modal-body">
          <div class="mb-3">
            <label for="modalAmenitiesName" class="form-label">편의시설명</label>
            <input type="text" class="form-control" name="amenitiesName" id="modalAmenitiesName" required>
          </div>
        </div>

        <!-- 모달 풋터 -->
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary" id="submitBtn">추가</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        </div>
      </form>
    </div>
  </div>
</div>

</body>
</html>
