<%@page import="com.jj.dto.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.jj.dto.Class_list"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.jj.dto.Estimate"%>


<%
	request.setCharacterEncoding("utf-8");
	String u_id = (String)session.getAttribute("u_id");
	ArrayList<Estimate> estimateList = (ArrayList<Estimate>)request.getAttribute("elist");
	
	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int listCount = pageInfo.getListCount();
	int nowPage = pageInfo.getPage();
	int maxPage=pageInfo.getMaxPage();
	int startPage=pageInfo.getStartPage();
	int endPage=pageInfo.getEndPage();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>JOURNEY JOY::여행톡::</title>

	<link rel="stylesheet" type="text/css" href="css/classList.css">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

	<!-- 페이징 -->
	<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
	<!-- <script src="js/jquery.twbsPagination.js" type="text/javascript"></script> -->

</head>
<script>
	$(function(){
        //내가만든모임/참여한모임 클릭이벤트
        $("#sector_section > input[type=button]").click(function(){
        	if($(this).attr('name') == 'made'){
        		$("input[name='made']").css({'color':'#FFE400', 'font-weight':'bold'});
        		$("input[name='participate']").css({'color': 'white', 'font-weight':'none'});
        	}else{
        		$("input[name='participate']").css({'color':'#FFE400', 'font-weight':'bold'});
        		$("input[name='made']").css({'color': 'white', 'font-weight':'none'});
        	}
        	
        	$.ajax({
        		url : "class_list.jj?page=classTab",
        		data : {"tab" : $(this).attr('name'), "u_id" : $("input[name=u_id]").val()},
        		success : function(re){
        			$("#class_div").html(re);
        		}	
        	});
        });

        $(".joinClass").click(function(){
        	if($(this).hasClass("toggleBtn")){
        		$(this).removeClass("toggleBtn");
        	}else{
        		$(this).addClass("toggleBtn");
        	}
        });
        
        /* 모임만들기 버튼 */
        $('.make_btn').click(function(){
        	var city = $("select[name=city]").val();
        	if(city == "여행중인 도시"){
        		alert("여행중인 도시를 선택해주세요.");
        	}else{
        		$(location).attr('href', 'class_insert.jsp?city='+$("select[name=city]").val()+'');
        	}
        });

        /* 검색필터 */
        $('#filter div').click(function(){
        	if($(this).css('background-color') != 'rgb(241, 241, 243)'){
        		$(this).css({'background':'#0D112D'});
        		$(this).find('p').css({'color' : 'white'});
        		$(this).siblings('div').css({"background":"white"});
        		$(this).siblings('div').find('p').css({'color' : '#0D112D'});
        		
        		/* 탭 글씨 색원래대로 */
        		$("input[name='participate']").css({'color': 'white', 'font-weight':'none'});
        		$("input[name='made']").css({'color': 'white', 'font-weight':'none'});

        		$.ajax({
        			url : "class_list.jj?page=classFilter",
        			data : {"city": $('select[name=city]').val(), "param" : $(this).attr('id'), "u_id" : $("input[name=u_id]").val()},
        			success : function(re){
        				$("#class_div").html(re);
        			}
        		});
        	}
        });

        /* 검색창 */
        $('#search img').click(function(){
        	var filter;
        	
        	if($('#entire').css('background-color') == '#0D112D'){
        		filter = 'entire';
        	}else if($('#recent').css('background-color') == 'rgb(241, 241, 243)'){
        		filter = "recent";
        	}else if($('#closing').css('background-color') == 'rgb(241, 241, 243)'){
        		filter = "closing";
        	}else if($('#ing').css('background-color') == 'rgb(241, 241, 243)'){
        		filter = "ing";
        	}else{
        		filter = "end";
        	}

        	$.ajax({
        		url : "class_list.jj?page=classFilter",
    			data : {"city": $('select[name=city]').val(), "param" : filter, "search" : $('input[name=searchBox]').val()},
    			success : function(re){
    				$("#class_div").html(re);
    			}
        	});
        })
        
        $('#location select').change(function(){
        	$.ajax({
        		url : "class_list.jj?page=classFilter",
    			data : {"city": $('select[name=city]').val()},
    			success : function(re){
    				$("#class_div").html(re);
    			}
        	});
        });

	});
	
	/* 모임참여 버튼 */
	function joinClass(no){
		$.ajax({
    		url : "class_apply.jj?page=class_apply",
    		data : {"u_id" : $("input[name=u_id]").val(), "c_no" : no},
    		success : function(re){
    			alert("모임에 참여하였습니다.");
    			location.reload();
    		}	
    	});
	}
	
	/* 모임취소 버튼 */
	function delClass(no){
		$.ajax({
    		url : "class_applyDel.jj?page=class_applyDel",
    		data : {"u_id" : $("input[name=u_id]").val(), "c_no" : no},
    		success : function(re){
    			location.reload();
    		}	
    	});
	}
	
	/* 페이징 */
    $('#pagination li').click(function(){
    	$(this).css({"background":"#6C94B8", "color":"white"});
		$(this).siblings('li').css({"background":"white", "color":"#646464"});
    });
