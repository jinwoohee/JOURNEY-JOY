<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="dao" class="com.jj.dao.Plan_review" />
<jsp:useBean id="dto" class="com.jj.dto.Plan_review" />

<%
	request.setCharacterEncoding("utf-8"); 
	String list = "a"; 
	ArrayList<com.jj.dto.Plan_review> reviewList = dao.select_plan_review(list);
	String u_id = (String) session.getAttribute("u_id");
	response.addCookie(new Cookie("u_id", u_id));
%>

<html>
<head>
    <meta charset="utf-8">
	<title>일정리뷰</title>

    <link href="css/plan_review_list.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

    <script>
		$(function(){
			$("img[name='write']").click(function(){
				alert("로그인을 해주세요.");	
			});
			$(".review_div").mouseenter(function(){
	        	$(this).css({'background':'#f1f1f3'});
	        });
			 $(".review_div").mouseleave(function(){
				 $(this).css({'background':'white'});
	        });
			 
			 
			 /* 선택한 나라에 따라서 도시선택*/
		/* 	$('select[name*=city]').hide();
			
			$('select[name=nation]').change(function(){
				
				var cities = ["japan", "canada", "philippines", "america", "australia", "newzealand", "china"];
				
				for(var i=0; i<cities.length; i++){
					if($('select[name=nation]').val() == cities[i]){
						$('#'+$('select[name=nation]').val()+'').show();
						$('select[name*=city]').not($('#'+$('select[name=nation]').val()+'')).hide();
					}
				}
			}); 
 */			
 
			 $('select[name=nation]').change(function() {
				if ($(this).find('option:selected').text() == '국가') {
					$('select[name=city]').find('option').remove();
					$('select[name=city]').append('<option>도시</option>');
				} else if ($(this).find('option:selected').text() == '일본') {
					$('select[name=city]').find('option').remove();
					$('select[name=city]').append("<option value=''>도시</option>");
					$('select[name=city]').append("<option value='tokyo'>도쿄</option>");
					$('select[name=city]').append("<option value='osaka'>오사카</option>");
					$('select[name=city]').append("<option value='fukuoka'>후쿠오카</option>");
					$('select[name=city]').append("<option value='kyoto'>교토</option>");
					$('select[name=city]').append("<option value='nagoya'>나고야</option>");
				} else if ($(this).find('option:selected').text() == '캐나다') {
					$('select[name=city]').find('option').remove();
					$('select[name=city]').append("<option value=''>도시</option>");
					$('select[name=city]').append("<option value='vancouver'>벤쿠버</option>");
					$('select[name=city]').append("<option value='toronto'>토론토</option>");
					$('select[name=city]').append("<option value='niagara'>나이아가라</option>");
					$('select[name=city]').append("<option value='victoria'>빅토리아</option>");
					$('select[name=city]').append("<option value='montreal'>몬트리올</option>");
				}else if ($(this).find('option:selected').text() == '필리핀') {
					$('select[name=city]').find('option').remove();
					$('select[name=city]').append("<option value=''>도시</option>");
					$('select[name=city]').append("<option value='manila'>마닐라</option>");
					$('select[name=city]').append("<option value='cebu'>세부</option>");
					$('select[name=city]').append("<option value='baguio'>바기오</option>");
					$('select[name=city]').append("<option value='iloilo'>일로일로</option>");
				}else if ($(this).find('option:selected').text() == '미국') {
					$('select[name=city]').find('option').remove();
					$('select[name=city]').append("<option value=''>도시</option>");
					$('select[name=city]').append("<option value='newyork'>뉴욕</option>");
					$('select[name=city]').append("<option value='boston'>보스턴</option>");
					$('select[name=city]').append("<option value='losAngeles'>로스앤젤레스</option>");
					$('select[name=city]').append("<option value='sanFrancisco'>샌프란시스코</option>");
					$('select[name=city]').append("<option value='cicago'>시카고</option>");
				}else if ($(this).find('option:selected').text() == '호주') {
					$('select[name=city]').find('option').remove();
					$('select[name=city]').append("<option value=''>도시</option>");
					$('select[name=city]').append("<option value='sydney'>시드니</option>");
					$('select[name=city]').append("<option value='melbourne'>멜버른</option>");
					$('select[name=city]').append("<option value='goldCoast'>골드코스트</option>");
					$('select[name=city]').append("<option value='brisbane'>브리즈번</option>");
				}else if ($(this).find('option:selected').text() == '뉴질랜드') {
					$('select[name=city]').find('option').remove();
					$('select[name=city]').append("<option value=''>도시</option>");
					$('select[name=city]').append("<option value='auckland'>오클랜드</option>");
					$('select[name=city]').append("<option value='queenstown'>퀸스타운</option>");
					$('select[name=city]').append("<option value='wellington'>웰링턴</option>");
				}else if ($(this).find('option:selected').text() == '중국') {
					$('select[name=city]').find('option').remove();
					$('select[name=city]').append("<option value=''>도시</option>");
					$('select[name=city]').append("<option value='shanghai'>상하이</option>");
					$('select[name=city]').append("<option value='beijing'>베이징</option>");
					$('select[name=city]').append("<option value='guangzhou'>광저우</option>");
					$('select[name=city]').append("<option value='qingdao'>칭다오</option>");
				}
			});
					
			/*검색*/
			$('#search img').click(function(){
				var nation = $('select[name=nation]').val();
				var search = $('input[name=searchBox]').val();
				var city = $('select[name=city_'+nation+']').val();

				$.ajax({
					url : "planReview_list.jj?page=planReviewSearch",
	        		data : {"city" : city, "search" : search},
	        		success : function(re){
	        			$("#list_div").html(re);
	        		}
				});
			});
			
			
			/*페이징*/
			 $(".review_div").hide();
			 $(".review_div").slice(0, 9).css("display", "block");
			 
			 //맨처음에 더보기 버튼
			 if($(".review_div:hidden").length == 0){
				 $('input[name="more_btn"]').hide();
			 }
			 	
			 //더보기 버튼
			 $('input[name="more_btn"]').click(function(){
				 $(".review_div:hidden").slice(0, 3).css("display", "block");
				 
				 if($(".review_div:hidden").length == 0){
					 $('input[name="more_btn"]').hide();
				 }
			 });
			
		});
    </script>
