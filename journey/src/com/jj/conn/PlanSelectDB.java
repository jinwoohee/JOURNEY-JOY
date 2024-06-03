package com.jj.conn;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Estimate;
import com.jj.dto.Plan;

public class PlanSelectDB {
	static PlanSelectDB plan_sel = new PlanSelectDB();
	
	public static PlanSelectDB seldb() {
		return plan_sel;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public List<Plan> select_id(String u_id) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("u_id", u_id);
		
		SqlSession sqls = sql.openSession();	
		List<Plan> planList = sqls.selectList("plan_select_id",param);
		
		sqls.close();
		return planList;
	}
	public List<Plan> select_e_no(int e_no) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("e_no", e_no);
		
		SqlSession sqls = sql.openSession();	
		List<Plan> planList = sqls.selectList("plan_select_eno",param);
		
		
		sqls.close();
		return planList;
	}
}
