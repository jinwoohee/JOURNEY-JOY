package com.jj.conn;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Product;

public class ProductSelectDB {
	static ProductSelectDB prod_sel = new ProductSelectDB();
	
	public static ProductSelectDB seldb() {
		return prod_sel;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public List<Product> selectMth(String e_destination) {	
		SqlSession sqls = sql.openSession();	
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("e_destination", e_destination);
		
		List<Product> prodList = sqls.selectList("product_select",param);
		sqls.close();

		return prodList ;
	}
}
