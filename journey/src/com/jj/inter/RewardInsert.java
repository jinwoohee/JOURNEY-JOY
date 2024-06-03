package com.jj.inter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.RewardInsertDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Reward;

public class RewardInsert implements JourneyInterface{
	
	static RewardInsert rInsert = new RewardInsert();
	
	public static RewardInsert rewardInsert() {
		return rInsert;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		System.out.println("--- inter/RewardInsert ---");
		
		RewardInsertDB insertDB = RewardInsertDB.insert();
		
		Reward reward = new Reward();
		String adultFee = request.getParameter("adult");
		String adult = adultFee.replaceAll(",", "");
		String stdFee = request.getParameter("std");
		String std = stdFee.replaceAll(",", "");
		String childFee = request.getParameter("child");
		String child = childFee.replaceAll(",", "");
		
		reward.setP_no(Integer.parseInt(request.getParameter("p_no")));
		reward.setAdult_fee(Integer.parseInt(adult));
		reward.setStd_fee(Integer.parseInt(std));
		reward.setChild_fee(Integer.parseInt(child));
		
		insertDB.insertReward(reward);
	
		return "package_list.jj?page=packageSelect";
	}

	
}
