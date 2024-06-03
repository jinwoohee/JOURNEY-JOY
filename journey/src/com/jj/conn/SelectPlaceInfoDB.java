package com.jj.conn;

import static com.jj.db.JdbcUtil.close;
import static com.jj.db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.jj.dao.JourneySql;
import com.jj.dto.Package_schedule;

public class SelectPlaceInfoDB {
	
	public List<Package_schedule> selectPlaceInfo(List<Package_schedule> psList){
		Connection con = getConnection();
		JourneySql sql = JourneySql.getInstance();
		sql.setConnection(con);
		
		String schedule = "";
		for (Package_schedule ps : psList) {
			schedule += ps.getPs_schedule() + ", ";
		}
		
		schedule = schedule.substring(0, schedule.length() - 2);
		
		ArrayList<Package_schedule> placeList = sql.mypagePsPlaceSelect(schedule);
		
		close(con);
		return placeList;
		
	}
}
