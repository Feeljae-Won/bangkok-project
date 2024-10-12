import { badWords } from './badWords.js';

const BadWordFilter = {
    check: function(text) {
        return badWords.some(badWord => text.includes(badWord));
    },

    blankCheck: function(text) {
        return text.trim().length === 0;
    },

    patternCheck: function(text) {
        const pattern = /^(?=.*[a-z가-힣])[a-z0-9가-힣]{2,16}$/;
        return pattern.test(text);
    },

    passwordPatternCheck: function(text) {
        const pattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{4,20}$/;
        return pattern.test(text);
    },

    emailPatternCheck: function(text) {
        const pattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return pattern.test(text);
    }
};



document.addEventListener('DOMContentLoaded', function() {
    const unameInput = document.getElementById('uname');
    const unameResultInvalid = document.getElementById('unameResult');
    const unameResultValid = document.getElementById('unameResultValid');

    const pwdInput = document.getElementById('password');
    const pwdResultInvalid = document.getElementById('pwdResult');
    const pwdResultValid = document.getElementById('pwdResultValid');

    const confirmPwdInput = document.getElementById('confirm-pwd');
    const confirmPwdResultInvalid = document.getElementById('confirmPwdResult');
    const confirmPwdResultValid = document.getElementById('confirmPwdResultValid');

    const emailInput = document.getElementById('email');
    const emailResultInvalid = document.getElementById('emailResult');
    const emailResultValid = document.getElementById('emailResultValid');

    const checkEmailButton = document.getElementById('checkEmailButton');
    const checkNicknameButton = document.getElementById('checkNicknameButton');

    // 사용자 이름 유효성 검사
    if (unameInput && unameResultInvalid && unameResultValid) {
        unameInput.addEventListener('input', function() {
            const text = unameInput.value;
            const hasBadWords = BadWordFilter.check(text);
            const isBlank = BadWordFilter.blankCheck(text);
            const isValidPattern = BadWordFilter.patternCheck(text);

            unameInput.classList.remove('is-valid', 'is-invalid');
            unameResultInvalid.style.display = 'none';
            unameResultValid.style.display = 'none';

            if (isBlank) {
                unameInput.classList.add('is-invalid');
                unameResultInvalid.textContent = '닉네임을 입력해 주세요.';
                unameResultInvalid.style.display = 'block';
            } else if (hasBadWords) {
                unameInput.classList.add('is-invalid');
                unameResultInvalid.textContent = '비속어가 포함되어 있습니다!';
                unameResultInvalid.style.display = 'block';
            } else if (!isValidPattern) {
                unameInput.classList.add('is-invalid');
                unameResultInvalid.textContent = '2자 이상 16자 이하, 영어/숫자/한글만 가능합니다.';
                unameResultInvalid.style.display = 'block';
            } else {
                unameInput.classList.add('is-valid');
                unameResultValid.textContent = '닉네임 사용 가능.';
                unameResultValid.style.display = 'block';
            }
        });
    } else {
        console.error('닉네임 입력 필드 또는 결과 요소를 찾을 수 없습니다.');
    }

    // 비밀번호 유효성 검사
    if (pwdInput && pwdResultInvalid && pwdResultValid) {
        pwdInput.addEventListener('input', function() {
            const text = pwdInput.value;
            const isBlank = BadWordFilter.blankCheck(text);
            const isValidPattern = BadWordFilter.passwordPatternCheck(text);

            pwdInput.classList.remove('is-valid', 'is-invalid');
            pwdResultInvalid.style.display = 'none';
            pwdResultValid.style.display = 'none';

            if (isBlank) {
                pwdInput.classList.add('is-invalid');
                pwdResultInvalid.textContent = '비밀번호를 입력해 주세요.';
                pwdResultInvalid.style.display = 'block';
            } else if (!isValidPattern) {
                pwdInput.classList.add('is-invalid');
                pwdResultInvalid.textContent = '4자 이상 20자 이하, 영어/숫자/특수문자를 포함해야 합니다.';
                pwdResultInvalid.style.display = 'block';
            } else {
                pwdInput.classList.add('is-valid');
                pwdResultValid.textContent = '비밀번호 사용 가능.';
                pwdResultValid.style.display = 'block';
            }
        });
    } else {
        console.error('비밀번호 입력 필드 또는 결과 요소를 찾을 수 없습니다.');
    }

    // 비밀번호 확인 유효성 검사
    if (confirmPwdInput && confirmPwdResultInvalid && confirmPwdResultValid && pwdInput) {
        confirmPwdInput.addEventListener('input', function() {
            const text = confirmPwdInput.value;
            const pwdText = pwdInput.value;

            confirmPwdInput.classList.remove('is-valid', 'is-invalid');
            confirmPwdResultInvalid.style.display = 'none';
            confirmPwdResultValid.style.display = 'none';

            if (text !== pwdText) {
                confirmPwdInput.classList.add('is-invalid');
                confirmPwdResultInvalid.textContent = '비밀번호가 일치하지 않습니다.';
                confirmPwdResultInvalid.style.display = 'block';
            } else {
                confirmPwdInput.classList.add('is-valid');
                confirmPwdResultValid.textContent = '비밀번호가 일치합니다.';
                confirmPwdResultValid.style.display = 'block';
            }
        });
    } else {
        console.error('비밀번호 확인 입력 필드 또는 결과 요소를 찾을 수 없습니다.');
    }

    // 이메일 유효성 검사
    if (checkEmailButton && emailInput && emailResultInvalid && emailResultValid) {
        checkEmailButton.addEventListener('click', checkEmail);
    } else {
        console.error('이메일 입력 필드, 중복확인 버튼 또는 결과 요소를 찾을 수 없습니다.');
    }

    // 닉네임 유효성 검사
    if (checkNicknameButton && unameInput && unameResultInvalid && unameResultValid) {
        checkNicknameButton.addEventListener('click', checkNickname);
    } else {
        console.error('닉네임 입력 필드, 중복확인 버튼 또는 결과 요소를 찾을 수 없습니다.');
    }

    // 비밀번호 가시성 토글
    const togglePasswordVisibility = (passwordFieldId, iconElement) => {
        const passwordField = document.getElementById(passwordFieldId);
        const toggleIcon = document.querySelector(`#${iconElement} i`);

        document.getElementById(iconElement).addEventListener('click', function() {
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordField.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        });
    };

    togglePasswordVisibility('password', 'togglePassword');
    togglePasswordVisibility('confirm-pwd', 'toggleConfirmPassword');
    
// 모듈이 로드될 때 함수들을 전역에 등록
window.checkNickname = checkNickname;
window.checkEmail = checkEmail;
});
    