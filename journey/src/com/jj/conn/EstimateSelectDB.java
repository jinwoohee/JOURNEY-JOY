package com.jj.conn;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Estimate;

public class EstimateSelectDB {
	static EstimateSelectDB esti_sel = new EstimateSelectDB();
	
	public static EstimateSelectDB seldb() {
		return esti_sel;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public List<Estimate> selectMth(String u_id) {	
		SqlSession sqls = sql.openSession();	
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("u_id", u_id);
		List<Estimate> estiList = sqls.selectList("estimate_select",param);

		sqls.close();
		return estiList;
	}
	public List<Estimate> selmtd(int e_no) {	
		SqlSession sqls = sql.openSession();
		
		List<Estimate> estiList = sqls.selectList("estimate_selectone",e_no);
		
		sqls.close();
		return estiList;
	}
}
