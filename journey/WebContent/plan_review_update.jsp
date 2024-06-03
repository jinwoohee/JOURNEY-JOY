<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.jj.dto.Day_review"%>
<%@page import="com.jj.dto.Plan_review"%>
<%@page import="java.util.ArrayList"%>

<jsp:useBean id="dao" class="com.jj.dao.Plan_review" >
<%
	request.setCharacterEncoding("utf-8");
	Plan_review pr = new Plan_review();
	Day_review dr = new Day_review();
	
	/* 첨부파일 */
	String uploadPath=request.getRealPath("/uploadFile");
	
	int size = 10*1024*1024;
	String name="";
	String subject="";
	String file_name="";
	String ori_file_name="";
	
	HashMap map = new HashMap();
	
	try{
		MultipartRequest multi=new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
		
		//일정리뷰
		pr.setPr_no(Integer.parseInt(multi.getParameter("page_no")));
		pr.setU_id((String) session.getAttribute("u_id"));
		pr.setE_no(Integer.parseInt(multi.getParameter("e_no")));
		pr.setPr_title(multi.getParameter("title"));
		pr.setPr_contents(multi.getParameter("content"));
		
		//일정리뷰 > day_review
		int sche = Integer.parseInt(multi.getParameter("sche_day"));
		for(int i=0; i<sche; i++){
			dr = new Day_review();
			
			dr.setPr_no(Integer.parseInt(multi.getParameter("page_no")));
			dr.setDr_day((i+1));
			dr.setDr_contents(multi.getParameter("day_review"+(i+1)));
			
			/* 데이리뷰 등록*/
			dao.update_day_review(dr.getPr_no(), dr.getDr_day(), dr.getDr_contents());
		}
		
		
		/* 첨부파일 */
		Enumeration files=multi.getFileNames();
		
		while(files.hasMoreElements()){
			String file1 =(String)files.nextElement();  //파일을 문자열로 바꿈
			file_name=multi.getFilesystemName(file1); //사용자가 인식하는 파일명 
			ori_file_name= multi.getOriginalFileName(file1); //실제 서버안에 들어간 파일명(저장되는파일명)
			
			if(file_name == null){
				map.put(file1, "bg1.jpg"); //기본이미지
			}else{
				map.put(file1, ori_file_name);
			}
		}
		
			pr.setPr_file(map.get("file1").toString());
			pr.setPr_file2(map.get("file2").toString());
			pr.setPr_file3(map.get("file3").toString());
			
			dao.update_plan_review(pr.getPr_no(), pr.getPr_title(), pr.getPr_contents(), pr.getPr_file(), pr.getPr_file2(), pr.getPr_file3());
			response.sendRedirect("plan_review_list.jsp");
		}catch(Exception e){
			e.printStackTrace();
		}
	%>
</jsp:useBean>
	

