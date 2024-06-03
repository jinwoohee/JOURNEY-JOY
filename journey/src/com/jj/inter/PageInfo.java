package com.jj.inter;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.ClassListSelectDB;
import com.jj.conn.LikeSelectDB;
import com.jj.conn.PageInfoDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Board;
import com.jj.dto.Class_list;
import com.jj.dto.Estimate;
import com.jj.dto.Package_like;

public class PageInfo implements JourneyInterface {

	static PageInfo pageSelect = new PageInfo();

	public static PageInfo pageInfoSelect() {
		return pageSelect;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {

		PageInfoDB selectPageCount = new PageInfoDB();

		int page = 1; // 현재페이지
		int limit = 0; // 최대페이지
		String returnPage = null;
		String table = request.getParameter("table"); // pageInfo select할 테이블

		/* 넘어오는 페이지 값 */
		if (request.getParameter("nowPage") != null) {
			page = Integer.parseInt(request.getParameter("nowPage"));
		}

		/* 페이지 별 limit 갯수 */
		if (request.getParameter("table").equals("package")) { // 패키지
			limit = 8;
			returnPage = "package_list.jsp";

			//패키지 전체
			ArrayList<com.jj.dto.Package> pkList = selectPageCount.getPackageList(page, limit);
			request.setAttribute("pkList", pkList);
			
			//좋아요
			LikeSelectDB selectLike = LikeSelectDB.select();
			List<Package_like> likeList = selectLike.selectLike();
			request.setAttribute("likeList", likeList);
		}else if(request.getParameter("table").equals("class_list")) { //모임
			limit = 10;
			returnPage ="classList.jsp";
			
			/* 모임 전체 */
			ClassListSelectDB selectDB = new ClassListSelectDB();
			
			ArrayList<Class_list> clist = selectPageCount.getClassList(page, limit);
			request.setAttribute("clist", clist);
			
			/* 견적 select > 여행중인 도시확인 */
			ArrayList<Estimate> elist = selectDB.selectEstimate(request.getParameter("u_id"));
			request.setAttribute("elist", elist);
		}

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

		return returnPage;
	}
}
