<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int p_no = (int)session.getAttribute("p_no");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="css/package_reward.css">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
</head>
<script>
	$(function(){
		/* 천단위 콤마찍기*/
		$('input[type=text]').keyup(function(){
			$(this).val($(this).val().replace(/\,/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		})
	});
	
	function regist(){
		if(rForm.adult.value == '' && rForm.std.value == '' && rForm.child.value == ''){
			alert('값을 입력해주세요.');
			return false;
		}else{
			alert('등록되었습니다.');
		}
	}
</script>
<body>
	<jsp:include page="main_header.jsp" />
		<section id="main_section">
			<div>
			
				<div>
					<p>상품 금액 등록</p>
				</div>
				<form name='rForm' method='post' action='reward.jj?page=rewardInsert' onsubmit='return regist()'>
					<input type="hidden" name="p_no" value="<%=p_no%>">
					<table id="rewardTable">
						<tr><td>성인</td></tr>
						<tr>
							<td>
								<input type="text" name="adult" size="20" placeholder=" 성인 요금 입력" onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');">
							</td>
						</tr>
						<tr><td>아동</td></tr>
						<tr>
							<td>
								<input type="text" name="std" size="20" placeholder=" 아동 요금 입력" onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');">
							</td>
						</tr>
						<tr><td>유아</td></tr>
						<tr>
							<td>
								<input type="text" name="child" size="20" placeholder=" 유아 요금 입력" onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');">
							</td>
						</tr>
					</table>
					<div id="buttonArea">
						<input type="submit" name="register" value="등록하기">
					</div>
				</form>
			</div>
		</section>
	<jsp:include page="main_footer.jsp" />
</body>
</html>