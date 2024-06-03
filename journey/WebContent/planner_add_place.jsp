<%@page import="java.util.Arrays"%>
<%@page import="java.sql.Array"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jj.dto.Place"%>
<%@page import="com.jj.dto.Eatery"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<%@page import="com.jj.dto.Plan"%>
<!DOCTYPE html>
<%	request.setCharacterEncoding("utf-8");
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
	
	List<Plan> planList = (List<Plan>)request.getAttribute("plan");
	request.setAttribute("plan", planList);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Date sdate = sdf.parse(e_start_date);
	Date edate = sdf.parse(e_end_date);
	long datecnt = 1+(edate.getTime() - sdate.getTime()) /(1000*60*60*24);
	
	
	String e_no = request.getParameter("e_no");

	if(e_no == null){
		e_no = "null";	
	}

%>
<html>
<head>
	<meta charset="utf-8">
	<title>JourneyJoy_main</title>

	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css\planner_add_place.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>	
	<script type="text/javascript" src="js\planner_add_place.js"></script>
	<script
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAN8pqDt8WwrtCF3kkPS7Snko0A-RTUns0&callback=initMap&libraries=places&v=weekly"
      defer
    ></script>
</head>

<script type="text/javascript">

/**
 * @license
 * Copyright 2019 Google LLC. All Rights Reserved.
 * SPDX-License-Identifier: Apache-2.0
 */
let map;
let service;
let re;
let pla_url;
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

  var que = document.getElementById("search_place");
  
  var request = {
    location : loc,
    radius: '2500',
    query: que.value
  };
  
  service = new google.maps.places.PlacesService(map);
  service.textSearch(request, callback);

}

function callbackz(place, status) {
  if (status == google.maps.places.PlacesServiceStatus.OK) {
	pla_url = place.url; 
  }
}

function callback(results, status) {
  if (status == google.maps.places.PlacesServiceStatus.OK) {
	  var id = document.getElementsByName("place_num");
    for (var i = 0; i < results.length; i++) {
      var place = results[i];
      createMarker(results[i]);
      for(var j = 0; j < id.length; j++){
      	selectMarker(results[i], id[j].value,j);
      }
    } map.setCenter(results[0].geometry.location);
  }
}

function createMarker(place) {
  var infowindow = new google.maps.InfoWindow();
  if (!place.geometry || !place.geometry.location) return;

  const marker = new google.maps.Marker({
    map,
    position: place.geometry.location,
  });
  

  const re_request = {
	      placeId : place.place_id,
	      fields : ["price_level", "opening_hours","photos","url"]
	    };
  
  service.getDetails(re_request, callbackz);

  google.maps.event.addListener(marker, "click", () => {
    infowindow.setContent(place.name+"<br>"+place.formatted_address+"<br>리뷰점수 : "+place.rating+"<br>"+"<a href='"+pla_url+"'  style='color:blue;' target='_blank'>구글지도에서 정보보기</a>");
    
    infowindow.open(map, marker);
  });
  
}
function selectMarker(place, btn_place,j){
	var infowindow = new google.maps.InfoWindow();	
	if (!place.geometry || !place.geometry.location) return;
		if(place.place_id == btn_place){
		var btn = document.getElementsByClassName("pl_label");
		const marker_pick = new google.maps.Marker({
		    map,
		    position: place.geometry.location,
		  });
		
		btn[j].addEventListener('click', function(){
			infowindow.setContent(place.name+"<br>"+place.formatted_address+"<br>리뷰점수 : "+place.rating+"<br>"+"<a href='"+pla_url+"'  style='color:blue;' target='_blank'>구글지도에서 정보보기</a>");
			infowindow.open(map, marker_pick);
			map.setCenter(place.geometry.location);
			map.setZoom(15);
		 });
	}
}
window.initMap = initMap;
</script>

