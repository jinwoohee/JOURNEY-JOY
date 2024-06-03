package com.jj.conn;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Account;
import com.jj.dto.Schedule;

public class AccountSelectDB {
	static AccountSelectDB acc_sel = new AccountSelectDB();
	
	public static AccountSelectDB seldb() {
		return acc_sel;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public List<Account> selmtd(int e_no) {	
		SqlSession sqls = sql.openSession();	
		
		List<Account> accList = sqls.selectList("account_select",e_no);
		sqls.close();
		System.out.println("가계부:"+accList.size());
		return accList;
	}
}
