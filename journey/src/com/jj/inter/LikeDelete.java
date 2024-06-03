package com.jj.inter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.LikeDeleteDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Package_like;

public class LikeDelete implements JourneyInterface{
	
	static LikeDelete likeDelete = new LikeDelete();
	
	public static LikeDelete likeDeleteinter() {
		return likeDelete;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		System.out.println("--- inter/likeDelete ---");
		
		LikeDeleteDB deleteDB = LikeDeleteDB.delete();
		
		Package_like like = new Package_like();
		like.setP_no(Integer.parseInt(request.getParameter("p_no")));
		like.setU_id(request.getParameter("u_id"));
		
		deleteDB.deleteLike(like);
		
		return "packageDetail.jj?page=package_detail&p_no="+Integer.parseInt(request.getParameter("p_no"));
	}
}
