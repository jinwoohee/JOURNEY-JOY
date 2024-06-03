package com.jj.inter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.ScheduleInsertDB;
import com.jj.conn.ScheduleUpdateDB;
import com.jj.dao.JourneyInterface;

public class ScheduleUpdate implements JourneyInterface {
static ScheduleUpdate sche_upd = new ScheduleUpdate();
	
	public static ScheduleUpdate updateSchedule() {
		return sche_upd;
	}

	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Cookie[] ck = request.getCookies();
		
		int e_no = Integer.parseInt(request.getParameter("e_no"));	
		int day = Integer.parseInt(request.getParameter("day"));
		
		System.out.println("e_no : "+e_no);
		System.out.println("day : "+day);
		
		for(int a = 1 ; a <= day ; a++) {		
			String place_arr= new String(request.getParameter("place_ids"+a).getBytes("8859_1"),"UTF-8");
			System.out.println(place_arr);
			String place = place_arr.replaceAll("\\[", "").replaceAll("\\]", "").replaceAll("empty", "");
			System.out.println("스케쥴업데이트"+place);
			ScheduleUpdateDB upsc = ScheduleUpdateDB.updatedb();
			int i = upsc.updateMtd(e_no, a, place);
		}
		
		String num = e_no+"";
		request.setAttribute("e_no", num);
		request.setAttribute("paging", "detail_my_edit");
		return "plan_page.jsp";
		
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

