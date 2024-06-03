<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="com.jj.dto.Package_like"%>
<%@page import="com.jj.dto.Package"%>
<%@page import="java.util.List"%>

<%
	request.setCharacterEncoding("utf-8");
	String u_id = (String) session.getAttribute("u_id");
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- css -->
<link rel="stylesheet" type="text/css" href="css/packageList.css">   
</head>
<body>
	<ul>
		<%
			List<Package> pkList = (List<Package>)request.getAttribute("pkList");
			List<Package_like> likeList = (List<Package_like>)request.getAttribute("likeList");
		
			if(pkList.size() < 1){
				out.println("<p align='center'>등록된 패키지 여행이 없습니다.</p>");
			}

			for(Package list : pkList){
				out.println("<li>");
				out.println("<input type='hidden' name='p_no' value='"+list.getP_no()+"'>");
				out.println("<div class='thumnail'>");
				out.println("<a href='packageDetail.jj?page=package_detail&p_no="+list.getP_no()+"&u_id="+u_id+"'>");
				out.println("<img src='uploadFile/"+list.getP_file()+"'/></a></div>");
				int flag=1;
				for(int idx = 0 ; idx < likeList.size() ; idx++){
					if(list.getP_no() == likeList.get(idx).getP_no() && likeList.get(idx).getU_id().equals(session.getAttribute("u_id"))){
						flag=2;
					}
				}
				if(flag==1)
					out.println("<div><img src='img/icon/heart2.png'/></div>");
				else
					out.println("<div><img src='img/icon/heart.png'/></div>");
				
				out.println("<div><p>"+list.getP_nation()+"</p></div>");
				out.println("<div><p>"+list.getP_city()+"</p></div>");
				out.println("<div><P class='title'>"+list.getP_title()+"</P></div>");
				out.println("<div><P>"+list.getU_nickname()+"</P></div>");
				
				DecimalFormat f = new DecimalFormat("###,###,###");
				out.println("<div><P>"+f.format(list.getChild_fee())+"~</P></div>");
				out.println("</li>");
			}
		%>
	</ul>
</body>
</html>