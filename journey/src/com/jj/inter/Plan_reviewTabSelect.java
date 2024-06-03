package com.jj.inter;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.ClassTabSelectDB;
import com.jj.conn.Plan_reviewTapSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Class_list;
import com.jj.dto.Estimate;

public class Plan_reviewTabSelect implements JourneyInterface{

	static Plan_reviewTabSelect tabSelect = new Plan_reviewTabSelect();
	
	public static Plan_reviewTabSelect plan_reviewTabSelect() {
		return tabSelect;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("--- inter/classTabSelect ---");
		Cookie[] ck = request.getCookies();
		String u_id = getCookieValue(ck, "u_id");
		System.out.println("아이디"+u_id);
		
		Plan_reviewTapSelectDB selectDB = new Plan_reviewTapSelectDB();
		
		ArrayList<Estimate> estilist = selectDB.selectPlan(u_id);
		 request.setAttribute("estilist", estilist);
		 System.out.println("사이즈="+estilist.size());
		return "plan_review_plan_select.jsp";
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
