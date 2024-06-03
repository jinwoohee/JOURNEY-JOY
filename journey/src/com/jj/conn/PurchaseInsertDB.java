package com.jj.conn;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Purchase;

public class PurchaseInsertDB {
	
	static PurchaseInsertDB insertDB = new PurchaseInsertDB();
	
	public static PurchaseInsertDB insert() {
		return insertDB;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public void insertPurchase(Purchase purchase) {
		
		System.out.println("--- conn/purchaseInsertDB ---");

		SqlSession ss = sql.openSession();
		int result = ss.insert("purchaseInsert", purchase);
		
		ss.commit();
		ss.close();
	}
}
