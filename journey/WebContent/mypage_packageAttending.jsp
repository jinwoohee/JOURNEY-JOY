<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jj.dto.Package" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<style type="text/css">
		.package_attending ul { /* 패키지-패키지 참여내역 */
			list-style: none;
			padding-inline-start: 0px;
			margin-top: 0px;
		    margin-bottom: 0px;
		}
		
		.package_attending li {
			padding-top: 25px;
    		padding-bottom: 25px;
		    border-bottom: 1px solid #ddd;
		}
		
		.pk_asize {
			border-bottom: 1px solid #ddd;
		}
		
		.pk_asize p {
			margin-top: 0px;
			margin-bottom: 25px;
			width: fit-content;
		}
		
		.pk_asize strong {
			color : #FA5252;
		}
		
		.pk_alist { /* 패키지 참여내역 전체div */
			width: 100%;
			height: 200px;
			display: -webkit-box;
		}
		
		.pk_alist > div:nth-of-type(3) {
			line-height: 26px;
		}
		
		.pk_aimg { /* 패키지 참여내역 img div */
			width: 200px;
			height: 200px;
			margin-right: 40px;
		}
		
		.pk_aimg img { 
			width: 100%;
			height: 100%;
			object-fit: cover
		}
		
		.pk_acont { /* 패키지 참여내역 contents */
			width: 345px;
		    height: 100%;
		    margin-right: 40px;
		}
		
		.pk_acont div {
			display: flow-root;
			margin-bottom: 10px;
		}
		
		.pk_acont p {
			margin-top: 0px;
		    margin-bottom: 0px;
		}
		
		.pk_atag {
			float: left;
		    border: 1px solid #6C94B8;
		    border-radius: 50px;
		    width: fit-content;
		    height: fit-content;
		    color: #6C94B8;
		    font-weight: 600;
		    text-align: center;
		    margin-right: 10px;
		    padding: 1px 7px;
		    background-color: white;
		}
		
		.pk_atitle { /* 제목 */
			font-size: 25px;
			overflow: hidden;
		    text-overflow: ellipsis;
		    display: -webkit-box;
		    -webkit-line-clamp: 4;
		    -webkit-box-orient: vertical;
		}
		
		.pk_aplan { /* 여행일정 */
			font-size: small;
			font-weight: 600;
		}
		
		.pk_abtn { /* 패키지 참여내역 버튼 div */
			height: 200px;
			display: flex;
		    align-items: center;
		}
		
		.pk_abtn button {
			width: 110px;
		    height: 46px;
			color: #6C94B8;
			font-size: 15px;
			font-weight: 600;
		    font-family: "Noto Sans KR", sans-serif;
		    background-color: white;
			border: 1px solid #6C94B8;
			border-radius: 4px;
		}
		
		.pk_abtn button:last-of-type {
			margin-top: 5px;
		}
		
		.pk_abtn button:last-of-type:hover { /* 참여취소 버튼 */
		    color: red;
			border: 1px solid red;
		}
		
		.pk_abtn_detail {
			display: grid;
		}
		
		
		
		.pk_ablank { /* 패키지 참여내역 없을 때 div */
			text-align: center;
		    font-size: 18px;
		    font-weight: 600;
		}
	</style>
	
	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
</head>
<body>
	<%
	ArrayList<Package> plist = (ArrayList<Package>)request.getAttribute("plist");
	
	if (plist.size() != 0) {
	%>
	<div class="pk_asize">
		<p>패키지 참여내역 <strong><%= plist.size() %></strong>개</p>
	</div>
	<ul>
	<% for (Package p : plist) { %>
		<li>
			<div class="pk_alist">
				<div class="pk_aimg"><img src="uploadFile/<%= p.getP_file() %>" /></div>
				<div class="pk_acont">
					<div>
						<p class="pk_atag"><%= p.getP_nation() %></p>
						<p class="pk_atag"><%= p.getP_city() %></p>
					</div>
					<div>
						<p class="pk_atitle"><strong><%= p.getP_title() %></strong></p>
					</div>
				</div>
				<div class="pk_acont">
					<div>
						<p>※ 여행일정</p>
						<p class="pk_aplan"><%= p.getP_start_date() %> ~ <%= p.getP_end_date() %></p>
					</div>
					<div>
						<p>※ 정원 / 가이드비용</p>
						<c:set var="pay" value="<%= p.getP_guide_pay() %>" />
						<fmt:formatNumber var="guide" value="${ pay }" />
						<p class="pk_aplan"><%= p.getP_volume() %>명 / ${ guide }원</p>
					</div>
					<div>
						<p>※ 참여 마감날짜</p>
						<p class="pk_aplan"><%= p.getP_due_date() %>까지</p>
					</div>
				</div>
				<div class="pk_abtn">
					<div class="pk_abtn_detail">
						<button>상세내역</button>
						<button>참여 취소</button>
					</div>
				</div>
			</div>
		</li>
	<% } %>
	</ul>
	<% } else { %>
	<div class="pk_ablank">
		패키지가 존재하지 않습니다.
	</div>
	<%
	} 
	%>
</body>
</html>