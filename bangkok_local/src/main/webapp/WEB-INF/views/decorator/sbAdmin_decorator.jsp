
<!-- sitemesh 사용을 위한 설정 파일 -->
<!-- 작성자 : 함수진 -->
<!-- 작성일 : 2024-06-28 -->
<!-- 최종수정일 : 2024-09-10 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>

<!DOCTYPE html>
<html>
<head>
<!-- Google API 클라이언트 라이브러리 로드 -->
<meta name="google-signin-client_id"
	content="862325386717-j1pfdincqeu0qo2991glaj4u72bm96vr.apps.googleusercontent.com">
<script src="https://accounts.google.com/gsi/client" async defer></script>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>BANGKOK:<decorator:title /></title>

<!-- Custom fonts for this template -->
<link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link href="/css/sb-admin-2.min.css" rel="stylesheet">

<!-- Bootstrap core JavaScript -->
<script src="/vendor/jquery/jquery.min.js"></script>
<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- datepicker - jquery ui 라이브러리 -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>

<!-- 아이콘 라이브러리 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<script src="https://kit.fontawesome.com/a076d05399.js"
	crossorigin="anonymous"></script>

<!-- 토스 API -->
<script src="https://js.tosspayments.com/v2/standard"></script>
<script type="text/javascript">
	// 처리 결과 모달창 표시
	$(document).ready(function() {
		// 메시지가 있을 때 모달을 표시
		<c:if test="${ !empty msg }">
			$("#msgModal").modal("show");
		</c:if>
		// 로그인 버튼 클릭 시 모달 열기
	    $("#loginButton").click(function() {
	        $("#loginModal").modal("show");
	    });

	    // 이메일로 진행하기 버튼 클릭 시 초기 화면에서 로그인 화면으로 전환
	    $("#proceedWithEmail").click(function() {
	        $("#initialModalBody").addClass("d-none");
	        $("#loginModalBody").removeClass("d-none");
	    });

	    // 뒤로가기 버튼 클릭 시 로그인 화면에서 초기 화면으로 전환
	    $("#backToInitial").click(function() {
	        $("#loginModalBody").addClass("d-none");
	        $("#initialModalBody").removeClass("d-none");
	    });

	    // 모달 닫기 시 폼 리셋 및 초기 상태로 복귀
	    $('#loginModal').on('hidden.bs.modal', function() {
	        $(this).find('form')[0].reset();
	        $("#initialModalBody").removeClass("d-none");
	        $("#loginModalBody").addClass("d-none");
	    });
		// 취소 이벤트
		$(".cancleBtn").click(function() {
			location.href = "/main.do";
		});
		
// 		//멤버 뷰 이벤트
		$("#profileBtn").click(function() {
			let email = "${login.email}";
			//console.log(email);
			
			let formTag = `
				<form action="/member/view.do" method="post" id="profileForm">
					<input type="hidden" name="email" value="\${email}">
				</form>
			`;
			
			$("body").append(formTag);
			
			$("#profileForm").submit();
		});
// 구글 멤버 뷰 이벤트
$("#profileBtn").click(function() {
    // 로그인 상태에서 세션 정보를 통해 이메일을 가져오는 방법을 사용
    let email = "${sessionScope.user.email}"; // Spring에서 제공하는 sessionScope를 사용한 예시
    if (!email) {
        console.error("Email is not set");
        return;
    }

    let formTag = `
        <form action="/member/view.do" method="post" id="profileForm">
            <input type="hidden" name="email" value="${email}">
        </form>
    `;
    
    $("body").append(formTag);
    $("#profileForm").submit();
});


		
		//오피스 뷰 이벤트
		$("#officeBtn").click(function() {
			let email = "${login.email}";
			//console.log(email);
			
			let formTag = `
				<form action="/member/bisView.do" method="post" id="officeForm">
					<input type="hidden" name="email" value="\${email}">
				</form>
			`;
			
			$("body").append(formTag);
			
			$("#officeForm").submit();
		});
		
		
	});
</script>

<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');

@font-face {
    font-family: 'Pretendard-Regular';
    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
    font-weight: 300;
    font-style: normal;
}
@font-face {
	font-family: 'goorm-sans-code';
	src:
		url('https://fastly.jsdelivr.net/gh/projectnoonnu/2408@1.0/goorm-sans-code.woff2')
		format('woff2');
	font-weight: normal;
	font-style: normal;
}

.nav-item {
	font-family: 'goorm-sans-code';
}

