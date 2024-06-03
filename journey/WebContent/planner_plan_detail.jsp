<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>JourneyJoy_main</title>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css\planner_plan_detail.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script type="text/javascript" src="js\planner_plan_detail.js"></script>
	<script
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAN8pqDt8WwrtCF3kkPS7Snko0A-RTUns0&callback=initMap&libraries=places&v=weekly"
      defer
    ></script>
</head>
<%
	String num = request.getParameter("num");

%>
<script>
$(function(){
	var day = $("#day").val();
	
	var place_name = opener.document.getElementsByName("select_values"+day);
	var place_id = opener.document.getElementsByName("pht_id"+day);

	var list_name = document.getElementsByClassName("list_name");
	var list_id = document.getElementsByName("place_id_src");
	
	var city = opener.document.getElementById("city").innerText;
	document.getElementById("city").innerText = city;
	
	for(var a = 0 ; a < 5 ; a++){
		list_name[a].innerText = "#"+place_name[a].value;
		list_id[a].setAttribute("value",place_id[a].value);
	}
	
	$("input[name='plan_sel']").click(function(){
		window.close(); 
	});
});
 
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
	var day = $("#day").val();
	var pla_id = opener.document.getElementsByName("pht_id"+day);
	  for(var i=0 ; i < 5 ; i++){
		  const re_request = {
			      placeId : pla_id[i].value,
			      
			      fields : ["name","photos","url"]
			    };
		  
		service.getDetails(re_request, callback);
	  }
}

function img_fix(img_src, pla_url,name){
		var img_v = document.getElementsByName("pla_img");
		var url_v = document.getElementsByName("pla_url");
		var name_v = document.getElementsByClassName("list_name");
		for(var i = 0 ; i < img_v.length; i++){
			if(name == name_v[i].innerText.replaceAll("#","")){
				
				img_v[i].setAttribute("src", img_src);
				url_v[i].setAttribute("href",pla_url);
				
				break;
			}else{
				
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

	<!-- 페이지 섹션 -->
	<section>

		<div id="content">
			<div id="list_text">
				<p id="list_text">| 일정 정보</p>
			</div>
			<input type="hidden" id="day" value="<%=num %>">
			<div id="main_content" >
				<div id="thema_div">
					<img src="img/icon/point.png">
					<p id="city"></p>
					<hr>
						
				</div>		
						
			<div id="plan_list">
				<div id="list_content">
					<input type="hidden" name="place_id_src" value="" id="id_srcs">
					<img src="" class="place_pic" name="pla_img"/>
					<div class="content_fdiv">
						<div class="list_place">
							<p class="list_name" ></p>
							<input type="hidden" id="pla_val" value="">
						</div>
						<div class="list_thema">
						
						</div>
					</div>
					<div class="content_detail">
						<div class="list_budget">

						</div>
						<a href="" name="pla_url" target='_blank'><input type="button" name="detail" value="상세정보 보기" class="button"/></a>
					</div>
				</div>
				<div id="list_content">
					<input type="hidden" name="place_id_src" value="" id="id_srcs">
					<img src="" class="place_pic" name="pla_img"/>
					<div class="content_fdiv">
						<div class="list_place">
							<p class="list_name" ></p>
							<input type="hidden" id="pla_val" value="">
						</div>
						<div class="list_thema">
						
						</div>
					</div>
					<div class="content_detail">
						<div class="list_budget">
						</div>
						<a href="" name="pla_url" target='_blank'><input type="button" name="detail" value="상세정보 보기" class="button"/></a>
					</div>
				</div>
				<div id="list_content">
					<input type="hidden" name="place_id_src" value="" id="id_srcs">
					<img src="" class="place_pic" name="pla_img"/>
					<div class="content_fdiv">
						<div class="list_place">
							<p class="list_name" ></p>
							<input type="hidden" id="pla_val" value="">
						</div>
						<div class="list_thema">
						
						</div>
					</div>
					<div class="content_detail">
						<div class="list_budget">
						</div>
						<a href="" name="pla_url" target='_blank'><input type="button" name="detail" value="상세정보 보기" class="button"/></a>
					</div>
				</div>
				<div id="list_content">
					<input type="hidden" name="place_id_src" value="" id="id_srcs">
					<img src="" class="place_pic" name="pla_img"/>
					<div class="content_fdiv">
						<div class="list_place">
							<p class="list_name" ></p>
							<input type="hidden" id="pla_val" value="">
						</div>
						<div class="list_thema">
						
						</div>
					</div>
					<div class="content_detail">
						<div class="list_budget">
						</div>
						<a href="" name="pla_url" target='_blank'><input type="button" name="detail" value="상세정보 보기" class="button"/></a>
					</div>
				</div>
				<div id="list_content">
					<input type="hidden" name="place_id_src" value="" id="id_srcs">
					<img src="" class="place_pic" name="pla_img"/>
					<div class="content_fdiv">
						<div class="list_place">
							<p class="list_name" ></p>
							<input type="hidden" id="pla_val" value="">
						</div>
						<div class="list_thema">
						
						</div>
						
	
					</div>
					<div class="content_detail">
						<div class="list_budget">
					
						</div>
						<a href="" name="pla_url" target='_blank'><input type="button" name="detail" value="상세정보 보기" class="button"/></a>
					</div>
				</div>
				</div>								
			</div>
		</div>
		<div id="side_menu">
			<p id="side_menu_p" align="center">side menu</p>
			<div id= "side_inner">
					<input type="button" name="plan_sel" value="창 닫기" class="button">
			</div>
		</div>
		<div id="map"></div>
	</section>

	
</body>
</html>