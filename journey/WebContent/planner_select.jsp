<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jj.dto.Place"%>
<%@page import="com.jj.dto.Eatery"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");
	Cookie[] cookies = request.getCookies();
%>
<%!private String getCookieValue(Cookie[] cookies, String name){
		String value = null;
		if(cookies == null)
			return null;
		for(Cookie cookie : cookies){
			if(cookie.getName().equals(name))
				return cookie.getValue();
		}
		return null;
	}%>
<%	
	String e_destination = getCookieValue(cookies, "e_destination");	
	String e_start_date = getCookieValue(cookies, "e_start_date");
	String e_end_date = getCookieValue(cookies, "e_end_date");
	String thema = getCookieValue(cookies, "e_thema");
	String d_thema = getCookieValue(cookies, "e_detail_thema");
	String volume = getCookieValue(cookies, "e_volume");
	String food_st = getCookieValue(cookies, "e_food_taste");
	String e_detail_thema = d_thema.replaceAll("_", ", ");
	String e_food_taste = food_st.replaceAll("_", ", ");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Date sdate = sdf.parse(e_start_date);
	Date edate = sdf.parse(e_end_date);
	long datecnt = 1+(edate.getTime() - sdate.getTime()) /(1000*60*60*24);
	
	System.out.println(e_destination);
	
	List<Eatery> eat = (List<Eatery>) request.getAttribute("eatery");
	List<Place> pla = (List<Place>) request.getAttribute("place");

%>
<html>
<head>
	<meta charset="utf-8">
	<title>JourneyJoy_main</title>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css\planner_select.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script type="text/javascript" src="js\planner_select.js"></script>	
	<script
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAN8pqDt8WwrtCF3kkPS7Snko0A-RTUns0&callback=initMap&libraries=places&v=weekly"
      defer
    ></script>
    
</head>
<script>
let map;
let service;
function initMap() {
	var loc= "";
	var wh = document.getElementById("city").innerText;
	
	if(wh === "도쿄"){
		loc =  {lat : 35.68111, lng : 139.76667};
	}else if (wh === "오사카"){
		loc = {lat : 34.6937378, lng : 135.5021651};
	}

  map = new google.maps.Map(document.getElementById("map"), {
    center: loc,
    zoom: 12,
  });
  service = new google.maps.places.PlacesService(map);
  
  select();
}
	
function select(){
	var day = document.getElementsByClassName("list_content").length;
	  for(var a = 1 ; a <= day; a++){
		  var pla = document.getElementById("pht_id"+a);

		  const re_request = {
			      placeId : pla.value,
			      fields : ["photos","name"]
			    };
		
		service.getDetails(re_request, callback);
	}
}

function img_fix(img_src, name){
	var a = 0;
	var img_v = document.getElementsByName("img_fix");
	
	for(a = 0; a < img_v.length ; a++){
		var b = a+1;
		var name_v = document.getElementsByName("select_values"+b);
		if(name == name_v[0].value){

			img_v[a].setAttribute("src", img_src);
			
			break;
		}else{
			
		}
	}
}

function callback(place, status) {
	  if (status == google.maps.places.PlacesServiceStatus.OK) {
		var photos = place.photos;
		
		var pla_ph = photos[0].getUrl();
		
		img_fix(pla_ph, place.name);
	  }
	}
	
