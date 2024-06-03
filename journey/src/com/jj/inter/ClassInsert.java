package com.jj.inter;

import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.ClassInsertDB;
import com.jj.conn.ClassListSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Class_list;
import com.jj.dto.Estimate;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class ClassInsert implements JourneyInterface{
	
	static ClassInsert cInsert = new ClassInsert();
	
	public static ClassInsert classInsert() {
		return cInsert;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("--- inter/classInsert ---");
		
		ClassInsertDB insertDB = new ClassInsertDB();
		
		/*첨부파일*/
		String realFolder="";
		String saveFolder="/uploadFile";
		int fileSize=10*1024*1024;
		ServletContext context = request.getServletContext();
		realFolder=context.getRealPath(saveFolder);   		
		MultipartRequest multi=new MultipartRequest(request,realFolder,fileSize,"UTF-8",new DefaultFileRenamePolicy());
		
		Class_list cl = new Class_list();
		cl.setU_id(multi.getParameter("u_id"));
		cl.setC_nation("*");
		//cl.setC_nation(request.getParameter("")); > plan에서 내가 여행중인 국가 값 가져오기
		
		cl.setC_city(multi.getParameter("city"));
		cl.setC_title(multi.getParameter("title"));
		cl.setC_contents(multi.getParameter("contents"));
		
		/* 첨부파일 */
		if(multi.getParameter("file") == "") {
			cl.setC_file1("img/travel/travel18.jpg"); //썸네일 기본이미지 넣기
		}else {
			cl.setC_file1(multi.getOriginalFileName((String)multi.getFileNames().nextElement()));
		}
		
		cl.setC_volume(Integer.parseInt(multi.getParameter("volumn")));
		
		
		/*금액 ,*/
		String fee = multi.getParameter("charge");
		String classFee = fee.replaceAll(",", "");
		
		cl.setC_charge(Integer.parseInt(classFee));
		cl.setC_end_date(multi.getParameter("endDt"));
		cl.setC_url(request.getRequestURI());
		
		insertDB.insertClass(cl);

		return "classList.jj?page=clist";
	}

}
