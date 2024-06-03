package com.jj.inter;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.jj.conn.EstimateInsertDB;
import com.jj.dao.JourneyInterface;


public class EstimateInsert implements JourneyInterface{
	static EstimateInsert esti_ins = new EstimateInsert();
	
	public static EstimateInsert insertEstimate() {
		return esti_ins;
	}

	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		String u_id = (String) session.getAttribute("u_id");
		
		Cookie[] ck = request.getCookies();
		String e_departure = getCookieValue(ck, "e_departure");
		String e_destination = getCookieValue(ck, "e_destination");
		String e_start_date = getCookieValue(ck, "e_start_date");
		String e_end_date = getCookieValue(ck, "e_end_date");
		String e_thema = getCookieValue(ck, "e_thema");
		String e_detail_thema = getCookieValue(ck, "e_detail_thema");
		String e_volume = getCookieValue(ck, "e_volume");
		String e_food_taste = getCookieValue(ck, "e_food_taste");
		String e_airplane = getCookieValue(ck, "e_airplane");
		String e_hotel = getCookieValue(ck, "e_hotel");
		
		String thema_arr = e_detail_thema.replaceAll("_", ",");
		
		String food_arr = e_food_taste.replaceAll("_", ",");
		System.out.println("sadasdsa");
		EstimateInsertDB idb = EstimateInsertDB.indb();
		Map<String, Object> param = idb.insertMth(u_id, e_departure, e_destination, e_start_date, e_end_date, e_thema, thema_arr, e_volume, food_arr, e_airplane, e_hotel);
		
		request.setAttribute("e_no", param.get("e_no"));

		return "planner.jj?page=schedule_insert";
		
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
