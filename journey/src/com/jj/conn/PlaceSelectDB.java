package com.jj.conn;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Eatery;
import com.jj.dto.Place;

public class PlaceSelectDB {
static PlaceSelectDB pla_sel = new PlaceSelectDB();
	
	public static PlaceSelectDB seldb() {
		return pla_sel;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public List<Place> selectMth(String e_destination, String e_thema, String d_thema, String day) {	
		SqlSession sqls = sql.openSession();	
		String thema = e_thema;
		String [] e_detail_thema = d_thema.split("_");
		int day_count = Integer.parseInt(day)*6;
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("e_destination",e_destination);
		param.put("plac_thema",thema);
		param.put("plac_detail_thema", e_detail_thema);
		param.put("day", day_count);
		System.out.println("!"+e_destination);
		List<Place> plaList = sqls.selectList("place_select",param);
		sqls.close();
		return plaList;
	}
	public List<Place> select_pl(){

		SqlSession sqls = sql.openSession();
		List<Place> plaList =sqls.selectList("place_selectAll");
		
		return plaList;
	}
	
}
