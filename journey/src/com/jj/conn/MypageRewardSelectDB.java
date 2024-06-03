package com.jj.conn;

import static com.jj.db.JdbcUtil.close;
import static com.jj.db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import com.jj.dao.JourneySql;
import com.jj.dto.Package;

public class MypageRewardSelectDB {
	
	public ArrayList<Package> mypageRewardSelectDB(String p_no) {
		Connection con = getConnection();
		JourneySql sql = JourneySql.getInstance();
		sql.setConnection(con);
		ArrayList<Package> rlist = sql.mypageRewardSelect(p_no); //패키지 리워드
		//System.out.println("MypageRewardSelectDB list----->"+rlist.size());
		
		close(con);
		return rlist;
	}
}
