<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.curr{
	width : 160px;
	height : 50px;
	text-align : center;
	background-color : white;
	font-size : 15px;
}

</style>
<body>
		<c:set var="exchangeList" value="${requestScope.exchangeList}" />
		
			<c:forEach var="ex" items="${exchangeList}">
			<div class="curr">
				${ex.cur_nm} 
				(${ex.cur_unit})<br>
				${ex.tts}원
			</div>
			</c:forEach>
			
</body>
</html>