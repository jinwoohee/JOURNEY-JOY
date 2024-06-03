<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.jj.dto.Package_like"%>
<%@page import="com.jj.dto.Package"%>
<%@page import="com.jj.dto.PageInfo"%>
<%@page import="java.util.List"%>

<%
	request.setCharacterEncoding("utf-8");
	String u_id = (String) session.getAttribute("u_id");
	
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
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- css -->
<link rel="stylesheet" type="text/css" href="css/packageList.css">

<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<!-- font -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

</head>
<script type="text/javascript">
	$(function() {
		/* 로그인 한 사용자만 이용 */
		$("#write").click(function(){
			$(location).attr('href', 'package_insert.jsp');
		});
		
		$("#noWrite").click(function(){
			alert("로그인 후 이용해주세요.");
			$(location).attr('href', 'login.jsp');	
		});
		
		$("#noDetail").click(function(){
			alert("로그인 후 이용해주세요.");
			$(location).attr('href', 'login.jsp');	
		});
		
		/* 날짜 */
		$("#datepicker").datepicker({
			dateFormat: 'yy-mm-dd' //달력 날짜 형태
			,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
			,showMonthAfterYear:true //년도 - 월 순서
			,changeYear: true //년 선택 가능
            ,changeMonth: true //월 선택 가능
            ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
		});

		//초기값을 오늘 날짜로 설정
        $("#datepicker").datepicker('setDate', 'today');

        /* 이미지 mouseenter, mouseleave */
        $(".thumnail").mouseenter(function(){
        	$(this).find('img').css({'transform':'scale(1.2)'});
        });
        $(".thumnail").mouseleave(function(){
        	$(this).find('img').css({'transform':'scale(1)'});
        });

        /* 버튼 mouseenter, mouseleave */
        $("input[type='button']").mouseenter(function(){
        	$(this).css({'box-shadow':'inset 5px 5px 10px #000054'});
        });
        $("input[type='button']").mouseleave(function(){
        	$(this).css({'box-shadow':'none'});
        });	
        
        /* 검색버튼 */
        $('#searchBtn').click(function(){
        	// var resultDiv = document.getElementById("packageList_div");
        	 
        	 $.ajax({ //전체, 최신순, 여행테마, 여행도시, 날짜, 단어
        		url : "package_list.jj?page=packageSearch",
        		data : {"param1" : $("select[name='param1']").val(), "param2" : $("select[name='param2']").val(), "param3" : $("select[name='param3']").val(), "param4" : $("select[name='param4']").val(), "date":$("input[name='date']").val(), "txt":$("input[name='searchBox']").val()},
        		success : function(re){
        			$("#packageList_div").html(re);
        		}
        	 });
        });
        
        /* 검색 이미지 아이콘 */
        $('#search_section div').mouseenter(function(){
        	$(this).css({"box-shadow":"0 0 8px #CCCCCC"});
        });
        $('#search_section div').mouseleave(function(){
        	$(this).css({"box-shadow": "none"});
        });
        
    	/* 검색 */
        $('#search_section div').click(function(){
        	if($(this).css('background-color') != 'rgb(241, 241, 243)'){
        		$(this).css({"background":"#f1f1f3", "border-radius":"10px"});
        		$(this).siblings('div').css({"background":"white"});
        		
        		$.ajax({ //최신순, 인기순, 마감순, 힐링, 액티비티, 자연, 테마파크, 먹방, 덕질, 일본, 캐나다, 그외
            		url : "package_list.jj?page=packageSearch",
            		data : {"param" : $(this).attr('id')},
            		success : function(re){
            			$("#packageList_div").html(re);
            		}
            	 });
        	}
        });
        
    	/* 페이징 */
        $('#pagination li').click(function(){
        	$(this).css({"background":"#6C94B8", "color":"white"});
    		$(this).siblings('li').css({"background":"white", "color":"#646464"});
        });
	});