.rounded-circle {
	width: 30px; /* 원하는 너비 */
	height: 30px; /* 원하는 높이, 원형으로 보이기 위해 너비와 같게 설정 */
	border-radius: 50%; /* 원형으로 만들기 */
	object-fit: cover; /* 이미지 비율 유지하면서 잘림 */
	overflow: hidden; /* 이미지가 원형 밖으로 나가지 않게 설정 */
}
content{
margin: 0 auto;
background: white;
}
</style>

<decorator:head />
</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar" style="background: #ff8533;">

			<!-- Sidebar - Brand -->
			<a
				class="sidebar-brand d-flex align-items-center justify-content-center"
				href="/main/main.do">
				<div class="sidebar-brand-icon">
					<i class='fab fa-telegram-plane'></i>
				</div>
				<div class="sidebar-brand-text mx-3">
					BANGKOK <sup>trip</sup>
				</div>
			</a>

			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->
			<li class="nav-item"><a class="nav-link" href="/info/list.do">
					<i class="fa fa-star"></i><span style="margin-left: 10px;">Activity</span>
			</a></li>

			<li class="nav-item"><a class="nav-link" href="/plan/list.do"><i
					class="fa fa-pencil"></i><span style="margin-left: 10px;">Trip
						Diary</span></a></li>
			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<!-- 			<div class="sidebar-heading">AIR</div> -->
			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseTwo"
				aria-expanded="true" aria-controls="collapseTwo"> <i
					class="fa fa-building"></i><span style="margin-left: 10px;">HOTEL</span>
			</a>
				<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
					data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<a class="collapse-item" href="/hotel/list.do">호텔검색</a> <a
							class="collapse-item" href="/hotel_reservations/list.do">예약내역</a>
					</div>
				</div></li>

			<!-- Nav Item - Utilities Collapse Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseUtilities"
				aria-expanded="true" aria-controls="collapseUtilities"> <i
					class="fa fa-plane"></i><span style="margin-left: 10px;">AIR</span>
			</a>
				<div id="collapseUtilities" class="collapse"
					aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<a class="collapse-item" href="/air/main.do">여행검색</a> <a
							class="collapse-item" href="/airReservation/list.do">예약내역</a>
					</div>
				</div></li>

			<!-- Divider -->
			<hr class="sidebar-divider">
			<!-- Nav Item - EVENT -->
			<li class="nav-item"><a class="nav-link event" href="/event/list.do">
					<i class="fa fa-bullhorn"></i><span style="margin-left: 10px;">EVENT</span>
			</a></li>
			<!-- Nav Item - Pages Collapse Menu -->
			<c:if test="${login.gradeNo == 9 }">
				<li class="nav-item"><a class="nav-link collapsed" href="#"
					data-toggle="collapse" data-target="#collapsePages"
					aria-expanded="true" aria-controls="collapsePages"><i
						class='far fa-address-card'></i><span style="margin-left: 10px;">MEMBERS</span>
				</a>
					<div id="collapsePages" class="collapse"
						aria-labelledby="headingPages" data-parent="#accordionSidebar">
						<div class="bg-white py-2 collapse-inner rounded">
							<a class="collapse-item" href="/member/memberList.do">회원 리스트</a>
						</div>
					</div></li>
			</c:if>

			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">

			<!-- Sidebar Toggler (Sidebar) -->
			<div class="text-center d-none d-md-inline">
				<button class="rounded-circle border-0" id="sidebarToggle"></button>
			</div>

		</ul>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

					<!-- Sidebar Toggle (Topbar) -->
					<button id="sidebarToggleTop"
						class="btn btn-link d-md-none rounded-circle mr-3">
						<i class="fa fa-bars"></i>
					</button>

					<!-- Topbar Navbar -->
					<ul class="navbar-nav ml-auto">

						<!-- Nav Item - Search Dropdown (Visible Only XS) -->
						<li class="nav-item dropdown no-arrow d-sm-none"><a
							class="nav-link dropdown-toggle" href="#" id="searchDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <i class="fas fa-search fa-fw"></i>
						</a> <!-- Search Dropdown Content Here --></li>

						<!-- Nav Item - User Information -->
						<li class="nav-item dropdown no-arrow"><a
							class="nav-link dropdown-toggle" href="#" id="userDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <!-- 사용자 정보 표시 --> <c:choose>
									<c:when test="${!empty user}">
										<!-- 구글 로그인 사용자 정보 표시 -->
										<span id="profileNickName"
											class="mr-2 d-none d-lg-inline text-gray-600 small">${user.name}님</span>
										<img id="profilePhoto" class="rounded-circle"
											src="${user.photo}" alt="Profile Picture">
									</c:when>
									<c:when test="${!empty login}">
										<!-- 일반 로그인 사용자 정보 표시 -->
										<span id="profileNickName"
											class="mr-2 d-none d-lg-inline text-gray-600 small">${login.nickName}님</span>
										<img id="profilePhoto" class="rounded-circle"
											src="${login.photo}" alt="Profile Picture">
									</c:when>
									<c:otherwise>
										<!-- 게스트 표시 -->
										<span class="mr-2 d-none d-lg-inline text-gray-600 small">Guest</span>
									</c:otherwise>
								</c:choose>
						</a> <!-- Dropdown Menu -->
							<div
								class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
								aria-labelledby="userDropdown">
								<c:choose>
									<c:when test="${!empty login || !empty user}">
										<!-- 로그인 사용자 메뉴 -->
										<a class="dropdown-item" id="profileBtn"> <i
											class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
											Profile
										</a>
										<c:if test="${!empty login && login.gradeNo == 5}">
											<a class="dropdown-item" id="officeBtn"> <i
												class="fas fa-building fa-sm fa-fw mr-2 text-gray-400"></i>
												Office
											</a>
										</c:if>
										<div class="dropdown-divider"></div>
										<a class="dropdown-item" href="#" data-toggle="modal"
											data-target="#logoutModal"> <i
											class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
											Logout
										</a>
									</c:when>
									<c:otherwise>
										<!-- 게스트 메뉴 -->
										<a class="dropdown-item" href="/member/joinForm.do"> <i
											class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> Join
										</a>
										<div class="dropdown-divider"></div>
										<a class="dropdown-item" href="#" data-toggle="modal"
											data-target="#loginModal"> <i
											class="fas fa-sign-in-alt fa-sm fa-fw mr-2 text-gray-400"></i>
											Login
										</a>
									</c:otherwise>
								</c:choose>
							</div></li>



					</ul>

				</nav>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">
					<decorator:body />
				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>
	<!-- Login Modal-->
	<jsp:include page="/WEB-INF/views/member/loginModal.jsp"></jsp:include>

	<!-- Logout Modal-->
	<jsp:include page="/WEB-INF/views/member/logoutModal.jsp"></jsp:include>

	<!-- Core plugin JavaScript-->
	<script src="/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="/js/sb-admin-2.min.js"></script>

	<!-- 메시지 모달 -->
	<div class="modal fade" id="msgModal" tabindex="-1" role="dialog"
		aria-labelledby="msgModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-body">
					<p>${msg}</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
    function initializeGoogleSignIn() {
        // Check if gapi is loaded
        if (typeof window.gapi !== 'undefined') {
            console.log('gapi is defined');
            
            gapi.load('auth2', function() {
                console.log('gapi.auth2 initialized');
                
                gapi.auth2.init({
                    client_id: '862325386717-j1pfdincqeu0qo2991glaj4u72bm96vr.apps.googleusercontent.com'
                }).then(function() {
                    console.log('Google Auth2 initialized');
                }).catch(function(error) {
                    console.log('Error initializing Google Auth2:', error);
                });
            });
        } else {
            console.log('gapi is not defined');
        }
    }

    // Check if Google Sign-In script is loaded
    function checkGapiLoaded() {
        if (typeof window.gapi !== 'undefined') {
            initializeGoogleSignIn();
        } else {
            console.log('Google Sign-In script not loaded yet');
        }
    }

    window.addEventListener('load', function() {
        checkGapiLoaded();
    });

    function handleCredentialResponse(response) {
        console.log('handleCredentialResponse called');
        const id_token = response.credential;
        if (id_token) {
            console.log('ID Token:', id_token);

            fetch('/auth/googleLogin.do', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ token: id_token })
            })
            .then(response => {
                console.log('서버 응답 상태:', response.status);
                if (!response.ok) {
                    throw new Error(`서버 응답 오류: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                console.log('서버 응답 데이터:', data);
                if (data.status === 'success') {
                    window.location.href = '/main/main.do';
                } else {
                    alert('구글 로그인에 실패했습니다: ' + (data.message || '알 수 없는 오류'));
                }
            })
            .catch(error => {
                console.error('로그인 중 에러 발생:', error);
                alert('로그인 중 에러가 발생했습니다. 나중에 다시 시도해 주세요.');
            });
        } else {
            console.log('No credential in response');
        }
    }
</script>

</html>