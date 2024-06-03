package com.jj.inter;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.LikeSelectDB;
import com.jj.conn.PackageSelectDB;
import com.jj.conn.PageInfoDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Package_like;
import com.jj.dto.Package;

public class PackageSelect implements JourneyInterface{
	
	static PackageSelect pSelect = new PackageSelect();
	
	public static PackageSelect packageSelectInter() {
		return pSelect;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		/* 페이징 */
		PageInfoDB selectPageCount = new PageInfoDB();
		int page=1;
		int limit = 8;
		String table = "package";
		
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
		
		/* 패키지 전체 */
		PackageSelectDB selectPackage = PackageSelectDB.select();
		List<Package> pkList = selectPackage.selectPackage();
		request.setAttribute("pkList", pkList);
		
		/* 좋아요 */
		LikeSelectDB selectLike = LikeSelectDB.select();
		List<Package_like> likeList = selectLike.selectLike();
		request.setAttribute("likeList", likeList);
		

		return "package_list.jsp";
	}
}