window.initMap = initMap;
</script>
<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>
	<!-- 페이지 섹션 -->
	<section>
	<form action="planner_edit.jsp" method="post" onsubmit="return check_plan()">
		<div id="content">
			<div id="list_text">
				<p id="list_text">| 여행일정 선택</p>
			</div>
			<div id="main_content" >
			<div id="thema_div">
				<img src="img/icon/point.png">
				<p id="city"><%= e_destination %></p>
				<hr>
				<p id="thema">여행테마</p>
				<img src="img\icon\arrow_up.png" width="23px" height="23px" id="up"/>			
				<img src="img\icon\arrow_down.png" width="23px" height="23px" id="down"/>
				<div id="detail_div">
					<div><p class="thema_text">#<%= thema %></p></div>
					<div><p class="thema_text">#<%= volume %></p></div>
					<div><p class="sub_thema">#<%= e_detail_thema %></p></div>
					<div><p class="sub_thema">#<%= e_food_taste %></p></div>
				</div>
				<a href="planner_main.jsp">
					<input type="button" name="edit_thema" value="테마수정하기" class="button" />
				</a>						
			</div>		
			
			<div id="plan_list">
				<%
				for(int a = 1 ; a <= datecnt*3 ; a++){
				%>
					<div class="list_content">
					
					<img src="" id="place_pic<%=a %>" name="img_fix"/>
					
					
					<input type="hidden" name="aaaaaa" value="">
					<div class="content_fdiv"> 
						<div class="list_place">
							<p class="list_place">
							<%
							for(int b = (a-1)*2 ; b <= (a-1)*2+1 ; b++){
								out.println("#"+pla.get(b).getPlac_name()+"&nbsp;");
								out.println("<input type='hidden' name='select_values"+a+"' value='"+pla.get(b).getPlac_name()+"'>");
								if( b% 2 == 0){
									out.println("<input type='hidden' name='pht_id"+a+"' value='"+pla.get(b).getPlac_id()+"' id='pht_id"+a+"'>");
								}
								else{
									out.println("<input type='hidden' name='pht_id"+a+"' value='"+pla.get(b).getPlac_id()+"' >");
								}
							}
							for(int c = (a-1)*3 ; c <= (a-1)*3+2 ; c++){
								out.println("#"+eat.get(c).getEat_name()+"&nbsp;&nbsp");
								out.println("<input type='hidden' name='select_values"+a+"' value='"+eat.get(c).getEat_name()+"'>");
								out.println("<input type='hidden' name='pht_id"+a+"' value='"+eat.get(c).getEat_id()+"' >");
								}				
							%>
							</p>
						</div>
						<div class="list_thema">
						 	<%
							for(int b = (a-1)*2 ; b <= (a-1)*2+1 ; b++){
								out.println("<p class='list_thema'>"+pla.get(b).getPlac_detail_thema().substring(0, pla.get(b).getPlac_detail_thema().length() - 1)+"</p>");								
							}
							for(int c = (a-1)*3 ; c <= (a-1)*3+2 ; c++){
								out.println("<p class='list_thema'>"+eat.get(c).getEat_food_taste().substring(0, eat.get(c).getEat_food_taste().length() - 1)+"</p>");							
							} 
							%>
						</div>
						<div class="select_btn_div">
							<input type="button" name="select" value="일정추가" class="button" onclick="add_plan(<%=a%>)">
						</div>
					</div>
					<div class="content_detail">
						<div class="list_budget">
							<p>평균예산</p>
							<p>약 99,000 ~</p>
						</div>
							<input type="button" name="detail" value="일정 상세보기" class="button" onclick="detail_open(<%=a%>)">
					</div>
				</div>
				<%						
					}				
				%>
				</div>
				<div id='more_div'>
            		<input type="button" name="more_btn" value="일정 더보기" class="button">
          	 	 </div>
				<input type="button" name="finish_btn" value="선택완료" class="button" />			
			</div>
		</div>
		<div id="select_div">
			<div id="select_plan_div">
				<div id="sel">
				<%
				for(int a = 1 ; a <= datecnt ; a++){
				%>
					<input type="hidden" id="next_a<%=a %>" value="none">
					<div class="select_plan">
						<p class="day">DAY<%=a %></p>
						<img src="img\icon\select_plz.png" id="select_pic<%= a %>" class = "sel_picture"/>
						<input type="button" name="del<%=a %>" value="삭제" class="button" onclick="del_plan(<%=a%>)"/>
						<input type="hidden" name="selected<%=a %>" class= "selected" value="null" >
						<input type="hidden" name="id_selected<%=a %>" class="selected_id" value="null">
					</div>
				<%}%>
				</div>
				<input type="button" name="close" value="닫기" class="button" />
					<input type="button" name="finish" value="선택완료" class="button" />			
			</div>
		</div>
			<div id="side_menu">
				<p id="side_menu_p" align="center">side menu</p>
				<input type="button" name="open" value="목록열기" class="button" />
			</div>
			</form>
			
			<div id="map"></div>
	</section>
		
	<footer>
		<jsp:include page="main_footer.jsp" />	
	</footer>
</body>
</html>