<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 로그아웃 모달 -->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<img src="/uploads/logo2.PNG"
					style="width: 180px; height: 50px; margin: 0;">
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">
				더 좋은 여행 정보를 놓치실 수 있습니다. <br> 그래도 로그아웃하시겠습니까?
			</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
				<button id="logoutBtn" class="btn btn-primary">로그아웃</button>
			</div>
		</div>
	</div>
</div>

<script>
  $(document).ready(function() {
    $('#logoutBtn').click(function() {
      $.ajax({
        url: '/auth/logout.do', // 로그아웃을 처리하는 서버 URL
        type: 'POST',
        success: function(response) {
          // 로그아웃 성공 후 처리
          window.location.href = '/main/main.do'; // 메인 페이지로 리다이렉트
        },
        error: function(xhr, status, error) {
          // 로그아웃 실패 시 처리
          alert('로그아웃 중 오류가 발생했습니다.');
        }
      });
    });
  });
</script>
