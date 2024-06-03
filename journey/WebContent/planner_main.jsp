<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%	
request.setCharacterEncoding("utf-8"); 

String u_id = (String) session.getAttribute("u_id");

%>
<html>
<head>
	<meta charset="utf-8">
	<title>JourneyJoy::</title>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css\planner_main.css">
	
	<script type="text/javascript" src="js\planner_main.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	
</head>
<script>
 $(function(){

    /* 날짜 */
    $("#startDt").datepicker({
      dateFormat: 'yy-mm-dd' //달력 날짜 형태
      ,minDate:0
      ,nextText : ">"
      ,prevText : "<"
      ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
      ,showMonthAfterYear:true //년도 - 월 순서
      ,changeYear: true //년 선택 가능
            ,changeMonth: true //월 선택 가능
            ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
            ,minDate : 0 //선택할수있는 최소날짜(0:오늘 이전날짜 선택 불가)
            ,onClose:function(selectedDate){ //startDt 닫힐때 endDt 선택가능한 최소날짜가 시작일로 지정
              $("#endDt").datepicker("option", "minDate", selectedDate);
            }

    });

    $("#endDt").datepicker({
      dateFormat: 'yy-mm-dd' //달력 날짜 형태
      ,minDate:0
      ,nextText : ">"
      ,prevText : "<"
      ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
      ,showMonthAfterYear:true //년도 - 월 순서
      ,changeYear: true //년 선택 가능
            ,changeMonth: true //월 선택 가능
            ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
    });
  });

//세계 날씨 정보 api
var weatherIcon = {
    '01' : 'fas fa-sun',
    '02' : 'fas fa-cloud-sun',
    '03' : 'fas fa-cloud',
    '04' : 'fas fa-cloud-meatball',
    '09' : 'fas fa-cloud-sun-rain',
    '10' : 'fas fa-cloud-showers-heavy',
    '11' : 'fas fa-poo-storm',
    '13' : 'far fa-snowflake',
    '50' : 'fas fa-smog'
};
var apiuri_s = "https://api.openweathermap.org/data/2.5/forecast?q=seoul&lang=kr&appid=fd030a11701fb174c6d72a31e5b7d170";
var apiuri_t = "https://api.openweathermap.org/data/2.5/forecast?q=tokyo&lang=kr&appid=fd030a11701fb174c6d72a31e5b7d170";

$.ajax({
    url: apiuri_s,
    dataType: "json",
    type: "GET",
    async: "false",
    success: function(resp) {

		for(var i = 0 ; i < resp.list.length ; i++){
			if((resp.list[i].dt-resp.list[0].dt)%86400 == 0){
				var date_t = resp.list[i].dt_txt;
				var $date = date_t.substr(5,5)+"&nbsp;&nbsp;&nbsp;";	
				var temp_o = resp.list[i].main.temp-273.15;
				var $temp = Math.floor(temp_o)+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				var $weather = resp.list[i].weather[0].description+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				
				$('#w_date').append($date);
				$('#w_weather').append($weather);
				$('#w_temp').append($temp);
			}
		}
	
    }
})

$.ajax({
    url: apiuri_t,
    dataType: "json",
    type: "GET",
    async: "false",
    success: function(resp) {
		for(var i = 0 ; i < resp.list.length ; i++){
			if((resp.list[i].dt-resp.list[0].dt)%86400 == 0){
				var date_t = resp.list[i].dt_txt;
				var $date = date_t.substr(5,5)+"&nbsp;&nbsp;&nbsp;";	
				var temp_o  = resp.list[i].main.temp-273.15;
				var $temp = Math.floor(temp_o)+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				var $weather = resp.list[i].weather[0].description+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				
				$('#tw_date').append($date);
				$('#tw_weather').append($weather);
				$('#tw_temp').append($temp);
			}
		}
    }
})

$.ajax({
    url: "https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=cSbAPPbCZnZRACrILukqKUUM9qewJzGK&data=AP01",
    dataType: "json",
    type: "GET",
    success: function(data) {
    	alert(data[1].cur_unit);

    }
})

/* 환율 */
$.ajax({
	type : "post",
	url : "currencyInfo.jj?page=currency",
	success : function(data){
			$("#exchange_div").html(data);
	}
});

