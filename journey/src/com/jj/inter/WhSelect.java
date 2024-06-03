package com.jj.inter;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.WhSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Company;

public class WhSelect implements JourneyInterface {
	static WhSelect wh = new WhSelect();
	
	public static WhSelect whselect() {
		return wh;
		
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		WhSelectDB whdb = WhSelectDB.whselectdb();
		List<Company> list = whdb.select();
		request.setAttribute("list", list);
		
		return "workingholiday.jsp";
	}

}
