
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jj.dto.Estimate"%>
<%@page import="com.jj.dto.Schedule"%>
<%@page import="com.jj.dto.Plan"%>
<%@page import="com.jj.dto.Place"%>
<%@page import="com.jj.dto.Eatery"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>

<%	
request.setCharacterEncoding("utf-8");
List<Estimate> esti = (List<Estimate>) request.getAttribute("estimate");
List<Schedule> sche = (List<Schedule>) request.getAttribute("schedule");
List<Plan> planList = (List<Plan>)request.getAttribute("plan");
List<Eatery> eate = (List<Eatery>) request.getAttribute("eatList");
List<Place> plac = (List<Place>) request.getAttribute("plaList");
System.out.println("사이즈"+plac.size());
request.setAttribute("plan", planList);

String paging = (String) request.getAttribute("paging");

String e_destination = esti.get(0).gete_destination();
String e_start_date = esti.get(0).gete_start_date();
String e_end_date = esti.get(0).gete_end_date();
String thema = esti.get(0).gete_thema();
String d_thema = esti.get(0).gete_detail_thema();
String volume = esti.get(0).gete_volume();
String food_st = esti.get(0).gete_food_taste();

String [] e_detail_thema = d_thema.split(",");
String [] e_food_taste = food_st.split(",");
String e_no = esti.get(0).gete_no()+"";

String food_arr = food_st.replaceAll(",", "_");
String thema_arr = d_thema.replaceAll(",", "_");


response.addCookie(new Cookie("e_destination", e_destination));
response.addCookie(new Cookie("e_start_date", e_start_date));
response.addCookie(new Cookie("e_end_date", e_end_date));
response.addCookie(new Cookie("e_thema", thema));
response.addCookie(new Cookie("e_detail_thema", thema_arr));
response.addCookie(new Cookie("e_volume", volume));
response.addCookie(new Cookie("e_food_taste", food_arr));

String sdt = e_start_date.replaceAll("-", ".");
String edt = e_end_date.replaceAll("-", ".");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
Date sdate = sdf.parse(e_start_date);
Date edate = sdf.parse(e_end_date);
long datecnt = 1+(edate.getTime() - sdate.getTime()) /(1000*60*60*24);
System.out.println("플랜editx22"+paging);

String day = datecnt+"";
response.addCookie(new Cookie("datecnt",day));
System.out.println("edit_edit로 왔다 e_no : "+e_no);
%>
<html>
<head>
	<meta charset="utf-8">
	<title>JourneyJoy_main</title>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css\planner_edit.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script type="text/javascript" src="js\planner_edit.js"></script>
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
	var day = document.getElementById("day_cnt");
	  for(var a = 1 ; a <= day.value; a++){
		  var img_id = document.getElementsByName("place_id_src"+a);
		  for(var i=0 ; i < img_id.length ; i++){
			  const re_request = {
				      placeId : img_id[i].value,
				      fields : ["name","photos","url"]
				    };
			  
			service.getDetails(re_request, callback);
		  }
	}
}

function img_fix(img_src, pla_url,name){
	var day = document.getElementById("day_cnt");
	
	for(var a = 1; a <= day.value ; a++){
		var img_v = document.getElementsByName("pla_img"+a);
		var url_v = document.getElementsByName("pla_url"+a);
		var name_v = document.getElementsByClassName("list_place"+a);

		for(var i = 0 ; i < img_v.length; i++){
			if(name == name_v[i].innerText.replaceAll("#","")){
				
				img_v[i].setAttribute("src", img_src);
				url_v[i].setAttribute("href",pla_url);
				
				break;
			}else{
				
			}
		}
	}
}

function callback(place, status) {
	  if (status == google.maps.places.PlacesServiceStatus.OK) {
		var photos = place.photos;
		
		var pla_ph = photos[0].getUrl();
		var pla_url = place.url; 
		img_fix(pla_ph, pla_url, place.name);
	  }
	}
	
