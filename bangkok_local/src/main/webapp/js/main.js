$(function() {
	// 공항 버튼을 클릭했을 때 동작
	$('.airport').click(function() {
		
		// 새로 오픈 될 때 검색 데이터 지우기
		$("#searchAirport").val("");

		// '출발지 검색' 또는 '도착지 검색'에 맞게 텍스트를 설정
		if ($(this).attr('id') === 'departureAirport') {
			$('#airportList h5').text('출발지 검색');
			$('#searchAirport').data('target', 'departure'); // target 설정
		} else {
			$('#airportList h5').text('도착지 검색');
			$('#searchAirport').data('target', 'arrival'); // target 설정
		}

		// 현재 열려 있는 리스트가 있으면 닫기
// 		$('#airportList').hide();

		// 검색 리스트 초기화 및 열기
		$(this).append($('#airportList'));
		$('#airportList').css({
			top: $(this).outerHeight() + 'px',  // 공항 아이콘 아래에 위치
			left: 0  // 공항 아이콘의 왼쪽에 정렬
		}).show();

		// input 필드에 포커스를 줘서 커서가 잡히도록 함
		$('#airportList input').focus();
	});

	// 공항 리스트 외부를 클릭하면 닫기
	$(document).click(function(event) {
		// 공항 리스트, 공항 버튼, 입력 필드를 제외한 외부 클릭 시에만 닫기
		if (!$(event.target).closest('.airport, #airportList, input').length) {
			$('#airportList').hide();
		}
	});
	
	// 공항 데이터 검색
	$("#searchAirport").keyup(function() {
		let searchAirport = $(this).val();
		console.log("key up : " + searchAirport);
		
		// 입력 데이터 없을 때 처리
		if(searchAirport.length === 0) {
			$('#airportListResults').empty();
            return;
		};
		
		// AJAX 요청 보내기
        $.ajax({
            url: '/air/searchAirport', // 서버의 공항 검색 API URL
            type: 'GET',
            data: { searchAirport: searchAirport }, // 요청에 검색어 전달
            dataType: 'json', // 반환되는 데이터 타입을 명시
            success: function(data, status, xhr) {
            	
            	console.log(data);
                // 검색 결과를 받아온 후 처리
                $('#airportListResults').empty(); // 기존 결과를 초기화
                if(data.list && data.list.length > 0) {
                    // 검색된 공항 목록을 추가
                    $.each(data.list, function(index, airport) {
                        $('#airportListResults').append(
                        		'<p class="search-result" data-code="' + airport.airportCode + '" data-name="' 
                        		+ airport.airportKor + '" style="cursor: pointer;">'
                        		+ ' <i class="fa fa-plane" style="color:#E37027"></i> '
                                + airport.airportKor + ' (<b>' + airport.airportCode + '</b>) - ' 
                                + airport.countryKor + '(' + airport.pan + ')</p>'
                        );
                    });
                } else {
                    $('#airportListResults').append('<p>검색 결과가 없습니다.</p>');
                }
            },
            error: function(xhr, status, er) {
                // 오류 발생 시 처리
                $('#airportListResults').empty();
                $('#airportListResults').append('<p>오류가 발생했습니다.</p>');
            }
        });
	});
	
	// 검색된 공항 클릭 시 overlay에 반영
    $(document).on('click', '.search-result', function() {
        let selectedCode = $(this).data('code');  // 공항 코드
        let selectedName = $(this).data('name');  // 공항 이름
        
        // 선택한 공항을 반영할 target이 'departure'인지 'arrival'인지 확인
        if ($('#searchAirport').data('target') === 'departure') {
            $('#departure').text(selectedCode);
            $('#departureKor').text(selectedName);
            $('#dCode').val(selectedCode);
        } else if ($('#searchAirport').data('target') === 'arrival') {
            $('#arrival').text(selectedCode);
            $('#arrivalKor').text(selectedName);
            $('#aCode').val(selectedCode);
        }

        // 검색 결과 닫기
        $('#airportListResults').empty();
        $('#airportList').hide();
    });

    // 출발지 선택 시
    $('#departureAirport').click(function() {
        $('#searchAirport').data('target', 'departure');
        $('#airportList').show();
    });

    // 도착지 선택 시
    $('#arrivalAirport').click(function() {
        $('#searchAirport').data('target', 'arrival');
        $('#airportList').show();
    });
	
	// swap 버튼 클릭 시 출발 공항과 도착 공항의 데이터를 교체
	$('.swap-button').click(function() {
		// 출발 공항의 텍스트 정보
		let departureCode = $('#departure').text();
		let departureKor = $('#departureKor').text();
		
		// 도착 공항의 텍스트 정보
		let arrivalCode = $('#arrival').text();
		let arrivalKor = $('#arrivalKor').text();
		
		// 출발과 도착 정보를 서로 교환
		$('#departure').text(arrivalCode);
		$('#departureKor').text(arrivalKor);
		$("#dCode").val(arrivalCode);
		$('#arrival').text(departureCode);
		$('#arrivalKor').text(departureKor);
		$("#aCode").val(departureCode);
	});
	
	// 편도 - 왕복 - 다구간 변경
	$(".type").click(function() {
		$(".type").removeClass("active");
		
		let type = $(this).text();
		if(type == "편도") {
			$("#dateRange").text("가는 날");
			$(".dateModal").removeClass("modal-xl");
			$(".dateModal").addClass("modal-md");
			$(".backType").hide();
			$("#typeGo").addClass("active");
			$("#modalTypeGo").addClass("active");
			$("#tripType").val("편도");
		}
		if(type == "왕복") {
			$("#dateRange").text("가는 날 ~ 오는 날");
			$(".dateModal").removeClass("modal-md");
			$(".dateModal").addClass("modal-xl");
			$(".backType").show();
			$("#typeGoBack").addClass("active");
			$("#modalTypeGoBack").addClass("active");
			$("#tripType").val("왕복");
		}
		console.log(type);
	});
	
	// 여행 일정 클릭했을 때 이벤트
	$('#inputDate').click(function() {
		
		// 새로 오픈 될 때 검색 데이터 지우기
		$("#inputSchedule").val("");
		$('#dateRange').text("가는 날" + " ~ " + "오는 날");
        $("#dDate").val("");
        $("#aDate").val("");
        $("#selectedDepartDate").val("");
        $("#selectedArriveDate").val("");

	});
	
	// 날짜 입력 설정 - datepicker
	let now = new Date();
	
	// Datepicker를 초기화
    $('#departureCalendar').datepicker({
    	// 입력란의 데이터 포맷 
		dateFormat: "yy-mm-dd",
		// 월 선택 입력 추가
		changeMonth: true,
		// 년 선택 입력 추가
		changeYear: true,
		// 월 선택할 때의 이름 - 원래는 영어가 기본
		monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
		// 달력의 요일 표시
		dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
		// 오늘까지만의 날짜를 선택 가능
		minDate : now,
		onSelect: function(dateText) {
// 			let dateAddTime = dateText + " 00:00:00" 
//             $("#selectedDepartDate").val(dateAddTime);
            $("#selectedDepartDate").val(dateText);
		}
    });
	
	//초기값을 오늘 날짜로 설정해줘야 합니다.
    $('#departureCalendar').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
	
    $('#arrivalCalendar').datepicker({
    	// 입력란의 데이터 포맷 
		dateFormat: "yy-mm-dd",
		// 월 선택 입력 추가
		changeMonth: true,
		// 년 선택 입력 추가
		changeYear: true,
		// 월 선택할 때의 이름 - 원래는 영어가 기본
		monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
		// 달력의 요일 표시
		dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
		// 오늘까지만의 날짜를 선택 가능
		minDate : now,
		onSelect: function(dateText) {
//             let dateAddTime = dateText + " 00:00:00" 
//             $("#selectedArriveDate").val(formattedDate);
            $("#selectedArriveDate").val(dateText);
		}
    });
    
 	 //초기값을 오늘 날짜로 설정해줘야 합니다.
    $('#arrivalCalendar').datepicker('setDate', '+1M'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)

    // "일정 선택 완료" 버튼 클릭 시 선택된 날짜를 표시
    $('#confirmDateBtn').click(function() {
        if ($("#selectedArriveDate").val() != null) {
            $('#dateRange').text($("#selectedDepartDate").val() + " ~ " + $("#selectedArriveDate").val());
            $("#dDate").val($("#selectedDepartDate").val());
            $("#aDate").val($("#selectedArriveDate").val());
        } else {
        	$('#dateRange').text($("#selectedDepartDate").val());
        	$("#dDate").val($("#selectedDepartDate").val());
        }
        // 모달 창 닫기
        console.log($("#selectedDepartDate").val()  + " ~ " + $("#selectedArriveDate").val());
        $('#datePickerModal').modal('hide');
        $('.modal-backdrop').remove();
    });
    
	// 탑승객 버튼을 클릭했을 때 동작
	// tooltip
	$(document).ready(function(){
	  $('[data-toggle="tooltip"]').tooltip();   
	});
	
	// 출발지 선택 시
	$('#passenger').click(function() {
		$('#passengerSelect').css({
			top: $('#passenger').outerHeight() + 'px',  // 공항 아이콘 아래에 위치
			left: 0  // 공항 아이콘의 왼쪽에 정렬
		}).show();
	});
	
	// 인원 선택 버튼
	$(".cntControl").click(function(){
// 		alert($(this).val());
// 		alert(cnt);
		// 값을 가져온다.
		let inputField = $(this).parent("span").find("input");
		let cntValue = parseInt($(this).parent("span").find("input").val());
		let increment = parseInt($(this).val());
		
		// 계산 값
		let newCnt = cntValue + increment;
		if (newCnt >= 0) {
			inputField.val(newCnt);
		}
		
		if ($("#adultCnt") == 0) {
			$(".alert-danger").show();
		}
	});
	
	// 인원 정보를 버튼으로 전송
	$("#comfirmPassengerBtn").click(function() {
		let adultCnt = parseInt($("#adultCnt").val());
		let childCnt = parseInt($("#childCnt").val());
		let infantCnt = parseInt($("#infantCnt").val());
		let totalCnt = adultCnt + childCnt + infantCnt;
// 		alert("성인 : " + adultCnt + ", 소아 : " + childCnt + ", 유아 : " + infantCnt);
		
		$("#aPassenger").val(adultCnt);
		$("#cPassenger").val(childCnt);
		$("#iPassenger").val(infantCnt);
		$('#totalPassenger').text("성인 : " + adultCnt + ", 소아 : " + childCnt + ", 유아 : " + infantCnt + " - 총 " + totalCnt + "명");
		$('#passengerModal').modal('hide');
	});
	
	
	// 좌석 등급 선택
	// span 클릭 시 아래에 div 창을 오버레이 밖에 표시
    $('#inputSeat').click(function() {
        // 현재 클릭한 span 태그의 위치 계산
        let offset = $(this).offset();
        
        // div의 위치를 클릭한 span 바로 아래로 설정
        $('#seatInfo').css({
            top: 40 + $(this).outerHeight(),
            left: 20
        }).toggle();  // 클릭 시 div가 나타나거나 사라짐
    });
	
	$(".seatBtn").click(function() {
		let seatGrade = $(this).data("seatgrade");
// 		alert(seatGrade);
		$("#selectedSeat").text(seatGrade);
		$("#seatGrade").val(seatGrade);
		$(".seatBtn").removeClass("active");
		$(this).addClass("active");
		$("#seatInfo").hide();
	});
	
	// 항공권 검색 버튼 눌렀을 때 데이터 유효성 검사
	$("#searchBtn").click(function() {
		let departure = $("#dCode").val();
		let arrival = $("#aCode").val();
		let departureTime = $("#dDate").val();
		let arrivalTime = $("#aDate").val();
		let adult = parseInt($("#aPassenger").val());
		let child = parseInt($("#cPassenger").val());
		let infant = parseInt($("#iPassenger").val());
		let type = $("#tripType").val();
		
		let totalCnt = adult + child + infant;
		
// 		alert("1.departure : " + departure + ", 2. arrival :" + arrival + ", 3. departureTime :" + departureTime
// 				+ ", 4.arrivalTime : " + arrivalTime + ", 5. adult : " + adult + ", 6. child : " + child 
// 				+ ", 7. infant : " + infant + ", 8. type : " + type);
		if (departure === null || departure === "" || arrival === null || arrival === "") {
			alert("출발지와 도착지는 필수 입니다. 출발지와 도착지를 선택해 주세요.");
			return false;
		}
		if (type === "왕복" && (arrivalTime === null || arrivalTime === "")) {
			alert("왕복 항공권 검색은 돌아오는 날 일정을 선택해야 합니다.");
			return false;
		}
		if (totalCnt == 0) {
			alert("최소 1인 이상 선택되어야 합니다.");
			return false;
		}
		
	});
	
	$("#allAirportBtn").click(function() {
		$("#allAirportModal").modal("show");
		
		// 각 나라의 airportListBtn 눌렀을 때 공항 리스트 처리
		$(".airportListBtn").click(function() {
			let country = $(this).data("countrycode");
			// console.log(country);
			
			$(".collapse").find(".airList").remove();
			$(".collapse").collapse("hide");
			
			// 바로 중분류의 데이터를 세팅한다.
			$("#airportList" + country).load("/airajax/getAirport.do?countryCode="	+ country);
			$("#airportList" + country).collapse("show");
		});
		
	});
	
});

// 이벤트 -------------------------

	$(function() {
		// 공지사항 글 보기 이동 처리
		$(document).ready(function() {

			$(".dataRow").click(function() {
				let eventNo = $(this).data("event-no");
				location = "/event/view.do?eventNo=" + eventNo;
			});
		});
	});

