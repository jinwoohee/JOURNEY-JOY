package com.jj.conn;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Schedule;

public class ScheduleUpdateDB {
static ScheduleUpdateDB sch_up = new ScheduleUpdateDB();
	
	public static ScheduleUpdateDB updatedb() {
		return sch_up;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public int updateMtd(int e_no, int sche_day, String place) {	
		Schedule dto = new Schedule();

		dto.setE_no(e_no);
		dto.setSche_day(sche_day);
		dto.setPlace(place);
		
		SqlSession sqls = sql.openSession();
		
		int i = sqls.update("schedule_update",dto);
		sqls.commit();
		sqls.close();
		return i;
	}
}
