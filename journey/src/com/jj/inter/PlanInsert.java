package com.jj.inter;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.AccountInsertDB;
import com.jj.conn.EstimateInsertDB;
import com.jj.conn.PlanInsertDB;
import com.jj.conn.ScheduleUpdateDB;
import com.jj.dao.JourneyInterface;

public class PlanInsert implements JourneyInterface{
	static PlanInsert plan_ins = new PlanInsert();
	
	public static PlanInsert insertPlan() { 
		return plan_ins;
	}

	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int e_no = Integer.parseInt(request.getParameter("e_no"));
		String plan_title = new String(request.getParameter("plan_subject").getBytes("8859_1"),"UTF-8");
		String plan_product = request.getParameter("selected_prod");
		
		//plan insert
		PlanInsertDB idb = PlanInsertDB.indb();
		idb.insertMth(e_no, plan_title, plan_product);	
		
		//schedule update
		int day = Integer.parseInt(request.getParameter("day"));
		
		for(int a = 1 ; a <= day ; a++) {
			String [] schedule = request.getParameterValues("change_value"+a);
			String result ="";
			for(int i = 0 ; i < schedule.length ; i++) {
				String ss = new String(schedule[i].getBytes("8859_1"),"UTF-8"); 
				result += ss+",";
			}
			System.out.println("result day"+a+":"+result);

			ScheduleUpdateDB upsc = ScheduleUpdateDB.updatedb();
			int i = upsc.updateMtd(e_no, a, result);
		}
		
		//account insert
	
		AccountInsertDB accdb = AccountInsertDB.indb();
	
		for(int a = 0 ; a<= day ; a++) {
			
			String [] amount = request.getParameterValues("prices"+a);
			String [] payment = request.getParameterValues("pay_with"+a);
			String [] contents = request.getParameterValues("content"+a);
			String [] category = request.getParameterValues("sort"+a);
			String [] curr = request.getParameterValues("curr"+a);
			
			
				for(int i = 0 ; i < amount.length ; i++) {
					
					int acc_amount = Integer.parseInt(amount[i].replaceAll(" ", ""));
					String acc_payment = new String(payment[i].getBytes("8859_1"),"UTF-8");
					String acc_contents = new String(contents[i].getBytes("8859_1"),"UTF-8");
					String acc_category = new String(category[i].getBytes("8859_1"),"UTF-8");
					String acc_curr = curr[i];			
					accdb.insertMth(e_no, a, i, acc_amount, acc_payment, acc_contents, acc_category, acc_curr);
			}
		}
	
		//page
		request.setAttribute("paging", "list");
		System.out.println("plan인설트 마지막");
		
		return "plan_page.jsp";
	}

}
