<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
$(function(){
	// 도시 항목 로드하기 by. ajax
	$(".cityListDiv").load("/city/list.do");
})
</script>

<!-- start to modal -->
<div class="modal" id="citySearchModal">
	<div class="modal-dialog">
		<div class="modal-content">
		
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">여행을 어디로 떠나시나요?</h4>
				<button type="button" class="close cancelBtn" data-dismiss="modal">&times;</button>
			</div>
			
			<!-- Modal body -->
			<div class="modal-body">
			<form action="/plan/list.do" id="citySearchForm">
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<select name="key" id="key" class="custom-select" style="border-right-radius: none;">
							<option value="c">나라</option>
							<option value="ct">도시</option>
						</select>
					</div>
					<input id="word" name="word" class="form-control" 
						placeholder="여행을 어디로 떠나시나요?">
					<div class="input-group-append">
						<button class="btn" type="button" 
							style="border:1px solid #ced4da; color:#cccccc;">
							<i class="fa fa-search"></i>
						</button>
					</div>
				</div>
			</form>
				
			<!-- 검색 리스트 -->
			<div class="cityListDiv">
				<!-- loading by. ajax -->
<%-- 				<c:forEach items="${cityList }" var="vo"> --%>
<!-- 					<div class="card mb-0 cityList" style="height:80px;"> -->
<%-- 						<input type='hidden' value='${vo.countryCode}' name="countryCode"> --%>
<!-- 						<div class="card-body" style="padding:10px;"> -->
<!-- 							<div class="img-thumbnail float-left"> -->
<%-- 								<img src="${vo.cityImg}" alt="cityImg" width="50" height="50"> --%>
<!-- 							</div> -->
<!-- 							<div class="float-left"  -->
<!-- 								style="width: 50%; margin-left: 10px;"> -->
<%-- 								<p style="font-weight:bold; font-size:15px;">${vo.cityName}, ${vo.countryKor}</p> --%>
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<%-- 				</c:forEach> --%>
			</div>
			</div>
			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-outline-secondary cancelBtn" 
					style="width: 80px;" data-dismiss="modal">cancel</button>
			</div>
		
		</div>
	</div>
</div>
<!-- end of modal -->