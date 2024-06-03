package com.jj.inter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.InquiryUpdateFlagDB;
import com.jj.dao.JourneyInterface;

public class InquiryUpdateFlag implements JourneyInterface {
	static InquiryUpdateFlag iuFlag = new InquiryUpdateFlag();
	
	public static InquiryUpdateFlag inquiryUpdateFlag() {
		return iuFlag;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String u_id = request.getParameter("u_id");
		
		InquiryUpdateFlagDB iuFlagDB = new InquiryUpdateFlagDB();
		int row = iuFlagDB.inquiryUpdateFlag(u_id);
		
		return "main_header.jsp";
	}
}
