package com.jj.conn;

import static com.jj.db.JdbcUtil.close;
import static com.jj.db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import com.jj.dao.JourneySql;
import com.jj.dto.Location_review;

public class MypagePlaceReviewSelectDB {
	
	public ArrayList<Location_review> mypagePlaceReviewSelectDB(String u_id) {
		Connection con = getConnection();
		JourneySql sql = JourneySql.getInstance();
		sql.setConnection(con);
		ArrayList<Location_review> lrList = sql.mypagePlaceReviewSelect(u_id);
		
		close(con);
		return lrList;
	}
}
