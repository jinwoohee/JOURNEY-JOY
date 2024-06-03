package com.jj.inter;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.MypagePackageSelectDB;
import com.jj.conn.MypagePurchaseSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Package;
import com.jj.dto.Purchase;

public class MypagePurchaseSelect implements JourneyInterface {
	static MypagePurchaseSelect mpSelect = new MypagePurchaseSelect();
	
	public static MypagePurchaseSelect mypagePurchaseSelect() {
		return mpSelect;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		/* 패키지(참여내역) */
		String u_id = request.getParameter("u_id");
		
		MypagePurchaseSelectDB mpSelectDB = new MypagePurchaseSelectDB();
		ArrayList<Purchase> pchlist = mpSelectDB.mypagePurchaseSelect(u_id);
		
		String num = ""; //참여한 패키지 번호
		for (Purchase p : pchlist) {
			num += p.getP_no() + "/";
		}
		
		MypagePackageSelectDB mSelectDB = new MypagePackageSelectDB();
		ArrayList<Package> plist = new ArrayList<Package>();
		
		String[] p_no = num.split("/");
		for (String s : p_no) {
			plist.addAll(mSelectDB.mypagePackageSelectDB2(s));
		}
		
		request.setAttribute("plist", plist);		
		
		return "mypage_packageAttending.jsp";
	}
	
	
}
