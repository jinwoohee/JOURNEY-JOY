<%@page import="com.jj.dto.Location_review"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
	request.setCharacterEncoding("utf-8");
	String u_id = (String) session.getAttribute("u_id");
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장소 리뷰</title>
<!-- css -->
<link href="css/place_review.css" rel="stylesheet" type="text/css">

<!-- font -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
</head>
<script>
	$(function(){
		//작성버튼
		$("img[name='write']").click(function(){
			$(location).attr('href', 'place_review_write.jsp');
		});
		$("img[name='noWrite']").click(function(){
			alert("로그인 후 이용해주세요.");
			$(location).attr('href', 'login.jsp');
		});
		
		//수정버튼
		$(".modify").click(function(){
			$(location).attr('href', 'place_review_update.jsp?lr_no='+$(this).val());
		});
		
		//삭제버튼
		$(".delete").click(function(){
			alert("삭제하시겠습니까?");
			$(location).attr('href', 'placeReview_delete.jsp?lr_no='+$(this).val());
		});
		
		 //검색창 
		 $("input[name='search']").click(function(){
			 $.ajax({ //검색버튼 
         		url : "placeReview_list.jj?page=placeReviewSearch",
         		data : {"txt" : $("input[name='searchBox']").val(), "city" : $("select[name='city']").val()},
         		success : function(re){
         			$("#review_section").html(re);
         		}
         	 });
		 });
		 
		 //최신순, 별점순
		 $("#sort_section div").click(function(){
			 $.ajax({
         		url : "placeReview_list.jj?page=placeReviewSearch",
         		data : {"param" : $(this).attr('id')},
         		success : function(re){
         			$("#review_section").html(re);
         		}
         	 });
		 });
		 
		 //도시
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
		 

		 /*페이징*/
		 $(".review").hide();
		 $(".review").slice(0, 4).css("display", "block");
		 	
		 //더보기 버튼
		 $('input[name="more_btn"]').click(function(){
			 $(".review:hidden").slice(0, 2).css("display", "block");
			 
			 if($(".review:hidden").length == 0){
				 $('input[name="more_btn"]').hide();
			 }
		 });
	});
</script>
<body>
<jsp:include page="main_header.jsp" />
	<div>
		<section>
			<!-- 검색구간 -->
			<div id="search_section">
				<div id='sort_section'>
					<div id='recent'><img alt="최신순" src="img/icon/lrIcon-02.png"></div>
					<div id='starRating'><img alt="별점순" src="img/icon/lrIcon-04.png"></div>
				</div>
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
					<input type="text" name="searchBox" placeholder="검색단어 입력">
					<input type='button' name='search' value='검색'>
				</div>
				<div>
				<%
				 if(u_id != null){
					 out.println("<img src='img/icon/write.png' name='write'/>");
				 }else{
					 out.println("<img src='img/icon/write.png' name='noWrite'/>");
				 }
				%>
				</div>
			</div>
		</section>

        <section>
        	<div id= "review_section">
       			<jsp:useBean id="place" class="com.jj.dao.Review">
       				<%
       			//select
   					ArrayList<Location_review> lrList;
   					int lr_no=0;
   					
   					lrList = place.select_placeReview(lr_no);
       					
   					for(Location_review lr : lrList){
   						out.println("<div class='review'>"); //전체
   						out.println("<div>"); //프로필, 닉네임, 버튼
   						out.println("<img class='profile' src='"+lr.getU_profile()+"'/>");
   						out.println("<p>"+lr.getU_nickname()+"</p>");
   						if(u_id !=null && u_id.equals(lr.getU_id())){
   							out.println("<button class='modify' value='"+ lr.getLr_no()+"'>수정</button>");
       						out.println("<button class='delete' value='"+ lr.getLr_no()+"'>삭제</button>");
   						}
   						out.println("</div><div>");
   						if(lr.getEat_name() == null){
   							out.println("<p>"+lr.getPlac_name()+"</p>");
   						}else{
   							out.println("<p>"+lr.getEat_name()+"</p>");
   						}
   						
   						for(int i=1; i<6; i++){
   							if(i<=lr.getLr_star()){
   								out.println("<input type='radio' class='star' value='"+ i +"'><label>★</label>");
   							}else{
   								out.println("<input type='radio' class='star' value='"+ i +"'><label>☆</label>");
   							}
   						}
   						out.println("<textarea disabled>"+lr.getLr_contents()+"</textarea>");
   						out.println("</div><div class='file'>");
   						if(lr.getLr_file2().equals("bg1.jpg") && lr.getLr_file3().equals("bg1.jpg")){
   							out.println("<img src='uploadFile/"+lr.getLr_file1()+"' width=500px height=300px />");
   						}else if(lr.getLr_file3().equals("bg1.jpg")){
   							out.println("<img src='uploadFile/"+lr.getLr_file1()+"' width=245px height=300px />");
   							out.println("<img src='uploadFile/"+lr.getLr_file2()+"' width=245px height=300px />");
   						}else{
   							out.println("<img src='uploadFile/"+lr.getLr_file1()+"' width=310px height=300px />");
   							out.println("<img src='uploadFile/"+lr.getLr_file2()+"' width=180px height=145px />");
       						out.println("<img src='uploadFile/"+lr.getLr_file3()+"' width=180px height=145px/>");
   						}
   						out.println("</div><div>");
   						out.println("<p>"+lr.getLr_date()+"</p>");
   						out.println("</div></div>");
   					}
       				%>
       			</jsp:useBean>
        	</div>
        	<div id='more_div'><input type="button" name="more_btn" value="더보기"></div>
        </section>
    </div>
    <jsp:include page="main_footer.jsp" />
</body>

</html>