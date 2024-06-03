package com.jj.inter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.PlanDeleteDB;
import com.jj.conn.PlanInsertDB;
import com.jj.dao.JourneyInterface;

public class PlanDelete implements JourneyInterface{
	static PlanDelete plan_del = new PlanDelete();
	
	public static PlanDelete deletePlan() { 
		return plan_del;
	}

	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("hi delete");
		int e_no = Integer.parseInt(request.getParameter("e_no"));
		System.out.println("hi"+e_no);
		PlanDeleteDB idb = PlanDeleteDB.deldb();
		idb.deleteMtd(e_no);	
		
		request.setAttribute("paging", "list");
		return "plan_page.jsp";
	}

}
