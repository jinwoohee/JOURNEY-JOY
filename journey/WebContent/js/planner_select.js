$(document).ready(function() {
	$('#up').click(function() { // 테마정보 화살표 눌렀을때 (닫힘)
		$('#detail_div').hide();
		$('#up').css({'display':'none'});
		$('#down').css({'display':'block'});
	});
	$("#down").click(function() {// 테마정보 화살표 눌렀을때 (열림)
		$('#detail_div').show();
		$('#down').css({'display':'none'});
		$('#up').css({'display':'block'});
	});
	$("input[name='close']").click(function() { //선택한 일정 (페이지 하단)div 닫기
		$("#select_div").hide();
		$("input[name='open']").show();
		$("#side_menu").show();
	});
	$("input[name='open']").click(function() { //선택한 일정 (페이지 하단)div 열기
		$("#select_div").show();
		$("input[name='open']").hide();
		$("#side_menu").hide();
	});
/*	$(".button").mouseover(function(){
		$(this).css({'box-shadow':'inset 5px 5px 10px #CCCCCC'});
	});
	$(".button").mouseout(function(){
		$(this).css({'box-shadow':''});
	});*/

	$("input[name*='select']").click(function() {
		$("input[name='open']").hide();
		$("#side_inner").css({"border-bottom":"0"});
		$("#select_div").show();
	});
	$("input[name*='finish']").click(function(){
		$("form").submit();
	});
	
	/*페이징*/
	 $(".list_content").hide();
	 $(".list_content").slice(0, 6).css("display", "block");
	 	
	 if($(".list_content:hidden").length == 0){
		 $('input[name="more_btn"]').hide();
	 }
	 //더보기 버튼
	 $('input[name="more_btn"]').click(function(){
		 $(".list_content:hidden").slice(0, 3).css("display", "block");
		 
		 
	 });
	 $('input[name="more_btn"]').mouseover(function(){
		 $('input[name="more_btn"]').css({"border-bottom":"1px solid #646464"});
	 });
	 $('input[name="more_btn"]').mouseout(function(){
		 $('input[name="more_btn"]').css({"border-bottom":"none"});
	 });
});
function add_plan(num){
	var button = document.getElementsByName("select"+num);
	
	var act = document.getElementById("place_pic"+num);
	var img_value = act.src;
	
	var select = document.getElementsByName("select_values"+num);
	var selected_value ="";
	
	var selected_id = document.getElementsByName("pht_id"+num);
	var result_id = "";
	
	for(var i = 0 ; i < select.length ; i++){
		selected_value += select[i].value+"," ;
		result_id += selected_id[i].value+",";
	}
	
	
	
	
	var img = document.getElementsByClassName("sel_picture");
	var save_value = document.getElementsByClassName("selected");
	var save_id = document.getElementsByClassName("selected_id");
	

	for(var j = 0 ; j < img.length ; j++){
		var day = j+1;
		var pick = document.getElementById("next_a"+day);
		
		if(pick.value == img_value){
			alert("중복된 일정입니다.");
			console.log("1-1번");
			return false;
		}else if(pick.value !=="none"){
			continue
		}
		else {
			img[j].setAttribute('src', img_value);
			img[j].setAttribute('value', "1");		
			save_value[j].setAttribute('value',selected_value);
			save_id[j].setAttribute('value',result_id);
			
			pick.setAttribute('value',img_value);
			console.log("3성공");
			break;				
		
		/*else{ if(pick.value === "none"){
			for(var l = j+1 ; l < img.length ; l++){
				
				var date = l+1;
				if(date <= (img.length)){
					var next = document.getElementById("next_a"+date);
					
					if(next.value !== "none"){
						if(next.value == img_value){
							alert("중복된 일정입니다.");
							console.log("1번");
							return false;
						}
						else if(pick.value == img_value){
							alert("중복된 일정입니다.");
							console.log("2번");
							return false;
						}
						else {if(pick.value != img_value){
							img[j].setAttribute('src', img_value);
							save_value[j].setAttribute('value',selected_value);
							pick.setAttribute('value',img_value);
							console.log("3성공");
							break;				
						}
					}else{
						alert("4번");
						continue
					}
				}
			}
		}else{
			alert("5번");
			continue;
		}
		}*/
	}
}
}
			
function del_plan(num){
	var img = document.getElementById("select_pic"+num);
	var next = document.getElementById("next_a"+num);
	var img_src = document.getElementById("img_selected"+num);
	
	img.setAttribute('src', "img/icon/select_plz.png");
	next.setAttribute('value','none');
	img_src.setAttribute('value','none');
	
}
function check_plan(){
	var img = document.getElementsByClassName("sel_picture");

	for(var j = 0 ; j < img.length ; j++){
		var day = j+1;
		var pick = document.getElementById("next_a"+day);
		if(pick.value === "none"){
			alert("일정을 선택해주세요.");
			return false;
		}
		
	}
	
}
function detail_open(num){
	window.open("planner_plan_detail.jsp?num="+num,"일정상세보기");
}