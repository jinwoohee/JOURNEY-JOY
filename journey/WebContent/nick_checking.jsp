<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%
	String nickname = request.getParameter("nickname");
	System.out.println(nickname);
	Connection conn = null;
	Statement stmt = null;
	
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/trip", "root", "1234"); //db연결
		if (conn == null) {
			throw new Exception("데이터베이스에 연결할 수 없습니다.<br>");
		}
		stmt = conn.createStatement(); //실제 쿼리문장 수행
		ResultSet rs = stmt.executeQuery("select u_nickname from user where u_nickname = '" + nickname + "';");
		
		if (rs.next()) {
			System.out.println("닉네임존재ooo");
			out.println("1");
		} else {
			System.out.println("닉네임존재xxx");
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