package com.jj.inter;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.WhClearDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Company;

public class WhClear implements JourneyInterface {
	static WhClear clear = new WhClear();
	
	public static WhClear whclear() {
		return clear;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		WhClearDB whcleardb = new WhClearDB();
		List<Company> list = whcleardb.select();
		request.setAttribute("list", list);
		
		return "wh_list_form.jsp";
	}
	
	
}
