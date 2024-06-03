<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jj.dto.Estimate"%>
<%@page import="java.util.List"%>
<%@page import="com.jj.dto.Plan"%>
<%
request.setCharacterEncoding("utf-8");
List<Estimate> esti = (List<Estimate>) request.getAttribute("estimate");
List<Plan> plan = (List<Plan>) request.getAttribute("planList");
System.out.println("셀렉트 완료 이스 : "+esti.size()+"플랜 : "+plan.size());
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>JourneyJoy_main</title>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css/planlist.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>	
	<script type="text/javascript" src="js/planlist.js"></script>
	<link rel="stylesheet" type="text/css" href="css/main_header.css"> 
</head>

<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>
	<!-- 페이지 섹션 -->
	<section>
	<form action = "" method="post">
		<div>
			<img src="img/travel/planlist_main3.jpg" id="top_img">
			<div id="list_text">
				<p id="list_text">여행 계획서</p>
			</div>
		</div>
		<div id="content">	
			<a href="planner_main.jsp">
			<input type="button" name="make_plan"value="계획서 만들기" class="button">
			</a>
			<div id="filter">
				<select name="nation">
		    		<option value="choice">국가별로 보기</option>
		    		<option value="japan">일본</option>
		    		<option value="canada">캐나다</option>
		    		<option value="philippines">필리핀</option>
		    		<option value="america">미국</option>
		    		<option value="australia">호주</option>
		    		<option value="newzealand">뉴질랜드</option>
		    		<option value="china">중국</option>
			  	</select>
			  	<select name="city_sel" id="choice">
			  		<option value="choice">도시별로 보기</option>
			  		<option value="choice">국가를</option>
			  		<option value="choice">선택해주세요.</option>
			  	</select>
			  	<select name="city_japan" id="japan">
		    		<option value="choice">도시별로 보기</option>
		    		<option value="tokyo">도쿄</option>
		    		<option value="osaka">오사카</option>
		    		<option value="fukuoka">후쿠오카</option>
		    		<option value="kyoto">교토</option>
		    		<option value="nagoya">나고야</option>
			  	</select>
			  	<select name="city_canada" id="canada">
		    		<option value="choice">도시별로 보기</option>
		    		<option value="vancouver">벤쿠버</option>
		    		<option value="toronto">토론토</option>
		    		<option value="victoria">빅토리아</option>
		    		<option value="niagara">나이아가라</option>
		    		<option value="montreal">몬트리올</option>
			  	</select>
			  	<select name="city_philippines" id="philippines">
		    		<option value="choice">도시별로 보기</option>
		    		<option value="manila">마닐라</option>
		    		<option value="cebu">세부</option>
		    		<option value="baguio">바기오</option>
		    		<option value="iloilo">일로일로</option>
			  	</select>
			  	<select name="city_america" id="america">
		    		<option value="choice">도시별로 보기</option>
		    		<option value="newyork">뉴욕</option>
		    		<option value="boston">보스턴</option>
		    		<option value="losAngeles">로스앤젤레스</option>
		    		<option value="sanFrancisco">샌프란시스코</option>
		    		<option value="cicago">시카고</option>
			  	</select>
			  	<select name="city_australia" id="australia">
		    		<option value="choice">도시별로 보기</option>
		    		<option value="sydney">시드니</option>
		    		<option value="melbourne">멜버른</option>
		    		<option value="goldCoast">골드코스트</option>
		    		<option value="brisbane">브리즈번</option>
			  	</select>
			  	<select name="city_newzealand" id="newzealand">
		    		<option value="choice">도시별로 보기</option>
		    		<option value="auckland">오클랜드</option>
		    		<option value="queenstown">퀸스타운</option>
		    		<option value="wellington">웰링턴</option>
			  	</select>
			  	<select name="city_china" id="china">
		    		<option value="choice">도시별로</option>
		    		<option value="shanghai">상하이</option>
		    		<option value="beijing">베이징</option>
		    		<option value="guangzhou">광저우</option>
		    		<option value="qingdao">칭다오</option>
			  	</select>
				<select name="city">
					<option>도시별로 보기</option>
					<option>오사카</option>
					<option>도쿄</option>
					<option>벤쿠버</option>
					<option>오타와</option>
				</select>
				<select name="thema">
					<option>테마별로 보기</option>
					<option>힐링</option>
					<option>관광</option>
					<option>액티비티</option>
					<option>덕질</option>
				</select>
				<select name="date">
					<option>일정별로 보기</option>
					<option>1월</option>
					<option>2월</option> 
					<option>3월</option>
					<option>4월</option>
				</select>
				<input type="checkbox" name="end_plan" id="end" onchange="checking(this.id)">
				<label for="end" id="end_check" >지난 일정 보지않기</label>
			</div>

			<div id="plan_list">
				<%if(plan.size() == 0){ %>
					<div class="plan">
						<div class="plan_content">
							<h2>저장된 계획서가 없습니다.</h2>
						</div>
					</div>
					<%}else{ 
						for(Estimate st : esti){
							for(Plan pl : plan){
								if(st.gete_no() == pl.getE_no()){
									String pl_date = pl.getPlan_date()+"";
									String aabb = pl_date.replaceAll("-", ".");
									String city = st.gete_destination();
									String city_img ="";
									if(city.equals("도쿄")){
										city_img = "img/japan/tokyo3.jpg";
									}else if(city.equals("오사카")){
										city_img = "img/japan/osaka6.jpg";
									}else if(city.equals("나이아가라")){
										city_img = "img/canada/niagara2.jpg";
									}else if(city.equals("토론토")){
										city_img = "img/canada/toronto1.jpg";
									}else if(city.equals("밴쿠버")){
										city_img = "img/canada/vancouver1.jpg";
									}else if(city.equals("삿포로")){
										city_img = "img/japan/sapporo1.jpg";
									}else if(city.equals("뉴욕")){
										city_img = "img/usa/newyork1.jpg";
									}else if(city.equals("로스앤젤레스")){
										city_img = "img/usa/lasvegas.jpg";
									}else if(city.equals("다낭")){
										city_img = "img/vietnam/danang1.jpg";
									}else if(city.equals("나트랑")){
										city_img = "img/vietnam/natrang1.jpg";
									}else if(city.equals("푸꾸옥")){
										city_img = "img/vietnam/phuquoc1.jpg";
									}
							
					%>			
							<a href="plan_page.jsp?paging=detail_my&e_no=<%=st.gete_no() %>">
								<div class="plan">
								<div class="plan_img"><img src="<%=city_img %>" class="city_img"/><div class="square"></div></div>
									
									<div class="plan_content">												
										<p class="title"><%=pl.getPlan_title()%></p><span><%=aabb %></span>
										<br><br>
										<img src="img/icon/location.png"/><p class="destination">&nbsp;&nbsp;<%=city %></p>
										<br><br>
										<p class="trip_date"><%=st.gete_start_date().replaceAll("-", ".") %> ~ <%=st.gete_end_date().replaceAll("-", ".") %></p>
										<br>
										<p class="thema_text"><%=st.gete_thema()+","+st.gete_detail_thema()%></p>
										<input type="submit" name="del_plan<%= st.gete_no()%>" value="삭제" class="button" onclick="del_plan(<%=st.gete_no() %>)"/>
										<input type="hidden" name="e_no" value="<%=st.gete_no() %>">								
									</div>
								</div>
							</a>
							
									
					<% 			
								}
							}
						
					%>
				<%}} %>
			</div>
		</div>
		</form>
	</section>

	<footer>
		<jsp:include page="main_footer.jsp" />	
	</footer>
</body>
</html>