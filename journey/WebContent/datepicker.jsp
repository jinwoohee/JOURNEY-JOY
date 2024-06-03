<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<!-- 날짜 -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

</head>
<script>
$(function(){
	/* 날짜 */
	$("#startDt").datepicker({
		dateFormat: 'yy-mm-dd' //달력 날짜 형태
		,minDate:0
		,nextText : ">"
		,prevText : "<"
		,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
		,showMonthAfterYear:true //년도 - 월 순서
		,changeYear: true //년 선택 가능
        ,changeMonth: true //월 선택 가능
        ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
        ,minDate : 0 //선택할수있는 최소날짜(0:오늘 이전날짜 선택 불가)
        ,onClose:function(selectedDate){ //startDt 닫힐때 endDt 선택가능한 최소날짜가 시작일로 지정
        	$("#endDt").datepicker("option", "minDate", selectedDate);
        }

	});

	$("#endDt").datepicker({
		dateFormat: 'yy-mm-dd' //달력 날짜 형태
		,minDate:0
		,nextText : ">"
		,prevText : "<"
		,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
		,showMonthAfterYear:true //년도 - 월 순서
		,changeYear: true //년 선택 가능
        ,changeMonth: true //월 선택 가능
        ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
	});
});

</script>
<body>
<!-- menu bar -->
<jsp:include page="main_header.jsp"></jsp:include>
	
<input type="text" id="startDt" placeholder="여행출발일">
<input type="text" id="endDt" placeholder="여행도착일">
</body>
</html>