package com.jj.conn;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Company;

public class WhSearchDB {
	static WhSearchDB schdb = new WhSearchDB();
	
	public static WhSearchDB whsearchdb() {
		return schdb;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public List<Company> select(HashMap<String, ArrayList<String>> map) {
		SqlSession ss = sql.openSession();
		List<Company> list = ss.selectList("wh_search", map);
		System.out.println("list갯수------>"+list.size());
		
		ss.close();
		return list;
		
	}
}
