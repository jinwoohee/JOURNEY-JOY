<%@page import="com.jj.dto.Inquiry"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<%
		ArrayList<Inquiry> list = (ArrayList<Inquiry>)request.getAttribute("inquiry_list");
		
		if (list.size() > 0) {
			for (Inquiry iq : list) {
			//System.out.println(iq.getP_no());
	%>
		<div class="n_box">
		<%= iq.getU_id() %>님이 패키지[<%= iq.getP_title() %>]에 문의사항 메세지를 남겼습니다.
		</div>
	<% 		} 
		} else {
	%>
		<p>알림이 없습니다.</p>
	<%  } %>
</body>
</html>