/**
 * 일반 게시판 댓글 처리 객체
 */

// 이곳이 실행이 되는지 확인 할 수 있다.
console.log("Board Reply Module .........................");

// 일반 게시판 댓글을 처리하는 객체 선언 - jquery의 ajax 사용 : ajax(), getJSON(), get(), post()
let replyService = {

	// 1. 일반 게시판 댓글 리스트 처리 함수 - replyService.list(page, 성공함수, 실패함수);
	"list": function(page, callback, error) {
		console.log("댓글 리스트 ----------------------");
		// page가 없으면 1로 세팅한다.
		if (!page) page = 1;
		console.log("page : " + page + ", no : " + no);

		// ajax 형태를 만들어 처리한다. - getJSON()
		$.getJSON(
			"/boardreply/list.do?page=" + page + "&no=" + no,
			// 데이터 가져오기를 성공하면 실행되는 함수. data가 서버에서 넘겨주는 JSON 데이터
			function(data) {
				console.log(data);
				console.log(JSON.stringify(data));
				// callback이 있으면 실행 -> html tag를 만들어서 표시하는 함수 실행
				if (callback) callback(data);
			}
		).fail(function(xhr, status, err) {
			console.log("댓글 리스트 데이터 가져오기 오류 -------------------------------");
			console.log("xhr : " + xhr);
			console.log("status : " + status);
			console.log("err : " + err);
			// error가 있으면 실행
			if (error) error();
			else alert("댓글 데이터를 가져오는 중 오류 발생");
		});
	},

	// 2. 일반 게시판 댓글 등록 처리 함수 - replyService.write(댓글객체, 성공함수, 실패함수);
	"write": function(reply, callback, error) {
		console.log("댓글 등록 ----------------------");

		$.ajax({
			type: "post", // 데이터 전송 방식 postMapping이 받는다.
			url: "/boardreply/write.do", // 전송할 서버의 url
			data: JSON.stringify(reply), // 서버에 전송되는 데이터 : 자바 스크립트 객체 (JSON 데이터 형태) - url, header, body 중 body에 전송
			contentType: "application/json; charset=utf-8", // 서버에 전송되는 데이터 타입과 엔코딩의 대한 설정
			// 성공시 함수 선언
			// 댓글 등록 메세지 처리
			success: function(result, status, xhr) {
				if (callback) callback(result);
				// 없으면 alert으로 띄우자.
				else alert(result);
			},
			// 실패 했을 때 함수
			error: function(xhr, status, er) {
				console.log("xhr : " + xhr);
				console.log("status : " + status);
				console.log("er : " + er);
				if (error) error(er);
				else alert("댓글 등록에 실패했습니다.");
			}
		});
	},

	// 3. 일반 게시판 댓글 수정 처리 함수 - replyService.update(댓글객체, 성공함수, 실패함수);
	"update": function(reply, callback, error) {
		console.log("댓글 수정 ----------------------");

		$.ajax({
			type: "post", // 데이터 전송 방식 postMapping이 받는다.
			url: "/boardreply/update.do", // 전송할 서버의 url
			data: JSON.stringify(reply), // 서버에 전송되는 데이터 : body - rno,content
			contentType: "application/json; charset=utf-8", // 서버에 전송되는 데이터 타입과 엔코딩의 대한 설정
			// 성공시 함수 선언
			// 댓글 등록 메세지 처리
			success: function(result, status, xhr) {
				if (callback) callback(result);
				// 없으면 alert으로 띄우자.
				else alert(result);
			},
			// 실패 했을 때 함수
			error: function(xhr, status, er) {
				console.log("xhr : " + xhr);
				console.log("status : " + status);
				console.log("er : " + er);
				if (error) error(er);
				else alert("댓글 수정에 실패했습니다.");
			}
		});
	},

	// 일반 게시판 댓글 리스트 처리 함수 - replyService.delete(rno, 성공함수, 실패함수);
	"delete": function(rno, callback, error) {
		console.log("댓글 삭제 ----------------------");
		$.ajax({
			type: "get", // 데이터 전송 방식 GetMapping이 받는다.
			url: "/boardreply/delete.do?rno=" + rno, // 전송할 서버의 url : get방식으로, rno만 넘길시 ? 로 처리한다.
			// 성공시 함수 선언
			// 댓글 등록 메세지 처리
			success: function(result, status, xhr) {
				if (callback) callback(result);
				// 없으면 alert으로 띄우자.
				else alert(result);
			},
			// 실패 했을 때 함수
			error: function(xhr, status, er) {
				console.log("xhr : " + xhr);
				console.log("status : " + status);
				console.log("er : " + er);
				if (error) error(er);
				else alert("댓글 삭제를 실패했습니다.");
			}
		});
	}

};