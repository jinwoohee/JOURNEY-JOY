package com.jj.inter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.ClassApplyDeleteDB;
import com.jj.dao.JourneyInterface;

public class ClassApplyDelete implements JourneyInterface{
	
	static ClassApplyDelete caDelete = new ClassApplyDelete();
	
	public static ClassApplyDelete classDelete() {
		return caDelete;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ClassApplyDeleteDB deleteDB = new ClassApplyDeleteDB();
		
		int c_no = Integer.parseInt(request.getParameter("c_no"));
		
		deleteDB.deleteClassApply(c_no);
		
		
		return null;
	}

}
