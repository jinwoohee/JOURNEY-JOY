package com.jj.conn;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Package;

public class PackageDetailDB {
	
	static PackageDetailDB selectDB = new PackageDetailDB();
	
	public static PackageDetailDB select() {
		return selectDB;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public Package selectPackageDetail(int p_no){
		
		System.out.println("--- conn/packageDetailSelectDB ---");
		
		SqlSession ss = sql.openSession();
		Package pkDetail = ss.selectOne("packageDetailSelect", p_no);
		ss.close();
		
		return pkDetail;
	}
	
}