<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>
	<!-- 페이지 섹션 -->
	<section>
	<form action="planner_edit.jsp" method="post">
		<input type="hidden" name="e_no" value=<%=e_no %>>
		<div id="content">
			<div id="list_text">
				<p id="list_text">| 여행일정</p>
				<div id="day_div">	
					<%
						for(int a = 1 ; a <= datecnt ; a++){
									out.println("<p id='day"+a+"' onclick='day_select("+a+")'>Day"+a+"</p>");
								}
					%>	
				</div>
			</div>
			<div id="main_content">
			<div id="thema_div">
				<img src="img/icon/point.png">
				<p id="city"><%=e_destination%></p>
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
					<input type="button" name="edit_thema" value="수정하기" class="button" />
				</a>
			</div>
			<div id="plan_list">
						
				<div id="search">
					
					<input type="text" name ="search_place" id="search_place" placeholder ="이름, 테마로 검색"  />
					<img src="img/icon/search_btn.png" id="search_btn" />
					<div id="search_result">
						<div id="result_list">
					
					<%
					
					List<Place> pla = (List<Place>) request.getAttribute("search_place");
					List<Eatery> eat = (List<Eatery>) request.getAttribute("search_eatery");
					if(pla == null){
						out.println("<input type='radio' name='place_one' id='search_plz'><label for='search_plz' class='pl_label'>검색어를 입력해주세요.</label>");
						out.println("</div>");		
						for(int a = 1 ; a <= datecnt ; a++){
							out.println("<input type='button' id='plan_add"+a+"' value='여행지 추가' class='button' />");	
						}		
					}
					else{
						String locate;
						int z=-1;
						for(Place plalist : pla){
							z++;

							out.println("<input type='checkbox' name='place_one' value='"+plalist.getPlac_id()+"' id= 'pone"+z+"' onclick='checking(this.id)'>");
							out.println("<label for='pone"+z+"' class='pl_label'>"+plalist.getPlac_name()+"</label>");		
							out.println("<input type='hidden' name='place_num' value='"+plalist.getPlac_id()+"'>");
						}
						for(Eatery eatlist : eat){
							z++;

							out.println("<input type='checkbox' name='place_one' value='"+eatlist.getEat_id()+"' id= 'pone"+z+"' onclick='checking(this.id)'>");
							out.println("<label for='pone"+z+"' class='pl_label'>"+eatlist.getEat_name()+"</label>");		
							out.println("<input type='hidden' name='place_num' value='"+eatlist.getEat_id()+"'>");
						}
						out.println("</div>");		
						for(int a = 1 ; a <= datecnt ; a++){
							out.println("<input type='button' id='plan_add"+a+"' value='여행지 추가' class='button' onclick='plan_add_btn("+a+")'/>");	
						}	
					}
					%>					
				
							</div>		
						</div>	
						<div id="map"></div>
				<%
				for(int a = 1 ; a <= datecnt ; a++){ 
					String place_name = request.getParameter("place_name"+a);
					String place_cookie = getCookieValue(cookies, "pla"+a);

					String place_id = request.getParameter("place_ids"+a);
					System.out.println("aaaxx"+a+place_id);
					System.out.println("aaaxx"+a+place_name);
					String place_attr = (String) request.getAttribute("planList"+a);

					out.println("<div id='places"+a+"'>");
					out.println("<p class='my_place'>나의 여행지 (Day"+a+")</p>");
					if(place_name == null ){
						if(place_attr != null){
							out.println("<p id='places_text"+a+"'>"+place_attr+"</p>");
							out.println("<input type='hidden' name='edit_plan"+a+"' value='"+place_attr+"' id='edited"+a+"'>");
							out.println("<input type='hidden' name='edit_plan_id"+a+"'value='' id='edited_id"+a+"'>");
						}else{
							out.println("<p id='places_text"+a+"'>");
			
							String pa_list ="";						
							String place_edit = place_cookie.replaceAll("empty", "").replaceAll("-", " ");
							String [] pla_ck = place_edit.split("_");
							for(String pa : pla_ck){
								out.println("#"+pa);
								pa_list += "#"+pa+" ";
							}
						out.println("</p>");
				%>		
				<input type="hidden" name="edit_plan<%=a %>" value="<%=pa_list%>" id="edited<%=a%>">
				<input type="hidden" name="edit_plan_id<%=a %>" value="<%=place_id %>" id="edited_id<%=a %>">
				<% 	
						}
					}else{ 
					if(place_name.equals("empty")){
						System.out.println("aa");
						response.addCookie(new Cookie("pla"+a, ""));
						out.println("<p id='places_textb"+a+"'>일정이 비어있습니다.</p>");
						out.println("<p id='places_text"+a+"'></p>");
						out.println("<input type='hidden' name='edit_plan"+a+"'value='' id='edited"+a+"'>");
						out.println("<input type='hidden' name='edit_plan_id"+a+"'value='' id='edited_id"+a+"'>");
					}
					else{
						System.out.println("2번");
						String place_ck = place_name.replaceAll(",", "_").replaceAll("empty","");
						String []place = place_ck.split("_");
						String st_list = "";
						System.out.println("2번="+place_ck);
						out.println("<p id='places_text"+a+"'>");
							for(String st : place){
								out.println("#"+st);
								st_list += "#"+st+"_";
							}
						out.println("</p>");
						String st_list_arr = st_list.replaceAll("#", "").replaceAll(",", "_");
						System.out.println("2-2:"+st_list_arr);
						System.out.println("2-3:"+st_list);
						System.out.println("204:"+place_id);
				%>	 
				<input type="hidden" name="edit_plan<%=a%>" value="<%=st_list%>" id="edited<%=a%>">
				<input type="hidden" name="edit_plan_id<%=a %>" value="<%=place_id %>" id="edited_id<%=a %>">
				<% 
					}
				}
					out.println("</div>");
				}
				%>	
				<input type="hidden" name="edit_plan0" value="1">  
				
			
			</div>
			<input type="button" name="save_plan" value="저장" class="button">	
		</div>
			
		<div id="side_menu">
			<p id="side_menu_p" align="center">side menu</p>
			<input type="button" name="plan_sel" value="뒤로가기" class="button">
		</div>
			
			</div>
			</div>
		</form>
	</section>
	<footer>
	      <jsp:include page="main_footer.jsp" />	
	</footer>
</body>
</html>