<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- start to modal -->
<div class="modal" id="tripPlanModal">
	<div class="modal-dialog">
		<div class="modal-content">
		
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">여행 떠나기</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			
			<form method="post">
				<!-- Modal body -->
				<div class="modal-body">
					<!-- 여행 기간 설정 -->
					<div class="form-group">
						<label for="tripCity">날짜 또는 여행 기간</label>
						<button type="button" class="btn btn-block" id="tripPeriodBtn" 
							style="border:1px solid #d1d3e2; text-align: left">
							<span>여행 기간이 어떻게 되시나요?</span>
						</button>
<!-- 						<div class="datepicker"> -->
<!-- 							<input id="tripStartDate" name="tripStartDate" type="hidden" value=""> -->
<!-- 							<input id="tripEndDate" name="tripEndDate" type="hidden" value=""> -->
<!-- 						</div> -->
					</div>
					<div class="form-group">
						<label for="tripThema">여행 이름</label>
						<input class="form-control" placeholder="ex.파리로 떠나는 가을 휴가" 
							id="tripThema" name="tripThema" required maxlength="80">
					</div>
					<!-- 여행지 검색 구간 -->
					<div class="form-group">
						<label for="cityNum">여행지</label>
						<input type="hidden" id="cityNum" name="cityNum" value="">
						<button type="button" class="btn btn-block" id="citySearchBtn" 
							style="border:1px solid #d1d3e2; text-align: left">
							<span>여행을 어디로 떠나시나요?</span>
						</button>
						<!-- 여행 도시 게시판 리스트 + 버튼 추가 -->
						<!-- Ajax 로 로드하기 -->
					</div>
					<div class="form-group">
						<label for="tripComment">설명(선택사항)</label>
						<textarea class="form-control" id="tripComment" name="tripComment" maxlength="1000"
							rows="2"></textarea>
					</div>
				</div>
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="submit" class="btn btn-dark" 
						style="width: 80px;" id="modalMultiBtn">Go</button>
					<button type="button" class="btn btn-outline-secondary" 
						style="width: 80px;" data-dismiss="modal">cancel</button>
				</div>
			</form>
		
		</div>
	</div>
</div>
<!-- end of modal -->
