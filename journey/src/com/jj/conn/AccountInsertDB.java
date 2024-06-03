package com.jj.conn;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Account;

public class AccountInsertDB {
	static AccountInsertDB idb = new AccountInsertDB();
	
	public static AccountInsertDB indb() {
		return idb; 
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public void insertMth(int e_no, int acc_day, int acc_order, int acc_amount, String acc_payment, String acc_contents, String acc_category, String acc_curr) {
		System.out.println("db들어옴");
		Account dto = new Account();
		dto.setE_no(e_no);
		dto.setAcc_day(acc_day);
		dto.setAcc_order(acc_order);
		dto.setAcc_amount(acc_amount);
		dto.setAcc_payment(acc_payment);
		dto.setAcc_contents(acc_contents);
		dto.setAcc_category(acc_category);
		dto.setAcc_currency(acc_curr);
		
		SqlSession sqls = sql.openSession();
			
		int i = sqls.insert("account_insert", dto);
		System.out.println("acc_is_db 나가기");
		sqls.commit();
		sqls.close();
		
	}
}
