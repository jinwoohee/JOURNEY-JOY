<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jj.dto.Estimate"%>
<%@page import="java.util.List"%>
    
<%
request.setCharacterEncoding("utf-8");
	Cookie[] cookies = request.getCookies();
%>
<%!private String getCookieValue(Cookie[] cookies, String name){
		String value = null;
		if(cookies == null)
			return null;
		for(Cookie cookie : cookies){
			if(cookie.getName().equals(name))
				return cookie.getValue();
		}
		return null;
	}%>


<%

String u_id = (String) session.getAttribute("u_id");
response.addCookie(new Cookie("u_id", u_id));
String e_no = getCookieValue(cookies, "e_no");

if(e_no == null){
	response.sendRedirect("planlist.jsp");
}else{
	List<Estimate> estiList = (List<Estimate>) request.getAttribute("estimate");
	
	response.sendRedirect("plan.jsp");
}

%>
