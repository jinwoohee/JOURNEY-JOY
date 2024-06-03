package com.jj.conn;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Plan_review;

public class PlanReviewSearchDB {
	
	static PlanReviewSearchDB selectDB = new PlanReviewSearchDB();
	
	public static PlanReviewSearchDB select() {
		return selectDB;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public List<Plan_review> selectPlanReview(HashMap<String, String> map){
		
		SqlSession ss = sql.openSession();
		List<Plan_review> prList = ss.selectList("planReviewSearch", map);
		
		ss.close();
		
		return prList;
	}

}
