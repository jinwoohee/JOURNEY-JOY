<%@page import="com.jj.dto.Place"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jj.dto.Location_review"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<style type="text/css">
		.place_review > ul { /* 장소리뷰 */
			list-style: none;
			padding-inline-start: 0px;
			margin-top: 0px;
		    margin-bottom: 0px;
		    display: flex;
		}
		
		.pc_li {
			width: calc((100% - 115px) / 2);
		    border: 1px solid #666666;
		    border-radius: 10px;
		    padding: 20px;
		    float: left;
			margin-bottom: 25px;
		}
		
		.pc_wrap > li:nth-of-type(2n-1) {
			margin-right: 30px;
		}
		
		.pc_size {
			border-bottom: 1px solid #ddd;
			margin-bottom: 25px;
		}
		
		.pc_size p {
			margin-top: 0px;
			margin-bottom: 25px;
			width: fit-content;
		}
		
		.pc_size strong {
			color : #FA5252;
		}
		
		.pc_wrap {
			width: 100%;
		}
		
		.pc_list { /* 장소리뷰 전체div */
			width: 100%;
			height: 300px;
			display: -webkit-box;
		}
		
		.pc_title {
			width: 200px;
		    height: 100%;
		    margin-right: 40px;
		}
		
		.pc_imgBox { /* 장소리뷰 img div */
			width: 200px;
			height: 200px;
			overflow: hidden;
		}
		
		.pc_img {
			/*width: 200px;
			height: 100%;*/
		}
		
		.slides { /* img ul */
		    /*width: 600px;
		    height: 100%;*/
		    list-style: none;
		    padding-inline-start: 0px;
    	}
    	
    	.slide { /* img li */
    		/*width: 200px;
		    height: 100%;*/
		    float: left;
    	}
		
		.slide img { 
			/*width: 200px;
			height: 100%;*/
			object-fit: cover
		}
		
		.slider_nav {
			position: relative;
		    z-index: 10;
		    top: -26px;
		    left: 78px;
		    width: fit-content;
		}
		
		.dot {
			list-style: none;
		    border: 0.15em solid #9E9E9E;
		    box-sizing: border-box;
		    width: 1em;
		    height: 1em;
		    display: inline-block;
		    border-radius: 50%;
		    vertical-align: middle;
		    font-size: 12px;
			background-color: #ffffff1c;
		}
		
		.pc_pname {
			width: 100%;
		    height: calc(100% - 210px);
		    margin-top: 10px;
		}
		
		.pc_pname p {
			margin-top: 0px;
		    margin-bottom: 0px;
		    overflow-y: auto;
		    /* width: 100%; */
		    height: 100%;
		    font-weight: 600;
		}
		
		.pc_cont { /* 장소리뷰 contents */
			width: calc(100% - 240px);
			height: 100%;
		}
		
		.pc_cont div {
			margin-bottom: 10px;
		}
		
		.pc_cont p {
			margin-top: 0px;
		    margin-bottom: 0px;
		}
		
		.pc_date {
			font-size: 12px;
		    color: #ccc;
			display: flex;
		    justify-content: space-between;
		}
		
		.pc_star {
			
		}
		
		.pc_star label{
			font-size: 22px;
			color: #fc0;
		}
		
		/* 별점 */
		.star {
			appearance: none;
			margin: 0;
		}
		
		.pc_cont_detail {
			height: calc(100% - 42px);
			display: grid;
		    align-content: space-between;
		}
		
		.pc_detail {
			overflow-y: auto;
    		margin-bottom: 5px;
		}
		
		.pc_btn { /* 장소리뷰 버튼 div */
			/*height: calc(100% - 114px); */
			display: flex;
		    justify-content: flex-end;
		}
		
		.pc_btn button {
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
		
		.pc_btn button:hover {
			color: red;
			border: 1px solid red;
		}
		
		.pc_blank { /* 장소리뷰 없을 때 div */
			/* text-align: center; */
		    font-size: 18px;
		    font-weight: 600;
			height: 200px;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		}
	</style>
	
	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script type="text/javascript">
		$(function() {
			var width = 200;
			var height = 200;
			var li = $('.pc_li').size();
			var totalDot = $('.dot').size();
			var totalSlides = totalDot/li;
			
			var currentSlide = 2; //이 항목은 수정하지 않음
			var action;
			var dotNum;
			var dMinusC;
			
			function initSlider() {
				$('.pc_img').css('width', width);
				$('.pc_img').css('height', height);
				$('.slides').css('margin-left', 0);
				$('.slides').css('width', totalSlides*width);
				$('.slide').css('width', width);
				$('.slide').css('height', height);
				$('.slide img').css('width', width);
				$('.slide img').css('height', height);
			}
			
			$('.dot').click(function() {
				var $dots = $(this).parent();
				var $slideUl = $(this).parent().siblings('.pc_img').find('.slides');
				
				dotNum = $(this).attr('id');
				dotNum = parseInt(dotNum.substring(7))+1;
				dMinusC = dotNum-currentSlide;
				
				$dots.find('span').css({'background-color' : '#ffffff1c'});
				$(this).css({'background-color' : '#9E9E9E'});
				$slideUl.animate({'margin-left' : '-=' + (dMinusC*width)}, 100);
			});
			
			initSlider();
		});
	</script>
</head>
<body>
	<%
	ArrayList<Location_review> lrList = (ArrayList<Location_review>)request.getAttribute("lrList");
	ArrayList<Place> pclist = (ArrayList<Place>)request.getAttribute("pclist");
	
	if (lrList.size() != 0) {
	%>
	<div class="pc_size">
		<p>장소리뷰 <strong><%= lrList.size() %></strong>개</p>
	</div>
	<ul>
		<div class="pc_wrap">
			<% for (Location_review lr : lrList) { %>
			<li class="pc_li">
				<div class="pc_list">
					<div class="pc_title">
						<div class="pc_imgBox">
							<% 
							String str = "";
							if (lr.getLr_file1() != null) {
								str += lr.getLr_file1() + ",";
							}
							
							if (lr.getLr_file2() != null) {
								str += lr.getLr_file2() + ",";
							}
							
							if (lr.getLr_file3() != null) {
								str += lr.getLr_file3() + ",";
							}
							
							str = str.substring(0, str.length() - 1);
							String[] imgs = str.split(",");
							
							if (imgs.length == 3) {
							%>
							<div class="pc_img">
								<ul class="slides">
									<li class="slide"><img src="uploadFile/<%= imgs[0] %>" /></li>
									<li class="slide"><img src="uploadFile/<%= imgs[1] %>" /></li>
									<li class="slide"><img src="uploadFile/<%= imgs[2] %>" /></li>
								</ul>
							</div>
							<div class="slider_nav">
								<span class="dot" id="nav_dot1" style="background-color:#9E9E9E"></span>
								<span class="dot" id="nav_dot2"></span>
								<span class="dot" id="nav_dot3"></span>
							</div>
							<% } else if (imgs.length == 2) { %>
							<div class="pc_img">
								<ul class="slides">
									<li class="slide"><img src="uploadFile/<%= imgs[0] %>" /></li>
									<li class="slide"><img src="uploadFile/<%= imgs[1] %>" /></li>
								</ul>
							</div>
							<div class="slider_nav">
								<span class="dot" id="nav_dot1" style="background-color:#9E9E9E"></span>
								<span class="dot" id="nav_dot2"></span>
							</div>
							<% } else if (imgs.length == 1) { %>
							<img src="uploadFile/<%= imgs[0] %>" />
							<% } else if (imgs.length == 0) { %>
							<img src="img/travel/travel1.jpg" />
							<% } %>
						</div>
						<div class="pc_pname">
							<p>
							<%
							for (Place p : pclist) {
								if (lr.getPl_eat_no() == p.getPlac_no())
							%>
							<%= p.getPlac_name() %>
							<%
							}
							%>
							</p>
						</div>
					</div>
					<div class="pc_cont">
						<div class="pc_date">
							<p class="pc_star">
								<%
								for (int i = 1; i < 6; i++) {
									if (i <= lr.getLr_star()) {
								%>
								<input type="radio" class="star" value="<%= i %>"><label>★</label>
								<% 	} else { %>
								<input type="radio" class="star" value="<%= i %>"><label>☆</label>
								<%
									}
								}
								%>
							</p>
							<p><%= lr.getLr_date() %></p>
						</div>
						<div class="pc_cont_detail">
							<p class="pc_detail"><%= lr.getLr_contents() %></p>
							<p class="pc_btn">
								<button>리뷰삭제</button>
							</p>
						</div>
					</div>
				</div>
			</li>
			<% } %>
		</div>
	</ul>
	<% } else { %>
	<div class="pc_blank">
		장소리뷰가 존재하지 않습니다.
	</div>
	<% } %>
</body>
</html>