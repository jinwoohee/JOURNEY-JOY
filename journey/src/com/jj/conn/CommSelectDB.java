package com.jj.conn;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Community;

public class CommSelectDB {
	
	static CommSelectDB selectDB = new CommSelectDB();
	
	public static CommSelectDB select() {
		return selectDB;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public List<Community> selectComm(int p_no){
		
		System.out.println("--- conn/commSelectDB ---");
		
		SqlSession ss = sql.openSession();
		List<Community> comm = ss.selectList("commSelect", p_no);
		ss.close();
		
		return comm;
	}

}
