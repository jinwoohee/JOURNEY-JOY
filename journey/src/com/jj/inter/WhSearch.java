package com.jj.inter;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.WhSearchDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Company;

public class WhSearch implements JourneyInterface {
	static WhSearch sch = new WhSearch();
	
	public static WhSearch whsearch() {
		return sch;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String txt = request.getParameter("txt");
		//System.out.println(txt);
		
		String[] data = txt.split("삭제");
		//System.out.println(Arrays.toString(data));
		
		HashMap<String, ArrayList<String>> map = new HashMap<String, ArrayList<String>>();
		ArrayList<String> alist = new ArrayList<String>();
		String key = "";
		
		for (String s : data) {
			//System.out.println(s);
			String[] word = s.split("-");
			//System.out.println(Arrays.toString(word));
			
			key = word[1];
			String value = word[0];
			//value.replaceAll("\\[", "").replaceAll("\\]", "");
			if (word[0].contains(">")) {
				String[] str = word[0].split(">");
				value = str[1];
				
			}
			
			if (map.containsKey(key)) {
				alist = map.get(key);
				alist.add(value);
			} else {
				alist.add(value);
			}
			
			map.put(key, alist);
		}
		
		if (key.equals("com_work_day")) {
			String ss = "";
			for (String str : alist) {
				ss += str + ",";
			}
			System.out.println(ss);
			ss = ss.replaceAll(",$", "");
			System.out.println(ss);
			alist.clear();
			alist.add(ss);
		}
		
		
		//System.out.println(map.get("com_work_days"));
		//System.out.println(map.get("com_work_day"));
		
		for (String k : map.keySet()) {
			//System.out.println(key);
		}
		
		WhSearchDB schdb = new WhSearchDB();
		List<Company> list = schdb.select(map);
		request.setAttribute("list", list);
		
		return "wh_list_form.jsp";
	}
	
}
