<%@page import="java.util.List"%>
<%@page import="com.jj.dto.Company"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>workingholiday_list_form</title>
	
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
</head>
<body>
	<div class="wrap_form">
		<%
			List<Company> list = (List<Company>)request.getAttribute("list");
			
			for (Company com : list) {
		%>
		<div class="wh_list">
			<a href="workingholiday.jj?page=whlist&com_no=<%= com.getCom_no() %>">
			<ul>
				<li>
					<p class="com_title"><%= com.getCom_title() %></p>
					<p class="com_name"><%= com.getCom_name() %></p>
					<hr>
					<p class="com_country"><%= com.getCom_country() %>(<%= com.getCom_city() %>)</p>
					<p class="com_job"><%= com.getCom_job1() %> > <%= com.getCom_job2() %></p>
					<p class="com_wtime"><%= com.getCom_start_time() + ":00~" + com.getCom_end_time() + ":00" %></p>
					
					<fmt:parseNumber var="end_time" integerOnly="true" type="number" value="<%= com.getCom_end_time() %>" />
                         	<fmt:parseNumber var="start_time" integerOnly="true" type="number" value="<%= com.getCom_start_time() %>" />
                         	<c:set var="etime" value="${ end_time }" />
                         	<c:set var="stime" value="${ start_time }" />
                         	<c:set var="wtime" value="${ etime-stime<0 ? -(etime-stime) : etime-stime }" />
                         	
                         	<c:set var="sal_name" value="<%= com.getCom_sal_name() %>" />
                         	<c:set var="salary" value="<%= com.getCom_salary() %>" />
                         	<fmt:formatNumber var="sal" value="${ salary }" /> <%-- 시급/건별 --%>
                         	
                         	<c:set var="day" value="${ salary*wtime }" /> <%-- 일급 --%>
                         	<fmt:formatNumber var="result1" value="${ day }" />
                         	
                         	<c:set var="workdays" value="<%= com.getCom_work_days() %>" />
                         	<c:set var="days" value="${ fn:split(workdays, ',') }" />
                         	<c:set var="week" value="${ salary*wtime*fn:length(days) }" /> <%-- 주급 --%>
                         	<fmt:formatNumber var="result2" value="${ week }" />
                         	
                         	<c:set var="month" value="${ salary*wtime*fn:length(days)*4 }" /> <%-- 월급 --%>
                         	<fmt:formatNumber var="result3" value="${ month }" />
                         	
                         	<c:set var="year" value="${ salary*wtime*fn:length(days)*4*12 }" /> <%-- 연봉 --%>
                         	<fmt:formatNumber var="result4" value="${ year }" />
                         	
                         	<c:if test="${ sal_name eq '시급' }">
                         		<p class="com_sal"><%= com.getCom_sal_name() %> ${ sal }원</p>
                         	</c:if>
                         	<c:if test="${ sal_name eq '일급' }">
                         		<p class="com_sal"><%= com.getCom_sal_name() %> ${ result1 }원</p>
                         	</c:if>
                         	<c:if test="${ sal_name eq '주급' }">
                         		<p class="com_sal"><%= com.getCom_sal_name() %> ${ result2 }원</p>
                         	</c:if>
                         	<c:if test="${ sal_name eq '월급' }">
                         		<p class="com_sal"><%= com.getCom_sal_name() %> ${ result3 }원</p>
                         	</c:if>
                         	<c:if test="${ sal_name eq '연봉' }">
                         		<p class="com_sal"><%= com.getCom_sal_name() %> ${ result4 }원</p>
                         	</c:if>
                         	<c:if test="${ sal_name eq '건별' }">
                         		<p class="com_sal"><%= com.getCom_sal_name() %> ${ sal }원</p>
                         	</c:if>
                         	
					<p class="com_etime">~<%= com.getCom_term() %></p>
				</li>
			</ul>
			</a>
		</div>
		<% } %>
	</div>
</body>
</html>