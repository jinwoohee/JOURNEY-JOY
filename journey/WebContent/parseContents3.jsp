<%@page import="com.jj.dto.DtoPublicInfo3"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.parseCont {
		font-size: 15px;
	}
	
	.contents {
		border: 1px solid #9E9E9E;
    	box-shadow: 3px 3px 10px #cccccc;
    	margin-bottom: 20px;
	}
	
	.contents p {
		margin-top: 0px;
		margin-bottom: 0px;
    	padding-left: 10px;
    	padding-right: 10px;
	}
	
	.parseNat {
		text-align: left;
	    font-size: 12px;
	    padding-top: 10px;
	}
	
	.parseTitle {
		text-align: left;
	    font-weight: 600;
	    font-size: 17px;
	    padding-top: 2px;
	    padding-bottom: 10px;
	}
	
	.parseSumar {
		text-align: justify;
    	padding-bottom: 10px;
	}
	
	.parseUrl {
		text-align: left;
    	padding-bottom: 10px;
    	font-size: 12px;
	}
</style>
</head>
<body>
	<div class="parseCont">
	<%
	ArrayList<DtoPublicInfo3> plist = (ArrayList<DtoPublicInfo3>) request.getAttribute("plist");
	
	if (plist.size() != 0) {
		for (DtoPublicInfo3 info : plist) {
	%>
	<div class="contents">
		<p class="parseNat"><%= info.getNatn() %> > <%= info.getRegn() %></p>
		<p class="parseTitle"><%= info.getNewsTitl() %></p>
		<p class="parseSumar"><%= info.getCntntSumar() %></p>
		<p class="parseUrl">관련기사 링크: <%= info.getKotraNewsUrl() %></p>
	</div>
	<%
		}
	}
	%>
	</div>
</body>
</html>