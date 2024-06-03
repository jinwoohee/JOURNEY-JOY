package com.jj.inter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.PurchaseInsertDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Purchase;

public class PurchaseInsert implements JourneyInterface{
	
	static PurchaseInsert pInsert = new PurchaseInsert();
	
	public static PurchaseInsert purchaseInsert() {
		return pInsert;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("--- inter/PurchaseInsert ---");

		PurchaseInsertDB insertDB = PurchaseInsertDB.insert();
		
		Purchase purchase = new Purchase();
		
		purchase.setU_id(request.getParameter("u_id"));
		purchase.setP_no(Integer.parseInt(request.getParameter("p_no")));
		purchase.setAdult_num(Integer.parseInt(request.getParameter("adultCount")));
		purchase.setStd_num(Integer.parseInt(request.getParameter("stdCount")));
		purchase.setChild_num(Integer.parseInt(request.getParameter("childCount")));
		
		insertDB.insertPurchase(purchase);
		
		return "packageDetail.jj?page=package_detail&p_no="+Integer.parseInt(request.getParameter("p_no"));
	}
}
