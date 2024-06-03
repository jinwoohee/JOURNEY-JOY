package com.jj.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import com.jj.dto.Board;
import com.jj.dto.Class_list;
import com.jj.dto.Estimate;
import com.jj.dto.Inquiry;
import com.jj.dto.Location_review;
import com.jj.dto.Place;
import com.jj.dto.Plan_review;
import com.jj.dto.Purchase;
import com.jj.dto.User;

import com.jj.dto.Package;
import com.jj.dto.Package_like;
import com.jj.dto.Package_schedule;

import static com.jj.db.JdbcUtil.*;

public class JourneySql { 
	
	DataSource ds;
	Connection con;
	private static JourneySql journeySql;
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	private JourneySql() {}
	
	public static JourneySql getInstance() {
		if(journeySql == null) {
			journeySql = new JourneySql();
		}
		return journeySql;
	}
	
	public void setConnection(Connection con) {
		this.con = con;
	}
	
	//우희 부분
	public ArrayList<Inquiry> inquirySelect(String u_id) { //문의하기 select
		String sql = "select * from inquiry where p_uid = '"+u_id+"' order by i_no desc";
		ArrayList<Inquiry> alist = new ArrayList<Inquiry>();
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Inquiry iq = new Inquiry();
				iq.setI_no(rs.getInt("i_no"));
				iq.setP_no(rs.getInt("p_no"));
				iq.setP_uid(rs.getString("p_uid"));
				iq.setP_title(rs.getString("p_title"));
				iq.setU_id(rs.getString("u_id"));
				iq.setI_contents(rs.getString("i_contents"));
				iq.setI_date(rs.getDate("i_date"));
				iq.setI_flag(rs.getInt("i_flag"));
				
				alist.add(iq);
				//System.out.println(iq.getP_no());
			}
		} catch (SQLException e) {
			System.out.println("inquirySelect 에러------->"+e);
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return alist;
	}
	
	public int inquiryUpdateFlag(String u_id) { //문의하기 구분자 update
		String sql = "update inquiry set i_flag = 1 where p_uid = '"+u_id+"'";
		int row = 0;
		
		try {
			pstmt = con.prepareStatement(sql);
			row = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("sql inquiryUpdateFlag 에러-------->"+e);
		} finally {
			close(pstmt);
		}
		
		//System.out.println("inquiryUpdateFlag------>"+row);
		return row;
	}
	
	public ArrayList<Package> mypagePackageSelect(String u_id) { //패키지 기획내역(패키지 상세내용 select)
		String sql = "select * from package where u_id = '" + u_id + "' order by p_no desc";
		ArrayList<Package> alist = new ArrayList<Package>();
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Package pk = new Package();
				pk.setP_no(rs.getInt("p_no"));
				pk.setU_id(rs.getString("u_id"));
				pk.setP_nation(rs.getString("p_nation")); 
				pk.setP_city(rs.getString("p_city"));
				pk.setP_theme(rs.getString("p_theme"));
				pk.setP_title(rs.getString("p_title"));
				pk.setP_start_date(rs.getString("p_start_date"));
				pk.setP_end_date(rs.getString("p_end_date"));
				pk.setP_volume(rs.getInt("p_volume"));
				pk.setP_due_date(rs.getString("p_due_date"));
				pk.setP_guide_pay(rs.getInt("p_guide_pay"));
				pk.setP_date(rs.getString("p_date"));
				pk.setP_file(rs.getString("p_file"));
				pk.setP_notification(rs.getString("p_notification"));
				pk.setP_url(rs.getString("p_url"));
				
				alist.add(pk);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("sql mypagePackageSelect 에러----->"+e);
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return alist;
	}
	
	public ArrayList<Package_schedule> mypagePackageScheSelect(String p_no) { //패키지 일정 select
		String sql = "select * from package_schedule where p_no = " + p_no;
		ArrayList<Package_schedule> alist = new ArrayList<Package_schedule>();
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Package_schedule ps = new Package_schedule();
				ps.setP_no(rs.getInt("p_no"));
				ps.setPs_schedule(rs.getString("ps_schedule"));
				ps.setPs_day(rs.getString("ps_day"));
				ps.setPs_title(rs.getString("ps_title"));
				ps.setPs_contents(rs.getString("ps_contents"));
				ps.setPs_notification(rs.getString("ps_notification"));
				
				alist.add(ps);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("sql mypagePackageScheSelect 에러----->"+e);
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return alist;
	}
	
	public ArrayList<Package> mypageRewardSelect(String p_no) { //패키지 리워드 select
		String sql = "select * from reward where p_no = " + p_no;
		ArrayList<Package> alist = new ArrayList<Package>();
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				Package pk = new Package();
				pk.setP_no(rs.getInt("p_no"));
				pk.setAdult_fee(rs.getInt("adult_fee"));
				pk.setStd_fee(rs.getInt("std_fee"));
				pk.setChild_fee(rs.getInt("child_fee"));
				
				alist.add(pk);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("sql mypageRewardSelect 에러----->"+e);
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return alist;
	}
	
	public ArrayList<Package_schedule> mypagePsPlaceSelect(String schedule) { //패키지 장소 select
		String sql = "select * from place where plac_no in (" + schedule + ")";
		ArrayList<Package_schedule> alist = new ArrayList<Package_schedule>();
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Package_schedule ps = new Package_schedule();
				ps.setPlac_no(rs.getInt("plac_no"));
				ps.setPlac_name(rs.getString("plac_name"));
				ps.setPlac_addr(rs.getString("plac_addr"));
				ps.setPlac_explan(rs.getString("plac_explan"));
				ps.setPlac_file1(rs.getString("plac_file1"));
				
				alist.add(ps);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return alist;
	}
	
	public ArrayList<Purchase> mypagePurchaseSelect(String u_id) { //패키지 참여내역 select
		String sql = "select * from purchase where u_id = '" + u_id + "' order by p_no desc";
		ArrayList<Purchase> alist = new ArrayList<Purchase>();
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Purchase pc = new Purchase();
				pc.setU_id(rs.getString("u_id"));
				pc.setP_no(rs.getInt("p_no"));
				
				alist.add(pc);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return alist;
	}
	
	public ArrayList<Package> mypagePackageSelect2(String p_no) { //패키지 참여내역(패키지 상세내용 select)
		String sql = "select * from package where p_no = " + p_no;
		ArrayList<Package> alist = new ArrayList<Package>();
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Package pk = new Package();
				pk.setP_no(rs.getInt("p_no"));
				pk.setU_id(rs.getString("u_id"));
				pk.setP_nation(rs.getString("p_nation"));
				pk.setP_city(rs.getString("p_city"));
				pk.setP_theme(rs.getString("p_theme"));
				pk.setP_title(rs.getString("p_title"));
				pk.setP_start_date(rs.getString("p_start_date"));
				pk.setP_end_date(rs.getString("p_end_date"));
				pk.setP_volume(rs.getInt("p_volume"));
				pk.setP_due_date(rs.getString("p_due_date"));
				pk.setP_guide_pay(rs.getInt("p_guide_pay"));
				pk.setP_date(rs.getString("p_date"));
				pk.setP_file(rs.getString("p_file"));
				pk.setP_notification(rs.getString("p_notification"));
				pk.setP_url(rs.getString("p_url"));
				
				alist.add(pk);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("sql mypagePackageSelect2 에러----->"+e);
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return alist;
	}
	
	public ArrayList<Package_like> mypageLikeSelect(String u_id) { //찜한 패키지 select
		String sql = "select * from package_like where u_id = '" + u_id + "' order by p_no desc";
		ArrayList<Package_like> alist = new ArrayList<Package_like>();
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Package_like pl = new Package_like();
				pl.setU_id(rs.getString("u_id"));
				pl.setP_no(rs.getInt("p_no"));
				
				alist.add(pl);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return alist;
	}
	
	public ArrayList<User> mypageUserInfoSelect(String u_id) { //user 정보 select
		String sql = "select * from user where u_id = '" + u_id + "'";
		ArrayList<User> alist = new ArrayList<User>();
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				User u = new User();
				u.setU_id(rs.getString("u_id"));
				u.setU_name(rs.getString("u_name"));
				u.setU_phone(rs.getString("u_phone"));
				u.setU_addr(rs.getString("u_addr"));
				u.setU_email(rs.getString("u_email"));
				u.setU_birth(rs.getDate("u_birth"));
				u.setU_gender(rs.getString("u_gender"));
				u.setU_nickname(rs.getString("u_nickname"));
				u.setU_profile(rs.getString("u_profile"));
				
				alist.add(u);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return alist;
	}
	
	public ArrayList<Plan_review> mypagePlanReviewSelect(String u_id) { //일정리뷰 select
		String sql = "select * from plan_review where u_id = '" + u_id + "' order by pr_no desc";
		ArrayList<Plan_review> alist = new ArrayList<Plan_review>();
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Plan_review pr = new Plan_review();
				pr.setPr_no(rs.getInt("pr_no"));
				pr.setU_id(rs.getString("u_id"));
				pr.setE_no(rs.getInt("e_no"));
				pr.setPr_title(rs.getString("pr_title"));
				pr.setPr_contents(rs.getString("pr_contents"));
				pr.setPr_file(rs.getString("pr_file1"));
				pr.setPr_file2(rs.getString("pr_file2"));
				pr.setPr_file3(rs.getString("pr_file3"));
				pr.setPr_date(rs.getDate("pr_date"));
				
				alist.add(pr);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return alist;
	}
	
	public ArrayList<Location_review> mypagePlaceReviewSelect(String u_id) { //장소리뷰 select
		String sql = "select * from location_review where u_id = '" + u_id + "' order by lr_no desc";
		ArrayList<Location_review> alist = new ArrayList<Location_review>();
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Location_review lr = new Location_review();
				lr.setLr_no(rs.getInt("lr_no"));
				lr.setU_id(rs.getString("u_id"));
				lr.setPl_eat_no(rs.getInt("pl_eat_no"));
				lr.setLr_contents(rs.getString("lr_contents"));
				lr.setLr_file1(rs.getString("lr_file1"));
				lr.setLr_file2(rs.getString("lr_file2"));
				lr.setLr_file3(rs.getString("lr_file3"));
				lr.setLr_date(rs.getDate("lr_date"));
				lr.setLr_star(rs.getInt("lr_star"));
				
				alist.add(lr);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return alist;
	}
	
	public ArrayList<Place> mypagePlaceSelect(String pl_eat_no) { //장소리뷰-장소 select
		String sql = "select * from place where plac_no = " + pl_eat_no;
		ArrayList<Place> alist = new ArrayList<Place>();
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Place p = new Place();
				p.setPlac_no(rs.getInt("plac_no"));
				p.setPlac_name(rs.getString("plac_name"));
				
				alist.add(p);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return alist;
	}
	
	public ArrayList<Board> boardListSelect(int page, int limit) { //자유게시판 select
		ArrayList<Board> alist = new ArrayList<Board>();
		
		String sql = "select * from board order by b_no desc limit ?,10";
		int startRow = (page - 1)*10;
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Board board = new Board();
				board.setB_no(rs.getInt("b_no"));
				board.setU_id(rs.getString("u_id"));
				board.setB_category(rs.getString("b_category"));
				board.setB_title(rs.getString("b_title"));
				board.setB_contents(rs.getString("b_contents"));
				board.setB_nation(rs.getString("b_nation"));
				board.setB_city(rs.getString("b_city"));
				board.setB_month(rs.getString("b_month"));
				board.setB_file1(rs.getString("b_file1"));
				board.setB_file2(rs.getString("b_file2"));
				board.setB_file3(rs.getString("b_file3"));
				board.setB_date(rs.getDate("b_date"));
				
				alist.add(board);
			}
		} catch (SQLException e) {
			System.out.println("sql boardListSelect Error-------->"+e);
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return alist;
	}
	
	
	
	
	
	

	//윤영 부분
	/* 모임 insert */
	public int insertClass(Class_list cl) {
		String sql = "";
		int insertCount=0;
		
		try {
			sql = "insert into class_list VALUES(default, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cl.getU_id());
			pstmt.setString(2, cl.getC_nation());
			pstmt.setString(3, cl.getC_city());
			pstmt.setString(4, cl.getC_title());
			pstmt.setString(5, cl.getC_contents());
			pstmt.setString(6, cl.getC_file1());
			pstmt.setString(7, cl.getC_file2());
			pstmt.setString(8, cl.getC_file3());
			pstmt.setInt(9, cl.getC_volume());
			pstmt.setInt(10, cl.getC_charge());
			pstmt.setString(11, cl.getC_end_date());
			pstmt.setString(12, cl.getC_url());
			
			insertCount = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("---JourneySql/insertClass---" + e);
		}finally {
			close(pstmt);
		}
		
		return insertCount;
		
	}

	/* 모임 select */
	public ArrayList<Class_list> selectClassList() {
		String sql = "SELECT DISTINCT c.*, u.u_profile, u.u_nickname AS u_nickname, a.u_id AS a_id, a.c_no AS a_no, (SELECT COUNT(*) FROM class_apply a WHERE c.c_no=a.c_no GROUP BY c_no) AS count \r\n" + 
						"FROM class_list c\r\n" + 
						"LEFT JOIN user u\r\n" + 
						"ON c.u_id = u.u_id \r\n" + 
						"LEFT JOIN class_apply a\r\n" + 
						"ON c.c_no = a.c_no \r\n" +
						"order by c.c_no limit 10";
		ArrayList<Class_list> classList = new ArrayList<Class_list>();
		Class_list cl = null;
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				cl = new Class_list();
				cl.setC_no(rs.getInt("c_no"));
				cl.setU_id(rs.getString("u_id"));
				cl.setU_profile(rs.getString("u_profile"));
				cl.setC_nation(rs.getString("c_nation"));
				cl.setC_city(rs.getString("c_city"));
				cl.setC_title(rs.getString("c_title"));
				cl.setC_contents(rs.getString("c_contents"));
				cl.setC_file1(rs.getString("c_file1"));
				cl.setC_file2(rs.getString("c_file2"));
				cl.setC_file3(rs.getString("c_file3"));
				cl.setC_volume(rs.getInt("c_volume"));
				cl.setC_charge(rs.getInt("c_charge"));
				cl.setC_end_date(rs.getString("c_end_date"));
				cl.setC_date(rs.getString("c_date"));
				cl.setC_url(rs.getString("c_url"));
				cl.setU_nickname(rs.getString("u_nickname"));
				cl.setA_id(rs.getString("a_id"));
				cl.setA_no(rs.getInt("a_no"));
				cl.setCount(rs.getInt("count"));
				
				classList.add(cl);
			}
		} catch (Exception e) {
			System.out.println("--- JourneySql/selectClassList---");
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return classList;
	}

	/* 모임 탭 select */
	public ArrayList<Class_list> selectTabClass(String tab, String u_id) {
		
		String sql = null;
		
		if(tab.equals("made")) {
			sql = "SELECT c.*, u.u_profile, u.u_nickname AS u_nickname, a.u_id AS a_id, a.c_no AS a_no, (SELECT COUNT(*) FROM class_apply a WHERE c.c_no=a.c_no GROUP BY c_no) AS count \r\n" + 
					"FROM class_list c \r\n" + 
					"LEFT JOIN user u \r\n" + 
					"ON c.u_id = u.u_id \r\n" + 
					"LEFT JOIN class_apply a \r\n" + 
					"ON c.c_no = a.c_no \r\n" + 
					"WHERE c.u_id ='"+u_id+"' \r\n" + 
					"order by c.c_no limit 10";
		}else {
			sql = "SELECT c.*, u.u_profile, u.u_nickname AS u_nickname, a.u_id AS a_id, a.c_no AS a_no, (SELECT COUNT(*) FROM class_apply a WHERE c.c_no=a.c_no GROUP BY c_no) AS count \r\n" + 
					"FROM class_list c \r\n" + 
					"LEFT JOIN user u \r\n" + 
					"ON c.u_id = u.u_id \r\n" + 
					"LEFT JOIN class_apply a \r\n" + 
					"ON c.c_no = a.c_no \r\n" + 
					"WHERE a.u_id = '"+u_id+"' \r\n" + 
					"order by c.c_no limit 10";
		}
		
		ArrayList<Class_list> classList = new ArrayList<Class_list>();
		Class_list cl = null;
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				cl = new Class_list();
				cl.setC_no(rs.getInt("c_no"));
				cl.setU_id(rs.getString("u_id"));
				cl.setU_profile(rs.getString("u_profile"));
				cl.setC_nation(rs.getString("c_nation"));
				cl.setC_city(rs.getString("c_city"));
				cl.setC_title(rs.getString("c_title"));
				cl.setC_contents(rs.getString("c_contents"));
				cl.setC_file1(rs.getString("c_file1"));
				cl.setC_file2(rs.getString("c_file2"));
				cl.setC_file3(rs.getString("c_file3"));
				cl.setC_volume(rs.getInt("c_volume"));
				cl.setC_charge(rs.getInt("c_charge"));
				cl.setC_end_date(rs.getString("c_end_date"));
				cl.setC_date(rs.getString("c_date"));
				cl.setC_url(rs.getString("c_url"));
				cl.setU_nickname(rs.getString("u_nickname"));
				cl.setA_id(rs.getString("a_id"));
				cl.setA_no(rs.getInt("a_no"));
				cl.setCount(rs.getInt("count"));
				
				classList.add(cl);
			}
		} catch (Exception e) {
			System.out.println("--- JourneySql/selectClassTabList---");
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return classList;
	}

	/* 모임 참여하기 */
	public int insertClassApply(int c_no, String u_id) {
		String sql = "";
		int insertCount = 0;
		
		try {
			sql = "INSERT INTO class_apply VALUES(default, ?, ?, now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, c_no);
			pstmt.setString(2, u_id);
			
			insertCount = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("--- JourneySql/insertClassApply ---" + e);
		} finally {
			close(pstmt);
		}
		
		return insertCount;
	}

	/* 모임 참여취소 */
	public int deleteClassApply(int c_no) {
		String sql = "";
		int deleteCount = 0;
		
		try {
			sql = "DELETE FROM class_apply WHERE c_no ="+ c_no;
			pstmt = con.prepareStatement(sql);
			
			deleteCount = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("--- JourneySql/deleteClassApply ---" + e);
		} finally {
			close(pstmt);
		}
		
		return deleteCount;
	}

	/* 모임 검색 */
	public ArrayList<Class_list> selectSearchClass(String param, String search, String city) {
		String sql = null;
		String condition = null;
		
		sql = "SELECT c.*, u.u_profile, u.u_nickname AS u_nickname, a.u_id AS a_id, a.c_no AS a_no, (SELECT COUNT(*) FROM class_apply a WHERE c.c_no=a.c_no GROUP BY c_no) AS count \r\n" + 
				"FROM class_list c \r\n" + 
				"LEFT JOIN user u \r\n" + 
				"ON c.u_id = u.u_id \r\n" + 
				"LEFT JOIN class_apply a \r\n" + 
				"ON c.c_no = a.c_no \r\n ";
		
		if(!city.equals("여행중인 도시")) { //여행국가 선택 ㅒ
			if(param == null && search == null) {//검색필터, 검색창 X
				condition = "WHERE c.c_city = '"+city+"' limit 10";
			}else if(param != null && search == null) {//검색필터 O, 검색창 X
				if(param.equals("entire")) {
					condition = "ORDER BY c.c_no limit 10";
				}else if(param.equals("recent")) {
					condition = "WHERE c.c_city = '"+city+"'and c.c_end_date >= DATE_FORMAT(now(), '%Y-%m-%d') ORDER BY c.c_no limit 10";
				}else if(param.equals("closing")) {
					condition = "WHERE c.c_city = '"+city+"'and c.c_end_date >= DATE_FORMAT(now(), '%Y-%m-%d') ORDER BY c.c_end_date limit 10";
				}else if(param.equals("ing")) {
					condition = "WHERE c.c_city = '"+city+"'and c.c_end_date > DATE_FORMAT(now(), '%Y-%m-%d') ORDER BY c.c_no limit 10";
				}else if(param.equals("end")){
					condition = "WHERE c.c_city = '"+city+"'and c.c_end_date < DATE_FORMAT(now(), '%Y-%m-%d') - INTERVAL 1 DAY ORDER BY c.c_no limit 10";
				}
			}else if(param != null && search != null) { //검색필터 O, 검색창 O
				if(param.equals("entire")) {
					condition = "ORDER BY c.c_no limit 10";
				}else if(param.equals("recent")) {
					condition = "WHERE c.c_city = '"+city+"'and c.c_title LIKE '%"+search+"%' and c.c_end_date >= DATE_FORMAT(now(), '%Y-%m-%d') ORDER BY c.c_no limit 10";
				}else if(param.equals("closing")) {
					condition = "WHERE c.c_city = '"+city+"'and c.c_title LIKE '%"+search+"%' and c.c_end_date >= DATE_FORMAT(now(), '%Y-%m-%d') ORDER BY c.c_end_date limit 10";
				}else if(param.equals("ing")) {
					condition = "WHERE c.c_city = '"+city+"'and c.c_title LIKE '%"+search+"%' and c.c_end_date > DATE_FORMAT(now(), '%Y-%m-%d') ORDER BY c.c_no limit 10";
				}else if(param.equals("end")){
					condition = "WHERE c.c_city = '"+city+"'and c.c_title LIKE '%"+search+"%'and c.c_end_date < DATE_FORMAT(now(), '%Y-%m-%d') - INTERVAL 1 DAY ORDER BY c.c_no limit 10";
				}
			}else if(param == null && search != null) { //검색필터 X, 검색창 O
				condition = "WHERE c.c_city = '"+city+"'and c.c_title LIKE %"+search+"%' ORDER BY c.c_no limit 10";
			}
		}else if(city.equals("여행중인 도시")){ //여행국가 선택 X
			if(search  == null) { //검색창 값 없을때
				if(param.equals("entire")) {
					condition = "ORDER BY c.c_no limit 10";
				}else if(param.equals("recent")) {
					condition = "WHERE c.c_end_date >= DATE_FORMAT(now(), '%Y-%m-%d') ORDER BY c.c_no limit 10";
				}else if(param.equals("closing")) {
					condition = "WHERE c.c_end_date >= DATE_FORMAT(now(), '%Y-%m-%d') ORDER BY c.c_end_date limit 10";
				}else if(param.equals("ing")) {
					condition = "WHERE c.c_end_date > DATE_FORMAT(now(), '%Y-%m-%d') ORDER BY c.c_no limit 10";
				}else if(param.equals("end")){
					condition = "WHERE c.c_end_date < DATE_FORMAT(now(), '%Y-%m-%d') - INTERVAL 1 DAY ORDER BY c.c_no limit 10";
				}
			}else { //검색창 값 있을때 
				if(param.equals("entire")) {
					condition = "ORDER BY c.c_no limit 10";
				}else if(param.equals("recent")) {
					condition = "WHERE c.c_title LIKE '%"+search+"%' and c.c_end_date >= DATE_FORMAT(now(), '%Y-%m-%d') ORDER BY c.c_no limit 10";
				}else if(param.equals("closing")) {
					condition = "WHERE c.c_title LIKE '%"+search+"%' and c.c_end_date >= DATE_FORMAT(now(), '%Y-%m-%d') ORDER BY c.c_end_date limit 10";
				}else if(param.equals("ing")) {
					condition = "WHERE c.c_title LIKE '%"+search+"%' and c.c_end_date > DATE_FORMAT(now(), '%Y-%m-%d') ORDER BY c.c_no limit 10";
				}else if(param.equals("end")){
					condition = "WHERE c.c_title LIKE '%"+search+"%'and c.c_end_date < DATE_FORMAT(now(), '%Y-%m-%d') - INTERVAL 1 DAY ORDER BY c.c_no limit 10";
				}
			}
		}

		ArrayList<Class_list> classList = new ArrayList<Class_list>();
		Class_list cl = null;
		
		try { 
			pstmt = con.prepareStatement(sql+condition);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				cl = new Class_list();
				cl.setC_no(rs.getInt("c_no"));
				cl.setU_id(rs.getString("u_id"));
				cl.setU_profile(rs.getString("u_profile"));
				cl.setC_nation(rs.getString("c_nation"));
				cl.setC_city(rs.getString("c_city"));
				cl.setC_title(rs.getString("c_title"));
				cl.setC_contents(rs.getString("c_contents"));
				cl.setC_file1(rs.getString("c_file1"));
				cl.setC_file2(rs.getString("c_file2"));
				cl.setC_file3(rs.getString("c_file3"));
				cl.setC_volume(rs.getInt("c_volume"));
				cl.setC_charge(rs.getInt("c_charge"));
				cl.setC_end_date(rs.getString("c_end_date"));
				cl.setC_date(rs.getString("c_date"));
				cl.setC_url(rs.getString("c_url"));
				cl.setU_nickname(rs.getString("u_nickname"));
				cl.setA_id(rs.getString("a_id"));
				cl.setA_no(rs.getInt("a_no"));
				cl.setCount(rs.getInt("count"));
				
				classList.add(cl);
			}
		} catch (Exception e) {
			System.out.println("--- JourneySql/selectClassTabList---");
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return classList;
	}

	/* 여행계획서 select */
	public ArrayList<Estimate> selectEstimateList(String u_id) {
		String sql = null;
		
		sql = "SELECT DISTINCT p.e_no, e.e_destination, e.e_start_date, e.e_end_date\r\n" + 
				"FROM plan p\r\n" + 
				"LEFT JOIN estimate e\r\n" + 
				"ON p.e_no = e.e_no\r\n" + 
				"WHERE u_id = '"+u_id+"' and now() between e.e_start_date and e.e_end_date";
		
		ArrayList<Estimate> estimateList = new ArrayList<Estimate>();
		Estimate e = null;

		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				e = new Estimate();
				e.sete_no(rs.getInt("e_no"));
				e.sete_destination(rs.getString("e_destination"));
				e.sete_start_date(rs.getString("e_start_date"));
				e.sete_end_date(rs.getString("e_end_date"));
				
				estimateList.add(e);
			}
		} catch (Exception e2) {
			System.out.println("--- JourneySql/selectEstimate ---");
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return estimateList;
	}
	
	public ArrayList<Estimate> selectPlanList(String u_id) {
		String sql = null;
	
		sql = 	" SELECT * FROM estimate WHERE u_id ='"+u_id+"'";
		
		ArrayList<Estimate> estiList = new ArrayList<Estimate>();
		Estimate e = null;

		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				e = new Estimate();
				e.sete_no(rs.getInt("e_no"));
				e.sete_destination(rs.getString("e_destination"));
				e.sete_start_date(rs.getString("e_start_date"));
				e.sete_end_date(rs.getString("e_end_date"));
				e.sete_thema(rs.getString("e_thema"));
				e.sete_detail_thema(rs.getString("e_detail_thema"));
				e.sete_volume(rs.getString("e_volume"));
				e.sete_food_taste(rs.getString("e_food_taste"));
					
				estiList.add(e);
			}
		} catch (Exception e2) {
			System.out.println("--- JourneySql/selectEstimate ---"+e2);
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return estiList;
	}
	
	//pageInfo
	public int selectListCount(String table) {
		int listCount = 0;
		
		String sql = null;
		sql = "SELECT COUNT(*) FROM "+table;
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
		} catch (Exception e) {
			close(rs);
			close(pstmt);
		}
		return listCount;
	}

	//package 페이징 리스트
	public ArrayList<Package> selectPackageList(int page, int limit) {
		
		ArrayList<Package> packageList = new ArrayList<Package>();
		
		String sql = null;
		sql = "SELECT DISTINCT p.p_no, p.p_file, p.p_nation, p.p_city, p.p_title, u.u_nickname, r.child_fee\r\n" + 
				"FROM package p\r\n" + 
				"LEFT JOIN user u\r\n" + 
				"ON p.u_id = u.u_id\r\n" + 
				"LEFT JOIN reward r\r\n" + 
				"ON p.p_no = r.p_no\r\n" + 
				"ORDER BY p.p_no DESC limit ?,8";
		int startRow = (page-1)*8;
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,  startRow);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Package p = new Package();
				p.setP_no(rs.getInt("p_no"));
				p.setP_file(rs.getString("p_file"));
				p.setP_nation(rs.getString("p_nation"));
				p.setP_city(rs.getString("p_city"));
				p.setP_title(rs.getString("p_title"));
				p.setU_nickname(rs.getString("u_nickname"));
				p.setChild_fee(rs.getInt("child_fee"));
				
				packageList.add(p);
				
			}
		} catch (Exception e) {
			close(rs);
			close(pstmt);
		}
		
		return packageList;
	}

	//class 페이징 리스트
	public ArrayList<Class_list> selectClassCount(int page, int limit) {
		
		String sql = "SELECT DISTINCT c.*, u.u_profile, u.u_nickname AS u_nickname, a.u_id AS a_id, a.c_no AS a_no, (SELECT COUNT(*) FROM class_apply a WHERE c.c_no=a.c_no GROUP BY c_no) AS count \r\n" + 
				"FROM class_list c\r\n" + 
				"LEFT JOIN user u\r\n" + 
				"ON c.u_id = u.u_id \r\n" + 
				"LEFT JOIN class_apply a\r\n" + 
				"ON c.c_no = a.c_no \r\n" +
				"order by c.c_no limit ?,10";
		
		ArrayList<Class_list> classList = new ArrayList<Class_list>();
		Class_list cl = null;
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				cl = new Class_list();
				cl.setC_no(rs.getInt("c_no"));
				cl.setU_id(rs.getString("u_id"));
				cl.setU_profile(rs.getString("u_profile"));
				cl.setC_nation(rs.getString("c_nation"));
				cl.setC_city(rs.getString("c_city"));
				cl.setC_title(rs.getString("c_title"));
				cl.setC_contents(rs.getString("c_contents"));
				cl.setC_file1(rs.getString("c_file1"));
				cl.setC_file2(rs.getString("c_file2"));
				cl.setC_file3(rs.getString("c_file3"));
				cl.setC_volume(rs.getInt("c_volume"));
				cl.setC_charge(rs.getInt("c_charge"));
				cl.setC_end_date(rs.getString("c_end_date"));
				cl.setC_date(rs.getString("c_date"));
				cl.setC_url(rs.getString("c_url"));
				cl.setU_nickname(rs.getString("u_nickname"));
				cl.setA_id(rs.getString("a_id"));
				cl.setA_no(rs.getInt("a_no"));
				cl.setCount(rs.getInt("count"));
				
				classList.add(cl);
			}
		} catch (Exception e) {
			System.out.println("--- JourneySql/selectClassList---");
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return classList;
	}

}
