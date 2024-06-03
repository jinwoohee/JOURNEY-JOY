package com.jj.inter;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.EstimateSelectDB;
import com.jj.conn.PlanSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Estimate;
import com.jj.dto.Plan;
import com.jj.dto.Plan_review;
import com.jj.dto.User;

public class MypagePlannerSelect implements JourneyInterface {
	static MypagePlannerSelect mPlanner = new MypagePlannerSelect();
	
	public static MypagePlannerSelect mypagePlannerSelect() {
		return mPlanner;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String u_id = request.getParameter("u_id");
		String tab = request.getParameter("tab");
		ArrayList<User> ulist = (ArrayList<User>)request.getAttribute("ulist"); //회원정보
		ArrayList<Plan_review> prList = (ArrayList<Plan_review>)request.getAttribute("prList"); //일정리뷰
		
		EstimateSelectDB estidb = EstimateSelectDB.seldb();
		List<Estimate> estiList = estidb.selectMth(u_id);
		
		PlanSelectDB plandb = PlanSelectDB.seldb();
		List<Plan> planList = plandb.select_id(u_id);
		
		request.setAttribute("estimate", estiList);
		request.setAttribute("planList", planList);
		
		request.setAttribute("ulist", ulist);
		request.setAttribute("prList", prList);
		
		return "mypage.jj?page=mypagePackageMaking&tab="+tab+"&u_id="+u_id;
	}
	
	
}
