package com.jj.conn;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Community;

public class CommInsertDB {
	
	static CommInsertDB insertDB = new CommInsertDB();
	
	public static CommInsertDB insert() {
		return insertDB;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public void isnertComm(Community comm) {
		
		System.out.println("--- conn/commInsertDB ---");
		SqlSession ss = sql.openSession();
		int result = ss.insert("commInsert", comm);
		
		ss.commit();
		ss.close();
	}

}
