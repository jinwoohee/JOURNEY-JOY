package com.jj.conn;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Package;

public class PackageSearchDB {

	static PackageSearchDB selectDB = new PackageSearchDB();
	
	public static PackageSearchDB select() {
		return selectDB;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public List<Package> selectPackage(String param){
		System.out.println("--- conn/packageSearchDB ---");

		SqlSession ss = sql.openSession();
		List<Package> pkList = ss.selectList("packageSearch", param);
		
		ss.close();
		
		return pkList;
	}
}
