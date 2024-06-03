<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="board" class="com.jj.dao.BoardDB">
	<%
		request.setCharacterEncoding("utf-8");
		int no = Integer.parseInt(request.getParameter("no"));
		int nowPage = Integer.parseInt(request.getParameter("nowPage"));
		
		board.selectRow(no, nowPage);
		response.sendRedirect("board.jsp");
	%>
	</jsp:useBean>
</body>
</html>