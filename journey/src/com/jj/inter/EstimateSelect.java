package com.jj.inter;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.jj.conn.AccountSelectDB;
import com.jj.conn.EaterySelectDB;
import com.jj.conn.EstimateSelectDB;
import com.jj.conn.PlaceSelectDB;
import com.jj.conn.PlanSelectDB;
import com.jj.conn.ProductSelectDB;
import com.jj.conn.ScheduleSelectDB;
import com.jj.conn.TicketSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Account;
import com.jj.dto.Eatery;
import com.jj.dto.Estimate;
import com.jj.dto.Place;
import com.jj.dto.Plan;
import com.jj.dto.Product;
import com.jj.dto.Schedule;
import com.jj.dto.Ticket;
import com.mysql.cj.Session;

public class EstimateSelect implements JourneyInterface{
	static EstimateSelect esti_sel = new EstimateSelect();
	
	public static EstimateSelect selectEstimate() {
		return esti_sel;
	}
	
	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub	
		HttpSession session = request.getSession(false);
		String u_id = (String) session.getAttribute("u_id");

		Cookie[] ck = request.getCookies();
		String num = getCookieValue(ck, "e_no");
		String product = getCookieValue(ck,"e_destination");
		String ticket = getCookieValue(ck, "e_detail_thema");
		String wh = getCookieValue(ck, "where");

		EstimateSelectDB estidb = EstimateSelectDB.seldb();
		
