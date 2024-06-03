package com.jj.conn;

import static com.jj.db.JdbcUtil.close;
import static com.jj.db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import com.jj.dao.JourneySql;
import com.jj.dto.User;

public class MypageUserInfoSelectDB {
	
	public ArrayList<User> mypageUserInfoSelectDB(String u_id) {
		Connection con = getConnection();
		JourneySql sql = JourneySql.getInstance();
		sql.setConnection(con);
		ArrayList<User> alist = sql.mypageUserInfoSelect(u_id);
		
		close(con);
		return alist; 
	}
}
