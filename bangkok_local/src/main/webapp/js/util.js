/**
 * JS Utility 프로그램 - 댓글의 페이지 네이션
 */

function replyPagination(pageObject) {
	let str = "";

	// 이전 페이지로 가는 버튼 (첫 페이지에서는 비활성화)
	str += "<li class=\"page-item";
	if (pageObject.page === 1) {
		str += " disabled\" style=\"pointer-events: none; cursor: default;\""; // disabled 상태의 스타일 추가
		str += " data-page=\"0\">";
		str += "<a class=\"page-link\" style=\"color: gray;\" href=\"#\">&laquo;</a></li>"; // 색상 회색으로 변경
	} else {
		str += "\" data-page=\"" + (pageObject.page - 1) + "\">";
		str += "<a class=\"page-link\" style=\"color: orange;\" href=\"#\">&laquo;</a></li>";
	}

	// 페이지 번호들
	for (let i = pageObject.startPage; i <= pageObject.endPage; i++) {
		str += "<li class=\"page-item";
		if (i === pageObject.page) { // 현재 페이지 액티브 설정
			str += " active";
		}
		str += "\" data-page=\"" + i + "\"><a class=\"page-link\" style=\"color: orange;\" href=\"#\">" + i + "</a></li>";
	}

	// 다음 페이지 - endPage가 10이면 11로 보내는 처리
	str += "<li class=\"page-item";
	if (pageObject.endPage >= pageObject.totalPage) str += " disabled ";
	str += "\" data-page=\"" + (pageObject.endPage + 1)
		+ "\"><a class=\"page-link\" href=\"#\">&raquo;</a></li>";

	return str;
}
