package com.jj.inter;

import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.LikeSelectDB;
import com.jj.conn.PackageSearchDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Package;
import com.jj.dto.Package_like;

public class PackageSearch implements JourneyInterface{
	
	static PackageSearch pSelect = new PackageSearch();
	
	public static PackageSearch packageSearchInter() {
		return pSelect;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		
		System.out.println("---inter/PackageSearch---");

		String param = request.getParameter("param");
		
		PackageSearchDB searchPackage = PackageSearchDB.select();
		List<Package> pkList = searchPackage.selectPackage(param);
		request.setAttribute("pkList", pkList);
		
		/* 좋아요 */
		LikeSelectDB selectLike = LikeSelectDB.select();
		List<Package_like> likeList = selectLike.selectLike();
		request.setAttribute("likeList", likeList);

		return "ajax.jsp";
	}
}
