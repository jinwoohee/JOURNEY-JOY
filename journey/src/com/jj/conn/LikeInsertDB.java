package com.jj.conn;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Package_like;

public class LikeInsertDB {
	
	static LikeInsertDB insertDB = new LikeInsertDB();
	
	public static LikeInsertDB insert() {
		return insertDB;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public void insertLike(Package_like like) {

		System.out.println("--- conn/likeInsertDB ---");
		SqlSession ss = sql.openSession();
		int result = ss.insert("likeInsert", like);
		
		ss.commit();
		ss.close();

	}

}
