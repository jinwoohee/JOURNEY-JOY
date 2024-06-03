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
	$("input[name='save_plan']").click(function(){
		$("form").submit();	
	});
	$("input[name='plan_sel']").click(function(){
		$("form").submit();	
	});
	
	
	// 검색버튼 클릭 시 발생//
	
	 $('#search_btn').click(function(){
     	$.ajax({
     		url : "planner.jj?page=place_search",
 			data : {"search_place": $('input[name=search_place]').val(), "city" :$("#city").text()},
 			success : function(re){
 				$("#search_result").html(re);
 				
 			}
     	});
    	initMap();
    	
    	$("p[id*='day']").css({'border':'none', 'color':'#646464','cursor':'pointer', 'margin-top':'14px', 'background-color' : 'transparent'});
    	$("p[id='day1']").css({'border':'none','cursor':'auto', 'color':'#6C94B8','border-top':'3px solid #6C94B8','margin-top':'11px', 'background-color' : 'white'});
    	$("div[id*='places']").css({'display':'none'});
    	$("div[id='places1']").css({'display':'block'});
    	$("input[id*='plan_add']").css({'display':'none'});
    	$("input[id='plan_add1']").css({'display':'block'});
     });
	 
	
	 
	 $('input[name=search_place]').keypress(function(e){
			//검색어 입력 후 엔터키 입력하면 조회버튼 클릭
			if(e.keyCode && e.keyCode == 13){
				$("#search_btn").trigger("click");
				return false;
			}
		});
});

function day_select(num){
	var day = "#day"+num;
	var places = "#places"+num;
	var add_btn = "#plan_add"+num;
	
	$("p[id*='day']").css({'border':'none', 'color':'#646464','cursor':'pointer', 'margin-top':'14px', 'background-color' : 'transparent'});
	$(day).css({'border':'none','cursor':'auto', 'color':'#6C94B8','border-top':'3px solid #6C94B8','margin-top':'11px', 'background-color' : 'white'});
	$("div[id*='places']").css({'display':'none'});
	$(places).css({'display':'block'});
	$("input[id*='plan_add']").css({'display':'none'});
	$(add_btn).css({'display':'block'});
	
}

function plan_add_btn(num){	
	
	var edit = document.getElementById("edited"+num);
	var before =document.getElementById("places_text"+num).innerText;
	var empty = document.getElementById("places_textb"+num);
	if(empty !=null){
		empty.remove();
	}
	
	$("input[name='place_one']").each(function(){
	    if( $(this).is(":checked") == true ){
	      var id = $(this).attr('id');
	      var checkVal = " #"+$(this).val();     
	     
	    
	      document.getElementById("places_text"+num).textContent = before+checkVal ;
	      
	      $(this).prop("checked", false);
	      $("label[for="+id+"]").css({"background-color":"", "color":"rgb(64,64,64)"});
	      
	      var after = edit.value+checkVal+"_";
	      var after = document.getElementById("places_text"+num).innerText;
	  	  edit.setAttribute('value',aaa);
	  	  
	    }
	});
	
}

function checking(id){ /*테마 체크 여부 */
	$("input[type='checkbox']").prop("checked", false);
	$("label").css({"background-color":"", "color":"rgb(64,64,64)"});
	$("input[id="+id+"]").prop("checked",true);
	  
	if($("input[id="+id+"]").is(":checked")){  
	    $("label[for="+id+"]").css({"background-color":"#1E427F", "color":"#f1f1f3"});
	  }else{
	    $("label[for="+id+"]").css({"background-color":"", "color":"rgb(64,64,64)"});
	  }
	
	selectMarker(id);
	
}

