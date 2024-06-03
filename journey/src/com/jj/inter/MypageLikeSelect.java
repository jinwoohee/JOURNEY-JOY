package com.jj.inter;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.MypageLikeSelectDB;
import com.jj.conn.MypagePackageSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Package;
import com.jj.dto.Package_like;
import com.jj.dto.Purchase;

public class MypageLikeSelect implements JourneyInterface {
	static MypageLikeSelect mlSelect = new MypageLikeSelect();
	
	public static MypageLikeSelect mypageLikeSelect() {
		return mlSelect;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String u_id = request.getParameter("u_id");
		
		MypageLikeSelectDB mlSelectDB = new MypageLikeSelectDB();
		ArrayList<Package_like> plList = mlSelectDB.mypageLikeSelectDB(u_id);
		
		String num = ""; //찜한 패키지 번호
		for (Package_like p : plList) {
			num += p.getP_no() + "/";
		}
		
		MypagePackageSelectDB mSelectDB = new MypagePackageSelectDB();
		ArrayList<Package> plist = new ArrayList<Package>();
		
		String[] p_no = num.split("/");
		for (String s : p_no) {
			plist.addAll(mSelectDB.mypagePackageSelectDB2(s));
		}
		
		request.setAttribute("plist", plist);
		
		return "mypage_packageLike.jsp";
	}

}
