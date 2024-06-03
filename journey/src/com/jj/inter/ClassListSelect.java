package com.jj.inter;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.ClassListSelectDB;
import com.jj.conn.PageInfoDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Class_list;
import com.jj.dto.Estimate;

public class ClassListSelect implements JourneyInterface {
	static ClassListSelect cSelect = new ClassListSelect();
	
	public static ClassListSelect classlistselect() {
		return cSelect;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		/* 페이징 */
		PageInfoDB selectPageCount = new PageInfoDB();
		int page=1;
		int limit = 10;
		String table = "class_list";
		
		int listCount = selectPageCount.getPageListCount(table);
		
		int maxPage=(int)((double)listCount/limit+0.95);
		int startPage = (((int) ((double)page / 10 + 0.9)) - 1) * 10 + 1;
   	    int endPage = startPage+10-1;
   	    
   	    if(endPage > maxPage) {
   	    	endPage = maxPage;
   	    }
   	    
   	    com.jj.dto.PageInfo pageInfo = new com.jj.dto.PageInfo();
	    pageInfo.setListCount(listCount);
	    pageInfo.setPage(page);
	    pageInfo.setMaxPage(maxPage);
	    pageInfo.setStartPage(startPage);
	    pageInfo.setEndPage(endPage);
	    
	    request.setAttribute("pageInfo", pageInfo);

	    /* 모임 전체 */
		ClassListSelectDB selectDB = new ClassListSelectDB();
		
		ArrayList<Class_list> clist = selectDB.selectClass();
		request.setAttribute("clist", clist);
		
		/* 견적 select > 여행중인 도시확인 */
		ArrayList<Estimate> elist = selectDB.selectEstimate(request.getParameter("u_id"));
		request.setAttribute("elist", elist);
		
		return "classList.jsp";
	}
	
	
}
