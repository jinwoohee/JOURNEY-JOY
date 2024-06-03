<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자유게시판-작성내용 DB넣기</title>
</head>
<body>
	<jsp:useBean id="board" class="com.jj.dao.BoardDB">
	<%
		request.setCharacterEncoding("utf-8");
		String id = (String)session.getAttribute("u_id");
		String title = request.getParameter("title");
		String nation = request.getParameter("nation");
		String city = request.getParameter("city");
		String month = request.getParameter("month");
		String category = request.getParameter("category");
		String content = request.getParameter("content");
		//out.println(content);
		
		board.insertRow(id, title, nation, city, month, category, content);
		response.sendRedirect("board.jsp");
	%>
	</jsp:useBean>
</body>
</html>