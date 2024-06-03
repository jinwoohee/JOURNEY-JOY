package com.jj.inter;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.MypagePlaceReviewSelectDB;
import com.jj.conn.MypagePlaceReview_placeSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Location_review;
import com.jj.dto.Place;

public class MypagePlaceReviewSelect implements JourneyInterface {
	static MypagePlaceReviewSelect mpcSelect = new MypagePlaceReviewSelect();
	
	public static MypagePlaceReviewSelect mypagePlaceReviewSelect() {
		return mpcSelect;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String u_id = request.getParameter("u_id");
		
		MypagePlaceReviewSelectDB mpcSelectDB = new MypagePlaceReviewSelectDB();
		ArrayList<Location_review> lrList = mpcSelectDB.mypagePlaceReviewSelectDB(u_id);
		
		String place = "";
		for (Location_review lr : lrList) {
			place += lr.getPl_eat_no() + "/";
		}
		
		MypagePlaceReview_placeSelectDB pcSelectDB = new MypagePlaceReview_placeSelectDB();
		ArrayList<Place> pclist = new ArrayList<Place>();
		String[] pl_eat_no = place.split("/");
		for (String s : pl_eat_no) {
			pclist.addAll(pcSelectDB.mypagePlaceSelectDB(s));
		}
		
		request.setAttribute("lrList", lrList);
		request.setAttribute("pclist", pclist);
		
		return "mypage_placeReview.jsp";
	}

}
