package com.jj.conn;

import static com.jj.db.JdbcUtil.close;
import static com.jj.db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import com.jj.dao.JourneySql;
import com.jj.dto.Package_like;

public class MypageLikeSelectDB {
	
	public ArrayList<Package_like> mypageLikeSelectDB(String u_id) {
		Connection con = getConnection();
		JourneySql sql = JourneySql.getInstance();
		sql.setConnection(con);
		ArrayList<Package_like> alist = sql.mypageLikeSelect(u_id);
		
		close(con);
		return alist;
	}
}
