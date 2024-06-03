<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String u_id = (String)session.getAttribute("u_id");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자유게시판-작성페이지</title>
	
	<link href="css/board_insert.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <script type="text/javascript">
    	$(document).ready(function () {
    		$('select[name=nation]').change(function() { //국가, 도시 선택
				console.log($(this).find('option:selected').text());
				if ($(this).find('option:selected').text() == '국가') {
					$('select[name=city]').find('option').remove();
					$('select[name=city]').append('<option>도시</option>');
				} else if ($(this).find('option:selected').text() == '일본') {
					$('select[name=city]').find('option').remove();
					$('select[name=city]').append('<option>도시</option>');
					$('select[name=city]').append('<option>도쿄</option>');
					$('select[name=city]').append('<option>오사카</option>');
					$('select[name=city]').append('<option>후쿠오카</option>');
					$('select[name=city]').append('<option>교토</option>');
					$('select[name=city]').append('<option>나리타</option>');
				} else if ($(this).find('option:selected').text() == '캐나다') {
					$('select[name=city]').find('option').remove();
					$('select[name=city]').append('<option>도시</option>');
					$('select[name=city]').append('<option>벤쿠버</option>');
					$('select[name=city]').append('<option>토론토</option>');
					$('select[name=city]').append('<option>캘거리</option>');
					$('select[name=city]').append('<option>빅토리아</option>');
					$('select[name=city]').append('<option>몬트리올</option>');
				}
			});
    		
			$('.del_btn').click(function () { //취소버튼
				if (confirm("취소하시겠습니까?")) {
					console.log("취소완료");
					$('form[name="boardForm"]').attr('action', 'board_selectDB.jsp?no=-1&nowPage=1');
				} else {
					console.log("그대로");
					return false;
				}
			});
			
			$('.sign_btn').click(function () { //등록버튼
				if($('input[name=title]').val() == "") {
					alert("제목을 입력해주세요");
					return false;
				} else if ($('select[name=nation] option:selected').text() == "국가") {
					alert("국가를 선택해주세요");
					return false;
				} else if ($('select[name=city] option:selected').text() == "도시") {
					alert("도시를 선택해주세요");
					return false;
				} else if ($('select[name=month] option:selected').text() == "여행시기") {
					alert("여행시기를 선택해주세요");
					return false;
				} else if ($('select[name=category] option:selected').text() == "카테고리") {
					alert("카테고리를 선택해주세요");
					return false;
				} else if ($('textarea[name=content]').val() == "") {
					alert("내용을 입력해주세요");
					return false;
				} else {
					alert("등록되었습니다.");
					$('form[name="boardForm"]').attr('action', 'board_insertDB.jsp');
				}
			});
		});
    </script>
</head>
<body>
	<jsp:include page="main_header.jsp" />
	
	
	<div class="board_wrap">
		<div class="board">
			<p>자유게시판 > 글쓰기</p>
			<form name="boardForm" method="post">
		       	<div class="board_write">
		       		<!-- 제목 -->
					<div class="title">
						<div>
							<label>제목</label>
						</div>
						<input type="text" name="title" placeholder="제목을 입력하세요">
					</div>
					<!-- 국가 및 도시 -->
					<div class="info">
						<div>
							<label>국가 및 도시</label>
						</div>
						<div class="slt">
							<select name="nation">
								<option>국가</option>	
								<option>일본</option>
								<option>캐나다</option>
							</select>
							<select name="city">
								<option>도시</option>
							</select>
						</div>
					</div>
					<!-- 여행시기 -->
					<div class="info">
						<div>
							<label>여행시기</label>
						</div>
						<div class="slt">
							<select name="month">
								<option>여행시기</option>
								<option>1월</option>
								<option>2월</option>
								<option>3월</option>
								<option>4월</option>
								<option>5월</option>
								<option>6월</option>
								<option>7월</option>
								<option>8월</option>
								<option>9월</option>
								<option>10월</option>
								<option>11월</option>
								<option>12월</option>
							</select>
						</div>
					</div>
					<!-- 카테고리 -->
					<div class="info">
						<div>
							<label>카테고리</label>
						</div>
						<div class="slt">
							<select name="category">
								<option>카테고리</option>
								<option>음식</option>
								<option>쇼핑</option>
								<option>일상</option>
								<option>날씨</option>
								<option>휴업/폐업</option>
							</select>
						</div>
					</div>
					<!-- 내용 -->
					<div class="cont">
						<textarea name="content" placeholder="내용을 입력해주세요"></textarea>
					</div>
				</div>
				<!-- 버튼 -->
				<div class="btn_wrap">
					<button class="del_btn">취소</button>
					<button class="sign_btn">등록</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>