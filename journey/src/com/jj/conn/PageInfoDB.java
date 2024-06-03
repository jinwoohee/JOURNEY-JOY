package com.jj.conn;

import static com.jj.db.JdbcUtil.close;
import static com.jj.db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import com.jj.dao.JourneySql;
import com.jj.dto.Board;
import com.jj.dto.Class_list;

public class PageInfoDB {
	
	//테이블 별 전체 listCount
	public int getPageListCount(String table) throws Exception{
		
		int listCount = 0;
		Connection con = getConnection();
		JourneySql sql = JourneySql.getInstance();
		sql.setConnection(con);
		listCount = sql.selectListCount(table);
		close(con);
		
		return listCount;
		
	}
	
	//package
	public ArrayList<com.jj.dto.Package> getPackageList(int page, int limit) throws Exception{
		
		ArrayList<com.jj.dto.Package> packageList = null;
		Connection con = getConnection();
		JourneySql sql = JourneySql.getInstance();
		sql.setConnection(con);
		packageList = sql.selectPackageList(page, limit);
		close(con);
		
		return packageList;
	}

	//class
	public ArrayList<Class_list> getClassList(int page, int limit) throws Exception{
		
		ArrayList<Class_list> classList = null;
		Connection con = getConnection();
		JourneySql sql = JourneySql.getInstance();
		sql.setConnection(con);
		classList = sql.selectClassCount(page, limit);
		close(con);
		
		return classList;
	}
	
	
}
