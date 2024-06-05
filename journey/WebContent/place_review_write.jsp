<%@page import="com.jj.dto.Eatery"%>
<%@page import="com.jj.dto.Place"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	request.setCharacterEncoding("utf-8");
	String u_id = (String) session.getAttribute("u_id");	
	String place_id = (String)request.getParameter("place_id");
	
	System.out.println(place_id);
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
	
	/* 필수입력 값 검사 */
	function regist(){
		if(lrForm.place_select.value ==''){
			alert("장소를 선택해주세요.");
			return false;
		}else if(lrForm.starRating.value == ''){
			alert("별점을 선택해주세요.");
			return false;
		}else if(lrForm.contents.value == ''){
			alert("리뷰를 작성해주세요.");
			lrForm.contents.focus();
			return false;
		}else{
			alert("리뷰가 등록되었습니다.");
		}
	}
	
	/* 취소버튼 */
	function cancel(){
		history.back();
	}
	
	/* 장소검색 */
 	function search(){
		var search = $('input[name=search_place]').val();
		
		$.ajax({
			url : "place_search.jj?page=lr_place_search",
			data :{"search": search},
			success : function(re){
				$(".place_list").html(re);
			}
		});
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
		<div id="write_div">
			<form name="lrForm" action="placeReview_insert.jsp" method="post" onsubmit="return regist()" enctype="multipart/form-data">
				<div class="place_select">
					<p>어디를 다녀오셨나요?</p>
					<input type="text" name="search_place" placeholder="장소 검색">
					<img src='img/icon/search_btn.png' onclick="search()">
				</div>
				<div class="place_list">
					<jsp:useBean id="selectPlace" class="com.jj.dao.Review">
						<select name='place_select'>
							<option value=''>장소 선택</option>
						<%
							ArrayList<Place> placeList;
							ArrayList<Eatery> eatList;
							
							String search = "";

							placeList = selectPlace.select_place(search);
							eatList = selectPlace.select_eat(search);
							
							for(Place p : placeList){
								if(place_id != null && place_id.equals(p.getPlac_id())){%>
									<option value="<%=p.getPlac_no()%>" selected><%=p.getPlac_name() %></option>
								<%}else{%>
									<option value="<%=p.getPlac_no()%>"><%=p.getPlac_name() %></option>
								<%}%>
								
							<%}
							for(Eatery e : eatList){
								if(place_id != null && place_id.equals(e.getEat_id())){%>
									<option value="<%=e.getEat_no() %>" selected><%=e.getEat_name() %></option>
								<%}else{%>
									<option value="<%=e.getEat_no() %>"><%=e.getEat_name() %></option>
								<%}%>
							<%}%> 
							</select>
					</jsp:useBean>
				</div>
				<div class ="star_area">
					<p>별점을 선택해주세요!</p>
					<div class="star-rating">
				    <input type="radio" class="star" name="starRating" value="1">
				    <input type="radio" class="star" name="starRating" value="2">
				    <input type="radio" class="star" name="starRating" value="3">
				    <input type="radio" class="star" name="starRating" value="4">
				    <input type="radio" class="star" name="starRating" value="5">
				</div>
				</div>
				
				<hr>
				<div>
					<textarea name="contents" maxlength="600" cols="70" placeholder="솔직한 리뷰를 남겨주세요. (300자 이내)"></textarea>
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
				
				<div id="buttonArea">
					<input type='button' value='취소' onclick="cancel()">
					<input type='submit' value='등록'>
				</div>
			</form>
		</div>
	</section>
	<jsp:include page="main_footer.jsp" />
</body>
</html>