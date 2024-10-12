<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
/* 기존 스타일 유지 */
article {
	padding-bottom: 50px;
	padding-top: 30px;
}

.container {
	width: 100%;
	max-width: 600px;
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
	background-color: #ffffff;
	box-sizing: border-box;
}

h3 {
	margin-bottom: 20px;
	color: #333;
	font-weight: 600;
	text-align: center;
}

.userForm {
	max-width: 500px;
	padding: 12px;
	border-radius: 6px;
	box-sizing: border-box;
	background-color: #fff;
	font-size: 16px;
	margin: 0 auto;
	display: block;
}

.btn-container {
	text-align: center;
}

.btnClass {
	border: none;
	border-radius: 6px;
	cursor: pointer;
	transition: background-color 0.3s, transform 0.2s;
}

.btnClass:hover {
	transform: translateY(-2px);
}

.result {
	color: #dc3545;
	font-size: 0.875em;
	margin-top: 10px;
}
/* 유효성 검사 결과 피드백 스타일 */
.valid-feedback, .invalid-feedback {
	display: none;
}

.is-valid ~ .valid-feedback {
	display: block;
	color: #28a745;
	font-size: 0.875em;
}

.is-invalid ~ .invalid-feedback {
	display: block;
	color: #dc3545;
	font-size: 0.875em;
}

.invalid-feedback, .valid-feedback {
	white-space: nowrap; /* 줄바꿈을 방지 */
	margin-left: 20px;
	margin-right: 0;
	text-align: left;
}

.hidden {
	display: none;
}

.input-container {
	position: relative;
}

.password-toggle {
	position: absolute;
	right: 15px; /* 아이콘을 왼쪽으로 이동 (값을 늘리면 더 왼쪽으로) */
	top: 50%;
	transform: translateY(-50%); /* 아이콘이 입력 필드 위에 오도록 설정 */
	cursor: pointer;
	z-index: 1;
}

.password-toggle i {
	pointer-events: none; /* 아이콘 클릭 이벤트를 방지 */
}

.form-check-inline {
	display: flex;
	align-items: center; /* 라디오 버튼과 텍스트를 수직 정렬 */
}
</style>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						var addr = '';
						var extraAddr = '';

						if (data.userSelectedType === 'R') {
							addr = data.roadAddress;
						} else {
							addr = data.jibunAddress;
						}

						if (data.userSelectedType === 'R') {
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}
						}

						document.getElementById('sample6_postcode').value = data.zonecode;
						document.getElementById('sample6_address').value = addr
								+ extraAddr;
						document.getElementById('sample6_detailAddress')
								.focus();

						document.getElementById("sample6_address").disabled = false;
						document.getElementById("sample6_detailAddress").disabled = false;
						document.getElementById("sample6_postcode").disabled = false;
					}
				}).open();
	}

	window.onload = function() {
		document.getElementById("sample6_postcode").disabled = true;
		document.getElementById("sample6_address").disabled = true;
		document.getElementById("sample6_detailAddress").disabled = true;

		// 초기 상태 설정
		toggleBusinessAddress();
	};

	function toggleBusinessAddress() {
		var isBusiness = document.getElementById('bissnice').checked;
		var businessAddressFields = document
				.getElementById('businessAddressFields');
		if (isBusiness) {
			businessAddressFields.classList.remove('hidden');
		} else {
			businessAddressFields.classList.add('hidden');
		}
	}
