package com.jj.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.jj.dto.Day_review;
import com.jj.dto.Place;
import com.jj.dto.Schedule;

public class Plan_review {
	Connection conn = null;
	Statement stmt = null;
	public void connDb() throws Exception{
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/trip", "root", "1234");
		if(conn == null) 
			throw new Exception("db연결실패<br>");
		stmt = conn.createStatement();
	}
	
	public void closeDb() throws Exception{
		try{
			stmt.close();
		}catch(Exception e){	
		}try{
			conn.close();			
		}catch(Exception ex){
		}		
	}	

	/* 일정리뷰 insert */
	public void insert_plan_review(String u_id, int e_no, String pr_title, String pr_contents, String pr_file, String pr_file2, String pr_file3) throws Exception{ 
		connDb();
		String command = String.format("insert into plan_review values(%s, '%s', %s, '%s', '%s', '%s', '%s', '%s', %s);", "default", u_id, e_no, pr_title, pr_contents, pr_file, pr_file2, pr_file3, "curdate()");
		int rowNum = stmt.executeUpdate(command);
		if(rowNum < 1)
		throw new Exception("데이터 입력 실패");
		
		closeDb();
	}
	
	/* insert후 pr_no select */
	public int select_pr_no() throws Exception {
		connDb();
		
		int pr_no = 0;
		ResultSet rs = stmt.executeQuery("SELECT MAX(pr_no) AS pr_no FROM plan_review;");
		
		if(rs.next()) {
			pr_no = rs.getInt("pr_no");
		}
		
		closeDb();
		return pr_no; 
	}
	
	/* 데이리뷰 insert */
	public void insert_day_review(int pr_no, int day, String dr_contents) throws Exception{ 
		connDb();
		String command = String.format("insert into day_review values(%s, %s, '%s');", pr_no, day, dr_contents);
		int rowNum = stmt.executeUpdate(command);
		if(rowNum < 1)
		throw new Exception("데이터 입력 실패");
		
		closeDb();
	}
	
	/* 일정리뷰 select */
	public ArrayList<com.jj.dto.Plan_review> select_plan_review(String num) throws Exception{
		ArrayList<com.jj.dto.Plan_review> reviewList = new ArrayList<com.jj.dto.Plan_review>();
		connDb();
		
		if(num.equals("a")) {
			ResultSet rs = stmt.executeQuery("SELECT DISTINCT p.*, u.u_nickname, u.u_profile, e.e_destination \r\n" + 
												"FROM plan_review p\r\n" + 
												"LEFT JOIN user u\r\n" + 
												"ON p.u_id = u.u_id\r\n" + 
												"LEFT JOIN estimate e\r\n" + 
												"ON p.e_no = e.e_no \r\n" +
												"ORDER BY pr_no DESC;");
			while(rs.next()) {
				com.jj.dto.Plan_review review = new com.jj.dto.Plan_review();
				review.setPr_no(rs.getInt("pr_no"));
				review.setU_id(rs.getString("u_id"));
				review.setU_nickname(rs.getString("u_nickname"));
				review.setU_profile(rs.getString("u_profile"));
				review.setE_destination(rs.getString("e_destination"));
				review.setE_no(rs.getInt("e_no"));
				review.setPr_title(rs.getString("pr_title"));
				review.setPr_contents(rs.getString("pr_contents"));
				review.setPr_file(rs.getString("pr_file1"));
				review.setPr_file2(rs.getString("pr_file2"));
				review.setPr_file3(rs.getString("pr_file3"));
				review.setPr_date(rs.getDate("pr_date"));
				
				reviewList.add(review);
			}
		}else{
			ResultSet rs = stmt.executeQuery("SELECT DISTINCT p.*, u.u_nickname, u.u_profile, e.e_destination, e_thema, e_detail_thema, d.dr_contents \r\n" + 
												"FROM plan_review p\r\n" + 
												"LEFT JOIN user u\r\n" + 
												"ON p.u_id = u.u_id\r\n" + 
												"LEFT JOIN estimate e\r\n" + 
												"ON p.e_no = e.e_no\r\n" + 
												"LEFT JOIN day_review d \r\n" + 
												"ON p.e_no = d.pr_no\r\n" + 
												"WHERE p.pr_no ="+num+" \r\n" + 
												"ORDER BY pr_no DESC");
			if(rs.next()) {
				com.jj.dto.Plan_review review = new com.jj.dto.Plan_review();
				review.setPr_no(rs.getInt("pr_no"));
				review.setU_id(rs.getString("u_id"));
				review.setU_nickname(rs.getString("u_nickname"));
				review.setU_profile(rs.getString("u_profile"));
				review.setE_destination(rs.getString("e_destination"));
				review.setE_thema(rs.getString("e_thema"));
				review.setE_detail_thema(rs.getString("e_detail_thema"));
				review.setE_no(rs.getInt("e_no"));
				review.setPr_title(rs.getString("pr_title"));
				review.setPr_contents(rs.getString("pr_contents"));
				review.setPr_file(rs.getString("pr_file1"));
				review.setPr_file2(rs.getString("pr_file2"));
				review.setPr_file3(rs.getString("pr_file3"));
				review.setPr_date(rs.getDate("pr_date"));
				
				reviewList.add(review);
			}
		}
		closeDb();
		return reviewList;
	}
	
