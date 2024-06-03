package com.jj.inter;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.EaterySelectDB;
import com.jj.conn.PlaceSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Eatery;
import com.jj.dto.Place;

public class EaterySelect implements JourneyInterface{
	static EaterySelect eat_sel = new EaterySelect();
	
	public static EaterySelect select_eat() {
		return eat_sel;
	}
	
	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		Cookie[] ck = request.getCookies();
		String destination = getCookieValue(ck, "e_destination");
		String e_food_taste = getCookieValue(ck, "e_food_taste");
		String thema = getCookieValue(ck, "e_thema");
		String d_thema = getCookieValue(ck, "e_detail_thema");
		String day = getCookieValue(ck, "datecnt");
		String e_destination = "";
		System.out.println(destination);
		if(destination.equals("오사카")) {
			e_destination = "osaka";
		}else if(destination.equals("도쿄")) {
			e_destination = "tokyo";
		}else if(destination.equals("후쿠오카")) {
			e_destination = "fukuoka";
		}else if(destination.equals("삿포로")) {
			e_destination = "sapporo";
		}else if(destination.equals("다낭")) {
			e_destination = "danang";
		}else if(destination.equals("나트랑")) {
			e_destination = "nhatrang";
		}else if(destination.equals("밴쿠버")) {
			e_destination = "vancouver";
		}else if(destination.equals("보스턴")) {
			e_destination = "boston";
		}else if(destination.equals("시카고")) {
			e_destination = "chicago";
		}else if(destination.equals("로스앤젤레스")) {
			e_destination = "losAngeles";
		}else if(destination.equals("뉴욕")) {
			e_destination = "newyork";
		}else if(destination.equals("샌프란시스코")) {
			e_destination = "sanFrancisco";
		}else if(destination.equals("시드니")) {
			e_destination = "sydney";
		}else if(destination.equals("멜버른")) {
			e_destination = "melbourne";
		}else if(destination.equals("퀸즈랜드")) {
			e_destination = "queensland";
		}else if(destination.equals("퀸즈타운")) {
			e_destination = "queenstown";
		}else if(destination.equals("오클랜드")) {
			e_destination = "auckland";
		}else if(destination.equals("웰링턴")) {
			e_destination = "wellington";
		}
		
		System.out.println(e_destination);
		
		EaterySelectDB esdb = EaterySelectDB.seldb();
		List<Eatery> eatList = esdb.selectMth(e_destination,e_food_taste,day);			
		request.setAttribute("eatery", eatList);	
		
		PlaceSelectDB psdb = PlaceSelectDB.seldb();
		List<Place> plaList = psdb.selectMth(e_destination,thema, d_thema,day);		
		request.setAttribute("place", plaList);
		
		return "planner_select.jsp";
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
