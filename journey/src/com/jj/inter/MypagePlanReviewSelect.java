package com.jj.inter;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.MypagePlanReviewSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Plan_review;
import com.jj.dto.User;

public class MypagePlanReviewSelect implements JourneyInterface {
	static MypagePlanReviewSelect mPlanSelect = new MypagePlanReviewSelect();
	
	public static MypagePlanReviewSelect mypagePlanReviewSelect() {
		return mPlanSelect;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String u_id = request.getParameter("u_id");
		String tab = request.getParameter("tab");
		ArrayList<User> ulist = (ArrayList<User>)request.getAttribute("ulist");
		
		MypagePlanReviewSelectDB mPlanSelectDB = new MypagePlanReviewSelectDB();
		ArrayList<Plan_review> prList = mPlanSelectDB.mypagePlanReviewSelectDB(u_id);
		
		request.setAttribute("prList", prList);
		request.setAttribute("ulist", ulist);
		
		return "mypage.jj?page=mypagePlanner&tab="+tab+"&u_id="+u_id;
	}

}
