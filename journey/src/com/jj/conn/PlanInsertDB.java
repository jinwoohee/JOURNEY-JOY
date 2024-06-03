package com.jj.conn;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Estimate;
import com.jj.dto.Plan;

public class PlanInsertDB {
	static PlanInsertDB idb = new PlanInsertDB();
	
	public static PlanInsertDB indb() {
		return idb; 
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public void insertMth(int e_no, String plan_title, String plan_product) {
		Plan dto = new Plan();
		dto.setE_no(e_no);
		dto.setPlan_title(plan_title);
		dto.setPlan_product(plan_product);
		dto.setPlan_url("null");
		
		SqlSession sqls = sql.openSession();
			
		int i = sqls.insert("plan_insert", dto);
		
		sqls.commit();
		sqls.close();
		
	}
}
