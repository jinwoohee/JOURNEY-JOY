package com.jj.conn;

import static com.jj.db.JdbcUtil.close;
import static com.jj.db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import com.jj.dao.JourneySql;
import com.jj.dto.Plan_review;

public class MypagePlanReviewSelectDB {
	
	public ArrayList<Plan_review> mypagePlanReviewSelectDB(String u_id) {
		Connection con = getConnection();
		JourneySql sql = JourneySql.getInstance();
		sql.setConnection(con);
		ArrayList<Plan_review> prList = sql.mypagePlanReviewSelect(u_id);
		
		close(con);
		return prList;
	}
}
