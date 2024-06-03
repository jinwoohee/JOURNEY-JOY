<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.jj.dto.Location_review"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
    
<% 
	request.setCharacterEncoding("utf-8");
	String u_id = (String) session.getAttribute("u_id");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="place" class="com.jj.dao.Review">
		<%
			//update
			request.setCharacterEncoding("utf-8");
			Location_review lr = new Location_review();
			
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
			
				lr.setU_id(u_id);
				lr.setLr_no(Integer.parseInt(multi.getParameter("lr_no")));
				lr.setLr_contents(multi.getParameter("contents"));
				
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

				lr.setLr_file1(map.get("file1").toString());
				lr.setLr_file2(map.get("file2").toString());
				lr.setLr_file3(map.get("file3").toString());

				lr.setLr_star(Integer.parseInt(multi.getParameter("starRating")));
				
				place.update_placeReview(lr.getU_id(), lr.getLr_no(), lr.getLr_contents(), lr.getLr_file1(), lr.getLr_file2(), lr.getLr_file3(), lr.getLr_star());
				
				response.sendRedirect("place_review.jsp");
				
			}catch(Exception e){
				e.printStackTrace();
			}

		%>
	</jsp:useBean>
</body>
</html>