	/*일정리뷰 수정*/
	public void update_plan_review(int pr_no, String pr_title, String pr_contents, String pr_file, String pr_file2, String pr_file3) throws Exception{
		connDb();
		String command = String.format("update plan_review set pr_title ='"+pr_title+"', pr_contents ='"+pr_contents+"', pr_file1 ='"+pr_file+"',pr_file2 ='"+pr_file2+"' ,pr_file3 ='"+pr_file3+"'  where pr_no = "+pr_no+";");
		int rowNum = stmt.executeUpdate(command);
		if(rowNum < 1)
		throw new Exception("데이터 입력 실패");
		
		closeDb();
	}
	
	
	/*데이리뷰 수정*/
	public void update_day_review(int pr_no, int dr_day, String dr_contents) throws Exception{
		connDb();
		String comm = String.format("UPDATE day_review SET dr_contents='"+dr_contents+"' WHERE pr_no="+pr_no+" and dr_day="+dr_day+";");
		
		int rowNum = stmt.executeUpdate(comm);
		if(rowNum < 1)
			throw new Exception("데이리뷰 수정 실패");
		
		closeDb();
	}
	
	
	/*일정리뷰 삭제*/
	public void delete_plan_review(int pr_no) throws Exception{
		connDb();
		String command = String.format("delete from plan_review where pr_no ="+pr_no+";");
		int rowNum = stmt.executeUpdate(command);
		if(rowNum < 1)
		throw new Exception("데이터 입력 실패");
		
		closeDb();
	}
	
	/*데이리뷰 삭제*/
	public void delete_day_review(int pr_no) throws Exception{
		connDb();
		String command = String.format("delete from day_review where pr_no ="+pr_no+";");
		int rowNum = stmt.executeUpdate(command);
		if(rowNum < 1)
		throw new Exception("데이터 입력 실패");
		
		closeDb();
	}
	
	/* 일정 select */
	public ArrayList<Schedule> select_planReview_pick(int e_no) throws Exception{
		ArrayList<Schedule> scList = new ArrayList<Schedule>();
		ResultSet rs = null;
		
		try {
			connDb();
			rs = stmt.executeQuery("SELECT * FROM schedule WHERE e_no="+e_no+";");
			
			while(rs.next()) {
				Schedule schedule = new Schedule();
				
				schedule.setE_no(rs.getInt("e_no"));
				schedule.setSche_day(rs.getInt("sche_day"));
				schedule.setPlace(rs.getString("place"));
				
				scList.add(schedule);
			}
		} finally {
			closeDb();
		}
		return scList;
	}
	
	/* 장소 이름 */
	public String selectPlaceName(String place) throws Exception{
		String plac_name = "";
		ResultSet rs = null;
		
		try {
			connDb();
			rs = stmt.executeQuery("SELECT plac_name FROM place WHERE plac_id = '"+place+"';");
		
			while(rs.next()) {
				plac_name = rs.getString("plac_name");
			}
		} finally {
			closeDb();
		}
		
		return plac_name;
		
	}
	
	/* 식당 이름 */
	public String selectEatName(String place) throws Exception{
		String eat_name = "";
		ResultSet rs = null;
		
		try {
			connDb();
			rs = stmt.executeQuery("SELECT eat_name FROM eatery WHERE eat_id ='"+place+"';");
		
			while(rs.next()) {
				eat_name = rs.getString("eat_name");
			}
		} finally {
			closeDb();
		}
		
		return eat_name;
		
	}
	
	
	
	/* 데이리뷰 select */
	public ArrayList<Day_review> select_dayReview_pick(int pr_no2) throws Exception{
		ArrayList<Day_review> drList = new ArrayList<Day_review>();
		ResultSet rs = null;
		
		try {
			connDb();
			rs = stmt.executeQuery("SELECT * FROM day_review WHERE pr_no="+pr_no2+";");
			
			while(rs.next()) {
				Day_review day = new Day_review();
				
				day.setPr_no(rs.getInt("pr_no"));
				day.setDr_day(rs.getInt("dr_day"));
				day.setDr_contents(rs.getString("dr_contents"));
				
				drList.add(day);
			}
		} finally {
			closeDb();
		}
		return drList;
	}
}

