package com.jj.conn;

import static com.jj.db.JdbcUtil.close;
import static com.jj.db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import com.jj.dao.JourneySql;
import com.jj.dto.Package_schedule;

public class MypagePackageScheSelectDB {
	
	public ArrayList<Package_schedule> mypagePackageScheSelectDB(String p_no) {
		Connection con = getConnection();
		JourneySql sql = JourneySql.getInstance();
		sql.setConnection(con);
		ArrayList<Package_schedule> pslist = sql.mypagePackageScheSelect(p_no); //패키지 일정
		//System.out.println("MypagePackageScheSelectDB list----->"+pslist.size());
		
		close(con);
		return pslist;
	}

}
