<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>내 정보 수정</title>
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
	cursor: pointer; /* 클릭 가능하게 커서 변경 */
}

#fileInput {
	display: none; /* 파일 입력 숨기기 */
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

.info-grid div input {
	width: 100%;
	padding: 8px;
	box-sizing: border-box;
	border-radius: 5px;
	border: 1px solid #ddd;
	font-size: 16px;
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
/* 스타일링을 위한 CSS 클래스 예시 */
.input-field {
	margin-right: 10px;
}

.check-button {
	width: 30%;
	margin-right: 5px;
}

.result-message {
	margin-top: 10px;
}
</style>
<script>
	function triggerFileInput() {
		document.getElementById('fileInput').click();
	}

	function previewImage(event) {
		const reader = new FileReader();
		reader.onload = function() {
			const output = document.getElementById('profileImage');
			output.src = reader.result;
		}
		reader.readAsDataURL(event.target.files[0]);
	}

	function checkNickname() {
		const nickName = document.querySelector('input[name="nickName"]').value;

		$.ajax({
			type : "POST",
			url : "/ajax/checkNickName",
			data : {
				nickName : nickName
			},
			dataType : "json",
			success : function(response) {
				const resultDiv = document.getElementById('unameResult');
				if (response) {
					resultDiv.textContent = "닉네임 사용 불가능";
					resultDiv.style.color = 'red';
				} else {
					resultDiv.textContent = "닉네임 사용 가능";
					resultDiv.style.color = 'green';
				}
			},
			error : function(xhr, status, error) {
				console.error("AJAX 요청 오류:", status, error);
				const resultDiv = document.getElementById('unameResult');
				resultDiv.textContent = "닉네임 확인 중 오류가 발생했습니다.";
				resultDiv.style.color = 'orange';
			}
		});
	}
	$(document).ready(function() {
	    $('form').submit(function(event) {
	        event.preventDefault(); // 기본 폼 제출 방지
	        $.ajax({
	            url: $(this).attr('action'),
	            type: 'POST',
	            data: new FormData(this),
	            contentType: false,
	            processData: false,
	            dataType: 'text',
	            success: function(response) {
	                $('#msg').text(response);
	                $('#updateModal').modal('show');
	            },
	            error: function(xhr, status, error) {
	                console.error('AJAX 요청 오류:', status, error);
	                $('#msg').text("정보 업데이트에 실패했습니다.");
	                $('#updateModal').modal('show');
	            }
	        });
	    });

	    // 프로필 이미지 미리보기
	    $('#fileInput').change(function(event) {
	        previewImage(event);
	    });
	});


	function previewImage(event) {
		const reader = new FileReader();
		reader.onload = function() {
			const output = document.getElementById('profileImage');
			output.src = reader.result;
		}
		if (event.target.files[0]) {
			reader.readAsDataURL(event.target.files[0]);
		}
	}
</script>

</head>
<body>
	<div class="container">
		<h2 class="mt-3">Profile Update</h2>
		<form action="update.do" method="post" enctype="multipart/form-data">
			<!-- 프로필 사진 -->
			<input type="file" id="fileInput" name="photoFile" accept="image/*">
			<input type="hidden" name="existingPhoto" value="${vo.photo}">
			<img src="${vo.photo}" alt="프로필 사진" id="profileImage"
				class="profile-img" onclick="triggerFileInput()">

			<!-- 사용자 정보 그리드 -->
			<div class="info-grid">
				<input type="hidden" value="${vo.email }" name="email">
				<div>
					<label>닉네임</label> <input type="text" name="nickName"
						value="${vo.nickName}" class="input-field"> <input
						type="button" onclick="checkNickname()" value="중복확인"
						class="btn btn-secondary btn-sm check-button">
					<div id="unameResult" class="result-message"></div>
				</div>
				<div>
					<label>이름</label> <input type="text" name="name" value="${vo.name}">
				</div>
				<div>
					<label>생년월일</label> <input type="date" name="birth"
						value="<fmt:formatDate value='${vo.birth}' pattern='yyyy-MM-dd' />">
				</div>
				<div>
					<label>연락처</label> <input type="tel" name="tel" value="${vo.tel}">
				</div>
			</div>

			<!-- 버튼 중앙 배치 -->
			<div class="btn-group text-center" role="group">
				<button class="btn" id="updateBtn" type="submit"
					style="background: orange; color: white;">수정</button>
			</div>
		</form>
	</div>
	<!-- 모달 HTML -->
	<div id="updateModal" class="modal fade" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">알림</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p id="msg"></p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>


</body>
</html>