</script>
<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>
	<!-- 페이지 섹션 -->
	<section>
		<div id="main_full_div">	
			<div id="slide_div" >
				<div id="content">
					<div class="kind_wrap">
  						<div class="kind_slider">
  							<form action="planner_cookie.jsp" method="post" onsubmit="return select_check()">
  							    <ul class="slider">
				        		    <li>
				        			    <article>       
				            			    <div class="main_div">
				                   				 <div class="main_con">
				                    				<p class="main_text"><%if(u_id == null){out.print("고객");}else{out.print(u_id+" ");}%>님,<br>어떤 여행을 꿈꾸시나요?</p>         
				                            		<input type="text" name="departure_text" id="departure_text" value="출발지" readonly="true" onclick="text_div(this.id)">
				                            		<div id="departure_text_div" tabindex='0'>
				                            			<div id="departure_div_in">
				                            				<p id="departure_sel">출발지 선택</p>
					                            			<table cellspacing="0" id="departure_table">
					                            				<tr>
					                            					<td class="departure_one">김포</td>
					                            					<td class="departure_one">인천</td>					           
					                            				</tr>
					                            				<tr>
					                            					<td class="departure_one">부산</td>
					                            					<td class="departure_one">대구</td>					           
					                            				</tr>
					                            				<tr>
					                            					<td class="departure_one">청주</td>
					                            					<td class="departure_one">제주</td>					           
					                            				</tr>
					                            				<tr>
					                            					<td class="departure_one">양양</td>
					                            					<td class="departure_one">김해</td>					           
					                            				</tr>
					                            			</table>
				                            			</div>
				                            		</div>
				                            		<input type="text" name="nation_text" id="nation_text" value="목적지(국가)" readonly="true" onclick="text_div(this.id)">
				                            		<div id="nation_text_div">
				                            			<div id="nation_div_in">
				                            				<p id="nation_sel">목적지 선택(국가)</p>
					                            			<table cellspacing="0" id="continent_table">
					                            				<tr>
					                            					<td class="continent_one" id="na_a" onclick="nation_open('a')">일본</td>	           
					                            				</tr>
					                            				<tr>
					                            					<td class="continent_one" id="na_b" onclick="nation_open('b')">동남아/대만/서남아</td>			           
					                            				</tr>
					                            				<tr>
					                            					<td class="continent_one" id="na_c" onclick="nation_open('c')">미주/캐나다/남중미</td>			           
					                            				</tr>
					                            				<tr>
					                            					<td class="continent_one" id="na_d" onclick="nation_open('d')">유럽/아프리카</td>			           
					                            				</tr>
					                            				<tr>
					                            					<td class="continent_one" id="na_e" onclick="nation_open('e')">괌/사이판/하와이</td>			           
					                            				</tr>					                            				
					                            				<tr>
					                            					<td class="continent_one" id="na_f" onclick="nation_open('f')">중국/홍콩/마카오</td>			           
					                            				</tr>
					                            				<tr>
					                            					<td class="continent_one" id="na_g" onclick="nation_open('g')">호주/뉴질랜드</td>			           
					                            				</tr>
					                            								                            				
					                            			</table>
					                            			<table id="nation_table_empty">
					                            				<tr>
					                            					<td id="nation_one_plz">지역을 선택해주세요.</td>
					                            					
				                            					</tr>
					                            				
					                            			</table>
					                            			<table id="nation_table_b">
					                            				<tr>
					                            					<td class="nation_one">베트남</td>
					                            					<td class="nation_one">대만</td>
					                            					           
					                            				</tr>
					                            				<tr>
					                            					<td class="nation_one">필리핀</td>	
					                            					<td class="nation_one">태국</td>	           
					                            				</tr>
					                            				<tr>
					                            					<td class="nation_one">싱가포르</td>	
					                            					<td class="nation_one">말레이시아</td>	           
					                            				</tr>
					                            				<tr>
					                            					<td class="nation_one">인도네시아</td>	
					                            					<td class="nation_one">라오스</td>	           
					                            				</tr>
					                            				<tr>
					                            					<td class="nation_one">캄보디아</td>	
					                            					<td class="nation_one">스리랑카</td>	           
					                            				</tr>					                            				
					                            			</table>
					                            			
					                            			<table id="nation_table_c">
					                            				<tr>
					                            					<td class="nation_one">미주</td>	
					                            					<td class="nation_one">캐나다</td>	
					                            					           
					                            				</tr>
					                            				<tr>
					                            					<td class="nation_one">멕시코</td>	
					                            					<td class="nation_one">브라질</td>	           
					                            				</tr>
					                            				<tr>
					                            					<td class="nation_one">아르헨티나</td>	
					                            					<td class="nation_one">페루</td>	           
					                            				</tr>
					                            				<tr>
					                            					<td class="nation_one">칠레</td>	
					                            					<td class="nation_one">볼리비아</td>	           
					                            				</tr>				                            				
					                            			</table>
					                            			<table id="nation_table_d">
					                            				<tr>
					                            					<td class="nation_one">그리스</td>	
					                            					<td class="nation_one">스페인</td>	
					                            					           
					                            				</tr>
					                            				<tr>
					                            					<td class="nation_one">크로아티아</td>	
					                            					<td class="nation_one">조지아</td>	           
					                            				</tr>
					                            				<tr>
					                            					<td class="nation_one">스위스</td>	
					                            					<td class="nation_one">이탈리아</td>	           
					                            				</tr>
					                            				<tr>
					                            					<td class="nation_one">체코</td>	
					                            					<td class="nation_one">오스트리아</td>	           
					                            				</tr>	
					                            				<tr>
					                            					<td class="nation_one">헝가리</td>	
					                            					<td class="nation_one">튀르키예</td>	
					                            					           
					                            				</tr>
					                            				<tr>
					                            					<td class="nation_one">프랑스</td>	
					                            					<td class="nation_one">영국</td>	           
					                            				</tr>
					                            				<tr>
					                            					<td class="nation_one">독일</td>	
					                            					<td class="nation_one">포르투갈</td>	           
					                            				</tr>		                            				
					                            			</table>
					                            			<table id="nation_table_e">
					                            				<tr>
					                            					<td class="nation_one">괌</td>	
					                            					<td class="nation_one">사이판</td>	
					                            					           
					                            				</tr>
					                            				<tr>
					                            					<td class="nation_one">하와이</td>	
					                            					<td class="nation_one"></td>         
					                            				</tr>	
					                            								                            				                   				
					                            			</table>
					                            			<table id="nation_table_f">
					                            				<tr>
					                            					<td class="nation_one">중국</td>	
					                            					<td class="nation_one">홍콩</td>	
					                            					           
					                            				</tr>
					                            				<tr>
					                            					<td class="nation_one">마카오</td>	
					                            					<td class="nation_one"></td>	           
					                            				</tr>					                            								                            				
					                            			</table>
					                            			<table id="nation_table_g">
					                            				<tr>
					                            					<td class="nation_one">호주</td>	
					                            					<td class="nation_one">뉴질랜드</td>	
					                            					           
					                            				</tr>
					                            				<tr>
					                            					<td class="nation_one">마카오</td>	
					                            					<td class="nation_one"></td>	           
					                            				</tr>					                            								                            				
					                            			</table>
				                            			</div>
				                            		</div>
				                            		<input type="text" name="city_text" id="city_text" value="목적지(도시)" readonly="true" onclick="text_div(this.id)">
				                            		<div id="city_text_div" tabindex='0'>
				                            			<div id="city_div_in">
				                            				<p id="city_sel" onclick="aa()">목적지 선택(도시)</p>
				                            				<p id="plz_pick_nation" onclick="aa()">국가를 선택해주세요.</p>
					                            			<table cellspacing="0" id="city_table_jp">
					                            				<tr>
					                            					<td class="city_one">오사카</td>
					                            					<td class="city_one">도쿄</td>
					                            					<td class="city_one">후쿠오카</td>
					                            				</tr>
					                            				<tr>
					                            					<td class="city_one">삿포로</td>
					                            					<td class="city_one">오키나와</td>
					                            					<td class="city_one">알펜루트</td>
					                            				</tr>
					                            				<tr>
					                            					<td class="city_one">나고야</td>
					                            					<td class="city_one">나오시마</td>
					                            					<td class="city_one">대마도</td>
					                            				</tr>
					                            				<tr>
					                            					<td class="city_one">교토</td>
					                            					<td class="city_one">고베</td>
					                            					<td class="city_one">히로시마</td>
					                            				</tr>
					                            				<tr>
					                            					<td class="city_one">니가타</td>
					                            					<td class="city_one">오카야마</td>
					                            					<td class=""></td>
					                            				</tr>		                            				
					                            			</table>
					                            			<table cellspacing="0" id="city_table_vi">
					                            				<tr>
					                            					<td class="city_one">다낭</td>
					                            					<td class="city_one">나트랑</td>
					                            					<td class="city_one">달랏</td>
					                            				</tr>
					                            				<tr>
					                            					<td class="city_one">푸꾸옥</td>
					                            					<td class="city_one">하노이</td>
					                            					<td class="city_one">호치민</td>
					                            				</tr>					                            		                      				
					                            			</table>
					                            			<table cellspacing="0" id="city_table_taiw">
					                            				<tr>
					                            					<td class="city_one">타이베이</td>
					                            					<td class="city_one">타이중</td>
					                            					<td class="city_one">가오슝</td>
					                            				</tr>
					                            				<tr>
					                            					<td class="city_one">컨딩</td>
					                            					<td class=""></td>
					                            					<td class=""></td>
					                            				</tr>					                            		                      				
					                            			</table>
					                            			<table cellspacing="0" id="city_table_thai">
					                            				<tr>
					                            					<td class="city_one">푸켓</td>
					                            					<td class="city_one">카오락</td>
					                            					<td class="city_one">방콕</td>
					                            				</tr>
					                            				<tr>
					                            					<td class="city_one">치앙마이</td>
					                            					<td class="city_one">코사무이</td>
					                            					<td class=""></td>
					                            				</tr>					                            		                      				
					                            			</table>
					                            			<table cellspacing="0" id="city_table_phil">
					                            				<tr>
					                            					<td class="city_one">보라카이</td>
					                            					<td class="city_one">세부</td>
					                            					<td class="city_one">방콕</td>
					                            				</tr>
					                            				<tr>
					                            					<td class="city_one">보홀</td>
					                            					<td class="city_one">팔라완</td>
					                            					<td class="city_one">클락</td>
					                            				</tr>	
					                            				<tr>
					                            					<td class="city_one">마닐라</td>
					                            					<td class=""></td>
					                            					<td class=""></td>
					                            				</tr>					                            		                      				
					                            			</table>
					                            			<table cellspacing="0" id="city_table_usa">
					                            				<tr>
					                            					<td class="city_one">뉴욕</td>
					                            					<td class="city_one">보스턴</td>
					                            					<td class="city_one">시카고</td>
					                            				</tr>
					                            				<tr>
					                            					<td class="city_one">로스앤젤레스</td>
					                            					<td class="city_one">워싱턴D.C</td>
					                            					<td class="city_one">산호세</td>
					                            				</tr>	
					                            				<tr>
					                            					<td class="city_one">샌프란시스코</td>
					                            					<td class="city_one"></td>
					                            					<td class="city_one"></td>
					                            				</tr>					                            		                      				
					                            			</table>
					                            			<table cellspacing="0" id="city_table_can">
					                            				<tr>
					                            					<td class="city_one">밴쿠버</td>
					                            					<td class="city_one">토론토</td>
					                            					<td class="city_one">나이아가라</td>
					                            				</tr>					                            		                      				
					                            			</table>
					                            			<table cellspacing="0" id="city_table_aust">
					                            				<tr>
					                            					<td class="city_one">시드니</td>
					                            					<td class="city_one">멜버른</td>
					                            					<td class="city_one">퀸즈랜드</td>
					                            				</tr>					                            		                      				
					                            			</table>
					                            			<table cellspacing="0" id="city_table_newz">
					                            				<tr>
					                            					<td class="city_one">퀸즈타운</td>
					                            					<td class="city_one">오클랜드</td>
					                            					<td class="city_one">웰링턴</td>
					                            				</tr>					                            		                      				
					                            			</table>
				                            			</div>
				                            		</div>
				                        		    <div id="cal_div">
				                            		    <input type="text" id="startDt" name = "startDt" placeholder="여행출발일" autocomplete="off"/>
				                          		        <input type="text" id="endDt" name = "endDt" placeholder="여행도착일" autocomplete="off"/>
				                           			</div>
				                        			<input type="checkbox" name="airplane" id ="air" value="1">
				                        			<label for="air" id="airplane">
				                        				<img src="img\icon\airplane_check.png" name="check_img" id="air_check">
				                        				항공권은 있어요
				                        			</label>
				                         			<input type="checkbox" name="hotel" id ="ho" value="1">
				                        			<label for="ho" id="hotel">
				                        				<img src="img\icon\hotel_check.png" name="check_img" id="hotel_check" >
						                        		숙소는 있어요				     
						                        	</label>
						                        	<br><br>
						                        	<% if(u_id == null){%>
						                        	<input type="button" value="테마선택" class="next_login" onclick="login_check()"/>
							                        <%}else{ %>
						                            <input type="button" value="테마선택" class="next" />		
						                            <%} %>    	                
						                		</div>                              
											</div>
				            			</article>
				         			</li>
				           			<li>
						               <article>
						                <div class="main_div">
						                    <div class ="main_con">
						                    	<div class='title_icon'>
						                    		<img src="img/icon/travel.png">
						                    		<p class="main_text">어떤 스타일의 여행을 원하시나요?</p>
						                   			<hr>
						                    	</div>
						                        <div id="thema_div">
						                                <input type="radio" name="thema" value="여유롭게힐링" id="thema1" checked>
						                                <label for="thema1" class="thema_check">힐링</label>
						                                <input type="radio" name="thema" value="체험/액티비티" id="thema2">
						                                <label for="thema2" class="thema_check">체험/액티비티</label>
						                                <input type="radio" name="thema" value="자연과함께" id="thema3">
						                                <label for="thema3" class="thema_check">자연과 함께</label>
						                                <input type="radio" name="thema" value="유명관광지는필수" id="thema4">
						                                <label for="thema4" class="thema_check">랜드마크</label>
						                                <input type="radio" name="thema" value="먹방" id="thema5">
						                                <label for="thema5" class="thema_check">먹방</label>
						                                <input type="radio" name="thema" value="덕질의성지" id="thema6">  
						                                <label for="thema6" class="thema_check">덕질의 성지</label>         
						                        </div>
						                        <div class='title_icon'>
						                        	<img src="img/icon/people.png">
						                        	 <p class="main_text">누구와 함께 여행가시나요?</p>
						                        	 <hr>
						                        </div>
						                        <div id="with_div">
						                                <input type="radio" name="with" value="혼자" id="with1" checked>
						                                <label for="with1" class="with_check">혼자</label>
						                                <input type="radio" name="with" value="친구와" id="with2">
						                                <label for="with2" class="with_check">친구와</label>
						                                <input type="radio" name="with" value="연인과" id="with3">
						                                <label for="with3" class="with_check">연인과</label>
						                                <input type="radio" name="with" value="아이동반" id="with4">
						                                <label for="with4" class="with_check">아이동반</label>
						                                <input type="radio" name="with" value="가족과" id="with5">
						                                <label for="with5" class="with_check">가족과</label>
						                                <input type="radio" name="with" value="기타" id="with6">
						                                <label for="with6" class="with_check">기타</label>            
						                        </div>
						                        <% if(u_id == null){%>
						                        <input type="button" value="테마선택" class="next_login" onclick="login_check()"/>
						                        <%}else{ %>
				                            	<input type="button" value="다음" class="next" /> 
				                            	<%} %>                      
						                    </div>                              
						                </div>
						            </article>
					            </li>
					            <li>
					        	    <article>
						           		<div class="main_div">
						                    <div class="main_con">
						                    	<div class='title_icon'>
						                    		<img src="img/icon/island.png">
						                    		<p class="main_text">어떤 여행지를 가고 싶으신가요?</p>
						                    		<hr>
						                    	</div>
						                        <div id="place_div">						                        	
						                        	<input type="checkbox" name="place" value="놀이공원" id="place1" onchange="checking(this.id)">
					                                <label for="place1" class="place_check">놀이공원</label>
					                                <input type="checkbox" name="place" value="박물관/미술관" id="place2" onchange="checking(this.id)">
					                                <label for="place2" class="place_check">박물관/미술관</label>
					                                <input type="checkbox" name="place" value="휴양림" id="place3" onchange="checking(this.id)">
					                                <label for="place3" class="place_check">휴양림</label>
					                                <input type="checkbox" name="place" value="랜드마크" id="place4" onchange="checking(this.id)">
					                                <label for="place4" class="place_check">랜드마크</label>
					                                <input type="checkbox" name="place" value="덕질" id="place5" onchange="checking(this.id)">
					                                <label for="place5" class="place_check">덕질</label>
					                                <input type="checkbox" name="place" value="문화재" id="place6" onchange="checking(this.id)">
					                                <label for="place6" class="place_check">문화재</label>
					                                <input type="checkbox" name="place" value="수영장/바다" id="place7" onchange="checking(this.id)">			
					                                <label for="place7" class="place_check">수영장/바다</label>		                                		
				                                    <input type="checkbox" name="place" value="온천/스파" id="place8" onchange="checking(this.id)">
				                                    <label for="place8" class="place_check">온천/스파</label>
					                                <input type="checkbox" name="place" value="백화점/쇼핑" id="place9" onchange="checking(this.id)">
					                                <label for="place9" class="place_check">백화점/쇼핑</label>
					                                <input type="checkbox" name="place" value="가볍게한잔" id="place10" onchange="checking(this.id)">
			                                		<label for="place10" class="place_check">가볍게 한잔</label>
					                            </div>
					                            <div class='title_icon'>
					                            	<img src="img/icon/food.png">
					                            	<p class="main_text">음식 취향을 골라주세요.</p>
					                            	<hr>
					                            </div>
					                           	<div id="eat_div">
				                                	<input type="checkbox" name="eat" value="한식" id="eat1" onchange="checking(this.id)">
				                                	<label for="eat1" class="eat_check">한식</label>
				                                    <input type="checkbox" name="eat" value="중식" id="eat2" onchange="checking(this.id)">
				                                    <label for="eat2" class="eat_check">중식</label>
				                                    <input type="checkbox" name="eat" value="일식" id="eat3" onchange="checking(this.id)">
				                                    <label for="eat3" class="eat_check">일식</label>
				                                    <input type="checkbox" name="eat" value="양식" id="eat4" onchange="checking(this.id)">
				                                    <label for="eat4" class="eat_check">양식</label>
				                                    <input type="checkbox" name="eat" value="아시아" id="eat5" onchange="checking(this.id)">
				                                    <label for="eat5" class="eat_check">아시아</label>
				                               		<input type="checkbox" name="eat" value="비건" id="eat6" onchange="checking(this.id)">   
				                               		<label for="eat6" class="eat_check">비건</label>
				                               		<input type="checkbox" name="eat" value="해산물" id="eat7" onchange="checking(this.id)">
				                               		<label for="eat7" class="eat_check">해산물</label>
				                                    <input type="checkbox" name="eat" value="육류" id="eat8" onchange="checking(this.id)">
				                                    <label for="eat8" class="eat_check">육류</label>
				                                    <input type="checkbox" name="eat" value="빵" id="eat9" onchange="checking(this.id)"> 
				                                    <label for="eat9" class="eat_check">빵지순례</label>
				                           		</div>
				                           		<% if(u_id == null){%>
				                           			<input type="button" value="일정만들기" id="save_login" onclick="login_check()"/>
				                           			<%}else{ %>
				                	                <input type="submit" value="일정 만들기" id="save" />
				                	                <%} %>
			            	                               
						    	                </div>                               
							                </div>			       
							            </article>
								    </li>
								</ul>
						     </form> 
						</div>
					</div>
				</div>
				<%if(u_id == null) {%>
				<a id="left_login" onclick="login_check()"><img src="img\icon\arrow_left.png" width="45px" height="45px"/></a><%}else{ %>
				<a id="left" ><img src="img\icon\arrow_left.png" width="45px" height="45px"/></a>
				<%} %>

				<%if(u_id == null) {%>
				<a id="right_login" onclick="login_check()"><img src="img\icon\arrow_right.png" width="45px" height="45px"/></a><%}else{ %>
				<a id="right"><img src="img\icon\arrow_right.png" width="45px" height="45px"/></a>
				<%} %>					
			</div>
			<div id="img_div">
				<div id="curr_div">
					환율
					<p id="curr_li"></p>
				</div>
				서울날씨
				<p id="w_date"></p>
				<p id="w_weather"></p>
				<p id="w_temp"></p>
				<br><br>
				도쿄날씨
				<p id="tw_date"></p>
				<p id="tw_weather"></p>
				<p id="tw_temp"></p>
				
				<div id="exchange_div"></div>
			</div>
			
		</div>
	</section>
	<footer>
		<jsp:include page="main_footer.jsp" />	
	</footer>
</body>
</html>