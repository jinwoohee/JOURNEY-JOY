package com.jj.inter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.AccountDeleteDB;
import com.jj.conn.AccountInsertDB;
import com.jj.conn.PlanDeleteDB;
import com.jj.conn.PlanInsertDB;
import com.jj.conn.PlanUpdateDB;
import com.jj.conn.ScheduleUpdateDB;
import com.jj.dao.JourneyInterface;

public class PlanUpdate implements JourneyInterface{
	static PlanUpdate plan_upd = new PlanUpdate();
	
	public static PlanUpdate updatePlan() { 
		return plan_upd;
	}

	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("hhhhhhhhh");
		int e_no = Integer.parseInt(request.getParameter("e_no"));
		String plan_title = new String(request.getParameter("plan_subject").getBytes("8859_1"),"UTF-8");
		String plan_product = request.getParameter("selected_prod");
		// plan update
		PlanDeleteDB pddb = PlanDeleteDB.deldb();
		pddb.deletePlan(e_no);
		PlanInsertDB pidb = PlanInsertDB.indb();
		pidb.insertMth(e_no, plan_title, plan_product);
		
		int day = Integer.parseInt(request.getParameter("day"));	
		//schedule update
		for(int a = 1 ; a <= day ; a++) { 
			String [] schedule = request.getParameterValues("change_value"+a);
			
			String result ="";
			if(schedule != null) {
			for(int i = 0 ; i < schedule.length ; i++) {
			
				String ss = new String(schedule[i].getBytes("8859_1"),"UTF-8"); 
				result += ss+",";
			}
			}
		

			ScheduleUpdateDB upsc = ScheduleUpdateDB.updatedb();
			int i = upsc.updateMtd(e_no, a, result);
		
		}
		// account update
		AccountDeleteDB accdel = AccountDeleteDB.deldb();
		accdel.deleteMth(e_no);
		
		AccountInsertDB accdb = AccountInsertDB.indb();
		for(int a = 0 ; a<= day ; a++) {
			String [] amount = request.getParameterValues("prices"+a);
			String [] payment = request.getParameterValues("pay_with"+a);
			String [] contents = request.getParameterValues("content"+a);
			String [] category = request.getParameterValues("sort"+a);
			String [] curr = request.getParameterValues("curr"+a);
			for(int i = 0 ; i < amount.length ; i++) {
				String am_ed = amount[i].replaceAll(",", "");
				int acc_amount = Integer.parseInt(am_ed);
				String acc_payment = new String(payment[i].getBytes("8859_1"),"UTF-8");
				String acc_contents = new String(contents[i].getBytes("8859_1"),"UTF-8");
				String acc_category = new String(category[i].getBytes("8859_1"),"UTF-8");
				String acc_curr = curr[i];		
				accdb.insertMth(e_no, a, i, acc_amount, acc_payment, acc_contents, acc_category, acc_curr);
			}
		}	

		request.setAttribute("paging", "list");	
		return "plan_page.jsp";
	}

}
