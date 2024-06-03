<%@page import="com.jj.dto.Eatery"%>
<%@page import="com.jj.dto.Place"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<select name='place_select'>
	<%
		ArrayList<Place> placeList = (ArrayList<Place>)request.getAttribute("placeList");
		ArrayList<Eatery> eatList = (ArrayList<Eatery>)request.getAttribute("eatList");
		
		if(placeList.size()>0 || eatList.size()>0){
			for(Place p : placeList){%>
				<option><%=p.getPlac_name() %></option>
	<%		}
			
			for(Eatery e : eatList){%>
				<option><%=e.getEat_name() %></option>
	<%		}
		}
	%>
</select>
</body>
</html>