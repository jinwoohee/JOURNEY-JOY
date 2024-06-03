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
	$("input[name=close]").click(function() {
		$("#select_div").hide();
		$("input[name=open]").show();
	});
	$("input[name=open]").click(function() {
		$("#select_div").show();
		$("input[name=open]").hide();
	});
	
});