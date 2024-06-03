package com.jj.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.jj.dto.Eatery;
import com.jj.dto.Location_review;
import com.jj.dto.Place;

public class Review {
	Connection conn = null;
	Statement stmt = null;
	
	/* 생성자 */
	public Review() throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver"); //라이브러리 연결은 실행시 한번만 선언하면 되기때문에
	}
	
	/* DB연결 */
	public void dbConn() throws Exception {
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/trip?characterEncoding=utf8&useSSL=false", "root", "1234");
		if(conn == null)
			throw new Exception("DB에 연결할 수 없습니다.<br>");
		stmt = conn.createStatement();
	}
	
	/* DB닫기 */
	public void dbClose() {
		try{
			stmt.close();
		}catch(Exception ignored){
		}try{
			conn.close();
		}catch(Exception ignored){
		}
	}
	
	/* 장소리뷰 insert */
	public void insert_placeReview(String u_id, int pl_eat_no, String contents, String lr_file1, String lr_file2, String lr_file3, int lr_star) throws Exception {
		try{
			dbConn();
			
			int success = stmt.executeUpdate("insert into location_review values(default,'"+ u_id +"',"+pl_eat_no+", '"+contents+"','"+lr_file1+"','"+lr_file2+"','"+lr_file3+"', curdate(),"+lr_star+");");
			if(success != 0) {
				System.out.println("insert location_review");
			}
		}finally{
			dbClose();
		}
	}
	
	
	/* 장소리뷰 select */
	public ArrayList<Location_review> select_placeReview(int lr_no) throws Exception {
		ArrayList<Location_review> lrList = new ArrayList<Location_review>();
		ResultSet rs = null;
		
		try{
			dbConn();
			
			if(lr_no == 0) {
				rs = stmt.executeQuery("SELECT DISTINCT l.*, u.u_nickname, u.u_profile, p.plac_name AS plac_name, e.eat_name as eat_name\r\n" + 
						"FROM location_review l \r\n" + 
						"LEFT JOIN user u \r\n" + 
						"ON l.u_id = u.u_id \r\n" + 
						"LEFT JOIN place p \r\n" + 
						"ON l.pl_eat_no = p.plac_no \r\n" + 
						"LEFT JOIN eatery e \r\n" + 
						"ON l.pl_eat_no = e.eat_no ORDER BY l.lr_no;");
			}else {
				rs = stmt.executeQuery("SELECT DISTINCT l.*, u.u_nickname, u.u_profile, p.plac_name AS plac_name, e.eat_name as eat_name\r\n" + 
						"FROM location_review l \r\n" + 
						"LEFT JOIN user u \r\n" + 
						"ON l.u_id = u.u_id \r\n" + 
						"LEFT JOIN place p \r\n" + 
						"ON l.pl_eat_no = p.plac_no \r\n" + 
						"LEFT JOIN eatery e \r\n" + 
						"ON l.pl_eat_no = e.eat_no \r\n" +
						"WHERE lr_no="+ lr_no+" ORDER BY l.lr_no;");
			}
			
			
			
			while(rs.next()){
				Location_review lr = new Location_review();
				
				lr.setU_id(rs.getString("u_id"));
				lr.setU_nickname(rs.getString("u_nickname"));
				lr.setU_profile(rs.getString("u_profile"));
				lr.setLr_no(Integer.parseInt(rs.getString("lr_no")));
				lr.setPl_eat_no(Integer.parseInt(rs.getString("pl_eat_no")));
				lr.setEat_name(rs.getString("eat_name"));
				lr.setPlac_name(rs.getString("plac_name"));
				lr.setLr_contents(rs.getString("lr_contents"));
				lr.setLr_file1(rs.getString("lr_file1"));
				lr.setLr_file2(rs.getString("lr_file2"));
				lr.setLr_file3(rs.getString("lr_file3"));
				lr.setLr_date(rs.getDate("lr_date"));
				lr.setLr_star(Integer.parseInt(rs.getString("lr_star")));
				
				lrList.add(lr);
				
			}
		}finally{
			dbClose();
		}
		return lrList;
		
	}
	
	/* 장소검색 */
	public ArrayList<Place> select_place(String search) throws Exception{
		ArrayList<Place> placeList = new ArrayList<Place>();
		ResultSet rs = null;
		
		try {
			dbConn();
			
			if(search == null) {
				rs = stmt.executeQuery("SELECT plac_no, plac_name, plac_id FROM place;");
			}else {
				rs = stmt.executeQuery("SELECT DISTINCT plac_no, plac_name, plac_id \r\n" + 
						"FROM place \r\n" + 
						"WHERE plac_name like '%"+search+"%';");
			}
			
			while(rs.next()) {
				Place place = new Place();

				place.setPlac_no(rs.getInt("plac_no"));
				place.setPlac_name(rs.getString("plac_name"));
				place.setPlac_id(rs.getString("plac_id"));
				
				placeList.add(place);
			}
			
		} finally {
			dbClose();
		}
		return placeList;
		
	}
	
	public ArrayList<Eatery> select_eat(String search) throws Exception{
		ArrayList<Eatery> eatList = new ArrayList<Eatery>();
		ResultSet rs = null;
		
		try {
			dbConn();
			
			if(search == null) {
				rs = stmt.executeQuery("SELECT eat_no, eat_name, eat_id FROM eatery;");
			}else {
				rs = stmt.executeQuery("SELECT DISTINCT eat_no, eat_name, eat_id \r\n" + 
						"FROM eatery\r\n" + 
						"WHERE eat_name like '%"+search+"%';");
			}
			
			while(rs.next()) {
				Eatery eat = new Eatery();
				
				eat.setEat_no(rs.getInt("eat_no"));
				eat.setEat_name(rs.getString("eat_name"));
				eat.setEat_id(rs.getString("eat_id"));
				
				eatList.add(eat);
			}
			
		} finally {
			dbClose();
		}
		return eatList;
		
	}

	/* 장소리뷰 update */
	public void update_placeReview(String u_id, int lr_no,String contents, String lr_file1, String lr_file2, String lr_file3, int lr_star) throws Exception {
		try{
			dbConn();
			int success = stmt.executeUpdate("update location_review set lr_contents='"+ contents +"', lr_file1='"+ lr_file1+"', lr_file2='"+lr_file2+"', lr_file3='"+lr_file3+"', lr_star="+lr_star+", lr_date=curdate() where u_id='"+u_id+"' and lr_no="+lr_no+";");
			
			if(success != 0) {
				System.out.println("update location_review");
			}
		}finally{
			dbClose();
		}
	}

	
	/* 장소리뷰 delete */
	public void delete_placeReview(String u_id, int lr_no) throws Exception{
		try{
			dbConn();
			int success = stmt.executeUpdate("delete from location_review where u_id='"+u_id+"' and lr_no='"+ lr_no +"' ;");
			
			if(success != 0) {
				System.out.println("delete location_review");
			}
		}finally{
			dbClose();
		}
	}
}
