package com.jj.conn;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Reward;

public class RewardInsertDB {
	
	static RewardInsertDB insertDB = new RewardInsertDB();
	
	public static RewardInsertDB insert() {
		return insertDB;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public void insertReward(Reward reward) {
		
		System.out.println("--- conn/rewardInsertDB ---");
		SqlSession ss = sql.openSession();
		int result = ss.insert("rewardInsert", reward);
		
		ss.commit();
		ss.close();
	}
}
