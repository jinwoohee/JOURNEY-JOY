package com.jj.inter;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.jj.conn.PlanSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Estimate;
import com.jj.dto.Plan;


public class PlanSelect implements JourneyInterface{
	static PlanSelect plan_sel = new PlanSelect();
	
	public static PlanSelect selectPlan() {
		return plan_sel;
	}
	
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub	
		List<Estimate> estiList = (List<Estimate>) request.getAttribute("estimate");
		HttpSession session = request.getSession(false);
		String u_id = (String) session.getAttribute("u_id");
		
		PlanSelectDB plandb = PlanSelectDB.seldb();
		List<Plan> planList = plandb.select_id(u_id);
		
		request.setAttribute("estimate", estiList);
		request.setAttribute("planList", planList);
		
		return "plan_list.jsp";
			
	}
}
