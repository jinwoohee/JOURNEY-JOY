<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.jj.dto.Package" %>
<%@page import="com.jj.dto.Package_schedule"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map.Entry"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<style>
		.package_making ul { /* 패키지-패키지 기획내역 */
			list-style: none;
			padding-inline-start: 0px;
		    margin-bottom: 0px;
		}
		
		.package_making li {
			margin-top: 25px;
			padding-bottom: 25px;
		    border-bottom: 1px solid #ddd;
		}
		
		.package_making > p {
			margin-top: 0px;
			margin-bottom: 0px;
		}
		
		.pk_list { /* 패키지 기획내역 전체div */
			width: 1200px;
			display: -webkit-box;
		}
		
		.pk_img { /* 패키지 기획내역 img div */
			width: 300px;
			height: 300px;
			margin-right: 40px;
		}
		
		.pk_img img { 
			width: 100%;
			height: 100%;
			object-fit: cover
		}
		
		.pk_cont { /* 패키지 기획내역 contents */
			width: 730px;
		}
		
		.pk_cont div {
			display: flow-root;
			margin-bottom: 15px;
		}
		
		.pk_cont div:last-of-type {
			display: block;
		}
		
		.pk_cont p {
			margin-top: 0px;
		    margin-bottom: 0px;
		}
		
		.pk_cont table { /* 패키지 기획내역-요금 */
			width: 600px;
			border: 1px #0D112D solid;
		    font-size: 15px;
		    box-shadow: 0 2px 5px rgba(0,0,0,.25);
		    border-collapse: collapse;
		    border-radius: 4px;
		    overflow: hidden;
		    text-align: center;
		}
		
		.pk_cont table td {
			border-right: 0.1em solid #f1f1f3;
			width: fit-content;
			background: white;
		}
		
		.pk_cont table tr:first-of-type td {
			background: #6C94B8;
		    color: #f1f1f3;
		    font-size: 15px;
		    font-weight: bold;
		}
		
		.pk_cont table tr:first-of-type td p {
			font-size: 9px;
			color: #ccc;
		}
		
		.pk_cont table tr:last-of-type td {
			
		}
		
		.pk_tag {
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
		
		.pk_title {
			font-size: 25px;
		}
		
		.pk_plan { /* 여행일정 */
			font-size: small;
			font-weight: 600;
		}
		
		.pk_btn { /* 패키지 기획내역 수정버튼 div */
			height: 300px;
			display: flex;
		    align-items: flex-end;
		}
		
		.pk_btn button {
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
		
		.pk_update_btn { /* 패키지 기획내역 수정버튼 세부div */
			position: relative;
		    top: 303px;
			right: 120px;
		    /* display: inline-grid; */
		    z-index: 5;
		    border: 1px solid #6c94b8;
		    border-radius: 4px;
		    box-shadow: 0 2px 5px rgba(0,0,0,.25);
		    padding: 10px 1px;
		    width: 130px;
		    height: 120px;
		    background-color: white;
		}
		
		.pk_update_btn button {
			width: 100%;
		    height: 40px;
		    font-size: 13px;
		    letter-spacing: -1px;
		    background-color: white;
		    border: none;
		    box-sizing: border-box;
		}
		
		.pk_update_btn button:hover {
			background-color: #f4f6fa;
		    color: #6c94b8;
		}
		
		.pk_blank { /* 패키지 기획내역 없을 때 div */
			text-align: center;
		    font-size: 18px;
		    font-weight: 600;
		}
	</style>
	
	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script type="text/javascript">
		$(function() {
			$('.pk_update_btn').hide();
			
			$('.pk_btn button').click(function() { //수정하기 버튼 클릭시
				if ($(this).parent().siblings('.pk_update_btn').css('display') == 'none') {
					$(this).parent().siblings('.pk_update_btn').show();
				} else {
					$(this).parent().siblings('.pk_update_btn').hide();
				}
			});
			
			$('.pk_btn button').blur(function() { //수정하기 버튼 blur
				$('.pk_update_btn').hide();
			});
		});
	</script>
</head>
<body>
	<%
	ArrayList<Package> plist = (ArrayList<Package>)request.getAttribute("package");
	HashMap<String, ArrayList<Package_schedule>> map = (HashMap<String, ArrayList<Package_schedule>>)request.getAttribute("packagesche"); //패키지 일정
	HashMap<String, ArrayList<Package_schedule>> map3 = (HashMap<String, ArrayList<Package_schedule>>)request.getAttribute("place"); //패키지 일정-장소
	HashMap<String, ArrayList<Package>> map2 = (HashMap<String, ArrayList<Package>>)request.getAttribute("reward");
	
	if (plist.size() != 0) {
	%>
	<p>패키지 기획내역 <strong><%= plist.size() %></strong>개</p>
	<ul>
	<% for (Package p : plist) { %>
		<li>
			<div class="pk_list">
				<div class="pk_img"><img src="uploadFile/<%= p.getP_file() %>" /></div>
				<div class="pk_cont">
					<div>
						<p class="pk_tag"><%= p.getP_nation() %></p>
						<p class="pk_tag"><%= p.getP_city() %></p>
					</div>
					<div>
						<p class="pk_title"><strong><%= p.getP_title() %></strong></p>
					</div>
					<div>
						<p>※ 요금</p>
						<%
						for (Entry<String, ArrayList<Package>> e2 : map2.entrySet()) {
							if (p.getP_no() == Integer.parseInt(e2.getKey())) {
								ArrayList<Package> rlist = e2.getValue();
								for (Package r : rlist) {
						%>
						<c:set var="f1" value="<%= r.getAdult_fee() %>" />
						<c:set var="f2" value="<%= r.getStd_fee() %>" />
						<c:set var="f3" value="<%= r.getChild_fee() %>" />
						<fmt:formatNumber var="adult" value="${ f1 }" />
						<fmt:formatNumber var="std" value="${ f2 }" />
						<fmt:formatNumber var="child" value="${ f3 }" />
						
						<table cellpadding="10px">
							<tr>
								<td>구분</td>
								<td>성인<p>만 12세이상</p></td>
								<td>아동<p>만 12세미만</p></td>
								<td>유아<p>만 2세미만</p></td>
							</tr>
							<tr>
								<td>기본상품</td>
								<td>${ adult }원</td>
								<td>${ std }원</td>
								<td>${ child }원</td>
							</tr>
						</table>
						<%
								}
							} 
						}
						%>
					</div>
					<div>
						<p>※ 여행일정</p>
					<% 
					for (Entry<String, ArrayList<Package_schedule>> e : map.entrySet()) {
						if (p.getP_no() == Integer.parseInt(e.getKey())) {
							ArrayList<Package_schedule> alist = e.getValue();
							for (Package_schedule ps : alist) {
					%>
						<p class="pk_plan">
							<%= ps.getPs_day() %>일차 - 
							<%
							for (Entry<String, ArrayList<Package_schedule>> e3 : map3.entrySet()) {
								if (p.getP_no() == Integer.parseInt(e3.getKey())) {
									ArrayList<Package_schedule> pclist = e3.getValue();
									String str = "";
									String schedule = ps.getPs_schedule().replaceAll(" ", ""); //공백제거
									String[] arr = schedule.split(",");
									//System.out.println(Arrays.toString(arr));
									for (Package_schedule pc : pclist) {
										for (int i = 0; i < arr.length; i++) {
											if (arr[i].equals(Integer.toString(pc.getPlac_no()))) {
												str += pc.getPlac_name() + ", ";
											}
										}
									}
									if (str != "") {
										str = str.substring(0, str.length() - 2);
										out.println(str);
									}
								}
							}
							%>
						</p>
					<% 
							}
						} 
					}
					%>
					</div>
				</div>
				<div class="pk_btn">
					<button>수정하기</button>
				</div>
				<div tabindex='0' class="pk_update_btn">
					<button class="pk_update_cont">패키지 상세내용</button>
					<button class="pk_update_plan">패키지 일정</button>
					<button class="pk_update_reward">패키지 리워드</button>
				</div>
			</div>
		</li>
	<% } %>
	</ul>
	<% } else { %>
	<div class="pk_blank">
		패키지가 존재하지 않습니다.
	</div>
	<% } %>
</body>
</html>