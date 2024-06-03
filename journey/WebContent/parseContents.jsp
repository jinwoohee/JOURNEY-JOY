<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jj.dto.DtoPublicInfo1"%>
<%@page import="org.w3c.dom.NodeList"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>해외취업 통계정보</title>
	
	<style type="text/css">
		.parseTbl {
			width: 100%;
			border-collapse: collapse;
			font-size: 15px;
		}
		
		.parseTbl thead {
			border-bottom: 2px solid #2c609c;
		}
		
		.parseTbl tbody tr {
			border-bottom: 1px solid #ddd;
		}
		
		.parseTbl tbody tr:last-of-type {
			border-bottom: none;
		}
		
		.parseTbl tr {
			line-height: 26px;
		}
		
		.parseTbl th, td {
			padding: 5px 0;
		}
		
		.parseTbl tr th:first-of-type {
			width: 40%;
		}
		
		.parseTbl tr th:nth-of-type(2) {
			width: 30%;
		}
		
		.parseTbl tr th:last-of-type {
			width: 30%;
		}
	</style>
</head>
<body>
	<div class="parseCont">
	<%
	ArrayList<DtoPublicInfo1> nodeList = (ArrayList<DtoPublicInfo1>)request.getAttribute("nodeList");
	
	if (nodeList.size() != 0) {
	%>
		<table class="parseTbl">
			<thead>
				<tr>
					<th>국가</th>
					<th>취업건수</th>
					<th>취업률</th>
				</tr>
			</thead>
			<tbody>
			<% for (DtoPublicInfo1 info : nodeList) { %>
				<tr>
					<td><%= info.getName()  %></td>
					<td><%= info.getCnt() %>건</td>
					<td><%= info.getRate() %>%</td>
				</tr>
			<% } %>
			</tbody>
		</table>
	<% } else { %>
		<div>내용이 없음</div>
	<% } %>
	</div>

</body>
</html>