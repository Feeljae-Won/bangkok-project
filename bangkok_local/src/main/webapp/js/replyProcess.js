/**
 * replyService 객체를 이용한 댓글 처리 코드
 */

// 댓글 리스트를 가져와서 화면에 표시하는 함수
function showList(page) {
    replyService.list(page, function(data) {
    // JSON인데 배열과 페이지 오브젝트를 받는다. 
 	// data의 구조 - {list[],pageObject} - 리스트배열과 페이지 오브젝트
        let list = data.list; // 댓글 리스트만 추출
        // ul tag안에 들어가는 문자열
        let str = "";

        // 데이터가 없는 경우 처리
        if (list == null || list.length === 0) {
            $(".chat").html("<div> 데이터가 존재하지 않습니다.</div>");
            $(".pagination").html(""); // 댓글의 페이지는 만들지 않는다.
            return;
        }

        // 데이터가 있는 경우 댓글 리스트 HTML 생성
        // 부트스트랩 4 사용
        for (let i = 0; i < list.length; i++) {
            str += "<li class='left clearfix' data-rno='" + list[i].rno + "' style='border-bottom: 1px solid #ccc; padding-bottom: 10px; margin-bottom: 10px;'>";
            str += "<div>";
            str += "<div class='header'>";
            str += "<strong class='primary-font'>" + list[i].name + " (" + list[i].id + ")</strong>";
            str += "<small class='pull-right text-muted'>" + toDateTime(list[i].writeDate) + "</small>";
            str += "</div>";
         	str += "<p><pre class='replyContent' style=\"font-family: 'goorm-sans-code';\">" + list[i].content + "</pre></p>";
            str += "</div>";
            
            // 로그인한 사용자의 댓글인 경우 수정/삭제 버튼 추가
            if (id === list[i].id) {
                str += "<div>";
                str += "<button class='replyUpdateBtn btn btn-success btn-sm'>수정</button>";
                str += "<button class='replyDeleteBtn btn btn-danger btn-sm'>삭제</button>";
                str += "</div>";
            }

            str += "</li>";
        }

        // 생성된 HTML을 .chat 요소에 삽입
        $(".chat").html(str);
        // ----- 페이지에 대한 출력
        $(".pagination").html(replyPagination(data.pageObject));
    });
}

// 초기 댓글 리스트 표시
showList(1);

// HTML 문서가 로딩된 후 실행되는 이벤트 처리
$(function() {
    // 새로운 댓글 등록 모달창 이벤트
    $("#newReplyBtn").click(function() {
    
    // 버튼 처리 - 등록이니까 등록버튼이 보이고 수정 버튼은 안보이게
       $("#replyWriteBtn").show();
       $("#replyUpdateBtn").hide();
       
        $("#replyModal .modal-title").text("댓글 등록");
        $("#replyContent").val(""); // 댓글 내용 초기화
    });

    // 댓글 등록 모달창에서의 댓글 등록 처리
    $("#replyWriteBtn").click(function() {
        // 댓글 등록에 필요한 데이터 수집
        let reply = {
            no: no,
            content: $("#replyContent").val()
        };

        // 댓글 등록 요청
        replyService.write(reply, function(result) {
            // 등록 성공 시 모달창 닫기 및 메시지 표시
            $("#replyModal").modal("hide");
            $("#msgModal .modal-body").text(result);
            $("#msgModal").modal("show");

            // 댓글 리스트를 다시 불러와서 업데이트
            showList(1);
        });
    });

    // 댓글 수정 버튼 클릭 이벤트 (추가적인 기능 구현 필요)
    // 맨 앞에 선택자는 새로 만들어진게 아닌 원래 있었던 객체를 선택해주세요.
    // 그 앞에 만들어진 HTML에서 find()를 이용해서 다시 찾아서 함수를 전달하는 방식 
    $(document).on("click", ".replyUpdateBtn", function() {
       // alert("수정 버튼 클릭됨");
       
       // 버튼 처리 - 수정이니까 수정버튼이 보이고 등록 버튼은 안보이게
       $("#replyWriteBtn").hide();
       $("#replyUpdateBtn").show();
       
        let li = $(this).closest("li");
        $("#replyModal .modal-title").text("댓글 수정");
        $("#replyRno").val(li.data("rno")); // 댓글번호 채우기
        $("#replyContent").val(li.find(".replyContent").text()); // 댓글 내용 채우기
        $("#replyModal").modal("show");
    });

	// (Modal-수정버튼)수정 처리 이벤트
	$("#replyUpdateBtn").click(function(){
		// 1. 데이터 수집 -> JSON으로 만들어서 처리. (rno , content 수집)
		// input태그 가져오기 데이터는 val() 메서드로 .
		let reply = {rno : $("#replyRno").val(), content : $("#replyContent").val()};
		
		// 처리 - replyService 객체 사용
		replyService.update(
			reply, // 서버에 전달되는 데이터
			function(result){	// 성공 함수
			 // 성공 시 모달창 닫기 및 메시지 표시
            $("#replyModal").modal("hide");
            $("#msgModal .modal-body").text(result);
            $("#msgModal").modal("show");
              // 댓글 리스트를 다시 불러와서 업데이트
            showList(replyPage);
			}
		);
		
	});


   // 댓글 삭제 버튼 클릭 이벤트
$(document).on("click", ".replyDeleteBtn", function() {
    // 삭제 확인
    if (!confirm("정말 삭제 하시겠습니까?")) {
        return; // 삭제를 취소한 경우 함수 종료
    }
    
    // 댓글 번호(rno) 수집
    var rno = $(this).closest("li").data("rno");
    
    // 삭제 처리
    replyService.delete(rno, function(result) {
        // 성공 시 모달창 닫기 및 메시지 표시
        $("#replyModal").modal("hide");
        $("#msgModal .modal-body").text(result);
        $("#msgModal").modal("show");
        
        // 댓글 리스트를 다시 불러와서 업데이트
        showList(1);
    });
});

// 댓글 페이지 네이션 이벤트 처리
	$(".pagination").on("click","a",function(){
		//alert("페이지 클릭");
	let page = $(this).parent().data("page");
	// replyPage : 현재 페이지
	// page = 이전 페이지
	//	if(page == replyPage)
	//		alert("이동 페이지(이동안함) : " + page);
	//	else 
	//		alert("이동 페이지(이동함) : " + page);
		// 다른 페이지 경우
		if(page != replyPage) {
			alert("이동 페이지(이동함) : " + page);
			replyPage = page;
			showList(replyPage);
		}
	return false; // a 태그는 동작이 되면 안되니까 false로 리턴
	});
        
});
