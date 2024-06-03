package com.jj.inter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.PsInsertDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Package_schedule;

public class PsInsert implements JourneyInterface{
	
	static PsInsert psInsert = new PsInsert();
	
	public static PsInsert scheduleInsertinter() {
		return psInsert;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("--- inter/package_scheduleInsert ---");
		
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8"); 
		
		HashMap a=(HashMap)request.getAttribute("map");
		Iterator<String> keys =a.keySet().iterator();
		String key = null;
		Package_schedule ps = null;
		
		HashMap<String, ArrayList<Package_schedule>> psMap = new HashMap<String, ArrayList<Package_schedule>>();
		ArrayList<Package_schedule> psList = new ArrayList<Package_schedule>();
		while(keys.hasNext()) {
			key = keys.next();
			ps = (Package_schedule)a.get(key);
			psList.add(ps);
			psMap.put("package_schedule", psList);
		}
		
		PsInsertDB psInsertDB = PsInsertDB.insert();
		psInsertDB.insertSchedule(psMap);
		
		return "package_reward.jsp";
	}
	
}
