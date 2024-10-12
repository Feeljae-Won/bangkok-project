<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 여행 상세보기 모달 -->
<!-- start to modal -->
<div class="modal" id="planDetailModal">
	<div class="modal-dialog">
		<div class="modal-content">
		
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">${planVO.place } <span style="font-size: 16px">${planVO.cate_name }</span></h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			
			<!-- Modal body -->
			<div class="modal-body">
				<!-- 여행지 사진 -->
				<div class="form-group">
					<div class="img-thumbnail form-control" style="border: 1px solid black; width:100%; height: 60%;">
						<img src="${planVO.imageFile }" alt="placeImg" width="100%" height="100%">
					</div>
				</div>
				<div class="form-group">
					<label for="tripDate">여행 날짜</label>
					<div class="form-control">
						<fmt:formatDate value="${planVO.tripDate }" pattern="yyyy년 MM월 dd일"/>
					</div>
				</div>
				<div class="form-group">
					<label for="tripDate">여행 시간</label>
					<input class="form-control" placeholder="${(!empty planVO.tripTime)?planVO.tripTime:'언제 갈까요?' }" readonly
						style="background: transparent;">
				</div>
				<div class="form-group">
					<label for="tripDate">세부 내용</label>
					<input class="form-control" placeholder="${(!empty planVO.planComment)?planVO.planComment:'세부 정보를 추가해 보세요.' }" readonly
						style="background: transparent;">
				</div>
			</div>
			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="submit" class="btn btn-dark" 
					style="width: 80px;" id="modalMultiBtn">Go</button>
				<button type="button" class="btn btn-outline-secondary" 
					style="width: 80px;" data-dismiss="modal">cancel</button>
			</div>
		
		</div>
	</div>
</div>
<!-- end of modal -->
