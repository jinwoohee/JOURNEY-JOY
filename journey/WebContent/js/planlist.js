$(function() {
	/*$(".button, #end_check").mouseover(function(){
		$(this).css({'box-shadow':'inset 5px 5px 10px #CCCCCC'});
	});
	$(".button, #end_check").mouseout(function(){
		$(this).css({'box-shadow':''});
	});*/
	$(".plan").mouseover(function() {
		$(this).css({'box-shadow':'0 1px 5px gray'});
	});
	$(".plan").mouseout(function() {
		$(this).css({'box-shadow':'0 2px 20px rgba(0, 0, 0, .1)'});
	});
	$("input[name*='del_plan']").mouseover(function(){
		$(this).css({'border-color':'red','color':'red'})
	});
	$("input[name*='del_plan']").mouseout(function(){
		$(this).css({'border-color':'#6C94B8','color':'#6C94B8'})
	});
	$('select[name=nation]').change(function(){
		
		var cities = ["choice","japan", "canada", "philippines", "america", "australia", "newzealand", "china"];
		
		for(var i=0; i<cities.length; i++){
			if($('select[name=nation]').val() == cities[i]){
				$('#'+$('select[name=nation]').val()+'').show();
				$('select[name*=city]').not($('#'+$('select[name=nation]').val()+'')).hide();
			}
		}
	});

});

function checking(id){ /*테마 체크 여부 */
  if($("input[id="+id+"]").is(":checked")){
    $("label[for="+id+"]").css({"border-color":"#6C94B8", "color":"#6C94B8","font-weight": "bold"});
  }else{
    $("label[for="+id+"]").css({"border-color":"gray", "color":"gray","font-weight": "normal"});
  }
 }
function del_plan(num){
	$("form").attr("action","plan.jj?page=plan_delete&e_no="+num);
}