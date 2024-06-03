<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%
	session.removeAttribute("u_id");
	response.sendRedirect("index.jsp");
%>