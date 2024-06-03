package com.jj.conn;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Company;

public class WhClearDB {
	static WhClearDB cleardb = new WhClearDB();
	
	public static WhClearDB whcleardb() {
		return cleardb;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public List<Company> select() {
		SqlSession ss = sql.openSession();
		List<Company> list = ss.selectList("wh_select");
		
		ss.close();
		return list;
		
	}
}
