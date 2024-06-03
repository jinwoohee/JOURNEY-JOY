<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.jj.dto.Day_review"%>
<%@page import="com.jj.dto.Plan_review"%>
<%@page import="java.util.ArrayList"%>

<jsp:useBean id="dao" class="com.jj.dao.Plan_review" />

<%
	request.setCharacterEncoding("utf-8");
	Plan_review pr = new Plan_review();
	Day_review dr = new Day_review();
	
	pr.setU_id((String) session.getAttribute("u_id"));
	pr.setPr_no(Integer.parseInt(request.getParameter("page_no")));

	//일정리뷰 삭제
	dao.delete_plan_review(pr.getPr_no());
	
	//데이리뷰 삭제
	dao.delete_day_review(pr.getPr_no());
	
	response.sendRedirect("plan_review_list.jsp");
%>
