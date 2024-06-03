package com.jj.inter;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.SearchPlaceSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Eatery;
import com.jj.dto.Place;

public class SearchPlaceSelect implements JourneyInterface{
	static SearchPlaceSelect sps = new SearchPlaceSelect();
	
	public static SearchPlaceSelect search_place() {
		return sps;
	}
	
	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		Cookie[] ck = request.getCookies();
		
		String text = request.getParameter("search_place");
		String city_h = request.getParameter("city");
		String city ="";
		if(city_h.equals("오사카")) {
			city = "osaka";
		}
		System.out.println(city);
		SearchPlaceSelectDB spsdb = SearchPlaceSelectDB.seldb();
		List<Place> plaList = spsdb.searchmtd(text,city);	
		List<Eatery> eatList = spsdb.searchmtde(text,city);
		System.out.println("hi"+plaList.size());
		request.setAttribute("search_place", plaList);
		request.setAttribute("search_eatery", eatList);

		request.setAttribute("search", text);
		
		
		return "planner_add_place_search.jsp";
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
