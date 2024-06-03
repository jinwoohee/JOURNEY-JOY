package com.jj.conn;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Package;

public class PackageSelectDB {
	
	static PackageSelectDB selectDB = new PackageSelectDB();
	
	public static PackageSelectDB select() {
		return selectDB;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public List<Package> selectPackage(){
		System.out.println("--- conn/packageSelectDB ---");
		
		SqlSession ss = sql.openSession();
		List<Package> pkList = ss.selectList("packageSelect");
		ss.close();
		
		return pkList;
		
	}

}
