package com.jj.conn;

import static com.jj.db.JdbcUtil.close;
import static com.jj.db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import com.jj.dao.JourneySql;
import com.jj.dto.Class_list;

public class ClassSearchDB {
	
	public ArrayList<Class_list> searchClass(String param, String search, String city){
		
		ArrayList<Class_list> classList = null;
		Connection con = getConnection();
		JourneySql sql = JourneySql.getInstance();
		sql.setConnection(con);
		classList = sql.selectSearchClass(param, search, city);
		
		close(con);

		return classList;
	}

}
