package com.jj.conn;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Package_schedule;

public class PsSelectDB {
	
	static PsSelectDB selectDB = new PsSelectDB();
	
	public static PsSelectDB select() {
		return selectDB;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public List<Package_schedule> selectPackageSc(int p_no){
		
		System.out.println("--- conn/packageScheduleSelectDB ---");
		
		SqlSession ss = sql.openSession();
		List<Package_schedule> ps = ss.selectList("packageScheduleSelect", p_no);
		ss.close();
		
		return ps;
	}

}
