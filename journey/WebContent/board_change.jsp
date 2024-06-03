<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jj.dao.BoardDB"%>
<%@page import="com.jj.dto.Board"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String u_id = (String)session.getAttribute("u_id");
	int no = Integer.parseInt(request.getParameter("no")); //board_cont에서 넘어온 게시글번호
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자유게시판-수정페이지</title>
	
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
					window.location.href = 'board.jsp';
					//$('form[name="boardForm"]').attr('action', 'board.jsp');
				} else {
					console.log("그대로");
					return false;
				}
			});
			
			$('.chg_btn').click(function () { //수정버튼
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
					alert("수정되었습니다.");
					$('form[name="boardForm"]').attr('action', 'board_updateDB.jsp?no=<%=no%>');
				}
			});
		});
	</script>
</head>
<body>
	<jsp:include page="main_header.jsp" />

	<jsp:useBean id="board" class="com.jj.dao.BoardDB">
	<%
		ArrayList<Board> alist = board.selectRow(no, 0);
		
			for (Board b : alist) {
	%>
	<div class="board_wrap">
		<div class="board">
			<p>자유게시판 > 글 수정하기</p>
			<form name="boardForm" method="post">
		       	<div class="board_write">
		       		<!-- 제목 -->
					<div class="title">
						<div>
							<label>제목</label>
						</div>
						<input type="text" name="title" value="<%= b.getB_title() %>">
					</div>
					<!-- 국가 및 도시 -->
					<div class="info">
						<div>
							<label>국가 및 도시</label>
						</div>
						<div class="slt">
							<select name="nation">
								<option>국가</option>	
								<c:set var="nat" value="<%= b.getB_nation() %>" />
								<option <c:if test="${ nat == '일본' }">selected</c:if>>일본</option>
								<option <c:if test="${ nat == '캐나다' }">selected</c:if>>캐나다</option>
							</select>
							<select name="city">
								<option>도시</option>
								<c:set var="city" value="<%= b.getB_city() %>" />
								<c:if test="${ nat == '일본' }">
									<option <c:if test="${ city == '도쿄' }">selected</c:if>>도쿄</option>
									<option <c:if test="${ city == '오사카' }">selected</c:if>>오사카</option>
									<option <c:if test="${ city == '후쿠오카' }">selected</c:if>>후쿠오카</option>
									<option <c:if test="${ city == '교토' }">selected</c:if>>교토</option>
									<option <c:if test="${ city == '나리타' }">selected</c:if>>나리타</option>
								</c:if>
								<c:if test="${ nat == '캐나다' }">
									<option <c:if test="${ city == '벤쿠버' }">selected</c:if>>벤쿠버</option>
									<option <c:if test="${ city == '토론토' }">selected</c:if>>토론토</option>
									<option <c:if test="${ city == '캘거리' }">selected</c:if>>캘거리</option>
									<option <c:if test="${ city == '빅토리아' }">selected</c:if>>빅토리아</option>
									<option <c:if test="${ city == '몬트리올' }">selected</c:if>>몬트리올</option>
								</c:if>
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
								<%
									for (int i=1; i<13; i++) {
										if (b.getB_month().equals(i + "월")) {
											out.println("<option selected='selected'>" + i + "월</option>");
										} else {
											out.println("<option>" + i + "월</option>");
										}
									}
								%>
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
								<c:set var="category" value="<%= b.getB_category() %>" />
								<option <c:if test="${ category == '음식' }">selected</c:if>>음식</option>
								<option <c:if test="${ category == '쇼핑' }">selected</c:if>>쇼핑</option>
								<option <c:if test="${ category == '일상' }">selected</c:if>>일상</option>
								<option <c:if test="${ category == '날씨' }">selected</c:if>>날씨</option>
								<option <c:if test="${ category == '휴업/폐업' }">selected</c:if>>휴업/폐업</option>
							</select>
						</div>
					</div>
					<!-- 내용 -->
					<div class="cont">
						<textarea name="content"><%= b.getB_contents() %></textarea>
					</div>
				</div>
				<!-- 버튼 -->
				<div class="btn_wrap">
					<button type="button" class="del_btn">취소</button>
					<button class="chg_btn">등록</button>
				</div>
			</form>
		</div>	
	</div>
	<% } %>
	</jsp:useBean>
</body>
</html>