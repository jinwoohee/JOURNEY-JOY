package com.jj.conn;

import java.sql.Connection;

import com.jj.dao.JourneySql;

import static com.jj.db.JdbcUtil.*;

public class ClassApplyDB {
	
	public void insertClassApply(int c_no, String u_id) {
		
		Connection con = getConnection();
		JourneySql sql = JourneySql.getInstance();
		sql.setConnection(con);
		
		int resultCount = sql.insertClassApply(c_no, u_id);
		
		if(resultCount > 0) {
			commit(con);
		}else {
			rollback(con);
		} 
		
		close(con);
	}
 
}
