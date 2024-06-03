package com.jj.inter;

import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.jj.conn.PackageInsertDB;
import com.jj.conn.PackagePlaceSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Eatery;
import com.jj.dto.Place;

public class PackageInsert implements JourneyInterface {

	static PackageInsert pInsert = new PackageInsert();

	public static PackageInsert packageInsertinter() {
		return pInsert;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("--- inter/packageInsert ---");

		PackageInsertDB insertDB = PackageInsertDB.insert();
		
		/*첨부파일*/
		String realFolder="";
		String saveFolder="/uploadFile";
		int fileSize=10*1024*1024;
		ServletContext context = request.getServletContext();
		realFolder=context.getRealPath(saveFolder);   		
		MultipartRequest multi=new MultipartRequest(request,realFolder,fileSize,"UTF-8",new DefaultFileRenamePolicy());
		
		com.jj.dto.Package pk = new com.jj.dto.Package();
		pk.setU_id(multi.getParameter("u_id"));
		pk.setP_nation(multi.getParameter("nation"));
		
		String city1 = multi.getParameter("city_japan");
		String city2 = multi.getParameter("city_canada");
		String city3 = multi.getParameter("city_philippines");
		String city4 = multi.getParameter("city_america");
		String city5 = multi.getParameter("city_australia");
		String city6 = multi.getParameter("city_newzealand");
		String city7 = multi.getParameter("city_china");
		String selectCity = null;
		
		if(!city1.equals("choice")) {
			pk.setP_city(multi.getParameter("city_japan"));
			selectCity = multi.getParameter("city_japan");
		}else if(!city2.equals("choice")){
			pk.setP_city(multi.getParameter("city_canada"));
			selectCity = multi.getParameter("city_canada");
		}else if(!city3.equals("choice")) {
			pk.setP_city(multi.getParameter("city_philippines"));
			selectCity = multi.getParameter("city_philippines");
		}else if(!city4.equals("choice")) {
			pk.setP_city(multi.getParameter("city_america"));
			selectCity = multi.getParameter("city_america");
		}else if(!city5.equals("choice")) {
			pk.setP_city(multi.getParameter("city_australia"));
			selectCity = multi.getParameter("city_australia");
		}else if(!city6.equals("choice")) {
			pk.setP_city(multi.getParameter("city_newzealand"));
			selectCity = multi.getParameter("city_newzealand");
		}else if(!city7.equals("choice")) {
			pk.setP_city(multi.getParameter("city_china"));
			selectCity = multi.getParameter("city_china");
		}
		
		pk.setP_theme(multi.getParameter("theme"));
		pk.setP_title(multi.getParameter("title"));
		pk.setP_start_date(multi.getParameter("startDt"));
		pk.setP_end_date(multi.getParameter("endDt"));
		pk.setP_volume(Integer.parseInt(multi.getParameter("volumn")));
		pk.setP_due_date(multi.getParameter("dueDt"));
		
		String pay = multi.getParameter("guide");
		String guidePay = pay.replaceAll(",", "");
		pk.setP_guide_pay(Integer.parseInt(guidePay));

		/* 첨부파일 */
		if (multi.getParameter("file") == "") {
			pk.setP_file("img/travel/travel.jpg");//썸네일 기본이미지 넣기
		} else {
			pk.setP_file(multi.getOriginalFileName((String)multi.getFileNames().nextElement()));
		}
		pk.setP_notification(multi.getParameter("notice"));
		pk.setP_url(request.getRequestURI()); // 현재페이지 URL > 나중에 뒤에 ?페이지번호 붙이기
		
		HashMap<String, Object> param = insertDB.insertPackage(pk);
		
		//장소select
		PackagePlaceSelectDB selectPlace = PackagePlaceSelectDB.select();
		
		List<Place> placeList = selectPlace.selectPlace(selectCity);
		List<Eatery> eatList = selectPlace.selectEatery(selectCity);
		
		request.setAttribute("placeList", placeList);
		request.setAttribute("eatList", eatList);
		
		return "package_schedule.jsp?p_no="+param.get("p_no")+"&p_period="+param.get("p_period")+"&p_city="+param.get("p_city");
	}
}
