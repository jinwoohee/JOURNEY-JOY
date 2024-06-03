package com.jj.conn;

import static com.jj.db.JdbcUtil.close;
import static com.jj.db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.jj.dao.JourneySql;
import com.jj.dto.Estimate;


public class Plan_reviewTapSelectDB {
	public ArrayList<Estimate> selectPlan(String u_id) {
		
		ArrayList<Estimate> estiList = null;
		Connection con = getConnection();
		JourneySql sql = JourneySql.getInstance();
		sql.setConnection(con);
		estiList = sql.selectPlanList(u_id);
		close(con);
		
		return estiList;
	}
}
