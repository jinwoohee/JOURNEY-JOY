package com.jj.inter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.WhlistSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Company;

public class WhlistSelect implements JourneyInterface {
	static WhlistSelect whl = new WhlistSelect();
	
	public static WhlistSelect whlistselect() {
		return whl;
		
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		int com_no = Integer.parseInt(request.getParameter("com_no"));
		WhlistSelectDB whldb = WhlistSelectDB.whlistselectdb();
		Company com = whldb.list_select(com_no);
		request.setAttribute("com", com);
		
		
		return "workingholiday_listpage.jsp";
	}
	
	
}
