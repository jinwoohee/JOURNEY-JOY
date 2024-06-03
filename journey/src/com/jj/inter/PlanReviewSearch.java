package com.jj.inter;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.PlanReviewSearchDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Plan_review;

public class PlanReviewSearch implements JourneyInterface{
	
	static PlanReviewSearch pSelect = new PlanReviewSearch();
	
	public static PlanReviewSearch planReviewSearchInter() {
		return pSelect;
		
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("city", request.getParameter("city"));
		map.put("search", request.getParameter("search"));
		
		PlanReviewSearchDB searchReview = PlanReviewSearchDB.select();
		List<Plan_review> prList = searchReview.selectPlanReview(map);
		request.setAttribute("prList", prList);
		
		return "planReviewAjax.jsp";
	}
}
