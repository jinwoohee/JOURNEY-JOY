package com.jj.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.jj.dto.Departure_csv;
import com.jj.dto.Estimate;

public class IndexSql {
	Connection conn = null;
	Statement stmt = null;
	
	/* 생성자 */
	public IndexSql() throws Exception {
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
	
	//index 여행견적 요청나라 select
	public ArrayList<Estimate> selectEstimateCnt() throws Exception{
		ArrayList<Estimate> eList = new ArrayList<Estimate>();
		ResultSet rs = null;
		try {
			dbConn();
			
			rs = stmt.executeQuery("SELECT e_destination, COUNT(e_no) AS cnt FROM estimate GROUP BY e_destination ORDER BY cnt DESC;");
			
			while(rs.next()) {
				Estimate e = new Estimate();
				e = new Estimate();
				e.sete_destination(rs.getString("e_destination"));
				e.setCnt(rs.getInt("cnt"));
				
				eList.add(e);
			}
			
		} catch (Exception e2) {
			System.out.println("--- JourneySql/selectEstimateCnt ---"+e2);
		} finally {
			dbClose();
		}
		return eList;
	}
		
	//index 인기있는 여행국가 select
	public ArrayList<Departure_csv> selectDepartureSum() throws Exception{
		ArrayList<Departure_csv> dList = new ArrayList<Departure_csv>();
		ResultSet rs = null;
		try {
			dbConn();
			
			rs = stmt.executeQuery("SELECT nation, SUM(jan)+SUM(feb)+SUM(mar)+SUM(apr)+SUM(may)+SUM(jun)+SUM(jul)+SUM(aug)+SUM(sep)+SUM(oct)+SUM(nov) AS sum FROM departure_csv GROUP BY nation ORDER BY SUM DESC;");
			
			
			while(rs.next()) {
				Departure_csv dc = new Departure_csv();
				dc.setNation(rs.getString("nation"));
				dc.setSum(rs.getInt("sum"));
				
				dList.add(dc);
			}
		} catch (Exception e) {
			System.out.println("--- JourneySql/selectDepartureSum ---"+e);
		} finally {
			dbClose();
		}
		return dList;
	}
}
