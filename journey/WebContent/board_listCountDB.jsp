<%@page import="com.jj.dto.PageInfo"%>
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
		int nowPage = Integer.parseInt(request.getParameter("nowPage"));
		
		PageInfo pageInfo = board.listCountSelect(nowPage);
		request.setAttribute("pageInfo", pageInfo);
		request.getRequestDispatcher("board.jsp").forward(request, response);
	%>
	</jsp:useBean>
</body>
</html>