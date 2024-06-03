package com.jj.conn;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.omg.CORBA.Request;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Estimate;

public class EstimateInsertDB {
	static EstimateInsertDB idb = new EstimateInsertDB();
	
	public static EstimateInsertDB indb() {
		return idb;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public Map<String, Object> insertMth(String u_id, String e_departure, String e_destination, String e_start_date, String e_end_date, String e_thema, String e_detail_thema, String e_volume, String e_food_taste, String e_airplane, String e_hotel) {
		Estimate dto = new Estimate();
		Map<String, Object> param = new HashMap<String, Object>();
		
		dto.setu_id(u_id);
		dto.sete_departure(e_departure);
		dto.sete_destination(e_destination);
		dto.sete_start_date(e_start_date);
		dto.sete_end_date(e_end_date);
		dto.sete_thema(e_thema);
		dto.sete_detail_thema(e_detail_thema);
		dto.sete_volume(e_volume);
		dto.sete_food_taste(e_food_taste);
		dto.sete_airplane(e_airplane);
		dto.sete_hotel(e_hotel);
	
		SqlSession sqls = sql.openSession();
			
		int i = sqls.insert("estimate_insert", dto);
		
		sqls.commit();
		sqls.close();
		param.put("e_no", dto.gete_no());
		
		return param;
	}
}
