<%@page import="com.jj.dto.InqNotice"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- session -->
<%
	String u_id = (String) session.getAttribute("u_id");
	String loginChk;
	String joinChk;

	if(u_id != null){
		loginChk = u_id;
		joinChk = "로그아웃";
	}else{
		loginChk = "로그인";
		joinChk = "회원가입";
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>

<!-- 메인헤더 css -->
<link rel="stylesheet" type="text/css" href="css/main_header.css">

<!-- font -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<!-- 날짜 -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="css/jquery-ui.css">

</head>
<script>
$(function(){
	/* 메뉴바 */
	$('.main_menu, #sub_div, #main_menu_div').mouseover(function() { // 메인메뉴(5개짜리) 글자, div ,서브메뉴 에 마우스오버 시 서브메뉴나옴
		$('#sub_div').stop().slideDown(200);
	});
	$('#top_div, #sub_div, #main_menu_div').mouseout(function() { // 최상단 div(로고+메뉴+로그인), 서브메뉴 에스 마우스 오버시 서브메뉴 사라짐
		$('#sub_div').stop().slideUp(200);
	});
	$('.sub_menu_a').mouseover(function() {
		$(this).css({"font-weight":"bold"});
	});
	$('.sub_menu_a').mouseout(function() {
		$(this).css({"font-weight":"normal"});
	});
	
	$('.empty').click(function() { //로그인 없이 메뉴바 클릭시
		alert('로그인 후 이용해주세요');
	});
	
	/*헤더 색상변경*/
	$(window).scroll(function(){   
	   var scroll = $(window).scrollTop();
	   if (scroll > 1) {
	     $("#top_div, #sub_div").css({"background-color":"rgb(0,0,0,0.8"});
	     $(".sub_menu_a, .head_banner").css({"color":"#f1f1f3"});
	     $("#menu1").attr("src","img/header/mScroll-01.png");
	     $("#menu2").attr("src","img/header/mScroll-02.png");
	     $("#menu3").attr("src","img/header/mScroll-03.png");
	     $("#menu4").attr("src","img/header/mScroll-04.png");
	     $("#menu5").attr("src","img/header/mScroll-05.png");
	     $("#logo").attr("src","img/icon/lo_white.png");
	     $("#mypage_btn").attr("src","img/icon/mypage_btn_scroll.png");
	
	   }
	   else{
	     $("#top_div, #sub_div").css({"background-color":"white"});  
	     $(".sub_menu_a, .head_banner").css({"color":"#646464"});
	     $("#menu1").attr("src","img/header/menu-01.jpg");
	     $("#menu2").attr("src","img/header/menu-02.jpg");
	     $("#menu3").attr("src","img/header/menu-03.jpg");
	     $("#menu4").attr("src","img/header/menu-04.jpg");
	     $("#menu5").attr("src","img/header/menu-05.jpg");
	     $("#logo").attr("src","img/icon/logo.png");
	     $("#mypage_btn").attr("src","img/icon/mypage_btn.png");
	
	   }
	 });
      
	 
       $(window).on('load', function() { //page 띄우자마자 새알림 체크
    	  //console.log('window ready');
    	  var uid = $('input[name=uid]').val();
    	  
    	   $.ajax({
			  type : 'post',
			  data : {'u_id' : uid},
			  url : 'inquiryNotice.jj?page=inquiry_flag',
			  success : function(e) {
				  if (e > 0) { //새로운 알림 있으면
					  $('.alarm').attr('src', 'img/icon/alarm2.png');
				  } else {
					  $('.alarm').attr('src', 'img/icon/alarm.png');
				  }
			  }
		  }); 
      });
      
      $('.alarm').click(function() { //알람 버튼 클릭시
    	  var uid = $('input[name=uid]').val();
    	  
    	  $.ajax({ //문의하기 내용
			  type : 'post',
			  data : {'u_id' : uid},
			  url : 'inquiryNotice.jj?page=inquiry_notice',
			  success : function(data) {
				  if (data != null) {
					  $('.notice').html(data);
					  $.ajax({ //문의하기 알람 확인 update
		    			  type : 'post',
		    			  data : {'u_id' : uid},
		    			  url : 'inquiryNotice.jj?page=inquiry_updateFlag',
		    			  success : function(e) {
							console.log("flag update success!");
						  }
		        	  });
				  } else {
					  console.log("data null!");
				  }
			  }
		  });
    	  
    	  if ($('.noticeBox').css('display') == 'none') {
    		  $('.noticeBox').css('display', 'block');
    		  $('.alarm').attr('src', 'img/icon/alarm.png');
    	  } else {
    		  $('.noticeBox').css('display', 'none');
    		  $('.alarm').attr('src', 'img/icon/alarm.png');
    	  }
      });
      
      $('.adiv').blur(function() {
    	  $('.noticeBox').css('display', 'none');
		  $('.alarm').attr('src', 'img/icon/alarm.png');
	  }); 
      
});
	
/*마이페이지 가로 슬라이드부분*/
function showMenu(){
	$('#mypage' ).css( { 'display' : 'block' } );
	$('#mypage' ).css( { 'left' : '100%' } );
	//$('#mypage').css({'overflow' : 'hidden'});
	$('#mypage' ).animate( { "left": '0px' }, { duration: "200" },{ "animation-timing-function" : "ease"} );
}

function hideMenu(){
	//$('#mypage').css({'overflow' : 'visible'});
	$('#mypage' ).animate( { left: '100%' }, { duration: "200", complete:function(){ $('#mypage' ).css( { 'display' : 'none' } ); } } );
}

</script>
<body>
<header>
		<!-- 메뉴바 -->
		<div id="top_div">
			<a href="index.jsp">
				<img src="img/icon/logo.png" id="logo"/>
			</a>
			<div id="main_menu_div">
				<ul>
					<li class="main_menu"><img id='menu1' src='img/header/menu-01.jpg'></li>
					<li class="main_menu"><img id='menu2' src='img/header/menu-02.jpg'></li>
					<li class="main_menu"><img id='menu3' src='img/header/menu-03.jpg'></li>
					<li class="main_menu"><img id='menu4' src='img/header/menu-04.jpg'></li>
					<li class="main_menu"><img id='menu5' src='img/header/menu-05.jpg'></li>
				</ul>
			</div>
			<div id="login">
				<%
					if(loginChk.equals("로그인")){
						out.println("<a href='login.jsp' class='head_banner'>"+loginChk+"</a> &nbsp;&nbsp;&nbsp;");
					}else{
						out.println("<div tabindex='0' class='adiv'><img src='img/icon/alarm.png' class='alarm' /></div>"); //새로운 알람없을떄
						out.println("<a href='#' class='head_banner'>"+loginChk+"</a> &nbsp;&nbsp;&nbsp;");
					}

					if(joinChk.equals("회원가입")){
						out.println("<a href='join.jsp' class='head_banner'>"+joinChk+"</a>");
					}else{
						out.println("<a href='logout_session.jsp' class='head_banner'>"+joinChk+"</a>"); //로그아웃
					}
				%>
				<% if (u_id != null) { %>
					<img src="img/icon/mypage_btn.png" onclick="showMenu()" id="mypage_btn"/>
				<% } else { %>
					<a href="login.jsp"><img src="img/icon/mypage_btn.png" class="empty" id="mypage_btn"/></a>
				<% } %>
			</div>
		</div>

		<div id="sub_div">
			<div id="sub_menu_div">
				<% if (u_id != null) { %>
				<ul>
					<li><a href="planner_main.jsp" class="sub_menu_a">일정만들기</a></li>
					<li><a href="plan_page.jsp?paging=list" class="sub_menu_a">여행계획서</a></li>
				</ul>
				<ul>
					<li><a href="package_list.jj?page=packageSelect" class="sub_menu_a">패키지여행</a></li>
				</ul>
				<ul>
					<li><a href="classList.jj?page=clist&u_id=<%=u_id %>" class="sub_menu_a">모임</a></li>
					<li><a href="board.jsp" class="sub_menu_a">자유게시판</a></li>
				</ul>
				<ul>
					<li><a href="plan_review_list.jsp" class="sub_menu_a">일정리뷰</a></li>
					<li><a href="place_review.jsp" class="sub_menu_a">장소리뷰</a></li>
				</ul>
				<ul>
					<li><a href="workingholiday.jj?page=wh" class="sub_menu_a">워킹홀리데이</a></li>
				</ul>
				<% } else { %>
				<ul>
					<li class="empty"><a href="login.jsp" class="sub_menu_a">일정만들기</a></li>
					<li class="empty"><a href="login.jsp" class="sub_menu_a">여행계획서</a></li>
				</ul>
				<ul>
					<li class="empty"><a href="login.jsp" class="sub_menu_a">패키지여행</a></li>
				</ul>
				<ul>
					<li class="empty"><a href="login.jsp" class="sub_menu_a">모임</a></li>
					<li class="empty"><a href="login.jsp" class="sub_menu_a">자유게시판</a></li>
				</ul>
				<ul>
					<li class="empty"><a href="login.jsp" class="sub_menu_a">일정리뷰</a></li>
					<li class="empty"><a href="login.jsp" class="sub_menu_a">장소리뷰</a></li>
				</ul>
				<ul>
					<li class="empty"><a href="login.jsp" class="sub_menu_a">워킹홀리데이</a></li>
				</ul>
				<% } %>
			</div>
		</div>

		<!-- 마이페이지 -->
		<div id="mypage">
			<img src="img/icon/lo_white.png" id="logo"/>
			<ul id="mypage_ul">
				<li class="mypage_li"><h2>마이페이지</h2></li>
				<li class="mypage_li"><a href="mypage.jj?page=mypageUserInfo&u_id=<%= u_id %>&tab=myplan"><label>나의 여행계획서</label></a></li>
				<li class="mypage_li"><a href="mypage.jj?page=mypageUserInfo&u_id=<%= u_id %>&tab=mypackage"><label>패키지</label></a></li>
				<li class="mypage_li"><a href="mypage.jj?page=mypageUserInfo&u_id=<%= u_id %>&tab=myreview"><label>나의 리뷰보기</label></a></li>
				<li class="mypage_li"><a href="mypage.jj?page=mypageUserInfo&u_id=<%= u_id %>&tab=myinfo"><label>회원정보</label></a></li>
			</ul>
			<img src="img/icon/mypage_close.png" onclick="hideMenu()"/>
		</div>
		
		<!-- 알림창 -->
		<input type="hidden" name="uid" value="<%=u_id %>" />
		<div class="noticeBox">
			<div class="notice"></div>
		</div> 
	</header>
</body>
</html>