package com.jj.conn;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Purchase;

public class PurchaseSelectDB {
	
	static PurchaseSelectDB selectDB = new PurchaseSelectDB();
	
	public static PurchaseSelectDB select() {
		return selectDB;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public Purchase selectPur(int p_no, String u_id){
		
		System.out.println("--- conn/purchaseSelectDB ---");
		
		Purchase p = new Purchase();
		p.setP_no(p_no);
		p.setU_id(u_id);
		
		SqlSession ss = sql.openSession();
		Purchase purchase = ss.selectOne("purchaseSelect", p);
		ss.close();
		
		return purchase;
	}

}
