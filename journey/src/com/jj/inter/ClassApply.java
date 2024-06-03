package com.jj.inter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.ClassApplyDB;
import com.jj.dao.JourneyInterface;

public class ClassApply implements JourneyInterface{
	
	static ClassApply caInsert = new ClassApply();
	
	public static ClassApply classApplyInsert() {
		return caInsert;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String u_id = request.getParameter("u_id");
		int c_no = Integer.parseInt(request.getParameter("c_no"));
		
		ClassApplyDB insertDB = new ClassApplyDB();
		insertDB.insertClassApply(c_no, u_id);
		
		return "classList.jj?page=clist";
	}
	
}
