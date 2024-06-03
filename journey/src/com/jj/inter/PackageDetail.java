package com.jj.inter;

import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.CommSelectDB;
import com.jj.conn.LikeSelectDB;
import com.jj.conn.PackageDetailDB;
import com.jj.conn.PsSelectDB;
import com.jj.conn.PurchaseSelectDB;
import com.jj.conn.SelectPlaceInfoDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Community;
import com.jj.dto.Package_like;
import com.jj.dto.Package_schedule;
import com.jj.dto.Place;
import com.jj.dto.Purchase;


public class PackageDetail implements JourneyInterface{
	
	static PackageDetail pDetail = new PackageDetail();
	
	public static PackageDetail packageDetailInter() {
		return pDetail;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		int p_no = Integer.parseInt(request.getParameter("p_no"));
		String u_id = request.getParameter("u_id");
		
		System.out.println("---inter/packageDetail---");
		
		//패키지 select
		PackageDetailDB selectPackageDetail = PackageDetailDB.select();
		com.jj.dto.Package pkDetail = selectPackageDetail.selectPackageDetail(p_no);
		request.setAttribute("pkDetail", pkDetail);
		
		//찜 select
		LikeSelectDB selectLikeDetail = LikeSelectDB.select();
		Package_like like = selectLikeDetail.selectDetailLike(p_no, u_id);
		request.setAttribute("likeDetail", like);
		
		//일정 select
		PsSelectDB selectPackageSchedule = PsSelectDB.select();
		List<Package_schedule>psList = selectPackageSchedule.selectPackageSc(p_no);
		request.setAttribute("ps", psList);
		
		//select한 일정의 장소 정보 select
		SelectPlaceInfoDB selectPlaceInfo = new SelectPlaceInfoDB();
		List<Package_schedule> placeList = selectPlaceInfo.selectPlaceInfo(psList);
		request.setAttribute("placeList", placeList);
		
		//댓글 select
		CommSelectDB selectCommunity = CommSelectDB.select();
		List<Community> comm = selectCommunity.selectComm(p_no);
		request.setAttribute("comm", comm);
		
		//참여여부 select
		PurchaseSelectDB selectPurchase = PurchaseSelectDB.select();
		Purchase purchase = selectPurchase.selectPur(p_no, u_id);
		request.setAttribute("purchase", purchase);
		

		return "package_detail.jsp";
	}

}
