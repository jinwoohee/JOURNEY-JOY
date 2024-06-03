package com.jj.conn;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Package_schedule;

public class PsInsertDB {
	
	static PsInsertDB sinsertDB = new PsInsertDB();
	
	public static PsInsertDB insert() {
		return sinsertDB;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public Integer insertSchedule(HashMap<String, ArrayList<Package_schedule>> psMap) {
		System.out.println("--- conn/package_schedule InsertDB ---");
		
		SqlSession ss = sql.openSession();
		int result = ss.insert("pscheduleInsert",psMap);
		
		ss.commit();
		ss.close();

		return null; 
	}
}
