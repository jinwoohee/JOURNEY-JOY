package com.jj.conn;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Plan;

public class PlanUpdateDB {
static PlanUpdateDB updb = new PlanUpdateDB();
	
	public static PlanUpdateDB updb() {
		return updb; 
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public int updateMth(int e_no, String plan_title, String plan_product) {
		System.out.println("업데이트 db플랜"+e_no);
		Plan dto = new Plan();
		
		dto.setE_no(e_no);
		dto.setPlan_title(plan_title);
		dto.setPlan_product(plan_product);
	
		SqlSession sqls = sql.openSession();
		
		int i = sqls.update("plan_update", dto);
		
		sqls.commit();
		sqls.close();
		
		return i;
	}
}
