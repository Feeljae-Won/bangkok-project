<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.find {
	cursor: pointer;
}
.hr-text {
    border: none; /* 기본 경계 제거 */
    border-top: 1px solid #ccc; /* 상단 경계 */
    position: relative;
    text-align: center;
}

.hr-text::before {
    content: attr(data-content); /* data-content 속성 값 사용 */
    position: absolute;
    top: -10px; /* hr 위쪽에 위치 */
    left: 50%; /* 중앙 정렬 */
    transform: translateX(-50%); /* 중앙으로 이동 */
    background: white; /* 배경색 설정 (필요시) */
    padding: 0 10px; /* 좌우 여백 */
}
</style>
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
	aria-labelledby="loginModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<!-- 초기 화면 내용 -->
			<div class="modal-body" id="initialModalBody">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<div class="d-flex justify-content-center">
					<img src="/uploads/logo2.PNG" alt="Logo"
						style="max-width: 150px; max-height: 150px;">
				</div>
				<hr class="hr-text">
				<img src="/uploads/login2.png" alt="login"
					class="mx-auto d-block rounded"
					style="width: 450px; height: 250px; margin-bottom: 15px;">
				<h5
					style="font-family: 'goorm-sans-code'; font-weight: bold; margin-left: 10px;">로그인
					또는 회원가입</h5>
				<pre style="font-family: 'goorm-sans-code'; margin-left: 10px;">
BANGKOK에 로그인하면, 회원 전용 시크릿 특가를 확인하고
여행 계획을 편리하게 관리할 수 있습니다.
                </pre>
				<div
					style="display: flex; justify-content: center; align-items: center;">
					<button type="button" class="btn btn-outline-dark"
						id="proceedWithEmail" style="display: flex; align-items: center;">
						<i class="material-icons"
							style="font-size: 20px; margin-right: 8px;">email</i> 이메일로 진행하기
					</button>
				</div>
				<br>
				<div class="text-center my-3">
					<hr class="hr-text" data-content="또는">
				</div>
				<div class="d-flex justify-content-center">
					<div id="g_id_onload"
						data-client_id="862325386717-j1pfdincqeu0qo2991glaj4u72bm96vr.apps.googleusercontent.com"
						data-callback="handleCredentialResponse"></div>
					<div class="g_id_signin" data-type="standard"></div>
				</div>
			</div>
			<!-- 로그인 화면 내용 -->
			<div class="modal-body d-none" id="loginModalBody">
				<div class="d-flex justify-content-center">
					<img src="/uploads/logo2.PNG" alt="Logo"
						style="max-width: 150px; max-height: 150px;">
				</div>
				<hr class="hr-text">
				<h3
					style="font-family: 'goorm-sans-code'; font-weight: bold; display: flex; align-items: center; justify-content: center; position: relative;">
					<i class="material-icons" id="backToInitial"
						style="cursor: pointer; position: absolute; left: 0;">arrow_back</i>
					LOGIN
				</h3>
				<form action="/member/login.do" method="post">
					<div class="form-group">
						<label for="email">ID:</label> <input type="email"
							class="form-control" placeholder="ex) loginId@domain.com"
							id="email" name="email" autocomplete="off" required>
					</div>
					<div class="form-group">
						<label for="pw">Password:</label> <input type="password"
							class="form-control" placeholder="Password 입력" id="pw" name="pw"
							required>
					</div>
					<button type="submit"
						class="btn btn-outline-dark btn-block mb-2 LoginBtn">로그인</button>
				</form>
				<hr>
				<a href="/member/findPwForm.do" class="float-right find"
					style="color: #ff6600; font-family: 'goorm-sans-code'; font-size: small; text-decoration: none;">
					<i class="fa fa-unlock-alt"></i>&nbsp;비밀번호 찾기
				</a> <a href="/member/findEmailForm.do" class="float-left find"
					style="color: #ff6600; font-family: 'goorm-sans-code'; font-size: small; text-decoration: none;">
					<i class="fa fa-unlock-alt"></i>&nbsp;이메일 찾기
				</a>
			</div>
		</div>
	</div>
</div>
