package com.jj.inter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.LikeInsertDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Package_like;

public class LikeInsert implements JourneyInterface{
	
	static LikeInsert likeInsert = new LikeInsert();
	
	public static LikeInsert likeInsertinter() {
		return likeInsert;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		System.out.println("--- inter/likeInsert ---");
		
		LikeInsertDB insertDB = LikeInsertDB.insert();
		
		Package_like like = new Package_like();
		like.setP_no(Integer.parseInt(request.getParameter("p_no")));
		like.setU_id(request.getParameter("u_id"));
		
		insertDB.insertLike(like);
		
		return "packageDetail.jj?page=package_detail&p_no="+Integer.parseInt(request.getParameter("p_no"));
	}
	
}
