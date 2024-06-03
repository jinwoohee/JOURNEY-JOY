<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="javax.xml.crypto.Data"%>
<%@page import="java.sql.*" %>	
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String nickname = request.getParameter("nickname");
	String p1 = request.getParameter("phone");
	String p2 = request.getParameter("phone1");
	String p3 = request.getParameter("phone2");
	String ymd = request.getParameter("ymd");
	String email = request.getParameter("email");
	String emailAddr = request.getParameter("emailAddr");
	String addr1 = request.getParameter("addr1");
	String addr2 = request.getParameter("addr2");
	String addr3 = request.getParameter("addr3");
	String gender = request.getParameter("gender");

	Connection conn = null;
	Statement stmt = null;
	
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/trip", "root", "1234"); //db연결
		if (conn == null) {
			throw new Exception("데이터베이스에 연결할 수 없습니다.<br>");
		}
		stmt = conn.createStatement(); //실제 쿼리문장 수행
		int row = stmt.executeUpdate("insert into user values('" + id + "', '" + pw + "', '" + name + "', '" + p1 + "-" + p2 + "-" + p3 + "', '" 
				+ addr1 + "/" + addr2 + "/" + addr3 + "', '" + email + emailAddr + "', " + ymd + ", '"
				+ gender + "', '" + nickname + "', '"+"img/profile/profile.png" +"', "+ "curdate()" +");");
		
		if (row < 1) {
			throw new Exception("데이터를 DB에 입력할 수 없습니다.");
		}
	} finally {
		try {
			stmt.close();
		} catch (Exception e) {
			out.println("stmt------------");
			e.getStackTrace();
		}
		try {
			conn.close();
		} catch (Exception e) {
			out.println("conn------------");
			e.getStackTrace();
		}
	}
	response.sendRedirect("login.jsp");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>user_info_insert_page</title>
</head>
<body>

</body>
</html>