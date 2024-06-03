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
		int no = Integer.parseInt(request.getParameter("no"));
		//out.println(no);
		board.deleteRow(no);
		response.sendRedirect("board.jsp");
	%>
	</jsp:useBean>
</body>
</html>