window.initMap = initMap;
</script>
<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>
	<!-- 페이지 섹션 -->
	<section>
	<form action="planner.jj?page=schedule_update" method="post">
		<div id="content">
			<div id="list_text">
				<p id="list_text">여행일정</p>
				<div id="day_div">
					
					<%
						for(int a = 1 ; a <= datecnt ; a++){ 
						
							out.println("<p id='day"+a+"' onclick='day_select("+a+")'>Day"+a+"</p>");
						}
						String d_th = d_thema.replaceAll(",",", ");
						String f_st = food_st.replaceAll(",",", ");
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
					<div><p class="thema_text"><%=thema%></p></div>
					<div><p class="thema_text"><%=volume%></p></div>
					<div><p class="sub_thema"><%=d_th %></p></div>
					<div><p class="sub_thema"><%=f_st%></p></div>
				</div>
						
			</div>		
			<input type="hidden" name="e_no" value="<%=e_no%>">	
			<input type="hidden" name="day" value="<%=day%>" id="day_cnt">
			<div id="plan_list">
			<%
				for(int a = 1 ; a <= datecnt ; a++){
					int j = a-1;
					String st_list = "";
					String id_list = "";
						String place =sche.get(j).getPlace();
						String place_list = place.replaceAll("\\[", "").replaceAll("\\]", "").replaceAll(",", "&");
						System.out.println("dsadsa"+place);
						response.addCookie(new Cookie("pla"+a, place_list));
						String [] list_place = place.split(",");
						
			%>
				<div id="plan_list_day<%=a%>">
				<%	int z= 0;
				
					for(String st : list_place){
						for(Place pl : plac){
							if(pl.getPlac_id().equals(st)){
								String name = pl.getPlac_name();
						st_list += name+",";
						id_list += st+",";
						z++;
				%>
				<div id="list_content<%=a*100+z%>">
				<input type="hidden" name="place_id_src<%=a %>" value="<%=st%>" id="id_srcs<%=a*100+z%>">
					<img src="" class="place_pic" name="pla_img<%=a%>"/>
					<div class="content_fdiv">
						<div class="list_place">
							<p class="list_place<%=a %>" >#<%=name%></p>				
							<input type="hidden" id="pla_val<%=a*100+z %>" value="<%=name %>">		
						</div>
						<div class="list_thema">
						
						</div>	
						<input type="button" name="delete" value="삭제" onclick="del_list(<%=a*100+z %>)" class="button"/>	
					</div>
					<div class="content_detail">
						<div class="list_budget">
							<p>평균가격</p>
						<p>약 20,000원 ~</p>
						</div>
						<a href="" name="pla_url<%=a%>" target='_blank'><input type="button" name="detail" value="상세정보 보기" class="button"/></a>
					</div>
				</div>
				<% 
							}
						}
						for(Eatery ea : eate){
							if(ea.getEat_id().equals(st)){
								String name = ea.getEat_name();
								st_list += name+",";
								id_list += st+",";
								z++;
								%>
				<div id="list_content<%=a*100+z%>">
				<input type="hidden" name="place_id_src<%=a %>" value="<%=st%>" id="id_srcs<%=a*100+z%>">
					<img src="" class="place_pic" name="pla_img<%=a%>"/>
					<div class="content_fdiv">
						<div class="list_place">
							<p class="list_place<%=a %>" >#<%=name%></p>				
							<input type="hidden" id="pla_val<%=a*100+z %>" value="<%=name %>">		
						</div>
						<div class="list_thema">
						
						</div>	
						<input type="button" name="delete" value="삭제" onclick="del_list(<%=a*100+z %>)" class="button"/>	
					</div>
					<div class="content_detail">
						<div class="list_budget">
							<p>평균가격</p>
						<p>약 20,000원 ~</p>
						</div>
						<a href="" name="pla_url<%=a%>" target='_blank'><input type="button" name="detail" value="상세정보 보기" class="button"/></a>
					</div>
				</div>
								
					<% 
							}
						}
						
					
					}%>
				<input type="hidden" name="place_name<%=a%>" value="empty<%=st_list %>" id = "place_name<%=a%>" />
				<input type="hidden" name="place_ids<%=a %>" value="empty<%=id_list %>" id = "place_ids<%=a %>" />
				</div>		
						
			<%	System.out.println("플랜editx23"+st_list);}
			%>
			
			</div>
			<input type="submit" name="add_place" value="여행지 추가하기" class="button">
					<input type="submit" name="save_plan" value="수정" class="button"/>
			</div>
		<div id="side_menu">
			<p id="side_menu_p" align="center">side menu</p>
			<div id= "side_inner">
					<input type="submit" name="plan_sel_add" value="여행지&#10;추가하기" class="button">
			</div>
		</div>
		</div>
		<div id="map"></div>
		</form>
	</section>
	<footer>
       <jsp:include page="main_footer.jsp" />	
    </footer>
</body>
</html>