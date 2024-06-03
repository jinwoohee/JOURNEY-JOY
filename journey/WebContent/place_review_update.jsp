<%@page import="com.jj.dto.Location_review"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	request.setCharacterEncoding("utf-8");
	String u_id = (String) session.getAttribute("u_id");
	int lr_no = Integer.parseInt(request.getParameter("lr_no"));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장소리뷰 작성</title>

	<!-- css -->
	<link rel="stylesheet" type="text/css" href="css/place_review_write.css">

	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	
</head>
<script>
	function regist(){
		if(lrForm.starRating.value == ''){
			alert("별점을 선택해주세요.");
			return false;
		}else if(lrForm.contents.value == ''){
			alert("리뷰를 작성해주세요.");
			lrForm.contents.focus();
			return false;
		}else{
			alert("리뷰가 수정되었습니다.");
		}
	}
	
	function cancel(){
		history.back();
	}
	
	/* 첨부파일 */
	function upload(num){ //버튼 클릭시 input type=file 실행
 		$('input[name=file'+num+']').click();
 	}	
	
	/* 이미지 등록 후 미리보기 */
	function readURL(num){
		var img = new Image();
		img.src = '';
		
		const file = event.target.files;
		var imgTempUrl = window.URL.createObjectURL(file[0]);
		
		img.src = imgTempUrl;
		$('#preview'+num+'').append(img);
		$('input[name=upload_btn'+num+']').hide();
		$('input[name=del_btn'+num+']').show();
	}
	
	/* 첨부파일 삭제 버튼 */
	function del(num){
		$('input[name=file'+num+']').val("");
		$('#preview'+num+' > img').remove();
		$('input[name=upload_btn'+num+']').show();
		$('input[name=del_btn'+num+']').hide();
	}

</script>
<body>
	<jsp:include page="main_header.jsp" />
	<section>
	<jsp:useBean id="place" class="com.jj.dao.Review">
		<div id="write_div">
			<form name="lrForm" action="placeReview_update.jsp" method="post" onsubmit="return regist()" enctype="multipart/form-data">
			<%
				ArrayList<Location_review> lrList = place.select_placeReview(lr_no);
				for(Location_review lr : lrList){
					
					if(lr.getEat_name() == null){
						out.println("<p>"+lr.getPlac_name()+"</p>");
					}else{
						out.println("<p>"+lr.getEat_name()+"</p>");
					}%>
					
					<div class='star-rating'>
					<p>별점을 선택해주세요!</p>
					
				<%	for(int i=1; i<6; i++){
						out.println("<input type='radio' class='star' name='starRating' value='"+i+"'>");
					}%>
					</div>
					
					<hr>
					
					<div>
						<textarea name='contents' maxlength=1000 cols=70 placeholder='솔직한 리뷰를 남겨주세요. (500자 이내)'><%= lr.getLr_contents() %></textarea>
					</div>
					
					<div id="file">
					<div>
						<div id='thumnail1'>
							<div id='preview1'></div>
							<input type="button" name="upload_btn1" value="+" onclick="upload(1)">
							<input type="file" name="file1" accept=".jpg, .png, .gif" onchange="readURL(1)">
							<input type="button" name="del_btn1" value="-" onclick="del(1)">
						</div>
						<div id='thumnail2'>
							<div id='preview2'></div>
							<input type="button" name="upload_btn2" value="+" onclick="upload(2)">
							<input type="file" name="file2" accept=".jpg, .png, .gif" onchange="readURL(2)">
							<input type="button" name="del_btn2" value="-" onclick="del(2)">
						</div>
						<div id='thumnail3'>
							<div id='preview3'></div>
							<input type="button" name="upload_btn3" value="+" onclick="upload(3)">
							<input type="file" name="file3" accept=".jpg, .png, .gif" onchange="readURL(3)">	
							<input type="button" name="del_btn3" value="-" onclick="del(3)">	
						</div>
					</div>
				</div>
				<%}%>
				<div id="buttonArea">
					<input type='hidden' name='lr_no' value="<%=lr_no%>">
					<input type='button' value='취소' onclick="cancel()">
					<input type='submit' value='등록'>
				</div>
			</form>
		</div>
	</jsp:useBean>
	</section>		
	<jsp:include page="main_footer.jsp" />
</body>
</html>