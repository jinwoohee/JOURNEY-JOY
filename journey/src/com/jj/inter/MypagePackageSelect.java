package com.jj.inter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.MypagePackageScheSelectDB;
import com.jj.conn.MypagePackageSelectDB;
import com.jj.conn.MypagePsPlaceSelectDB;
import com.jj.conn.MypagePurchaseSelectDB;
import com.jj.conn.MypageRewardSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Estimate;
import com.jj.dto.Package;
import com.jj.dto.Package_schedule;
import com.jj.dto.Plan;
import com.jj.dto.Plan_review;
import com.jj.dto.Purchase;
import com.jj.dto.User;

public class MypagePackageSelect implements JourneyInterface {
	static MypagePackageSelect mSelect = new MypagePackageSelect();
	
	public static MypagePackageSelect mypagePackageSelect() {
		return mSelect;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String u_id = request.getParameter("u_id");
		String tab = request.getParameter("tab");
		ArrayList<User> ulist = (ArrayList<User>)request.getAttribute("ulist"); //회원정보
		ArrayList<Plan_review> prList = (ArrayList<Plan_review>)request.getAttribute("prList"); //일정리뷰
		List<Estimate> estiList = (List<Estimate>) request.getAttribute("estimate");
		List<Plan> planList = (List<Plan>) request.getAttribute("planList");
		
		/* 패키지(기획내역) */
		MypagePackageSelectDB mSelectDB = new MypagePackageSelectDB(); //패키지 상세내용
		ArrayList<Package> plist = mSelectDB.mypagePackageSelectDB(u_id);
		
		String no = "";
		for (Package pk : plist) {
			no += pk.getP_no() + "/";
		}
		
		//패키지 일정
		MypagePackageScheSelectDB msSelectDB = new MypagePackageScheSelectDB();
		ArrayList<Package_schedule> pslist;
		HashMap<String, ArrayList<Package_schedule>> map = new HashMap<String, ArrayList<Package_schedule>>();
		
		//패키지 리워드
		MypageRewardSelectDB mrSelectDB = new MypageRewardSelectDB();
		ArrayList<Package> rlist;
		HashMap<String, ArrayList<Package>> map2 = new HashMap<String, ArrayList<Package>>();
		
		//패키지 장소
		MypagePsPlaceSelectDB mppSelectDB = new MypagePsPlaceSelectDB();
		ArrayList<Package_schedule> pclist;
		HashMap<String, ArrayList<Package_schedule>> map3 = new HashMap<String, ArrayList<Package_schedule>>();
		
		if (no != "") {
			String[] p_no = no.split("/");
			for (String s : p_no) {
				pslist = msSelectDB.mypagePackageScheSelectDB(s);
				map.put(s, pslist);
				
				pclist = mppSelectDB.mypagePsPlaceSelect(pslist);
				map3.put(s, pclist);
				
				rlist = mrSelectDB.mypageRewardSelectDB(s);
				map2.put(s, rlist);
			}
		}
		//System.out.println("MypageSelect-------->" + plist + " / " + map + " / " + map2);
		
		request.setAttribute("package", plist);
		request.setAttribute("packagesche", map);
		request.setAttribute("reward", map2);
		request.setAttribute("place", map3);
		request.setAttribute("ulist", ulist); //회원정보
		request.setAttribute("prList", prList); //일정리뷰
		request.setAttribute("estimate", estiList);
		request.setAttribute("planList", planList);
		
		return "mypage.jsp?tab="+tab;
	}
}
