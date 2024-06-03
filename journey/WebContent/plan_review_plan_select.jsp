<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.jj.dto.Estimate"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
request.setCharacterEncoding("utf-8");
List<Estimate> esti = (List<Estimate>) request.getAttribute("estilist");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

    <link href="css/plan_review_plan_select.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
</head>
<script type="text/javascript">
$(function(){
	$(".plan_div").mouseenter(function(){
    	$(this).css({'box-shadow':'3px 3px 10px #CCCCCC'});
    });
	
	$(".plan_div").mouseleave(function(){
    	$(this).css({'box-shadow':'none'});
    });
});
</script>
<body>
<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>
	<!-- 페이지 섹션 -->
	<section>
		<div id="content">
			<%
				for(Estimate es : esti){%>
					<div class="depart_div"><p><%=es.gete_destination() %></p></div>
					<div class="plan_div">
						<a href="plan_review_write.jsp?e_no=<%=es.gete_no()%>&e_destination=<%=es.gete_destination()%>&page_no=write&e_start_date=<%=es.gete_start_date() %>&e_end_date=<%=es.gete_end_date() %>">
							<div>
								<img src='img/icon/acc_trip_check.png'>
								<p><%=es.gete_start_date() %> ~ <%=es.gete_end_date() %></p>
							</div>
							<div>#<%=es.gete_thema() %>
								<%
									String detailTheme = es.gete_detail_thema();
									String replace = detailTheme.replaceAll(",", " ");
									String [] theme = replace.split(" ");
									
									for(int i = 0; i < theme.length ; i ++){%>
										#<%=theme[i] %>
									<%}
								%>
							</div>
						</a>
					</div>
			<%} %>
		</div>
	</section>
		<jsp:include page="main_footer.jsp" />	
</body>
</html>