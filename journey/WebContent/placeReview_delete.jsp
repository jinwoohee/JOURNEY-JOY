<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
	request.setCharacterEncoding("utf-8");
	String u_id = (String) session.getAttribute("u_id");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="place" class="com.jj.dao.Review">
		<%
			int lr_no = Integer.parseInt(request.getParameter("lr_no"));
			place.delete_placeReview(u_id, lr_no);
			response.sendRedirect("place_review.jsp");
		%>
	</jsp:useBean>
</body>
</html>