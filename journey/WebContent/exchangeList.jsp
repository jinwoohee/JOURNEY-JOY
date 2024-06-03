<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<c:set var="exchangeList" value="${requestScope.exchangeList}" />
			<c:forEach var="ex" items="${exchangeList}">
				${ex.cur_nm} 
				${ex.cur_unit}
				${ex.tts}원
			</c:forEach>
	</div>
</body>
</html>