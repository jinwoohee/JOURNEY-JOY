package com.jj.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.jj.dto.Board;
import com.jj.dto.PageInfo;

public class BoardDB {
	Connection conn = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	
	public BoardDB() throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");
	}
	
	public void connDB() throws Exception {
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/trip", "root", "1234"); //DB에서 값을 가져올때 인코딩
		if(conn == null)
			throw new Exception("DB에 연결할 수 없습니다.<br>");
		stmt = conn.createStatement();
	}
	
	public void closeDB() {
		try {
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//row 생성
	public void insertRow(String id, String title, String nation, String city, String month, String category, String content) throws Exception {
		connDB();
		
		int row = stmt.executeUpdate("insert into board values(default, '" + id + "', '" + category + "', '" + title + "', '" + content + "', '" + nation + "', '" + city + "', '" + month + "', '', '', '', curdate());");
		if (row > 0) {
			System.out.println("게시글 등록완료");
		}
		
		closeDB();
	}
	
	//row 선택
	public ArrayList<Board> selectRow(int no, int nowPage) throws Exception {
		connDB();
		ResultSet rs = null;
		
		ArrayList<Board> alist = new ArrayList<Board>();
		if (no < 0) { //전체리스트출력
			String sql = "select *, (select u_nickname from user where user.u_id = board.u_id) as u_nickname from board order by b_no desc limit ?,10";
			int startRow = (nowPage - 1)*10;
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Board blist = new Board();
				blist.setB_no(rs.getInt("b_no"));
				blist.setU_id(rs.getString("u_id"));
				blist.setB_category(rs.getString("b_category"));
				blist.setB_title(rs.getString("b_title"));
				blist.setB_contents(rs.getString("b_contents"));
				blist.setB_nation(rs.getString("b_nation"));
				blist.setB_city(rs.getString("b_city"));
				blist.setB_month(rs.getString("b_month"));
				blist.setB_date(rs.getDate("b_date"));
				blist.setU_nickname(rs.getString("u_nickname"));
				
				alist.add(blist);
			}
		} else { //선택된 리스트만 출력
			rs = stmt.executeQuery("select * from board where b_no = " + no + ";");
			if (rs.next()) {
				Board blist = new Board();
				blist.setB_no(rs.getInt("b_no"));
				blist.setU_id(rs.getString("u_id"));
				blist.setB_category(rs.getString("b_category"));
				blist.setB_title(rs.getString("b_title"));
				blist.setB_contents(rs.getString("b_contents"));
				blist.setB_nation(rs.getString("b_nation"));
				blist.setB_city(rs.getString("b_city"));
				blist.setB_month(rs.getString("b_month"));
				blist.setB_date(rs.getDate("b_date"));
				
				//System.out.println(rs.getString("b_title"));
				alist.add(blist);
			}
		}
		
		closeDB();
		return alist;
	}
	
	//row 삭제
	public void deleteRow(int no) throws Exception {
		connDB();
		
		int row = stmt.executeUpdate("delete from board where b_no = " + no + ";");
		if (row > 0) {
			System.out.println("게시글 삭제완료");
		}
		
		closeDB();
	}
	
	//row 업데이트
	public void updateRow(int no, String id, String title, String nation, String city, String month, String category, String content) throws Exception {
		connDB();
		
		int row = stmt.executeUpdate("update board set b_category = '" + category + "', b_title = '" + title + "', b_contents = '" +
							content + "', b_nation = '" + nation + "', b_city = '" + city + "', b_month = '" + month + "' where b_no = " + no + " and u_id = '" + id + "';");
		if (row > 0) {
			System.out.println("게시글 수정완료");
		}
		
		closeDB();
	}
	
	//board.jsp 검색창
	public ArrayList<Board> searchRow(String stxt, String nation, String city, String month, String category) throws Exception {
		connDB();
		ArrayList<Board> alist = new ArrayList<Board>();
		
		if (nation.equals("국가"))
			nation = "";
		
		if (city.equals("도시"))
			city = "";
		
		if (month.equals("여행시기"))
			month = "";
		
		if (category.equals("카테고리"))
			category = "";
		//System.out.println("java----->" + stxt + "/" + nation + "/" + city + "/" + month + "/" + category);
		
		String sql = "select *, (select u_nickname from user where user.u_id = board.u_id) as u_nickname from board where b_title like '%" + stxt + "%' and b_nation like '%" + nation + "%' and b_city like '%" + city + "%' and b_month like '%" + month + "%' and b_category like '%" + category + "%' order by b_no desc;";
		ResultSet rs = stmt.executeQuery(sql);
		
		while (rs.next()) {
			Board b = new Board();
			b.setB_no(rs.getInt("b_no"));
			b.setU_id(rs.getString("u_id"));
			b.setB_category(rs.getString("b_category"));
			b.setB_title(rs.getString("b_title"));
			b.setB_contents(rs.getString("b_contents"));
			b.setB_nation(rs.getString("b_nation"));
			b.setB_city(rs.getString("b_city"));
			b.setB_month(rs.getString("b_month"));
			b.setB_date(rs.getDate("b_date"));
			b.setU_nickname(rs.getString("u_nickname"));
			
			alist.add(b);
		}
		
		closeDB();
		return alist;
	}
	
	public com.jj.dto.PageInfo listCountSelect(int nowPage) throws Exception {
		connDB();
		
		int listCount = 0; //리스트 갯수
		int page = 1; // 현재페이지
		int limit = 10; // 한페이지 최대 row갯수
		
		if (String.valueOf(nowPage) != null) {
			page = nowPage;
		}
		
		String sql = "select count(*) from board";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next()) {
				listCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("sql listCountSelect Error-------->"+e);
		}
		
		int maxPage = (int)((double)listCount/limit+0.95); //최대페이지
		int startPage = (((int) ((double)page / 10 + 0.9)) - 1) * 10 + 1; //시작페이지
   	    int endPage = startPage+10-1; //마지막페이지
   	    
   	    if(endPage > maxPage) {
   	    	endPage = maxPage;
   	    }
   	    
   	    com.jj.dto.PageInfo pageInfo = new com.jj.dto.PageInfo();
	    pageInfo.setListCount(listCount);
	    pageInfo.setPage(page);
	    pageInfo.setMaxPage(maxPage);
	    pageInfo.setStartPage(startPage);
	    pageInfo.setEndPage(endPage);
		
		closeDB();
		return pageInfo;
	}
}
