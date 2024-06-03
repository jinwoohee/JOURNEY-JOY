<%@page import="com.jj.dto.Eatery"%>
<%@page import="com.jj.dto.Place"%>
<%@page import="java.util.List"%>
<%@page import="com.jj.dto.Package"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<% 
	request.setCharacterEncoding("utf-8");
	String u_id = (String) session.getAttribute("u_id");
	
	int p_no;
	int p_period;
	
	if(request.getParameter("p_no") == null){
		p_no = (int)session.getAttribute("p_no");
		p_period = (int) session.getAttribute("p_period");
	}else{
		p_no = Integer.parseInt(request.getParameter("p_no"));
		p_period = Integer.parseInt(request.getParameter("p_period"));
		
		session.setAttribute("p_no", p_no);
		session.setAttribute("p_period", p_period);
	}
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<!-- css -->
	<link rel="stylesheet" type="text/css" href="css/package_schedule.css">
	
	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	
	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

</head>
<script>
	$(function(){
		$("div[id*='sc']").hide();
		$('#day1').css({'background':'#6C94B8', 'color':'white'});
		$('#sc1').show();
		
		/* 선택한 일정값 등록전에는 다른 일정 클릭못하게*/
		$("div[id*='day']").click(function(){	
			if($("div[id*='sc']").css("background") == "white"){
				$(this).css({'background':'#6C94B8', 'color':'white'});
				$("div[id*='sc']").slideDown();
				$(this).siblings("div[id*='day']").css({'pointer-events':'none'});
			}else if(($("div[id*='sc']").css("background") == '#0D112D')){
				alert("이미 등록된 일정입니다.");
			}else{
				alert("일정을 등록해주세요.");
			}
		});

		/* 파일등록 mouseenter/mouseleave */
		$("input[type='button']").mouseenter(function(){
			$(this).css({'box-shadow':'inset 5px 5px 10px #CCCCCC'});
		});

		$("input[type='button']").mouseleave(function(){
			$(this).css({'box-shadow':'none'});
		});
		
		$("button[name='regBtn']").click(function(){
			
			day = $(this).val();

			if($("input[name='title']").val() == ''){
				alert("제목을 입력해주세요.");
				return false;
			}else if($("textarea[name='contents']").val() == ''){
				alert("일정 설명을 입력해주세요.");
				return false;
			}else{
				alert("일정을 저장하였습니다.");
				
				sc = $("select[name='schedule1']").val() + "," + $("select[name='schedule2']").val() + "," + $("select[name='schedule3']").val() +"," + $("select[name='schedule4']").val();
				
				$(this).closest("div[id=sc"+day+"]").slideUp();
				$(this).parent().parent().siblings("div[id*='day"+day+"']").css({'background-color':'#0D112D', 'border' : 'none'});
				
				$("div[id*='day"+(parseInt(day)+parseInt(1))+"']").css({'background-color':'#6C94B8', 'color':'white'});				
				$("div[id=sc"+(parseInt(day)+parseInt(1))+"]").slideDown();
			}
		});
	});
	
	function regist(){
		if($("div[id*='sc']").is(":visible")){
			alert("일정을 등록해주세요.");
			return false;
		}else{
			alert("일정이 등록되었습니다. 리워드를 등록해주세요.");
		}
		
	}
</script>
<body>
	<jsp:include page="main_header.jsp" />
	
	<section id="schedule_section">
		<div>
			<p>일정 등록</p>
			<form name='sForm' method='post' action='aa.jsp'  onsubmit="return regist()">
			<input type='hidden' name='p_city' value='<%=request.getParameter("p_city")%>'>
			
			<%
				List<Place> placeList = (List<Place>)request.getAttribute("placeList");
				List<Eatery> eatList = (List<Eatery>)request.getAttribute("eatList");
				
				for(int i=1; i<p_period+1; i++){
					out.println("<div id='day"+i+"'>DAY"+i+"</div><div></div>");
					out.println("<input type='hidden' name='ps_day' value='"+i+"'>");
					
			%>
				<div id='sc<%=i%>'>
					<table id='scheduleTable'>
						<tr><td>일정 제목</td></tr>
						<tr>
							<td>
								<input type='text' name='title' size='20' maxlength='50' placeholder=' 제목 입력'>
							</td>
						</tr>
						<tr><td>일정 선택</td></tr>
						<tr>
							<td>
								<select name='schedule<%=i%>'>
									<%if(placeList.size()>0 || eatList.size()>0){
										for(Place p : placeList){%>
										<%
											String city = (String)request.getParameter("p_city");

											if(p.getPlac_city() != null){
												if(p.getPlac_city().equals(city)){%>
												<option value=<%=p.getPlac_no() %>><%=p.getPlac_name() %></option>
											<%}
											}%>
										<%}
									  }%>
								</select>
							</td>
						</tr>
						<tr><td>일정 선택</td></tr>
						<tr>
							<td>
								<select name='schedule<%=i%>'>
									<%if(placeList.size()>0 || eatList.size()>0){
										for(Place p : placeList){%>
										<%
											String city = (String)request.getParameter("p_city");
											if(p.getPlac_city() != null){
												if(p.getPlac_city().equals(city)){%>
												<option value=<%=p.getPlac_no() %>><%=p.getPlac_name() %></option>
											<%}
											}%>
										<%}
									  }%>
								</select>
							</td>
						</tr>
						<tr><td>일정 선택</td></tr>
						<tr>
							<td>
								<select name='schedule<%=i%>'>
									<%if(placeList.size()>0 || eatList.size()>0){
										for(Place p : placeList){%>
										<%
											String city = (String)request.getParameter("p_city");
											if(p.getPlac_city() != null){
												if(p.getPlac_city().equals(city)){%>
												<option value=<%=p.getPlac_no() %>><%=p.getPlac_name() %></option>
											<%}
											}%>
										<%}
									  }%>
								</select>
							</td>
						</tr>
						<tr><td>일정 선택</td></tr>
						<tr>
							<td>
								<select name='schedule<%=i%>'>
									<%if(placeList.size()>0 || eatList.size()>0){
										for(Place p : placeList){%>
										<%
											String city = (String)request.getParameter("p_city");
											if(p.getPlac_city() != null){
												if(p.getPlac_city().equals(city)){%>
												<option value=<%=p.getPlac_no() %>><%=p.getPlac_name() %></option>
											<%}
											}%>
										<%}
									  }%>
								</select>
							</td>
						</tr>
						<tr><td>일정 설명</td></tr>
						<tr>
							<td>
								<textarea name='contents' maxlength='100' cols='5' placeholder='설명 입력'></textarea>
							</td>
						</tr>
						<tr><td>공지사항</td></tr>
						<tr>
							<td>
								<textarea name='notice' maxlength='100' cols='5' placeholder='공지사항 입력'></textarea>
							</td>
						</tr>
				</table>
					<div id='buttonArea'>
						<input type="hidden" name="p_no" value="<%=p_no%>">
						<button type="button" name="regBtn" value="<%=i%>">일정저장</button>
					</div>
				</div>
				<% 
					}
				%>
				<input type="submit" value="등록하기">
			</form>
		</div>
	</section>
</body>
</html>