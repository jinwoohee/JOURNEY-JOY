<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jj.dao.BoardDB"%>
<%@page import="com.jj.dto.Board"%>
<%
	String u_id = (String)session.getAttribute("u_id");
	int no = Integer.parseInt(request.getParameter("no")); //board에서 넘어온 게시글번호
	//out.println(no);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자유게시판-상세페이지(수정/삭제)</title>
	
	<link href="css/board_cont.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function () {
			$('.del_btn').click(function () {
				//console.log($(this).val());
				var delete_no = $(this).val();
				
				if (!confirm("삭제하시겠습니까?")) {
					console.log("취소");
				} else {
					if (confirm("삭제되었습니다")) {
						$('form[name=boardForm]').attr('action', 'board_deleteDB.jsp?no=' + delete_no);
					}
					
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
		out.println(b.getU_id());
	%>
	<div class="board_wrap">
		<div class="board">
			<p><%= b.getB_title() %></p>
			<form name="boardForm" method="post">
		       	<div class="board_write">
		       		<!-- 제목 -->
					
					<!-- 국가 및 도시 -->
					<div class="info">
						<div>
							<label>국가 및 도시</label>
						</div>
						<p><%= b.getB_nation() %> / <%= b.getB_city() %></p>
					</div>
					<!-- 여행시기 -->
					<div class="info">
						<div>
							<label>여행시기</label>
						</div>
						<p><%= b.getB_month() %></p>
					</div>
					<!-- 카테고리 -->
					<div class="info">
						<div>
							<label>카테고리</label>
						</div>
						<p><%= b.getB_category() %></p>
					</div>
					<!-- 내용 -->
					<div class="cont">
						<textarea name="content" readonly><%= b.getB_contents() %></textarea>
					</div>
				</div>
				<!-- 버튼 -->
				<div class="btn_wrap">
					<%
						if (u_id != null) { //로그인 했을 때
							if (u_id.equals(b.getU_id())) {
								out.println("<button class='del_btn' value='" + no + "'>삭제</button>");
								out.println("<a href='board_change.jsp?no=" + no + "'><input type='button' value='수정'></a>");
							} else {
								out.println("<a href='board.jsp'><input type='button' value='목록으로'></a>");
							}
						} else { //로그인 안 했을 때
							out.println("<a href='board.jsp'><input type='button' value='목록으로'></a>");
						}
					%>
				</div>
			</form>
		</div>
	</div>
	<% } %>
	</jsp:useBean>
</body>
</html>