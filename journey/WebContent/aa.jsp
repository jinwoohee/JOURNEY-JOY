<%@page import="com.jj.dto.Package_schedule"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.HashMap"%>

<%
	request.setCharacterEncoding("utf-8");
	int p_period = (int)session.getAttribute("p_period");
	int p_no = (int)session.getAttribute("p_no");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	HashMap<String, Package_schedule> map = new HashMap<String, Package_schedule>();
	
	for(int i=0; i<p_period; i++){
		Package_schedule ps = new Package_schedule();

		String placeArr = Arrays.toString(request.getParameterValues("schedule"+(i+1)));
		String place = placeArr.replaceAll("\\[", "").replaceAll("\\]", "");
		
		ps.setP_no(p_no);
		ps.setPs_schedule(place);
		ps.setPs_day(request.getParameterValues("ps_day")[i]);
		ps.setPs_title(request.getParameterValues("title")[i]);
		ps.setPs_contents(request.getParameterValues("contents")[i]);
		ps.setPs_notification(request.getParameterValues("notice")[i]);
		
		map.put(request.getParameterValues("ps_day")[i], ps);
	}
	
	request.setAttribute("map", map);
	RequestDispatcher dispatcher = request.getRequestDispatcher("scheduleInsert.jj?page=package_scheduleInsert");
	dispatcher.forward(request, response);

%>
</body>
</html>