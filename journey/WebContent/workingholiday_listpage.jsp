<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jj.dto.Company"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String u_id = (String) session.getAttribute("u_id");
%>
<html>
<head>
    <meta charset="utf-8">
	<title>워홀 상세페이지</title>

    <link href="css/workingholiday_listpage.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
</head>
<body>
    <jsp:include page="main_header.jsp" />
    
    <div class="list">
        <section>
            <article>
	            <div class="list_wrap">
	            <% 
	            	Company com = (Company)request.getAttribute("com");
	            %>
	                <!-- 회사명/제목 -->
	                <div id="box1">
	                    <p><%= com.getCom_name() %></p>
	                    <p><%= com.getCom_title() %></p>
	                </div>
	
	                <!-- 모집조건 -->
	                <div id="box2">
	                    <p>▶ 모집조건</p>
	                    <hr>
	                    <table border="0" cellspacing="0" cellpadding="10px">                           
	                        <tr>
	                            <td>모집지역</td>
	                            <td><%= com.getCom_country() %></td>
	                            <td>></td>
	                            <td><%= com.getCom_city() %></td>
	                        </tr>
	                        <tr>
	                            <td>모집직종</td>
	                            <td><%= com.getCom_job1() %></td>
	                            <td>></td>
	                            <td><%= com.getCom_job2() %></td>
	                        </tr>
	                        <tr>
	                            <td>학력</td>
	                            <td colspan="3"><%= com.getCom_edu_level() %></td>
	                        </tr>
	                        <tr>
	                            <td>언어수준</td>
	                            <td colspan="3"><%= com.getCom_lang_level() %></td>
	                        </tr>
	                        <tr>
	                            <td>모집인원</td>
	                            <td colspan="3"><%= com.getCom_volume() %></td>
	                        </tr>
	                    </table>
	                </div>
	
	                <!-- 채용조건 -->
	                <div id="box3">
	                    <table border="0" cellspacing="0" cellpadding="10px">
	                        <p>▶ 채용조건</p>
	                        <hr>
	                        <tr>
	                            <td>업무내용</td>
	                            <td><%= com.getCom_contents() %></td>
	                        </tr>
	                        <tr>
	                            <td>전공</td>
	                            <td><%= com.getCom_major() %></td>
	                        </tr>
	                        <tr>
	                            <td>자격증</td>
	                            <td><%= com.getCom_license() %></td>
	                        </tr>
	                        <tr>
	                            <td>복리후생</td>
	                            <td><%= com.getCom_benefits() %></td>
	                        </tr>
	                    </table>
	                </div>
	
	                <!-- 근무조건 -->
	                <div id="box4">
	                    <table border="0" cellspacing="0" cellpadding="10px">
	                        <p>▶ 근무조건</p>
	                        <hr>
	                        <tr>
	                            <td>근무요일</td>
	                            <td><%= com.getCom_work_days() %></td>
	                        </tr>
	                        <tr>
	                            <td>근무시간</td>
	                            <td><%= com.getCom_start_time() + ":00~" + com.getCom_end_time() + ":00" %></td>
	                        </tr>
	                        <tr>
	                            <td>근무기간</td>
	                            <td><%= com.getCom_work_period() %></td>
	                        </tr>
	                        <tr>
	                            <td><%= com.getCom_sal_name() %></td>
	                            <td>
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
	                            		${ sal }원
	                            	</c:if>
	                            	<c:if test="${ sal_name eq '일급' }">
	                            		${ result1 }원 (시급 : ${ sal }원)
	                            	</c:if>
	                            	<c:if test="${ sal_name eq '주급' }">
	                            		${ result2 }원 (시급 : ${ sal }원)
	                            	</c:if>
	                            	<c:if test="${ sal_name eq '월급' }">
	                            		${ result3 }원 (시급 : ${ sal }원)
	                            	</c:if>
	                            	<c:if test="${ sal_name eq '연봉' }">
	                            		${ result4 }원
	                            	</c:if>
	                            	<c:if test="${ sal_name eq '건별' }">
	                            		${ sal }원
	                            	</c:if>
	                            </td>
	                        </tr>
	                    </table>
	                </div>
	
	                <!-- 접수내용 -->
	                <div id="box5">
	                    <table border="0" cellspacing="0" cellpadding="10px">
	                        <p>▶ 접수내용</p>
	                        <hr>
	                        <tr>
	                            <td>지원방법</td>
	                            <td>문자지원</td>
	                        </tr>
	                        <tr>
	                            <td>마감일</td>
	                            <td><%= com.getCom_term() %></td>
	                        </tr>
	                    </table>
	                </div>
	            </div>
            </article>
        </section>
    </div>

    <jsp:include page="main_footer.jsp" />
</body>
</html>