		System.out.println(wh);
		if(wh != null) { 
			if(wh.equals("list")) {		//나의 여행계획서 목록 불러올때
				System.out.println("이스티 셀렉트"+wh);
				List<Estimate> estiList = estidb.selectMth(u_id);
				request.setAttribute("estimate", estiList);
				return "plan.jj?page=plan_select";
			}
			else if(wh.equals("detail")){ // 여행계획서 처음 저장시에 detail부분으로 넘어갈때
				System.out.println("이스티 셀렉트"+wh);
				int e_no = Integer.parseInt(num);
				List<Estimate> estiList = estidb.selmtd(e_no); // 견적 select
				request.setAttribute("estimate", estiList);
				
				ScheduleSelectDB schedb = ScheduleSelectDB.seldb(); // 일정 select
				List<Schedule> scheList = schedb.selmtd(e_no);
				request.setAttribute("schedule", scheList);
				
				PlanSelectDB plandb = PlanSelectDB.seldb();
				List<Plan> planList = plandb.select_e_no(e_no);
				request.setAttribute("plan", planList);
				
				ProductSelectDB proddb = ProductSelectDB.seldb(); // 상품 select
				List<Product> prodList = proddb.selectMth(product);
				request.setAttribute("product", prodList);
				
				TicketSelectDB tickdb = TicketSelectDB.seldb(); // 티켓 select
				List<Ticket> tickList = tickdb.selectMth(ticket);
				request.setAttribute("ticket", tickList);
				
				EaterySelectDB eatsel = EaterySelectDB.seldb(); //음식점list select
				List<Eatery>eatList = eatsel.select_ea(); 
				request.setAttribute("eatList", eatList);
				
				PlaceSelectDB palsel = PlaceSelectDB.seldb(); //여행지 list select
				List<Place>plaList = palsel.select_pl();		
				request.setAttribute("plaList", plaList);
				
			
				return "plan.jsp"; 
				
			}else if(wh.equals("detail_my")) { // 내 계획서목록에서 눌렀을때 나오는거
				System.out.println("이스티 셀렉트"+wh);
				int e_no = Integer.parseInt(num);
				List<Estimate> estiList = estidb.selmtd(e_no); // 견적 select
				request.setAttribute("estimate", estiList);
				
				ScheduleSelectDB schedb = ScheduleSelectDB.seldb(); // 일정 select
				List<Schedule> scheList = schedb.selmtd(e_no);
				request.setAttribute("schedule", scheList);
				
				PlanSelectDB plandb = PlanSelectDB.seldb(); // 계획서 select
				List<Plan> planList = plandb.select_e_no(e_no);
				request.setAttribute("plan", planList);
				
				ticket = estiList.get(0).gete_detail_thema(); 
				product = estiList.get(0).gete_destination();
				
				ProductSelectDB proddb = ProductSelectDB.seldb(); // 내가 담은 상품 select
				List<Product> prodList = proddb.selectMth(product);
				request.setAttribute("product", prodList);
				
				TicketSelectDB tickdb = TicketSelectDB.seldb(); // 내가 담은 티켓 select
				List<Ticket> tickList = tickdb.select_myMth(ticket);
				request.setAttribute("ticket", tickList);
				
				AccountSelectDB accdb = AccountSelectDB.seldb(); //가계부 select
				List<Account> accList = accdb.selmtd(e_no);
				request.setAttribute("account", accList);
				

				EaterySelectDB eatsel = EaterySelectDB.seldb(); //음식점list select
				List<Eatery>eatList = eatsel.select_ea(); 
				request.setAttribute("eatList", eatList);
				
				PlaceSelectDB palsel = PlaceSelectDB.seldb(); //여행지 list select
				List<Place>plaList = palsel.select_pl();		
				request.setAttribute("plaList", plaList);
				
				System.out.println("my끝");
				
				request.setAttribute("paging", "my_detail");
				return "plan.jsp";
				
			}else if(wh.equals("edit_my")) { // 수정눌렀을때
				System.out.println("이스티 셀렉트"+wh);
				int e_no = Integer.parseInt(num);
				List<Estimate> estiList = estidb.selmtd(e_no); // 견적 select
				request.setAttribute("estimate", estiList);
				
				ScheduleSelectDB schedb = ScheduleSelectDB.seldb(); // 일정 select
				List<Schedule> scheList = schedb.selmtd(e_no);
				request.setAttribute("schedule", scheList);
				
				PlanSelectDB plandb = PlanSelectDB.seldb();
				List<Plan> planList = plandb.select_e_no(e_no);
				request.setAttribute("plan", planList);
				
				product = estiList.get(0).gete_destination();
				ticket = estiList.get(0).gete_detail_thema();
				
				ProductSelectDB proddb = ProductSelectDB.seldb(); // 상품 select
				List<Product> prodList = proddb.selectMth(product);
				request.setAttribute("product", prodList);
				
				TicketSelectDB tickdb = TicketSelectDB.seldb(); // 티켓 select
				List<Ticket> tickList = tickdb.select_myMth(ticket);
				request.setAttribute("ticket", tickList);
				
				EaterySelectDB eatsel = EaterySelectDB.seldb(); //음식점list select
				List<Eatery>eatList = eatsel.select_ea(); 
				request.setAttribute("eatList", eatList);
				
				PlaceSelectDB palsel = PlaceSelectDB.seldb(); //여행지 list select
				List<Place>plaList = palsel.select_pl();		
				request.setAttribute("plaList", plaList);
				System.out.println(plaList.size()+eatList.size()+"hi");
				
				request.setAttribute("paging", "my_edit");
				return "planner_edit_edit.jsp";
			}
			else if(wh.equals("detail_my_edit")){ // 여행계획서 수정 시에 detail부분으로 넘어갈때
				System.out.println("이스티 셀렉트"+wh);
				int e_no = Integer.parseInt(num);
				List<Estimate> estiList = estidb.selmtd(e_no); // 견적 select
				request.setAttribute("estimate", estiList);
				
				ScheduleSelectDB schedb = ScheduleSelectDB.seldb(); // 일정 select
				List<Schedule> scheList = schedb.selmtd(e_no);
				request.setAttribute("schedule", scheList);
				
				PlanSelectDB plandb = PlanSelectDB.seldb();
				List<Plan> planList = plandb.select_e_no(e_no);
				request.setAttribute("plan", planList);
				
				ProductSelectDB proddb = ProductSelectDB.seldb(); // 상품 select
				List<Product> prodList = proddb.selectMth(product);
				request.setAttribute("product", prodList);
				
				TicketSelectDB tickdb = TicketSelectDB.seldb(); // 티켓 select
				List<Ticket> tickList = tickdb.selectMth(ticket);
				request.setAttribute("ticket", tickList);
				
				AccountSelectDB accdb = AccountSelectDB.seldb(); //가계부 select
				List<Account> accList = accdb.selmtd(e_no);
				request.setAttribute("account", accList);
				

				EaterySelectDB eatsel = EaterySelectDB.seldb(); //음식점list select
				List<Eatery>eatList = eatsel.select_ea(); 
				request.setAttribute("eatList", eatList);
				
				PlaceSelectDB palsel = PlaceSelectDB.seldb(); //여행지 list select
				List<Place>plaList = palsel.select_pl();		
				request.setAttribute("plaList", plaList);
			
				return "plan_edit.jsp"; 
				
			}
			else {
				return "";
			}
		}else {
			return "";
		}
	}
	
	private String getCookieValue(Cookie[] cookies, String name) {
		String value = null;
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				if(cookie.getName().equals(name)) {
					return cookie.getValue();
				}
			}return null;
		}else {
			return null;
		}
	}
}
