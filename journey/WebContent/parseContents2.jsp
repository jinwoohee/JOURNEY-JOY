<%@page import="com.jj.dto.DtoPublicInfo2"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>해외취업 모집공고 정보</title>
	
	<style type="text/css">
		.parseTbl {
			text-align: left;
			border-collapse: collapse;
			font-size: 15px;
		}
		
		.parseTbl tbody {
			border: 2px solid #2c609c;
    		line-height: 25px;
    		width: 100%;
    		height: fit-content;
		    display: inline-table;
   			margin-bottom: 10px;
		}
		
		.parseTbl tbody tr:last-of-type {
			border-bottom: none;
		}
		
		.parseTbl tr {
			border-bottom: 1px solid #ccc;
			display: flex;
		    align-items: center;
		    padding: 3px 15px;
		}
		
		.parseTbl th {
			width: 20%;
		}
		
		.parseTbl td {
			width: 80%;
		}
		
		
	</style>
</head>
<body>
	<div class="parseCont">
		<table class="parseTbl">
			<%
			ArrayList<DtoPublicInfo2> nodeList = (ArrayList<DtoPublicInfo2>) request.getAttribute("nodeList");
			
			if (nodeList.size() != 0) {
				for (DtoPublicInfo2 info : nodeList) {
			%>
			<tbody>
				<tr>
					<th>공고명</th>
					<td><%= info.getRctntcSj() %></td>
				</tr>
				<tr>
					<th>업무내용</th>
					<td><%= info.getRctntcSprtQualfCn() %></td>
				</tr>
				<tr>
					<th>직종</th>
					<td><%= info.getDsptcKsco() %></td>
				</tr>
				<tr>
					<th>국가</th>
					<td><%= info.getDsptcNationScd() %></td>
				</tr>
				<tr>
					<th>모집종료기간</th>
					<td>~<%= info.getRctntcEndDe() %></td>
				</tr>
			</tbody>
			<%
				}
			}
			%>
		</table>
	</div>
</body>
</html>