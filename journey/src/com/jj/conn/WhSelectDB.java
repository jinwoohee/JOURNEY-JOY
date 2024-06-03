package com.jj.conn;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Company;

public class WhSelectDB {
	static WhSelectDB whdb = new WhSelectDB();
	
	public static WhSelectDB whselectdb() {
		return whdb;
		
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public List<Company> select() {
		SqlSession ss = sql.openSession();
		List<Company> list = ss.selectList("wh_select");
		
		ss.close();
		return list;
		
	}
}
