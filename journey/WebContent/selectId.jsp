<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	String id = request.getParameter("id");
	
	Connection conn = null; //연결에대한 정보
	Statement stmt = null;  //실제 쿼리문
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/trip?characterEncoding=utf8&useSSL=false", "root", "1234"); //DB에서 값을 가져올때 인코딩
		if(conn == null)
			throw new Exception("DB에 연결할 수 없습니다.<br>");
		stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("select * from user where u_id='"+id+"';");
		
		if(rs.next()){
			System.out.println("---아이디 중복---");
			out.print("1");
		}else{
			out.print("0");
		}
		
	}finally{
		try{
			stmt.close();
		}catch(Exception ignored){
		}try{
			conn.close();
		}catch(Exception ignored){
		}
	}
	
%>