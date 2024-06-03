package com.jj.conn;

import java.sql.Connection;

import com.jj.dao.JourneySql;
import com.jj.dto.Class_list;
import static com.jj.db.JdbcUtil.*;

public class ClassInsertDB {
	
	public void insertClass(Class_list cl) {
		
		System.out.println("conn/insertClass");
		
		Connection con = getConnection();
		JourneySql sql = JourneySql.getInstance();
		sql.setConnection(con);
		
		int resultCount = sql.insertClass(cl);
		
		if(resultCount > 0) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
	}
}
