package com.jj.conn;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Company;

public class WhlistSelectDB {
	static WhlistSelectDB whldb = new WhlistSelectDB();
	
	public static WhlistSelectDB whlistselectdb() {
		return whldb;
		
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public Company list_select(int com_no) {
		SqlSession ss = sql.openSession();
		Company com = ss.selectOne("wh_listselect", com_no);
		
		ss.close();
		return com;
	}
}
