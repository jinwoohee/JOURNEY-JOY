<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    


<%
request.setCharacterEncoding("utf-8");
	Cookie[] cookies = request.getCookies();
%>
<%!private String getCookieValue(Cookie[] cookies, String name){
		String value = null;
		if(cookies == null)
			return null;
		for(Cookie cookie : cookies){
			if(cookie.getName().equals(name))
				return cookie.getValue();
		}
		return null;
	}%>
    
<% 
	String paging = request.getParameter("paging");
	String e_no = (String) request.getAttribute("e_no");
	System.out.println("페이징 jsp로 옴 페이징 : "+paging+"e_no : "+e_no);
	
	if(paging != null){
		if(paging.equals("edit_my")){
			if(e_no == null){
				e_no = request.getParameter("e_no");
				System.out.println("수정");
				response.addCookie(new Cookie("where", "edit_my"));
				System.out.println(e_no);
				response.addCookie(new Cookie("e_no", e_no));
				response.sendRedirect("planner.jj?page=select");
			}
		}else if(paging.equals("detail_my")){
			e_no = request.getParameter("e_no");
			System.out.println("디테일");
			response.addCookie(new Cookie("where", "detail_my"));
			response.addCookie(new Cookie("e_no", e_no));
			response.sendRedirect("planner.jj?page=select");
			
		}else if(paging.equals("list")){
			System.out.println("리스트로");
			response.addCookie(new Cookie("where", "list"));
			response.sendRedirect("planner.jj?page=select");
		}
		
	}else{
		paging = (String) request.getAttribute("paging");
		if(paging.equals("list")){
		System.out.println("리스트로");
		response.addCookie(new Cookie("where", "list"));
		response.sendRedirect("planner.jj?page=select");
		
		}else if(paging.equals("detail_my_edit")){
			e_no = request.getParameter("e_no");
			System.out.println("디테일");
			response.addCookie(new Cookie("where", "detail_my_edit"));
			response.addCookie(new Cookie("e_no", e_no));
			response.sendRedirect("planner.jj?page=select");
			
		}
		else{
			response.addCookie(new Cookie("where", "detail"));
			response.addCookie(new Cookie("e_no", e_no));
			response.sendRedirect("planner.jj?page=select");
		}
		
	}
%>
