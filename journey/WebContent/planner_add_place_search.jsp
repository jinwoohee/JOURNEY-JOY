<%@page import="java.util.Arrays"%>
<%@page import="java.sql.Array"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jj.dto.Place"%>
<%@page import="com.jj.dto.Eatery"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<%@page import="com.jj.dto.Plan"%>
<%	request.setCharacterEncoding("utf-8");
	Cookie[] cookies = request.getCookies();
	System.out.println("ㅇㅇㅇ");
%>
<%!private String getCookieValue(Cookie[] cookies, String name){
		String value = null;
		if(cookies == null)
			return null;
		for(Cookie cookie : cookies){
			if(cookie.getName().equals(name))
				return cookie.getValue();
		}
		return null;
}%>
<% 	String e_start_date = getCookieValue(cookies, "e_start_date");
	String e_end_date = getCookieValue(cookies, "e_end_date");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Date sdate = sdf.parse(e_start_date);
	Date edate = sdf.parse(e_end_date);
	long datecnt = 1+(edate.getTime() - sdate.getTime()) /(1000*60*60*24);
	%>

<!DOCTYPE html>
<html>
<head>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>	
	
<meta charset="UTF-8">
<style>
div[id="result_list"]{
	width : 280px;
	height : 460px;
	overflow : hidden auto;
	border-bottom : 1px solid gray;
}
div[id="result_list"]::-webkit-scrollbar{
	width: 6px;

}
div[id="result_list"]::-webkit-scrollbar-thumb {
    border-radius: 3px;
    background: rgb(196, 198, 200)
 }   
div[id="result_list"]::-webkit-scrollbar-track-piece {
    background: rgb(233, 236, 239);
}
input[name="place_one"]{
	display: none;
}
label{
	display:inline-block;
	width : 240px;
	height : 25px;
	border-bottom : 1px solid gray;
	font-size : 15px;
	padding : 20px;
	cursor: pointer;
}
div[id="search_result1"]{
	width : 280px;
	height : 545px;
	float:left;
}

</style>
<script type="text/javascript">
$(document).ready(function() {

});
	
function checking(id){ /*테마 체크 여부 */
	$("input[type='checkbox']").prop("checked", false);
	$("label").css({"background-color":"", "color":"rgb(64,64,64)"});
	$("input[id="+id+"]").prop("checked",true);	
	  
	if($("input[id="+id+"]").is(":checked")){  
	    $("label[for="+id+"]").css({"background-color":"#1E427F", "color":"#f1f1f3"});
	  }else{
	    $("label[for="+id+"]").css({"background-color":"", "color":"rgb(64,64,64)"});
	  }
}

function plan_add_btn(num){	
	var edit = document.getElementById("edited"+num);
	var before =document.getElementById("places_text"+num).innerText;
	var empty = document.getElementById("places_textb"+num);
	
	var edit_id = document.getElementById("edited_id"+num);
	if(empty !=null){
		empty.remove();
	}
	
	
	$("input[name='place_one']").each(function(){
	    if( $(this).is(":checked") == true ){	    	
	      var id = $(this).attr('id');
	      var checkVal = " #"+$("label[for="+id+"]").text()+"!new!";
	      var checkvalue = "#"+$("label[for="+id+"]").text()+"!new!"; 
	      document.getElementById("places_text"+num).textContent = before+checkVal ;
	      
	      var id_v = $(this).val();
	      
	      $(this).prop("checked", false);
	      $("label[for="+id+"]").css({"background-color":"white", "color":"rgb(64,64,64)"});
	      
	      var after = edit.value+checkvalue+"_";
	  	  edit.setAttribute('value',after);
	  	  var after_id = edit_id.value+id_v+",";
	  	  edit_id.setAttribute('value',after_id);
	    }
	});
}
</script>
<title>Insert title here</title>
</head>

<%
	String u_id = (String)session.getAttribute("u_id"); 
%>
<body>
<div id="search_result1">
					<div id="result_list">
					
					<%
					List<Place> pla = (List<Place>) request.getAttribute("search_place");
					List<Eatery> eat = (List<Eatery>) request.getAttribute("search_eatery");

					if(pla == null && eat == null){
						out.println("<input type='radio' name='place_one' id='search_plz'><label for='search_plz' class='pl_label'>검색어를 입력해주세요.</label>");
						out.println("</div>");		
						for(int a = 1 ; a <= datecnt ; a++){
							out.println("<input type='button' id='plan_add"+a+"' value='여행지 추가' class='button' />");	
						}		
					}
					else{
						String locate;
						int z=-1;
						for(Place plalist : pla){
							z++;

							out.println("<input type='checkbox' name='place_one' value='"+plalist.getPlac_id()+"' id= 'pone"+z+"' onclick='checking(this.id)'>");
							out.println("<label for='pone"+z+"' class='pl_label'>"+plalist.getPlac_name()+"</label>");		
							out.println("<input type='hidden' name='place_num' value='"+plalist.getPlac_id()+"'>");
						}
						for(Eatery eatlist : eat){
							z++;

							out.println("<input type='checkbox' name='place_one' value='"+eatlist.getEat_id()+"' id= 'pone"+z+"' onclick='checking(this.id)'>");
							out.println("<label for='pone"+z+"' class='pl_label'>"+eatlist.getEat_name()+"</label>");		
							out.println("<input type='hidden' name='place_num' value='"+eatlist.getEat_id()+"'>");
						}
						out.println("</div>");
						for(int a = 1 ; a <= datecnt ; a++){
							out.println("<input type='button' id='plan_add"+a+"' value='여행지 추가' class='button' onclick='plan_add_btn("+a+")'/>");	
						}	
					}
					
					%>						
				</div>		
				</div>
</body>
</html>