</head>
<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>

	<!-- 페이지 섹션 -->
    <div>
        <section>
            <article>
            	<!-- 검색필터 -->
				<div id="search_section">
					<div>	
						<select name='nation'>
	                    <option value=''>국가</option>
	                    <option value='japan'>일본</option>
	                    <option value='canada'>캐나다</option>
	                    <option value="philippines">필리핀</option>
			    		<option value="america">미국</option>
			    		<option value="australia">호주</option>
			    		<option value="newzealand">뉴질랜드</option>
			    		<option value="china">중국</option>
                	</select>
                	
                	<select name='city'>
	                    <option value=''>도시</option>
                	</select>
					</div>

	                <div id="search">
						<input type="text" name="searchBox" placeholder=" 검색단어 입력">
						<img src='img/icon/search_btn.png'>
					</div>
					<div id="write_div">
					  <%
					  	if(u_id == null){
                  			 out.println("<img src='img/icon/write.png' name='write'/>");
                  		}else{
                			out.println("<a href='plan_review.jj?page=plan_reviewTab'><img src='img/icon/write.png' /></a>");
					  	}
					  %>
					</div>
				</div>
            </article>
            <article>
           		<div id="list_div">         		
	            	<%
		            	for(com.jj.dto.Plan_review pr : reviewList){ %>
    						
    						<div class='review_div'>
    							<a href='plan_review_detail.jsp?page_no=<%=pr.getPr_no()%>&e_no=<%=pr.getE_no() %>'>
	    							<img src='<%=pr.getU_profile() %>'/>
	    							<p><%= pr.getU_nickname()%></p>
	    							<div><%=pr.getPr_date() %></div>
	    							<img src='uploadFile/<%=pr.getPr_file() %>' />
	    							<div class='nation_div'>
		    							<img id="icon" src="img/icon/plane.png">
		    							<p><%=pr.getE_destination() %></p>
	    							</div>
	   								<div><p><%=pr.getPr_title() %></p></div>
	    							<p><%=pr.getPr_contents() %></p>
    							</a>
    						</div>
    				<%	}%>			
                </div>
            </article>
            <div id='more_div'>
            	<input type="button" name="more_btn" value="더보기">
            </div>
        </section>
    </div>
	<jsp:include page="main_footer.jsp" />	
</body>
</html>