package com.jj.conn;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Purchase;

public class PurchaseDeleteDB {
	
	static PurchaseDeleteDB deleteDB = new PurchaseDeleteDB();
	
	public static PurchaseDeleteDB delete() {
		return deleteDB;
	}
	
SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public void deletePurchase(Purchase p) {

		System.out.println("--- conn/purchaseDeleteDB ---");
		SqlSession ss = sql.openSession();
		int result = ss.insert("purchasedelete", p);
		
		ss.commit();
		ss.close();
	}
}
