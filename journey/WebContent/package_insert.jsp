<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<% 
	request.setCharacterEncoding("utf-8");
	String u_id = (String) session.getAttribute("u_id");	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JOURNEY JOY::패키지 여행::</title>

	<!-- css -->
	<link rel="stylesheet" type="text/css" href="css/packagePlan.css">
	
	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	
	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

</head>
<script>
	$(function(){
		/* 선택한 나라에 따라서 도시선택*/
		$('select[name*=city]').hide();
		
		$('select[name=nation]').change(function(){
			
			var cities = ["japan", "canada", "philippines", "america", "australia", "newzealand", "china"];
			
			for(var i=0; i<cities.length; i++){
				if($('select[name=nation]').val() == cities[i]){
					$('#'+$('select[name=nation]').val()+'').show();
					$('select[name*=city]').not($('#'+$('select[name=nation]').val()+'')).hide();
				}
			}
		});


		/* 날짜 */
		$("#startDt, #dueDt").datepicker({
			dateFormat: 'yy-mm-dd' //달력 날짜 형태
			,minDate:0
			,nextText : ">"
			,prevText : "<"
			,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
			,showMonthAfterYear:true //년도 - 월 순서
			,changeYear: true //년 선택 가능
            ,changeMonth: true //월 선택 가능
            ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
            ,minDate : 0 //선택할수있는 최소날짜(0:오늘 이전날짜 선택 불가)
            ,onClose:function(selectedDate){ //startDt 닫힐때 endDt 선택가능한 최소날짜가 시작일로 지정
            	$("#endDt").datepicker("option", "minDate", selectedDate);
            }

		});

		$("#endDt").datepicker({
			dateFormat: 'yy-mm-dd' //달력 날짜 형태
			,minDate:0
			,nextText : ">"
			,prevText : "<"
			,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
			,showMonthAfterYear:true //년도 - 월 순서
			,changeYear: true //년 선택 가능
            ,changeMonth: true //월 선택 가능
            ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
		});
		
		
		
		/* 썸네일 버튼클릭->파일업로드 */
		$("#fileBtn").click(function (e) {
			$('input[type=file]').click();
		});


		/* 버튼 mouseenter/mouseleave */
		$('input[type=button]').mouseenter(function(){
			if($(this).attr('id') == 'fileBtn'){
				$(this).css({'box-shadow':'inset 5px 5px 10px #000054'});
			}else{
				$(this).css({'box-shadow':'inset 5px 5px 10px #CCCCCC'});
			}
			
		});

		$('input[type=button]').mouseleave(function(){
			$(this).css({'box-shadow':'none'});
		});

		/* 썸네일 등록 후 이미지 미리보기 */
		var img = new Image();
		img.src = '';

		$('input[type=file]').change(function(event){
			const file = event.target.files;
			var imgTempUrl = window.URL.createObjectURL(file[0]);

			img.src = imgTempUrl;
			$('#preview').append(img);
		});
		
		/* 썸네일 삭제버튼 */
		$('#delBtn').click(function(){
			$('input[type=file]').val("");
			$('#preview > img').remove();
		});
		
		//천단위 콤마 
		$("input[name=guide]").keyup(function(){
			$(this).val($(this).val().replace(/[^0-9.]/g,'').replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		});
		
		//숫자입력값 확인
		$("input[name=volumn]").keyup(function(){
			$(this).val($(this).val().replace(/[^0-9.]/g,''));
		});
	})
	
	function regist(){
		if(pForm.nation.value == 'nation_choice'){
			alert("국가를 선택해주세요.");
			return false;
		}else if(pForm.theme.value == 'choice'){
			alert("테마를 선택해주세요.");
			return false;
		}else if(pForm.city.value == 'choice'){
			alert("도시를 선택해주세요.");
			return false;
		}else if(pForm.title.value == ''){
			alert("제목을 작성해주세요.");
			return false;
		}else if(pForm.startDt.value == '' || pForm.endDt.value == ''){
			alert("여행기간을 선택해주세요.");
			return false;
		}else if(pForm.volumn.value == '' || pForm.volumn.value < 3){
			alert("여행최소인원을 작성해주세요.(3명이상)");
			return false;
		}else if(pForm.dueDt.value == ''){
			alert("신청 마감 날짜를 선택해주세요.");
			return false;
		}else if(pForm.guide.value == ''){
			alert("가이드 비용을 작성해주세요.");
			return false;
		}else{
			alert("패키지 여행이 등록되었습니다. 일정을 등록해주세요.");
		}
	}
</script>
<body>
	<jsp:include page="main_header.jsp" />
	
	<section id="main_section">
		<div>
			<form name="pForm" action="packageInsert.jj?page=packageInsert" method="post" onsubmit="return regist()" enctype="multipart/form-data">
				<table id="packageTable">
					<tr><td>국가 및 도시</td></tr>
					<tr>
						<td>
							<select name="nation">
					    		<option value="choice">국가</option>
					    		<option value="japan">일본</option>
					    		<option value="canada">캐나다</option>
					    		<option value="philippines">필리핀</option>
					    		<option value="america">미국</option>
					    		<option value="australia">호주</option>
					    		<option value="newzealand">뉴질랜드</option>
					    		<option value="china">중국</option>
						  	</select>
						  	<select name="city_japan" id="japan">
					    		<option value="choice">도시</option>
					    		<option value="tokyo">도쿄</option>
					    		<option value="osaka">오사카</option>
					    		<option value="fukuoka">후쿠오카</option>
					    		<option value="kyoto">교토</option>
					    		<option value="nagoya">나고야</option>
						  	</select>
						  	<select name="city_canada" id="canada">
					    		<option value="choice">도시</option>
					    		<option value="vancouver">벤쿠버</option>
					    		<option value="toronto">토론토</option>
					    		<option value="victoria">빅토리아</option>
					    		<option value="niagara">나이아가라</option>
					    		<option value="montreal">몬트리올</option>
						  	</select>
						  	<select name="city_philippines" id="philippines">
					    		<option value="choice">도시</option>
					    		<option value="manila">마닐라</option>
					    		<option value="cebu">세부</option>
					    		<option value="baguio">바기오</option>
					    		<option value="iloilo">일로일로</option>
						  	</select>
						  	<select name="city_america" id="america">
					    		<option value="choice">도시</option>
					    		<option value="newyork">뉴욕</option>
					    		<option value="boston">보스턴</option>
					    		<option value="losAngeles">로스앤젤레스</option>
					    		<option value="sanFrancisco">샌프란시스코</option>
					    		<option value="chicago">시카고</option>
						  	</select>
						  	<select name="city_australia" id="australia">
					    		<option value="choice">도시</option>
					    		<option value="sydney">시드니</option>
					    		<option value="melbourne">멜버른</option>
					    		<option value="goldCoast">골드코스트</option>
					    		<option value="brisbane">브리즈번</option>
						  	</select>
						  	<select name="city_newzealand" id="newzealand">
					    		<option value="choice">도시</option>
					    		<option value="auckland">오클랜드</option>
					    		<option value="queenstown">퀸스타운</option>
					    		<option value="wellington">웰링턴</option>
						  	</select>
						  	<select name="city_china" id="china">
					    		<option value="choice">도시</option>
					    		<option value="shanghai">상하이</option>
					    		<option value="beijing">베이징</option>
					    		<option value="guangzhou">광저우</option>
					    		<option value="qingdao">칭다오</option>
						  	</select>
						</td>
					</tr>
					<tr><td>여행 테마</td></tr>
					<tr>
						<td>
							<select name="theme" size="1">
					    		<option value="choice">테마</option>
					    		<option value="healing">힐링</option>
					    		<option value="activity">체험/액티비티</option>
					    		<option value="nature">자연</option>
					    		<option value="themepark">테마파크</option>
					    		<option value="eating">먹방</option>
					    		<option value="favorite">덕질</option>
						  	</select>
						</td>
					</tr>
					<tr><td>제목</td></tr>
					<tr>
						<td>
							<input type="text" name="title" size="20" maxlength="50" placeholder=" 제목입력">
						</td>
					</tr>
					<tr><td>여행일정</td></tr>
					<tr>
						<td>
							<input type="text" id="startDt" name="startDt" placeholder="여행출발일">
							<input type="text" id="endDt" name="endDt" placeholder="여행도착일">
						</td>
					</tr>
					<tr><td>모집인원</td></tr>
					<tr>
						<td>
							<input type="text" name="volumn" size="20" maxlength="3" placeholder=" (최소 3명이상)">
						</td>
					</tr>
					<tr><td>신청마감</td></tr>
					<tr>
						<td>
							<input type="text" id="dueDt" name="dueDt" placeholder="신청마감일">
						</td>
					</tr>
					<tr><td>가이드비용</td></tr>
					<tr>
						<td>
							<input type="text" name="guide" size="20">
						</td>
					</tr>
					<tr><td>공지사항</td></tr>
					<tr>
						<td>
							<textarea name="notice" maxlength="200" cols="7"></textarea>
						</td>
					</tr>
					<tr><td>썸네일</td></tr>
					<tr>
						<td>
							<div id="thumnail">
								<div id="preview"></div>
								<div>
									<input type="file" name="file" accept=".jpg, .png, .gif" />
									<input type="button" id="fileBtn" value="추가">
									<input type="button" id="delBtn" value="삭제">
								</div>
							</div>
						</td>
					</tr>
				</table>
				<input type="hidden" name="u_id" value="<%=(String)session.getAttribute("u_id")%>">
				<div id="buttonArea">
					<hr>
					<input type="button" value="취소" onclick='history.back()'>
					<input type="submit" value="등록" name="register">
				</div>
			</form>
		</div>
	</section>
	<jsp:include page="main_footer.jsp" />
</body>
</html>