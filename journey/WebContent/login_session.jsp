<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@page import="java.sql.*" %>
<%
	String u_id = request.getParameter("u_id");
	String u_pw = request.getParameter("u_pw");
	System.out.println(u_id + " | " + u_pw);
	
	Connection conn = null;
	Statement stmt = null;
	
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/trip", "root", "1234"); //db연결
		if (conn == null) {
			throw new Exception("데이터베이스에 연결할 수 없습니다.<br>");
		}
		stmt = conn.createStatement(); //실제 쿼리문장 수행
		//String sql = "select u_id, u_pw from user where u_id='" + u_id + "' and u_pw = '" + u_pw + "';";
		ResultSet rs = stmt.executeQuery("select u_id, u_pw from user where u_id='" + u_id + "' and u_pw = '" + u_pw + "';");
		
		if (rs.next()) {
			System.out.println("rs.next------->u_id");
			session.setAttribute("u_id", rs.getString("u_id"));
			response.sendRedirect("index.jsp");
		} else {
			System.out.println("값 못가져옴");
			response.sendRedirect("login.jsp?success=no");
		}
	} finally {
		try {
			stmt.close();
		} catch (Exception e) {
			System.out.println("stmt------------");
			e.getStackTrace();
		}
		try {
			conn.close();
		} catch (Exception e) {
			System.out.println("conn------------");
			e.getStackTrace();
		}
	}
	
	
	
	
	
	
%>