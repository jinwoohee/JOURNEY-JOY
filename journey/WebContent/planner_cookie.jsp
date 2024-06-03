<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<%
	request.setCharacterEncoding("utf-8");
	
	String id = (String) session.getAttribute("u_id");
	String departure = request.getParameter("departure");
	String destination = request.getParameter("city_text");
	String start_date = request.getParameter("startDt");
	String end_date = request.getParameter("endDt");
	String thema = request.getParameter("thema");
	String []detail_thema = request.getParameterValues("place");
	String volume = request.getParameter("with");
	String []food_taste = request.getParameterValues("eat");  //메인에서 고른 음식취향을 배열로 가져온다.
	String airplane;
	String hotel;
	if(request.getParameter("airplane") == null){
		airplane = "1";
	}else{
		airplane = "2";
	}
	if(request.getParameter("hotel") == null){
		hotel = "1";
	}else{
		hotel = "2";
	}
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Date sdate = sdf.parse(start_date);
	Date edate = sdf.parse(end_date);
	long datecnt = 1+(edate.getTime() - sdate.getTime()) /(1000*60*60*24);
	String day = datecnt+"";
			
	String thema_arr = Arrays.toString(detail_thema);
	String thema_st = thema_arr.replaceAll("\\[", "").replaceAll("\\]", "").replaceAll(",", "");
	String e_detail_thema = thema_st.replaceAll(" ", "_");

	String food_arr = Arrays.toString(food_taste); // 배열로 가져온 food_taste[]를 스트링형태로 바꾼다. Arrays.toString으로 바꾸면 [값1, 값2, 값3] .. 으로 자동저장된다.
	String food_st = food_arr.replaceAll("\\[", "").replaceAll("\\]", "").replaceAll(",", ""); // 위의 이유로 괄호 삭제.(콤마는 쿠키에 넣을수없어서 삭제함)
	// String food_st = "값1, 값2, 값3, 값4 ..." 로 DB에 넣어야 해서 작업함
	// 뺄때는 split으로 ", "(띄어쓰기 구분)
	String e_food_taste = food_st.replaceAll(" ", "_"); // 위의 줄의 이유로 쿠키에는 ,(콤마)가 못들어가서 Arrays.toString 으로 값넣을시에 생성되는 띄어쓰기 값을 _ 로 바꿈  (쿠키생성시에만 필요)
	
	response.addCookie(new Cookie("u_id", id));
	response.addCookie(new Cookie("e_departure", departure));
	response.addCookie(new Cookie("e_destination", destination));
	response.addCookie(new Cookie("e_start_date", start_date));
	response.addCookie(new Cookie("e_end_date", end_date));
	response.addCookie(new Cookie("e_thema", thema));
	response.addCookie(new Cookie("e_detail_thema", e_detail_thema));
	response.addCookie(new Cookie("e_volume", volume));
	response.addCookie(new Cookie("e_food_taste", e_food_taste));
	response.addCookie(new Cookie("e_airplane", airplane));
	response.addCookie(new Cookie("e_hotel", hotel));
	response.addCookie(new Cookie("datecnt",day));
	response.sendRedirect("planner.jj?page=plan");
	
%>