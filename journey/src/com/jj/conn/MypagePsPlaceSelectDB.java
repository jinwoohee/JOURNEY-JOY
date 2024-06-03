package com.jj.conn;

import static com.jj.db.JdbcUtil.close;
import static com.jj.db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import com.jj.dao.JourneySql;
import com.jj.dto.Package_schedule;

public class MypagePsPlaceSelectDB {
	
	public ArrayList<Package_schedule> mypagePsPlaceSelect(ArrayList<Package_schedule> pslist) {
		Connection con = getConnection();
		JourneySql sql = JourneySql.getInstance();
		sql.setConnection(con);
		
		String schedule = "";
		for (Package_schedule ps : pslist) {
			schedule += ps.getPs_schedule() + ", ";
		}
		
		if (schedule != "")
			schedule = schedule.substring(0, schedule.length() - 2);
		//System.out.println("일정 스케줄------>"+schedule);
		
		ArrayList<Package_schedule> pclist = sql.mypagePsPlaceSelect(schedule);
		
		close(con);
		return pclist;
	}
	
}
