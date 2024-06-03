window.onload = function() {
	$(function() {
		$('.main_menu, #sub_div, #main_menu_div').mouseover(function() { // 메인메뉴(5개짜리) 글자, div ,서브메뉴 에 마우스오버 시 서브메뉴나옴
			$('#sub_div').stop().slideDown(200);
		});
		$('#top_div,#sub_div,#main_menu_div').mouseout(function() { // 최상단 div(로고+메뉴+로그인), 서브메뉴 에스 마우스 오버시 서브메뉴 사라짐
			$('#sub_div').stop().slideUp(200);
		});
		$('.sub_menu_a').mouseover(function() {
			$(this).css({"color":"rgb(64,64,64)","font-weight":"bold"});
		});
		$('.sub_menu_a').mouseout(function() {
			$(this).css({"color":"#959595","font-weight":"400"});
		});
	});	
}


function showMenu(){ // 마이페이지 가로 슬라이드부분
	$('#mypage' ).css( { 'display' : 'block' } );
	$('#mypage' ).css( { 'left' : '100%' } );
	$('#mypage' ).animate( { "left": '0px' }, { duration: "200" },{ "animation-timing-function" : "ease"} );
}

function hideMenu(){
	$('#mypage' ).animate( { left: '100%' }, { duration: "200", complete:function(){ $('#mypage' ).css( { 'display' : 'none' } ); } } );
}
