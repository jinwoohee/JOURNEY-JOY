<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jj.dao.BoardDB"%>
<%@page import="com.jj.dto.Board"%>
<%@page import="com.jj.dto.PageInfo"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String u_id = (String)session.getAttribute("u_id");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>자유게시판</title>
    
    <link href="css/board.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <script type="text/javascript">
    	$(document).ready(function () {
    		$('select[name=nation]').change(function() {
				console.log($(this).find('option:selected').text());
				if ($(this).find('option:selected').text() == '국가') {
					$('select[name=city]').find('option').remove();
					$('select[name=city]').append('<option>도시</option>');
				} else if ($(this).find('option:selected').text() == '일본') {
					$('select[name=city]').find('option').remove();
					$('select[name=city]').append('<option>도시</option>');
					$('select[name=city]').append('<option>도쿄</option>');
					$('select[name=city]').append('<option>오사카</option>');
					$('select[name=city]').append('<option>후쿠오카</option>');
					$('select[name=city]').append('<option>교토</option>');
					$('select[name=city]').append('<option>나리타</option>');
				} else if ($(this).find('option:selected').text() == '캐나다') {
					$('select[name=city]').find('option').remove();
					$('select[name=city]').append('<option>도시</option>');
					$('select[name=city]').append('<option>벤쿠버</option>');
					$('select[name=city]').append('<option>토론토</option>');
					$('select[name=city]').append('<option>캘거리</option>');
					$('select[name=city]').append('<option>빅토리아</option>');
					$('select[name=city]').append('<option>몬트리올</option>');
				}
			});
    		
			$('#search_btn').click(function () {
				/*if ($('select[name=nation] option:selected').text() != "국가" || $('select[name=city] option:selected').text() != "도시" ||
					$('select[name=month] option:selected').text() != "여행시기" || $('select[name=category] option:selected').text() != "카테고리" ||
					$('input[name=stxt]').val() != null) {
					return false;
				}*/
				
				
		
			});
			
			$('.write').click(function () {
				$('form[name="write"]').attr('action', 'board_insert.jsp');
			});
			
			$('.no_write').click(function () {
				alert("로그인 후 이용가능합니다.");
				$('form[name="write"]').attr('action', 'login.jsp');
			});
			
			/* 페이징 */
	        $('#pagination li').click(function(){
	        	$(this).css({"background":"#6C94B8", "color":"white"});
	    		$(this).siblings('li').css({"background":"white", "color":"#646464"});
	        });
		});
    </script>
