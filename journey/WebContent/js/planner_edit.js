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
	/*$(".button").mouseover(function(){
		$(this).css({'box-shadow':'inset 5px 5px 10px #CCCCCC'});
	});
	$(".button").mouseout(function(){
		$(this).css({'box-shadow':''});
	});*/
	$("input[name='add_place'], input[name='plan_sel_add']").click(function(){
		$("form").attr("action","planner_add_place.jsp");
	});
	$("input[name='save_plan_edit']").click(function(){
		$("form").attr("action","planner.jj?page=schedule_update");
	});
	
});

function day_select(num){
	var day = "#day"+num;
	var list_no = "#plan_list_day"+num;
	
	$("p[id*='day']").css({'border':'none', 'color':'#646464','cursor':'pointer', 'margin-top':'14px', 'background-color' : 'transparent'});
	$(day).css({'border':'none','cursor':'auto', 'color':'#6C94B8','border-top':'3px solid #6C94B8','margin-top':'11px', 'background-color' : 'white'});
	$("div[id*='plan_list_day']").css({'display':'none'});
	$(list_no).css({'display':'block'});
	
}


function del_list(num){
	var day = Math.trunc(num/100);
	
	var val = document.getElementById("pla_val"+num).value+",";
	var place = document.getElementById("place_name"+day);
	var id = document.getElementById("id_srcs"+num).value+",";
	var place_id = document.getElementById("place_ids"+day);
	
	var result = place.value.replaceAll(val,"");
	place.setAttribute('value',result);
	var result_id = place_id.value.replaceAll(id,"");
	place_id.setAttribute("value",result_id);
	 
	var list = document.getElementById("list_content"+num);
	list.remove();
	
	if($("input[name='place_id_src"+day+"']").length == 0){
		 $("div[id='list_empty"+day+"']").show();
	 }
}
