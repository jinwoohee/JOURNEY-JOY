<%@page import="com.jj.dto.Schedule"%>
<%@page import="com.jj.dto.Plan_review"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="dao" class="com.jj.dao.Plan_review" />
<jsp:useBean id="dto" class="com.jj.dto.Plan_review" />
<%
	request.setCharacterEncoding("utf-8"); 
	String pr_no = request.getParameter("page_no"); //write, pr_no
	String u_id = (String) session.getAttribute("u_id"); //아이디
	int e_no = Integer.parseInt(request.getParameter("e_no")); //견적번호
	String e_destination = request.getParameter("e_destination"); //도착지(도시)
	String e_start_date = request.getParameter("e_start_date"); //여행시작날짜
	String e_end_date = request.getParameter("e_end_date"); //여행종료날짜
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<!-- css -->
	<link href="css/plan_review_write.css" rel="stylesheet" type="text/css">

<title>Insert title here</title>
</head>
<script>

	/* 일정 상세보기 */
	function place_down(a){
		var place_div = "#pl_eat_div"+a;
		var down = "#down"+a;
		var up = "#up"+a;
		$("div[id*='pl_eat']").hide();
		$(place_div).slideDown();
		$("img[id*='down']").css({'display':'block'});
		$("img[id*='up']").css({'display':'none'});
		$(down).css({'display':'none'});
		$(up).css({'display':'block'});
	}
	function place_up(a){
		var place_div = "#pl_eat_div"+a;
		var down = "#down"+a;
		var up = "#up"+a;
		
		$(place_div).slideUp();
		$(down).css({'display':'block'});
		$(up).css({'display':'none'});
	}
	
	/* 첨부파일 */
	function upload(num){ //버튼 클릭시 input type=file 실행
 		$('input[name=file'+num+']').click();
 	}	
	
	/* 이미지 등록 후 미리보기 */
	function readURL(num){
		var img = new Image();
		img.src = '';
		
		const file = event.target.files;
		var imgTempUrl = window.URL.createObjectURL(file[0]);
		
		img.src = imgTempUrl;
		$('#preview'+num+'').append(img);
		$('input[name=upload_btn'+num+']').hide();
		$('input[name=del_btn'+num+']').show();
	}
	
	/* 첨부파일 삭제 버튼 */
	function del(num){
		$('input[name=file'+num+']').val("");
		$('#preview'+num+' > img').remove();
		$('input[name=upload_btn'+num+']').show();
		$('input[name=del_btn'+num+']').hide();
	}
