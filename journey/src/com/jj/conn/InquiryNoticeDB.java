package com.jj.conn;

import static com.jj.db.JdbcUtil.close;
import static com.jj.db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import com.jj.dao.JourneySql;
import com.jj.dto.Inquiry;

public class InquiryNoticeDB {
	
	public ArrayList<Inquiry> inquirySelect(String u_id) {
		Connection con = getConnection();
		JourneySql sql = JourneySql.getInstance();
		sql.setConnection(con);
		ArrayList<Inquiry> inquiry_list = sql.inquirySelect(u_id);
		
		close(con);
		return inquiry_list;
	}
	
	
}