</head>
<body>
	<jsp:include page="main_header.jsp" />
	
	<div class="all_wrap">
		<!-- 게시판 검색필터 -->
		<form action="board.jsp" method="post">
			<div class="f_wrap">
				<select name="nation">
					<option>국가</option>	
					<option>일본</option>
					<option>캐나다</option>
					
				</select>
				<select name="city">
					<option>도시</option>
				</select>
				<select name="month">
					<option>여행시기</option>
					<option>1월</option>
					<option>2월</option>
					<option>3월</option>
					<option>4월</option>
					<option>5월</option>
					<option>6월</option>
					<option>7월</option>
					<option>8월</option>
					<option>9월</option>
					<option>10월</option>
					<option>11월</option> 
					<option>12월</option>
				</select>
				<select name="category">
					<option>카테고리</option>
					<option>음식</option>
					<option>쇼핑</option>
					<option>일상</option>
					<option>날씨</option>
					<option>휴업/폐업</option>
				</select>
				<input type="text" name="stxt" placeholder="검색어를 입력해주세요">
				<button type="submit" id="search_btn" name="sbtn">검색</button>
			</div>
		</form>
		
		<!-- 게시판 리스트 -->
		<jsp:useBean id="board" class="com.jj.dao.BoardDB">
		<%
			PageInfo pageInfo;
			
			if ((PageInfo) request.getAttribute("pageInfo") != null) {
				pageInfo = (PageInfo) request.getAttribute("pageInfo");
			} else {
				pageInfo = board.listCountSelect(1);
			}
		
			request.setCharacterEncoding("utf-8");
			String stxt = request.getParameter("stxt");
			String nation = request.getParameter("nation");
			String city = request.getParameter("city");
			String month = request.getParameter("month");
			String category = request.getParameter("category");
			//System.out.println("jsp----->" + stxt + "/" + nation + "/" + city + "/" + month + "/" + category);
			
			ArrayList<Board> alist;
			
			if (stxt != null || nation != null || city != null || month != null || category != null) {
				alist = board.searchRow(stxt, nation, city, month, category);
			} else {
				alist = board.selectRow(-1, pageInfo.getPage());
			}
			
			out.println("<div class='board_wrap'>");
			out.println("<div class='board'>");
			out.println("<div class='board_title'>");
			out.println("<p class='sch_result'>총 게시물<strong> " + pageInfo.getListCount() + "</strong>개</p>");
			out.println("</div>"); //board_title 끝
			out.println("<div class='board_list_wrap'>");
			out.println("<div class='board_list'>");
			out.println("<div class='top'>");
			out.println("<div class='num'>번호</div>");
			out.println("<div class='ncity'>국가/도시</div>");
			out.println("<div class='category'>카테고리</div>");
			out.println("<div class='title'>제목</div>");
			out.println("<div class='uid'>작성자</div>");
			out.println("<div class='date'>작성일</div>");
			out.println("</div>"); //top 끝
			//for문
			for (Board b : alist) {
				out.println("<div>");
				out.println("<div class='num'>" + b.getB_no() + "</div>");
				out.println("<div class='ncity'>" + b.getB_nation() + "/" + b.getB_city() + "</div>");
				out.println("<div class='category'>" + b.getB_category() + "</div>");
				out.println("<div class='title'><a href='board_cont.jsp?no=" + b.getB_no() + "'>" + b.getB_title() + "</a></div>");
				out.println("<div class='uid'>" + b.getU_nickname() + "</div>");
				out.println("<div class='date'>" + b.getB_date() + "</div>");
				out.println("</div>");
			}
			out.println("</div>"); //board_list 끝
			out.println("</div>"); //board_list_wrap 끝
			out.println("<form name='write' method='post'>");
			if (u_id != null) {
				out.println("<button class='write'>글쓰기</button>");
			} else {
				out.println("<button class='no_write'>글쓰기</button>");
			}
			out.println("</form>");
		%>
		<div class="pagination_div">
			<ul class="pagination">
				<c:set var="nowPage" value="<%= pageInfo.getPage() %>" />
				<c:set var="maxPage" value="<%= pageInfo.getMaxPage() %>" />
				
				<c:choose>
					<c:when test="${ nowPage <= 1 }"><li><p>이전</p></li></c:when>
					<c:otherwise>
						<li><a href="board_listCountDB.jsp?nowPage=${ nowPage - 1 }"><p>이전</p></a></li>
					</c:otherwise>
				</c:choose>
				<c:forEach var="i" begin="<%= pageInfo.getStartPage() %>" end="<%= pageInfo.getEndPage() %>">
					<c:choose>
						<c:when test="${ i == nowPage }">
							<li><p style="text-decoration: underline;">${ i }</p></li>
						</c:when>
						<c:otherwise>
							<li><a href="board_listCountDB.jsp?nowPage=${ i }"><p>${ i }</p></a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:choose>
					<c:when test="${ nowPage >= maxPage }"><li><p>다음</p></li></c:when>
					<c:otherwise>
						<li><a href="board_listCountDB.jsp?nowPage=${ nowPage + 1 }"><p>다음</p></a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
		<%	
			out.println("</div>"); //board 끝
			out.println("</div>"); //board_wrap 끝
		%>
	    </jsp:useBean>
	</div>
	
	<jsp:include page="main_footer.jsp"></jsp:include>
</body>
</html>