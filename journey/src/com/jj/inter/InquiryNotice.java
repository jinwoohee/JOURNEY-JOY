package com.jj.inter;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.InquiryNoticeDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Inquiry;

public class InquiryNotice implements JourneyInterface {
	static InquiryNotice iNotice = new InquiryNotice();
	
	public static InquiryNotice inquiryNotice() {
		return iNotice;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String u_id = request.getParameter("u_id");
		//System.out.println("현재 로그인한 id---->"+u_id);
		
		InquiryNoticeDB iNoticeDB = new InquiryNoticeDB();
		ArrayList<Inquiry> inquiry_list = iNoticeDB.inquirySelect(u_id);
		request.setAttribute("inquiry_list", inquiry_list);
		//System.out.println("InquiryNotice----->"+inquiry_list.size());
		
		return "mheader_box.jsp";
	}
	
}
