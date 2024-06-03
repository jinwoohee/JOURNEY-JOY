package com.jj.inter;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.InquiryInsertDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.InqNotice;

public class InquiryInsert implements JourneyInterface {
	static InquiryInsert qInsert = new InquiryInsert();
	
	public static InquiryInsert inquiryInsert() {
		return qInsert;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		int p_no = Integer.parseInt(request.getParameter("no"));
		String p_uid = request.getParameter("pid");
		String p_title = request.getParameter("title");
		String u_id = request.getParameter("id");
		String i_contents = request.getParameter("contents");
		//System.out.println("InquiryInsert----->"+p_no+"/"+u_id+"/"+i_contents);
		
		InquiryInsertDB qInsertDB = new InquiryInsertDB();
		int row = qInsertDB.inquiryInsertDB(p_no, p_uid, p_title, u_id, i_contents);
		
		return "packageDetail.jj?page=package_detail";
	}

}
