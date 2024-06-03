package com.jj.conn;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;

public class AccountDeleteDB {
	static AccountDeleteDB del_db = new AccountDeleteDB();
	
	public static AccountDeleteDB deldb() {
		return del_db; 
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public void deleteMth(int e_no) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("e_no", e_no);
		
		SqlSession sqls = sql.openSession();
			
		int i = sqls.delete("account_delete", param);
		
		sqls.commit();
		sqls.close();
	}
}
