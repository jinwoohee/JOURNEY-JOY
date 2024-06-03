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
		.package_like ul { /* 패키지-찜한 패키지 */
			list-style: none;
			padding-inline-start: 0px;
			margin-top: 0px;
		    margin-bottom: 0px;
		}
		
		.package_like li {
			padding-top: 25px;
    		padding-bottom: 25px;
		    border-bottom: 1px solid #ddd;
		}
		
		.pk_like_size {
			border-bottom: 1px solid #ddd;
		}
		
		.pk_like_size > p {
			margin-top: 0px;
			margin-bottom: 25px;
			width: fit-content;
		}
		
		.pk_like_size strong {
			color : #FA5252;
		}
		
		.pk_like_list { /* 찜한패키지 전체div */
			width: 100%;
			height: 200px;
			display: -webkit-box;
		}
		
		.pk_like_img { /* 찜한패키지 img div */
			width: 200px;
			height: 200px;
			margin-right: 40px;
		}
		
		.pk_like_img img { 
			width: 100%;
			height: 100%;
			object-fit: cover
		}
		
		.pk_like_cont { /* 찜한패키지 contents */
			width: 345px;
			height: 100%;
		    margin-right: 40px;
		}
		
		.pk_like_cont div {
			display: flow-root;
			margin-bottom: 10px;
		}
		
		.pk_like_cont p {
			margin-top: 0px;
		    margin-bottom: 0px;
		}
		
		.pk_like_tag {
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
		
		.pk_like_title { /* 제목 */
			font-size: 25px;
			overflow: hidden;
		    text-overflow: ellipsis;
		    display: -webkit-box;
		    -webkit-line-clamp: 4;
		    -webkit-box-orient: vertical;
		}
		
		.pk_like_plan { /* 여행일정 */
			font-size: small;
			font-weight: 600;
		}
		
		.pk_like_btn { /* 찜한패키지 버튼 div */
			height: 200px;
			display: flex;
		    align-items: center;
		}
		
		.pk_like_btn button {
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
		
		.pk_like_btn button:last-of-type {
			margin-top: 5px;
		}
		
		.pk_like_btn button:last-of-type:hover { /* 찜하기 취소버튼 */
		    color: red;
			border: 1px solid red;
		}
		
		.pk_like_btn_detail {
			display: grid;
		}
		
		
		
		.pk_like_blank { /* 찜한패키지 없을 때 div */
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
	<div class="pk_like_size">
		<p>찜한 패키지 <strong><%= plist.size() %></strong>개</p>
	</div>
	<ul>
	<% for (Package p : plist) { %>
		<li>
			<div class="pk_like_list">
				<div class="pk_like_img"><img src="uploadFile/<%= p.getP_file() %>" /></div>
				<div class="pk_like_cont">
					<div>
						<p class="pk_like_tag"><%= p.getP_nation() %></p>
						<p class="pk_like_tag"><%= p.getP_city() %></p>
					</div>
					<div>
						<p class="pk_like_title"><strong><%= p.getP_title() %></strong></p>
					</div>
				</div>
				<div class="pk_like_cont">
					<div>
						<p>※ 여행일정</p>
						<p class="pk_like_plan"><%= p.getP_start_date() %> ~ <%= p.getP_end_date() %></p>
					</div>
					<div>
						<p>※ 정원 / 가이드비용</p>
						<c:set var="pay" value="<%= p.getP_guide_pay() %>" />
						<fmt:formatNumber var="guide" value="${ pay }" />
						<p class="pk_like_plan"><%= p.getP_volume() %>명 / ${ guide }원</p>
					</div>
					<div>
						<p>※ 참여 마감날짜</p>
						<p class="pk_like_plan"><%= p.getP_due_date() %>까지</p>
					</div>
				</div>
				<div class="pk_like_btn">
					<div class="pk_like_btn_detail">
						<button>상세내역</button>
						<button>찜하기 취소</button>
					</div>
				</div>
			</div>
		</li>
	<% } %>
	</ul>
	<% } else { %>
	<div class="pk_like_blank">
		패키지가 존재하지 않습니다.
	</div>
	<%
	}
	%>
</body>
</html>