package com.jj.conn;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Package_like;
public class LikeSelectDB {
	
	static LikeSelectDB selectDB = new LikeSelectDB();
	
	public static LikeSelectDB select() {
		return selectDB;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public List<Package_like> selectLike(){
		System.out.println("--- conn/likeListSelectDB ---");
		
		SqlSession ss = sql.openSession();
		List<Package_like> likeList = ss.selectList("likeSelect");
		ss.close();
		
		return likeList;
	}
	
	public Package_like selectDetailLike(int p_no, String u_id) {
		System.out.println("--- conn/likeSelectDB ---");
		
		Package_like pl = new Package_like();
		pl.setP_no(p_no);
		pl.setU_id(u_id);
		
		SqlSession ss = sql.openSession();
		Package_like like = ss.selectOne("likeSelectDetail", pl);
		ss.close();
		
		return like;	
	}

}
