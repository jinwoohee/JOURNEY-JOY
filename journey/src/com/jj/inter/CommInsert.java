package com.jj.inter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.CommInsertDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Community;

public class CommInsert implements JourneyInterface{
	
	static CommInsert cInsert = new CommInsert();
	
	public static CommInsert commentInsert() {
		return cInsert;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("--- inter/commInsert ---");

		CommInsertDB insertDB = CommInsertDB.insert();
		
		String contents = new String(request.getParameter("comment_txt").getBytes("8859_1"),"UTF-8");
		
		Community comm = new Community();
		comm.setP_no(Integer.parseInt(request.getParameter("no")));
		comm.setU_id(request.getParameter("id"));
		comm.setComm_contents(contents);
		
		insertDB.isnertComm(comm);
		
		return "packageDetail.jj?page=package_detail&p_no="+request.getParameter("no");
	}

}
