package com.jj.conn;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Location_review;

public class PlaceReviewSearchDB {
	
	static PlaceReviewSearchDB selectDB = new PlaceReviewSearchDB();
	
	public static PlaceReviewSearchDB select(){
		return selectDB;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public List<Location_review> selectPlaceReview(HashMap<String, String> map){
		
		SqlSession ss = sql.openSession();
		List<Location_review> lrList = ss.selectList("placeReviewSearch", map);
		
		ss.close();
		
		return lrList;
	}
}
