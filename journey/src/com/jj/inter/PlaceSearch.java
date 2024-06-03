package com.jj.inter;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.dao.JourneyInterface;
import com.jj.dao.Review;
import com.jj.dto.Eatery;
import com.jj.dto.Place;

public class PlaceSearch implements JourneyInterface{
	
	static PlaceSearch pSelect = new PlaceSearch();
	
	public static PlaceSearch placeSearchInter() {
		return pSelect;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("--- inter/PlaceSearch ---");
		
		Review review = new Review();
		
		String search = request.getParameter("search");
		
		ArrayList<Place> place = review.select_place(search);
		ArrayList<Eatery> eat = review.select_eat(search);
		
		request.setAttribute("placeList", place);
		request.setAttribute("eatList", eat);
	
		return "placeSearch.jsp";
	}
}