</script>
<script type="text/javascript">
	//닉네임 중복 확인 함수

	// 이메일 중복 확인 함수
	function checkEmail() {
		const email = document.getElementById('email').value;
		const resultDiv = document.getElementById('emailResult');
		const resultValidDiv = document.getElementById('emailResultValid');
		const emailInput = document.getElementById('email');

		if (!email) {
			resultDiv.textContent = "이메일을 입력해주세요.";
			resultDiv.style.display = "block";
			resultValidDiv.style.display = "none";
			emailInput.classList.add('is-invalid');
			emailInput.classList.remove('is-valid');
			return;
		}

		$.ajax({
			type : "POST",
			url : "/ajax/checkEmail",
			data : {
				email : email
			},
			dataType : "json", // JSON 형식으로 응답 처리
			success : function(response) {
				console.log("Full Response:", response); // 응답 전체 로그 확인
				if (response) {
					resultDiv.textContent = "이메일이 이미 사용 중입니다."; // 이메일이 존재할 경우
					resultDiv.style.display = "block";
					resultValidDiv.style.display = "none";
					emailInput.classList.add('is-invalid');
					emailInput.classList.remove('is-valid');
				} else {
					resultValidDiv.textContent = "이메일 사용 가능"; // 이메일이 존재하지 않을 경우
					resultValidDiv.style.display = "block";
					resultDiv.style.display = "none";
					emailInput.classList.add('is-valid');
					emailInput.classList.remove('is-invalid');
				}
			},
			error : function(xhr, status, error) {
				console.error("AJAX 요청 오류:", status, error);
				resultDiv.textContent = "이메일 확인 중 오류가 발생했습니다.";
				resultDiv.style.display = "block";
				resultValidDiv.style.display = "none";
				emailInput.classList.add('is-invalid');
				emailInput.classList.remove('is-valid');
			}
		});
	}

	function checkNickname() {
		const nickName = document.querySelector('input[name="nickName"]').value;

		$.ajax({
			type : "POST",
			url : "/ajax/checkNickName",
			data : {
				nickName : nickName
			},
			dataType : "json", // JSON 형식으로 응답 처리
			success : function(response) {
				const resultDiv = document.getElementById('unameResult');
				console.log("Full Response:", response); // 응답 전체 로그 확인
				if (response) {
					resultDiv.textContent = "닉네임 사용 불가능"; // 닉네임이 존재할 경우
					resultDiv.style.color = 'red'; // 색상 변경 (선택 사항)
				} else {
					resultDiv.textContent = "닉네임 사용 가능"; // 닉네임이 존재하지 않을 경우
					resultDiv.style.color = 'green'; // 색상 변경 (선택 사항)
				}
			},
			error : function(xhr, status, error) {
				console.error("AJAX 요청 오류:", status, error);
				const resultDiv = document.getElementById('unameResult');
				resultDiv.textContent = "닉네임 확인 중 오류가 발생했습니다.";
				resultDiv.style.color = 'orange'; // 색상 변경 (선택 사항)
			}
		});
	}
</script>

<script type="text/javascript">
$(document).ready(function() {
    let yearRangeStart = 1900;
    let yearRangeEnd = new Date().getFullYear();

    $(".datepicker").datepicker({
        changeMonth: true,
        changeYear: true,
        dateFormat: "yy-mm-dd",
        maxDate: new Date(),
        yearRange: yearRangeStart + ":" + yearRangeEnd,
        beforeShow: function(input, inst) {
            // Show custom year dropdown
            const yearDropdown = $('<div class="custom-year-dropdown"></div>');
            for (let year = yearRangeEnd; year >= yearRangeStart; year--) {
                const yearOption = $('<div>' + year + '</div>').click(function() {
                    $(input).datepicker("setDate", new Date(year, new Date().getMonth(), new Date().getDate()));
                    yearDropdown.hide();
                });
                yearDropdown.append(yearOption);
            }
            $("body").append(yearDropdown);
            const offset = $(input).offset();
            yearDropdown.css({
                top: offset.top + $(input).outerHeight(),
                left: offset.left,
                width: $(input).outerWidth()
            }).show();
        },
        onClose: function() {
            $(".custom-year-dropdown").remove(); // Remove dropdown on close
            validateAge($(this).val());
        }
    });

    let isEligible = false; // 18세 이상인지 여부를 저장

    function validateAge(selectedDate) {
        const today = new Date();
        const birthDate = new Date(selectedDate);
        let age = today.getFullYear() - birthDate.getFullYear();
        const month = today.getMonth() - birthDate.getMonth();
        const day = today.getDate() - birthDate.getDate();

        if (month < 0 || (month === 0 && day < 0)) {
            age--;
        }

        isEligible = age >= 18; // 18세 이상인지 여부 업데이트
        $("#submitBtn").prop('disabled', !isEligible); // 버튼 상태 업데이트
    }

    // 가입 버튼에 마우스 오버 이벤트 추가
    $("#submitBtn").hover(function() {
        if (!isEligible) {
            const btnOffset = $(this).offset();
            $("#ageWarningTooltip").css({
                top: btnOffset.top - 40, // 버튼 위에 위치
                left: btnOffset.left,
            }).show(); // 툴팁 표시
        }
    }, function() {
        $("#ageWarningTooltip").hide(); // 마우스가 버튼을 벗어나면 툴팁 숨김
    });

    // 초기 상태로 버튼 비활성화
    $("#submitBtn").prop('disabled', true);
});