</script>
<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>
	
	<!-- header(이미지) -->
	<section>
		<div id="top_section">
			<img src="img/travel/travel.jpg">
			<div>
				<div>
					<p>패키지 여행</p>
					<p>#다함께 #떠나는 #패키지 #여행</p>
				</div>
			</div>
		</div>
	</section>

	<!-- 계획하기 버튼 -->
	<div id='packageWrite_div'>
		<%
			if(u_id != null){
				out.println("<input type='button' id='write' value='패키지 기획하기'>");
			}else{
				out.println("<input type='button' id='noWrite' value='패키지 기획하기'>");
			}
		%>
		
	</div>

	<!-- 검색구간 -->
	<section>
		<div id="search_section">
			<div id='recent'><img alt="최신순" src="img/icon/search1.png"></div>
			<div id='popular'><img alt="인기순" src="img/icon/search2.png"></div>
			<div id='closing'><img alt="마감순" src="img/icon/search3.png"></div>
			<div id='healing'><img alt="힐링" src="img/icon/search4.png"></div>
			<div id='activity'><img alt="체험/액티비티" src="img/icon/search12.png"></div>
			<div id='nature'><img alt="자연" src="img/icon/search6.png"></div>
			<div id='themepark'><img alt="테마파크" src="img/icon/search5.png"></div>
			<div id='eating'><img alt="먹방" src="img/icon/search8.png"></div>
			<div id='favorite'><img alt="덕질" src="img/icon/search7.png"></div>
			<div id='japan'><img alt="일본" src="img/icon/search9.png"></div>
			<div id='canada'><img alt="캐나다" src="img/icon/search10.png"></div>
			<div id='etc'><img alt="그외" src="img/icon/search11.png"></div>
		</div>
	</section>

	<!-- 리스트 출력 -->
	<section>
		<article>
			<div id='packageList_div'>
				<ul>
					<%
						List<Package> pkList = (List<Package>)request.getAttribute("pkList");
						List<Package_like> likeList = (List<Package_like>)request.getAttribute("likeList");%>
						
						<input type='hidden' name='total' value=<%=pkList.size() %>>
						
						<%					
						for(Package list : pkList){
							out.println("<li>");
							out.println("<input type='hidden' name='p_no' value='"+list.getP_no()+"'>");
							out.println("<div class='thumnail'>");
							out.println("<a href='packageDetail.jj?page=package_detail&p_no="+list.getP_no()+"&u_id="+u_id+"'>");
							out.println("<img src='uploadFile/"+list.getP_file()+"'/></a></div>");
							int flag=1;
							for(int idx = 0 ; idx < likeList.size() ; idx++){
								if(list.getP_no() == likeList.get(idx).getP_no() && likeList.get(idx).getU_id().equals(session.getAttribute("u_id"))){
									flag=2;
								}
							}
							if(flag==1)
								out.println("<div><img src='img/icon/heart2.png'/></div>");
							else
								out.println("<div><img src='img/icon/heart.png'/></div>");	
							
							out.println("<div><p>"+list.getP_nation()+"</p></div>");
							out.println("<div><p>"+list.getP_city()+"</p></div>");
							out.println("<div><P class='title'>"+list.getP_title()+"</P></div>");
							out.println("<div><P>"+list.getU_nickname()+"</P></div>");
							
							DecimalFormat f = new DecimalFormat("###,###,###");
							out.println("<div><P>"+f.format(list.getChild_fee())+"~</P></div>");
							out.println("</li>");
						}
					%>
				</ul>
			</div>	
		</article>
	</section>
	<div class="pagination_div">
		<ul class="pagination">
			<%
				if(nowPage<=1){%>
					<li>이전</li>
			<%}else{%>
				<li><a href="classList.jj?page=selectPageInfo&nowPage=<%=nowPage-1%>&table=package">이전</a></li>
			<%} %>
			
			<%
				for(int i=startPage; i<=endPage; i++){
					if(i == nowPage){%>
						<li><%=i %></li>
			<%		}else{%>
						<li><a href="classList.jj?page=selectPageInfo&nowPage=<%=i%>&table=package"><%=i %></a></li>
				
			<%		}
				}
			%>
			
			<%
				if(nowPage >= maxPage){%>
					<li>다음</li>
			<%	}else{%>
				<li><a href="classList.jj?page=selectPageInfo&nowPage=<%=nowPage+1%>&table=package">다음</a></li>
			<%}%>
		</ul>
	</div>
	<jsp:include page="main_footer.jsp" />
</body>
</html>