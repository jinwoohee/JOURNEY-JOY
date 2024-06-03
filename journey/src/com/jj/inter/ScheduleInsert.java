package com.jj.inter;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.EaterySelectDB;
import com.jj.conn.PlaceSelectDB;
import com.jj.conn.ScheduleInsertDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Eatery;
import com.jj.dto.Place;

public class ScheduleInsert implements JourneyInterface{
	static ScheduleInsert sche_in = new ScheduleInsert();
	
	public static ScheduleInsert insertSchedule() {
		return sche_in;
	}

	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Cookie[] ck = request.getCookies();
		int e_no = (int) request.getAttribute("e_no");	
		int day = Integer.parseInt(getCookieValue(ck, "datecnt"));
		System.out.println("hy2"+day);
		
		for(int a = 1 ; a <= day ; a++) {		
			String place_arr= new String(request.getParameter("place_ids"+a).getBytes("8859_1"),"UTF-8");
			System.out.println("스케쥴인서트"+place_arr);
			String place = place_arr.replaceAll("empty", "");
			
			ScheduleInsertDB isc = ScheduleInsertDB.insertdb();
			int i = isc.insertMtd(e_no, a, place);
		}

		String num = e_no+"";
		
		request.setAttribute("e_no", num);
		request.setAttribute("paging", "detail_my");
		
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