</script>

</head>
<body>
	<article>
		<div class="container">
			<h3>회원가입</h3>
			<hr>
			<form action="join.do" method="post" onsubmit="setGradeNo()"
				enctype="multipart/form-data">
				<!-- 라디오 버튼 -->
				<div class="text-center">
					<input type="radio" id="default" name="memberType"
						value="individual" checked onclick="toggleBusinessAddress()">
					<label for="default">개인</label> &nbsp;&nbsp;&nbsp; <input
						type="radio" id="bissnice" name="memberType" value="businessUser"
						onclick="toggleBusinessAddress()"> <label
						for="businessUser">사업자</label>
				</div>
				<!-- 입력폼 -->
				<div class="userForm">
					<div class="form-group user">
						<label for="name">이름:</label>
						<div class="input-container">
							<input id="name" name="name" class="form-control"
								placeholder="이름 입력">
						</div>
					</div>
					<div class="form-group user">
						<label for="email">이메일:</label>
						<div
							style="display: flex; justify-content: space-between; width: 100%; max-width: 500px; margin: 0 auto;">
							<input type="email" id="email" name="email" class="form-control"
								placeholder="ex) example@domain.com"
								style="margin-right: 5px; margin-left: 5px;"> <input
								type="button" onclick="checkEmail()" value="중복확인"
								class="btn btn-secondary btn-sm check-button">
						</div>
						<div id="emailResult" class="result-message"></div>
						<div id="emailResultValid" class="valid-feedback"></div>
					</div>


					<div class="form-group user">
						<label for="uname">닉네임:</label>
						<div
							style="display: flex; justify-content: space-between; width: 100%; max-width: 500px; margin: 0 auto;">
							<input type="text" class="form-control" id="uname"
								placeholder="닉네임 입력" name="nickName" required maxlength="30"
								style="margin-right: 5px; margin-left: 5px;">
							<!-- 닉네임 중복 확인 버튼 -->
							<input type="button" onclick="checkNickname()" value="중복확인"
								class="btn btn-secondary btn-sm check-button">
							<div id="unameResult" class="result-message"></div>
						</div>
						<div id="unameResult" class="invalid-feedback"></div>
						<div id="unameResultValid" class="valid-feedback"></div>
					</div>

					<div class="password-container">
						<div class="form-group user">
							<label for="password">비밀번호:</label>
							<div class="input-container">
								<input type="password" id="password" name="pw"
									class="form-control" placeholder="비밀번호 입력"> <span
									id="togglePassword" class="password-toggle "><i
									class="fa fa-eye" aria-hidden="true"></i> </span>
								<div id="pwdResult" class="invalid-feedback"></div>
								<div id="pwdResultValid" class="valid-feedback"></div>
							</div>
							<br>
							<div class="password-container">
								<div class="form-group user">
									<label for="confirm-pwd">비밀번호 확인:</label>
									<div class="input-container">
										<input type="password" class="form-control" id="confirm-pwd"
											placeholder="비밀번호 재입력" name="confirm-pwd" required> <span
											id="toggleConfirmPassword" class="password-toggle ml-5"><i
											class="fa fa-eye" aria-hidden="true"></i> </span>
										<div id="confirmPwdResult" class="invalid-feedback"></div>
										<div id="confirmPwdResultValid" class="valid-feedback"></div>
									</div>
								</div>
							</div>
							<!-- 성별 버튼 -->
							<label for="gender" class="mr-3">성별:</label>
							<div class="custom-control custom-radio custom-control-inline">
								<input type="radio" class="custom-control-input"
									id="customRadio" name="gender" value="남자"> <label
									class="custom-control-label" for="customRadio">남자</label>
							</div>
							<div class="custom-control custom-radio custom-control-inline">
								<input type="radio" class="custom-control-input"
									id="customRadio2" name="gender" value="여자"> <label
									class="custom-control-label" for="customRadio2">여자</label>
							</div>
							<div class="form-group user">
								<label for="birthDate" class="label">생년월일:</label>
								<div class="input-group">
									<div class="input-group-prepend">
										<span class="input-group-text"><i
											class="fa fa-calendar"></i></span>
									</div>
									<input class="form-control datepicker" id="birthDate"
										name="birth" required autocapitalize="off" readonly>
								</div>
								<div id="birthResult" class="invalid-feedback"></div>
							</div>

							<div class="form-group user">
								<label for="tel" class="label"> 연락처: </label> <input type="text"
									class="form-control" placeholder="'-'포함 입력" id="tel" name="tel">
							</div>
							<div class="form-group user">
								<label for="photoFile" class="label"> 프로필 사진: </label> <input
									type="file" class="form-control" placeholder="'-'포함 입력"
									id="photoFile" name=photoFile multiple accept="image/*">
							</div>
							<br>

							<!-- 사업자 정보 입력 -->

							<div id="businessAddressFields" class="form-group hidden">
								<hr class="sidebar-divider">
								<label for="address">사업장 주소:</label>
								<div
									style="display: flex; justify-content: space-between; width: 100%; max-width: 500px; margin: 0 auto;">
									<input type="text" id="sample6_postcode" class="form-control"
										name="post_code" disabled placeholder="우편번호"> <input
										type="button" onclick="sample6_execDaumPostcode()"
										value="우편번호 찾기" class="btn btn-secondary btn-sm"
										name="post_code">
								</div>
								<input type="text" id="sample6_address" class="form-control"
									name="office_adr" placeholder="주소" disabled> <input
									type="text" id="sample6_detailAddress" class="form-control"
									name="detail_adr" placeholder="상세주소" disabled><br>
								<div class="form-group">
									<label for="office_num" class="label"> 사업자 번호: </label> <input
										type="text" class="form-control" placeholder="'-'포함 입력"
										id="office_num" name="office_num">
								</div>
								<div class="form-group">
									<label for="office_Name" class="label"> 사업장 명: </label> <input
										type="text" class="form-control" placeholder="사업장 명 입력"
										id="office_Name" name="office_name">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="btn-container">
					<div id="ageWarningTooltip"
						style="display: none; position: absolute; background-color: #f8d7da; border: 1px solid #f5c6cb; border-radius: 5px; padding: 10px; z-index: 1000;">
						만 18세 이상만 가입 가능합니다.</div>
					<button type="submit" class="btn btn-warning btnClass"
						id="submitBtn">가입</button>
					<button type="reset" class="btn btn-secondary btnClass">다시작성</button>
					<button type="button" class="btn btn-secondary btnClass cancleBtn">취소</button>
				</div>
			</form>
		</div>
	</article>
	<!-- 스크립트 파일 -->
	<script type="module" src="/js/mainBadWord.js"></script>
	<script type="text/javascript">
		function setGradeNo() {
			var gradeNo;
			var memberType = document
					.querySelector('input[name="memberType"]:checked').value;
			if (memberType === 'businessUser') {
				gradeNo = 5;
			} else {
				gradeNo = 1;
			}
			// 폼의 hidden input에 gradeNo 값을 설정
			var gradeNoInput = document.createElement('input');
			gradeNoInput.type = 'hidden';
			gradeNoInput.name = 'gradeNo';
			gradeNoInput.value = gradeNo;
			document.querySelector('form').appendChild(gradeNoInput);
		}
	</script>
</body>
</html>
