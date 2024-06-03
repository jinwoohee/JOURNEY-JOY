package com.jj.conn;

import static com.jj.db.JdbcUtil.*;

import java.sql.Connection;

import com.jj.dao.JourneySql;

public class InquiryUpdateFlagDB {
	
	public int inquiryUpdateFlag(String u_id) {
		Connection con = getConnection();
		JourneySql sql = JourneySql.getInstance();
		sql.setConnection(con);
		int row = sql.inquiryUpdateFlag(u_id);
		//System.out.println("inquiry update row----->"+row);
		
		if (row > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		close(con);
		
		return row;
	}
}
