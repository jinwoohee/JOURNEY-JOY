package com.jj.conn;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Package_like;

public class LikeDeleteDB {
	
	static LikeDeleteDB deleteDB = new LikeDeleteDB();
	
	public static LikeDeleteDB delete() {
		return deleteDB;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public void deleteLike(Package_like like) {

		System.out.println("--- conn/likeDeleteDB ---");
		SqlSession ss = sql.openSession();
		int result = ss.insert("likedelete", like);
		
		ss.commit();
		ss.close();
	}
}