</script>
<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>
	<!-- 페이지 섹션 -->
	<section>
		<div id="main_div">
			<%
			/* 일수(여행종료날짜-여행시작날짜) 가져오기 > 지금은 안씀 
			String start = e_start_date;
			String end = e_end_date;
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			Date sdate = sdf.parse(start);
			Date edate = sdf.parse(end);
			long datecnt = 1+(edate.getTime() - sdate.getTime()) /(1000*60*60*24);*/
			
			/* 일정가져오기 */
			ArrayList<Schedule> scList = (ArrayList<Schedule>)dao.select_planReview_pick(e_no);
			
			if(pr_no.equals("write")){//새로작성	%>					
				<form action='plan_review_insert.jsp' method='post' enctype="multipart/form-data">
					<input type='text' name='title' maxlength='50' placeholder='리뷰 제목(최대50자)' value='<%=u_id %>의 <%= e_destination %> 여행기'>
					<input type='hidden' name='e_no' value=<%=e_no %>>
					<textarea name='content' placeholder='여행 후기'></textarea>
					<hr><div id='empty'></div>
					
					<!-- 첨부파일 -->
					<div id="file_txt"><p>첨부파일</p></div>
					<div id="file">
						<div>
							<div id='thumnail1'>
								<div id='preview1'></div>
								<input type="button" name="upload_btn1" value="+" onclick="upload(1)">
								<input type="file" name="file1" accept=".jpg, .png, .gif" onchange="readURL(1)">
								<input type="button" name="del_btn1" value="-" onclick="del(1)">
							</div>
							<div id='thumnail2'>
								<div id='preview2'></div>
								<input type="button" name="upload_btn2" value="+" onclick="upload(2)">
								<input type="file" name="file2" accept=".jpg, .png, .gif" onchange="readURL(2)">
								<input type="button" name="del_btn2" value="-" onclick="del(2)">
							</div>
							<div id='thumnail3'>
								<div id='preview3'></div>
								<input type="button" name="upload_btn3" value="+" onclick="upload(3)">
								<input type="file" name="file3" accept=".jpg, .png, .gif" onchange="readURL(3)">	
								<input type="button" name="del_btn3" value="-" onclick="del(3)">	
							</div>
						</div>
					</div>
					
					<% for(Schedule sc : scList){ %>
						<div class='day_plan'>
							<div class='day_info'>
								<input type='hidden' name='sche_day' value=<%=sc.getSche_day() %>>
								<p class='day'>Day<%=sc.getSche_day()%></p>
								<img src='img/icon/write.png' class='day_write' onclick='place_down(<%=sc.getSche_day()%>)'>
								
								<%
								String schedule_place = sc.getPlace();
								schedule_place = schedule_place.replaceAll(",", " ");
								String [] place = schedule_place.split(" ");
								String place_name = "";
								String eat_name = "";
								%>
								
								<p class='place_info'>
								<%for(int i=0; i<place.length; i++){
									place_name = (String)dao.selectPlaceName(place[i]);
									eat_name = (String)dao.selectEatName(place[i]);
								%>
									#<%=place_name%>
									<%=eat_name%>
								<%} %></p>
								<img src='img/icon/arrow_down.png' id='down<%=sc.getSche_day()%>' onclick='place_down(<%=sc.getSche_day()%>)'/>
								<img src='img/icon/arrow_up.png' id='up<%=sc.getSche_day()%>' onclick='place_up(<%=sc.getSche_day()%>)'/>
							</div>
						
							<div id='pl_eat_div<%=sc.getSche_day()%>'>
								<div id='day_review<%=sc.getSche_day()%>'>
									<textarea name='day_review<%=sc.getSche_day()%>' placeholder='일정후기'></textarea>
								</div>
								<%for(int i=0; i<place.length; i++){
									place_name = (String)dao.selectPlaceName(place[i]);
									eat_name = (String)dao.selectEatName(place[i]);
								%>
									<p class='place'><div class='no'><%=i+1 %></div><%=place_name %><%=eat_name%></p>
									<a href='place_review_write.jsp?place_id=<%=place[i] %>'><img src='img/icon/write.png' class='place_write'></a>
								<%} %>
								</div>
							</div>
						<%}%>
						<div id='save_div'>
							<input type='submit' name='save' value='등록'>
							<a href='plan_review_list.jsp'><input type='button' name='cancel' value='취소'/></a>
						</div>
						</form>
						
						<%}else{
							ArrayList<com.jj.dto.Plan_review> reviewList = dao.select_plan_review(pr_no);
							for(com.jj.dto.Plan_review pr : reviewList){
						%>
							<form action='plan_review_update.jsp' method='post' enctype="multipart/form-data">
								<input type='hidden' name='page_no' value='<%=pr_no %>'>
								<input type='hidden' name='e_no' value=<%=e_no %>>
								<input type='text' name='title' placeholder='리뷰 제목(최대50자)' value='<%=pr.getPr_title() %>'>
								<textarea name='content' placeholder='여행 후기'><%=pr.getPr_contents() %></textarea>
								<hr>
								<div id='empty'></div>
								
								<!-- 첨부파일 -->
								<div id="file_txt"><p>첨부파일</p></div>
								<div id="file">
									<div>
										<div id='thumnail1'>
											<div id='preview1'></div>
											<input type="button" name="upload_btn1" value="+" onclick="upload(1)">
											<input type="file" name="file1" accept=".jpg, .png, .gif" onchange="readURL(1)">
											<input type="button" name="del_btn1" value="-" onclick="del(1)">
										</div>
										<div id='thumnail2'>
											<div id='preview2'></div>
											<input type="button" name="upload_btn2" value="+" onclick="upload(2)">
											<input type="file" name="file2" accept=".jpg, .png, .gif" onchange="readURL(2)">
											<input type="button" name="del_btn2" value="-" onclick="del(2)">
										</div>
										<div id='thumnail3'>
											<div id='preview3'></div>
											<input type="button" name="upload_btn3" value="+" onclick="upload(3)">
											<input type="file" name="file3" accept=".jpg, .png, .gif" onchange="readURL(3)">	
											<input type="button" name="del_btn3" value="-" onclick="del(3)">	
										</div>
									</div>
								</div>
								
								<% for(Schedule sc : scList){ %>
									<div class='day_plan'>
										<div class='day_info'>
											<input type='hidden' name='sche_day' value=<%=sc.getSche_day() %>>
											<p class='day'>Day<%=sc.getSche_day()%></p>
											<img src='img/icon/write.png' class='day_write' onclick='place_down(<%=sc.getSche_day()%>)'>
											
											<%
											String schedule_place = sc.getPlace();
											schedule_place = schedule_place.replaceAll(",", " ");
											String [] place = schedule_place.split(" ");%>
											
											<p class='place_info'>
											<%for(int i=0; i<place.length; i++){%>
												#<%=place[i] %>
											<%} %></p>
											<img src='img/icon/arrow_down.png' id='down<%=sc.getSche_day()%>' onclick='place_down(<%=sc.getSche_day()%>)'/>
											<img src='img/icon/arrow_up.png' id='up<%=sc.getSche_day()%>' onclick='place_up(<%=sc.getSche_day()%>)'/>
										</div>
									
										<div id='pl_eat_div<%=sc.getSche_day()%>'>
											<div id='day_review<%=sc.getSche_day()%>'>
												<textarea name='day_review<%=sc.getSche_day()%>' placeholder='일정후기'></textarea>
											</div>
											<%for(int i=0; i<place.length; i++){%>
												<p class='place'><div class='no'><%=i+1 %></div><%=place[i] %></p>
												<a href='place_review_write.jsp?place_name=<%=place[i] %>'><img src='img/icon/write.png' class='place_write'></a>
											<%} %>
											</div>
										</div>
									<%}%>
								<div id='save_div'>
									<input type='submit' name='save' value='수정'>
									<a href='plan_review_list.jsp'><input type='button' name='cancel' value='취소'/></a>
								</div>	
								</form>
						<%} %>
				<%}%>
		</div>
	</section>
	<footer>
		<jsp:include page="main_footer.jsp" />	
	</footer>
</body>
</html>