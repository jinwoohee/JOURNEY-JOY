package com.jj.conn;

import java.sql.Connection;
import java.util.ArrayList;

import static com.jj.db.JdbcUtil.*;

import com.jj.dao.JourneySql;
import com.jj.dto.Class_list;

public class ClassTabSelectDB {
	
	public ArrayList<Class_list> selectTabClass(String tab, String u_id){
		
		ArrayList<Class_list> classList = null;
		Connection con = getConnection();
		JourneySql sql = JourneySql.getInstance();
		sql.setConnection(con);
		classList = sql.selectTabClass(tab, u_id);
		
		close(con);

		return classList;
	}

}
