package com.jj.inter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.PurchaseDeleteDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Purchase;

public class PurchaseDelete implements JourneyInterface{
	
	static PurchaseDelete purchaseDelete = new PurchaseDelete();
	
	public static PurchaseDelete pDeleteinter() {
		return purchaseDelete;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("--- inter/purchaseDelete ---");
		
		PurchaseDeleteDB deleteDB = PurchaseDeleteDB.delete();
		
		Purchase p = new Purchase();
		p.setP_no(Integer.parseInt(request.getParameter("p_no")));
		p.setU_id(request.getParameter("u_id"));
		
		deleteDB.deletePurchase(p);;
		
		return "packageDetail.jj?page=package_detail&p_no="+Integer.parseInt(request.getParameter("p_no"));
	}

}
