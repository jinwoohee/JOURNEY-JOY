package com.jj.conn;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Plan;

public class PlanDeleteDB {
	static PlanDeleteDB d_db = new PlanDeleteDB();
	
	public static PlanDeleteDB deldb() {
		return d_db; 
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public void deleteMtd(int e_no) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("e_no", e_no);

		SqlSession sqls = sql.openSession();

		sqls.delete("plan_delete", param);
		sqls.delete("schedule_delete", param);
		sqls.delete("estimate_delete", param);

		sqls.commit();
		sqls.close();
		
	}public void deletePlan(int e_no) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("e_no", e_no);

		SqlSession sqls = sql.openSession();

		sqls.delete("plan_delete", param);

		sqls.commit();
		sqls.close();
	}
}