</script>
<body>
	<jsp:include page="main_header.jsp" />

	<!-- header(이미지) -->
	<section>
		<div id="top_section">
			<img src="img/travel/class.jpg">
			<div>
				<div>
					<p>모임만들기</p>
					<p>#여행지에서 #만드는 #새로운 #인연</p>
				</div>
			</div>
		</div>
	</section>

	<!-- 모임만들기 버튼 -->
	<div>
	<% if(estimateList.size() > 0){%>
			<input type='button' class='make_btn' value='모임 만들기'>
	<%}%>
	</div>

	<!-- 내가여행중인 국가 -->
	<section>
		<div id="location">
			<img id="icon" src="img/icon/plane.png">
			<div>
				<select name='city'>
				<option>여행중인 도시</option>
				<%
					for(Estimate e : estimateList){%>
						<option><%=e.gete_destination() %></option>
				<%	} %>
				</select>
			</div>
			<hr>
		</div>
	</section>
	
	<!-- 검색구간 -->
	<section>
		<div id="search_section">
			<div>
				<div id='filter'>
					<div id='entire'><p>#전체</p></div>
					<div id='recent'><p>#최신순</p></div>
					<div id='closing'><p>#마감순</p></div>
					<div id='ing'><p>#진행중</p></div>
					<div id='end'><p>#종료</p></div>
				</div>
				<div id="search">
					<input type="text" name="searchBox" placeholder=" 검색단어 입력">
					<img src='img/icon/search_btn.png'>
				</div>
			</div>
		</div>
	</section>

	<!-- 버튼 -->
	<section>
		<article>
			<div id="sector_section">
				<input type="hidden" name="u_id" value=<%=u_id %>>
				<input type="button" name="made" value="내가 만든 모임">
				<input type="button" name="participate" value="참여한 모임">
			</div>
		</article>
	</section>

	<!-- 리스트 출력 -->
	<section>
		<article>
			<div id="class_div">
				<%
					ArrayList<Class_list> classList = (ArrayList<Class_list>)request.getAttribute("clist");	
					
					int flag = 0;

					for (Class_list c : classList) {
						for(Estimate e : estimateList){ //내가 여행중인 도시만 참여하기 버튼 생성
							if(c.getC_city().equals(e.gete_destination())){
								flag = 1;
							}else{
								flag = 0;
							}
						}
				%>
				<div id="class_section">
					<!-- 프로필/닉네임 -->
					<div >
						<img class='profile' src="<%=c.getU_profile() %>">
						<p><%= c.getU_nickname() %></p>		
					</div>
					<div>
						<div>
							<img src="uploadFile/<%=c.getC_file1()%>">
						</div>
						<div>
							<img src="img/icon/location.png">
							<p><%= c.getC_city() %></p>
							<div>
								<table>
									<tr>
										<td>모임명</td>
										<td><%= c.getC_title() %></td>
									</tr>
									<tr>
										<td>모임 내용</td>
										<td><%= c.getC_contents() %></td>
									</tr>
									<tr>
										<td>모집 인원</td>
										<td><%=c.getCount() %>/<%= c.getC_volume() %>명</td>
									</tr>
									<tr>
										<td>예상 경비</td>
										<% DecimalFormat f = new DecimalFormat("###,###,###"); %>
										<td><%= f.format(c.getC_charge())+"원" %></td>
									</tr>
									<tr>
										<td>모집 종료</td>
										<td><%= c.getC_end_date() %></td>
									</tr>
								</table>
								<%
								  if(flag == 1){
									//참여 하기, 취소하기
									if(c.getA_id() != null && c.getA_id().equals(u_id)){ //참여여부(a_id : 참여한 사람 아이디)
										if(c.getC_no() == c.getA_no()){%>
											<input type='button' name='del_btn<%=c.getC_no() %>' value='참여취소' onclick='delClass(<%=c.getC_no() %>)'>
										<%}else{%>
											<input type='button' name='join_btn<%=c.getC_no() %>' value='모임참여' onclick='joinClass(<%=c.getC_no() %>)'>
										<%}
									}else{
								%>
								
								<%
									//모집마감된 경우 참여버튼 안되게
									Date now = new Date();
									SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
									String today = sf.format(now);

									int date = Integer.parseInt(today.replaceAll("-", ""));
									int getDate = Integer.parseInt(c.getC_end_date().replaceAll("-", ""));
									
									if(date > getDate || c.getCount() == c.getC_volume()){ //모집마감날짜, 모집인원
										out.println("<input type='button' name='end_btn' value='참여마감'>");
									}else{
								%>
								<input type='button' name='join_btn<%=c.getC_no() %>' value='모임참여' onclick='joinClass(<%=c.getC_no() %>)'>
								<%} }  }%>
							</div>
						</div>
					</div>
				</div>
				<% } %>
			</div>
		</article>
	</section>
	<div class="pagination_div">
		<ul class="pagination">
			<%
				if(nowPage<=1){%>
					<li>이전</li>
			<%}else{%>
				<li><a href="classList.jj?page=selectPageInfo&nowPage=<%=nowPage-1%>&table=class_list">이전</a></li>
			<%} %>
			
			<%
				for(int i=startPage; i<=endPage; i++){
					if(i == nowPage){%>
						<li><%=i %></li>
			<%		}else{%>
						<li><a href="classList.jj?page=selectPageInfo&nowPage=<%=i%>&table=class_list"><%=i %></a></li>
				
			<%		}
				}
			%>
			
			<%
				if(nowPage >= maxPage){%>
					<li>다음</li>
			<%	}else{%>
				<li><a href="classList.jj?page=selectPageInfo&nowPage=<%=nowPage+1%>&table=class_list">다음</a></li>
			<%}%>
		</ul>
	</div>
	<jsp:include page="main_footer.jsp" />
</body>
</html>