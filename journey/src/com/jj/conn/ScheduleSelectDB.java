package com.jj.conn;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Schedule;

public class ScheduleSelectDB {
static ScheduleSelectDB sche_sel = new ScheduleSelectDB();
	
	public static ScheduleSelectDB seldb() {
		return sche_sel;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public List<Schedule> selmtd(int e_no) {	
		SqlSession sqls = sql.openSession();	
		
		List<Schedule> scheList = sqls.selectList("schedule_select",e_no);
		sqls.close();
		return scheList;
	}
}
