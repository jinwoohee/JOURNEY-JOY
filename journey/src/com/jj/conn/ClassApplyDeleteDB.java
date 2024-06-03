package com.jj.conn;

import static com.jj.db.JdbcUtil.*;

import java.sql.Connection;

import com.jj.dao.JourneySql;

public class ClassApplyDeleteDB {
	
	public void deleteClassApply(int c_no) {
		Connection con = getConnection();
		JourneySql sql = JourneySql.getInstance();
		sql.setConnection(con);
		
		int resultCount = sql.deleteClassApply(c_no);
		
		if(resultCount > 0) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
	}
}
