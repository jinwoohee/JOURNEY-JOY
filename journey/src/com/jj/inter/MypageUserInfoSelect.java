package com.jj.inter;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.MypageUserInfoSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.User;

public class MypageUserInfoSelect implements JourneyInterface {
	static MypageUserInfoSelect muSelect = new MypageUserInfoSelect();
	
	public static MypageUserInfoSelect mypageUserInfoSelect() {
		return muSelect;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String u_id = request.getParameter("u_id");
		String tab = request.getParameter("tab");
		
		MypageUserInfoSelectDB muSelectDB = new MypageUserInfoSelectDB();
		ArrayList<User> ulist = muSelectDB.mypageUserInfoSelectDB(u_id);
		
		request.setAttribute("ulist", ulist);
		
		return "mypage.jj?page=mypagePlanReview&tab="+tab+"&u_id="+u_id;
	}
	

}
