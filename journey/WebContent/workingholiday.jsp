<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@page import="com.jj.dto.Company"%>
<%@page import="java.util.List"%>
<%@page import="java.net.URLDecoder"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%
	String u_id = (String) session.getAttribute("u_id");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>워킹홀리데이</title>

	<link href="css/workingholiday.css" rel="stylesheet" type="text/css">
	
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	
	<script type="text/javascript">
		var onclk1 = true; //큰 조건 선택시 글자색
		var onclk2 = true; //큰 조건 선택시 배경색
		var offclk1 = true; //미선택된 큰 조건 글자색
		var offclk2 = true; //미선택된 큰 조건 배경색
		var cname = ''; //큰 조건 클래스이름
		var cnamebcolr = ''; //큰 조건 배경색

		$(document).ready(function() {
			$('.ly_sub, .resultSetWrap, .arrup').hide();
			$('.sub1, .sub2, .sub3, .sub4, .sub5, .sub6, .sub7, .sub8, .sub9').parent().hide(); //직종 상세 레이어
			$('.sub10, .sub11, .sub12, .sub13, .sub14, .sub15, .sub16, .sub17, .sub18').parent().hide(); //국가 상세 레이어
			
			//큰 조건 클릭 시 글자,배경색 변화
			$('.detailBox>dl>dt').click(function() {
				if ($(this).siblings('.ly_sub').length) {
					console.log('세부레이어 존재');
					$(this).siblings('.ly_sub').toggle(0, function() {
						console.log(cname);
						console.log($(this).siblings('dt').css('background-color'));
						if (cname != $(this).parent().attr('class') && 
							$(this).siblings('dt').css('background-color') == 'rgb(241, 241, 243)' && 
							cnamebcolr == 'rgb(44, 96, 156)') {
							console.log(clchange(onclk1)+backclchange(onclk2));
							console.log('1----------');
						}
						cname = $(this).parent().attr('class');
						console.log('2----------');
						console.log(cname);
						console.log($(this).siblings('dt').css('background-color'));
						$(this).siblings('dt').find('p').css({'color':clchange(onclk1)});
						$(this).siblings('dt').css({'background-color':backclchange(onclk2)});
						console.log('3----------');
						cnamebcolr = $(this).siblings('dt').css('background-color');
						console.log('cnamebcolr - '+cnamebcolr);
						console.log($(this).siblings('dt').css('background-color'));
						$(this).parent().siblings('dl').find('p').css({'color':clchange2(offclk1)});
						$(this).parent().siblings('dl').find('dt').css({'background-color':backclchange2(offclk2)});
						$(this).parent().siblings('dl').find('.ly_sub').hide();
						$(this).parent().siblings('dl').find('.arrup').hide();
						$(this).parent().siblings('dl').find('.arrdown').show();
						$(this).siblings('dt').find('.arrdown').toggle(0);
						$(this).siblings('dt').find('.arrup').toggle(0);
					});
				} else {
					console.log('세부레이어 존재x');
					$(this).children('img').toggle(0, function() {
						console.log(cname);
						console.log($(this).parent().css('background-color'));
						if (cname != $(this).parent().parent().attr('class') && 
							$(this).parent().css('background-color') == 'rgb(241, 241, 243)' && 
							cnamebcolr == 'rgb(44, 96, 156)') {
							console.log(clchange(onclk1)+backclchange(onclk2));
							console.log('1----------');
						}
						cname = $(this).parent().parent().attr('class');
						console.log('2----------');
						console.log(cname);
						console.log($(this).parent().css('background-color'));
						$(this).siblings('p').css({'color':clchange(onclk1)});
						$(this).parent().css({'background-color':backclchange(onclk2)});
						console.log('3----------');
						cnamebcolr = $(this).parent().css('background-color');
						console.log('cnamebcolr - '+cnamebcolr);
						console.log($(this).parent().css('background-color'));
						$(this).parent().parent().siblings('dl').find('p').css({'color':clchange2(offclk1)});
						$(this).parent().parent().siblings('dl').find('dt').css({'background-color':backclchange2(offclk2)});
						$(this).parent().parent().siblings('dl').find('.ly_sub').hide();
						$(this).parent().parent().siblings('dl').find('.arrup').hide();
						$(this).parent().parent().siblings('dl').find('.arrdown').show();
						$(this).parent().find('.arrdown').toggle(0);
						$(this).parent().find('.arrup').toggle(0);
					});
				}
				
				
			});

			$('.lb_tag').mouseenter(function() {
				$(this).css({'text-decoration' : 'underline'});
			});

			$('.lb_tag').mouseleave(function() {
				$(this).css({'text-decoration' : 'none'});
			});

			//세부조건 선택시
			$('.lb_tag').click(function() {
				if ($(this).parent().parent().parent().siblings('.ly_sub').length) {
					console.log('세부레이어있음');
					$(this).parent().parent().parent().siblings('.ly_sub').toggle(0, function() {
						console.log(cname);
						console.log($(this).siblings('dt').css('background-color'));
						if (cname != $(this).parent().attr('class') && 
							$(this).siblings('dt').css('background-color') == 'rgb(241, 241, 243)' && 
							cnamebcolr == 'rgb(44, 96, 156)') {
							console.log(clchange(onclk1)+backclchange(onclk2));
							console.log('1----------');
						}
						cname = $(this).parent().attr('class');
						console.log('2----------');
						console.log(cname);
						console.log($(this).siblings('dt').css('background-color'));
						$(this).siblings('dt').find('p').css({'color':clchange(onclk1)});
						$(this).siblings('dt').css({'background-color':backclchange(onclk2)});
						console.log('3----------');
						cnamebcolr = $(this).siblings('dt').css('background-color');
						console.log('cnamebcolr - '+cnamebcolr);
						console.log($(this).siblings('dt').css('background-color'));
						$(this).parent().siblings('dl').find('p').css({'color':clchange2(offclk1)});
						$(this).parent().siblings('dl').find('dt').css({'background-color':backclchange2(offclk2)});
						$(this).parent().siblings('dl').find('.ly_sub').hide();
						$(this).parent().siblings('dl').find('.arrup').hide();
						$(this).parent().siblings('dl').find('.arrdown').show();
						$(this).siblings('dt').find('.arrdown').toggle(0);
						$(this).siblings('dt').find('.arrup').toggle(0);
					});
				} else {
					if ($(this).closest('.detail_sec').length) {
						console.log('세부레이어');
						if ($(this).closest('.two').length) {
							console.log('2차직종');
							$(this).siblings('input').off().on('change', function() {
								var checked = $(this).prop('checked');
								var $label = $(this).next();
								var lb_value = $label.attr('value');
								var chkid = $(this).attr('id');
								var split = $(this).attr('id').substr(0, 4); //자른 id값
								var txt =  $(this).closest('.two').siblings('.detail_sec').find('input[id='+split+']').next().text() //1차직종 text
								var f_value = $(this).closest('.two').siblings('.detail_sec').find('input[id='+split+']').next().attr('value'); //1차직종 value
								
								var $name = $(this).attr('name'); //클릭한 input의 name
								var $input = $(this).parent().siblings('.item').find('input[name='+$name+']'); //클릭한 input의 같은 name의 input
								
								if (checked) {
									if ($label.text() == '전체') { //text가 전체일때
										$label.css({'font-weight':'bold', 'border':'1px solid #2c609c', 'border-radius':'10px', 'background-color':'#f1f1f3'});
										if ($name == $input.attr('name')) { //같은 name의 input만
											$input.next().css({'font-weight':'unset', 'border':'none', 'border-radius':'0px', 'background-color':'white'});
										}
										
										var gdata = '[data-group!='+ chkid +'] [data-name*='+ $name +']';
										$('.items li').remove(gdata); //같은 name의 전체 li 선택했으므로 일반 li 삭제
										
										$('.items').append('<li id='+ chkid +' class="total" data-group='+ chkid + ' data-name=' + $name + '><button>'+ txt +'<span class="ico">-'+ f_value +'삭제</span></button></li>');
										$('.items li').data('group', chkid);
										$('.items li').data('name', $name);

										//조건이 있으면 검색창 생성
										if ($('.items').find('li').length > 0) {
											$('.resultSetWrap').show();
										}
									} else { //text가 전체가 아닐때
										$label.css({'font-weight':'bold', 'border':'1px solid #2c609c', 'border-radius':'10px', 'background-color':'#f1f1f3'});
										$input.next().eq(0).css({'font-weight':'unset', 'border':'none', 'border-radius':'0px', 'background-color':'white'});
										
										var gdata = '[data-group!='+ chkid +'] [data-name*='+ $name +']';
										$('.items .total').remove(gdata); //같은 name의 전체 li 삭제
										
										$('.items').append('<li id='+ chkid +' data-group='+ chkid + ' data-name=' + $name + '><button>'+ txt + '>' + $label.text() +'<span class="ico">-'+ lb_value +'삭제</span></button></li>');
										$('.items li').data('group', chkid);
										$('.items li').data('name', $name);
										
										//조건이 있으면 검색창 생성
										if ($('.items').find('li').length > 0) {
											$('.resultSetWrap').show();
										}
									}
								} else {
									$label.css({'font-weight':'unset', 'border':'none', 'border-radius':'0px', 'background-color':'white'});
									
									var gdata = '[data-group*=' + chkid + ']';
									$('.items li').remove(gdata);
																
									//조건이 없으면 검색창 없애기
									if ($('.items').find('li').length == 0) {
										$('.resultSetWrap').hide();
									}
								}
							});
						} else {
							console.log('1차직종');
							$(this).siblings('input').off().on('change', function() {
								var checked = $(this).prop('checked');
								var $label = $(this).next();

								if (checked) { //1차 선택시
									$label.css({'font-weight':'bold', 'border':'1px solid #2c609c', 'border-radius':'10px', 'background-color':'#f1f1f3'});
									$(this).parent().siblings('.item').find('label').css({'font-weight':'unset', 'border':'none', 'border-radius':'0px', 'background-color':'white'});
									
									//직종 상세 레이어
									if ($label.text() == '외식음료') {
										$('.sub2').parent().hide();
										$('.sub3').parent().hide();
										$('.sub4').parent().hide();
										$('.sub5').parent().hide();
										$('.sub6').parent().hide();
										$('.sub7').parent().hide();
										$('.sub8').parent().hide();
										$('.sub9').parent().hide();
										$('.sub1').parent().show();
									} else if ($label.text() == '유통판매') {
										$('.sub1').parent().hide();
										$('.sub3').parent().hide();
										$('.sub4').parent().hide();
										$('.sub5').parent().hide();
										$('.sub6').parent().hide();
										$('.sub7').parent().hide();
										$('.sub8').parent().hide();
										$('.sub9').parent().hide();
										$('.sub2').parent().show();
									} else if ($label.text() == '문화/여가/생활') {
										$('.sub1').parent().hide();
										$('.sub2').parent().hide();
										$('.sub4').parent().hide();
										$('.sub5').parent().hide();
										$('.sub6').parent().hide();
										$('.sub7').parent().hide();
										$('.sub8').parent().hide();
										$('.sub9').parent().hide();
										$('.sub3').parent().show();
									} else if ($label.text() == '서비스') {
										$('.sub1').parent().hide();
										$('.sub2').parent().hide();
										$('.sub3').parent().hide();
										$('.sub5').parent().hide();
										$('.sub6').parent().hide();
										$('.sub7').parent().hide();
										$('.sub8').parent().hide();
										$('.sub9').parent().hide();
										$('.sub4').parent().show();
									} else if ($label.text() == '사무회계') {
										$('.sub1').parent().hide();
										$('.sub2').parent().hide();
										$('.sub3').parent().hide();
										$('.sub4').parent().hide();
										$('.sub6').parent().hide();
										$('.sub7').parent().hide();
										$('.sub8').parent().hide();
										$('.sub9').parent().hide();
										$('.sub5').parent().show();
									} else if ($label.text() == '생산/건설') {
										$('.sub1').parent().hide();
										$('.sub2').parent().hide();
										$('.sub3').parent().hide();
										$('.sub4').parent().hide();
										$('.sub5').parent().hide();
										$('.sub7').parent().hide();
										$('.sub8').parent().hide();
										$('.sub9').parent().hide();
										$('.sub6').parent().show();
									} else if ($label.text() == '교육/강사') {
										$('.sub1').parent().hide();
										$('.sub2').parent().hide();
										$('.sub3').parent().hide();
										$('.sub4').parent().hide();
										$('.sub5').parent().hide();
										$('.sub6').parent().hide();
										$('.sub8').parent().hide();
										$('.sub9').parent().hide();
										$('.sub7').parent().show();
									} else if ($label.text() == '미디어') {
										$('.sub1').parent().hide();
										$('.sub2').parent().hide();
										$('.sub3').parent().hide();
										$('.sub4').parent().hide();
										$('.sub5').parent().hide();
										$('.sub6').parent().hide();
										$('.sub7').parent().hide();
										$('.sub9').parent().hide();
										$('.sub8').parent().show();
									} else if ($label.text() == '운전/배달') {
										$('.sub1').parent().hide();
										$('.sub2').parent().hide();
										$('.sub3').parent().hide();
										$('.sub4').parent().hide();
										$('.sub5').parent().hide();
										$('.sub6').parent().hide();
										$('.sub7').parent().hide();
										$('.sub8').parent().hide();
										$('.sub9').parent().show();
									}
									
									//국가 상세 레이어
									if ($label.text() == '일본') {
										$('.sub11').parent().hide();
										$('.sub12').parent().hide();
										$('.sub13').parent().hide();
										$('.sub14').parent().hide();
										$('.sub15').parent().hide();
										$('.sub16').parent().hide();
										$('.sub17').parent().hide();
										$('.sub18').parent().hide();
										$('.sub10').parent().show();
									} else if ($label.text() == '캐나다') {
										$('.sub10').parent().hide();
										$('.sub12').parent().hide();
										$('.sub13').parent().hide();
										$('.sub14').parent().hide();
										$('.sub15').parent().hide();
										$('.sub16').parent().hide();
										$('.sub17').parent().hide();
										$('.sub18').parent().hide();
										$('.sub11').parent().show();
									} else if ($label.text() == '필리핀') {
										$('.sub10').parent().hide();
										$('.sub11').parent().hide();
										$('.sub13').parent().hide();
										$('.sub14').parent().hide();
										$('.sub15').parent().hide();
										$('.sub16').parent().hide();
										$('.sub17').parent().hide();
										$('.sub18').parent().hide();
										$('.sub12').parent().show();
									} else if ($label.text() == '미국') {
										$('.sub10').parent().hide();
										$('.sub11').parent().hide();
										$('.sub12').parent().hide();
										$('.sub14').parent().hide();
										$('.sub15').parent().hide();
										$('.sub16').parent().hide();
										$('.sub17').parent().hide();
										$('.sub18').parent().hide();
										$('.sub13').parent().show();
									} else if ($label.text() == '호주') {
										$('.sub10').parent().hide();
										$('.sub11').parent().hide();
										$('.sub12').parent().hide();
										$('.sub13').parent().hide();
										$('.sub15').parent().hide();
										$('.sub16').parent().hide();
										$('.sub17').parent().hide();
										$('.sub18').parent().hide();
										$('.sub14').parent().show();
									} else if ($label.text() == '뉴질랜드') {
										$('.sub10').parent().hide();
										$('.sub11').parent().hide();
										$('.sub12').parent().hide();
										$('.sub13').parent().hide();
										$('.sub14').parent().hide();
										$('.sub16').parent().hide();
										$('.sub17').parent().hide();
										$('.sub18').parent().hide();
										$('.sub15').parent().show();
									} else if ($label.text() == '동남아') {
										$('.sub10').parent().hide();
										$('.sub11').parent().hide();
										$('.sub12').parent().hide();
										$('.sub13').parent().hide();
										$('.sub14').parent().hide();
										$('.sub15').parent().hide();
										$('.sub17').parent().hide();
										$('.sub18').parent().hide();
										$('.sub16').parent().show();
									} else if ($label.text() == '중국') {
										$('.sub10').parent().hide();
										$('.sub11').parent().hide();
										$('.sub12').parent().hide();
										$('.sub13').parent().hide();
										$('.sub14').parent().hide();
										$('.sub15').parent().hide();
										$('.sub16').parent().hide();
										$('.sub18').parent().hide();
										$('.sub17').parent().show();
									} else if ($label.text() == '유럽') {
										$('.sub10').parent().hide();
										$('.sub11').parent().hide();
										$('.sub12').parent().hide();
										$('.sub13').parent().hide();
										$('.sub14').parent().hide();
										$('.sub15').parent().hide();
										$('.sub16').parent().hide();
										$('.sub17').parent().hide();
										$('.sub18').parent().show();
									}
								} else { //1차 선택해제시
									$label.css({'font-weight':'unset', 'border':'none', 'border-radius':'0px', 'background-color':'white'});
									
									//직종 상세 레이어
									if ($label.text() == '외식음료') {
										$('.sub1').parent().hide();
									} else if ($label.text() == '유통판매') {
										$('.sub2').parent().hide();
									} else if ($label.text() == '문화/여가/생활') {
										$('.sub3').parent().hide();
									} else if ($label.text() == '서비스') {
										$('.sub4').parent().hide();
									} else if ($label.text() == '사무회계') {
										$('.sub5').parent().hide();
									} else if ($label.text() == '생산/건설') {
										$('.sub6').parent().hide();
									} else if ($label.text() == '교육/강사') {
										$('.sub7').parent().hide();
									} else if ($label.text() == '미디어') {
										$('.sub8').parent().hide();
									} else if ($label.text() == '운전/배달') {
										$('.sub9').parent().hide();
									}
									
									//국가 상세 레이어
									if ($label.text() == '일본') {
										$('.sub10').parent().hide();
									} else if ($label.text() == '캐나다') {
										$('.sub11').parent().hide();
									} else if ($label.text() == '필리핀') {
										$('.sub12').parent().hide();
									} else if ($label.text() == '미국') {
										$('.sub13').parent().hide();
									} else if ($label.text() == '호주') {
										$('.sub14').parent().hide();
									} else if ($label.text() == '뉴질랜드') {
										$('.sub15').parent().hide();
									} else if ($label.text() == '동남아') {
										$('.sub16').parent().hide();
									} else if ($label.text() == '중국') {
										$('.sub17').parent().hide();
									} else if ($label.text() == '유럽') {
										$('.sub18').parent().hide();
									}
								}
							});
						}

					} else {
						console.log('세부레이어없음');
						$(this).closest('.nano').siblings('dt').children('p').css({'color':'#f1f1f3'});
						$(this).closest('.nano').siblings('dt').css({'background':'#2c609c'});
						$(this).closest('dl').siblings('dl').find('p').css({'color':'#646464'});
						$(this).closest('dl').siblings('dl').find('dt').css({'background-color':'#f1f1f3'});
						console.log($(this).text());
						
						$(this).siblings('input').off().on('change', function() {
							var checked = $(this).prop('checked');
							var chkname = $(this).attr('name');
							var $label = $(this).next();
							var lb_value = $label.attr('value');
							var chkid = $(this).attr('id');
							var wlen = $('.items li[name=week]').length;
							var wklen = $('.items li[name=weekend]').length;
							console.log('wlen-------'+wlen);
							//var txt =  $(this).closest('.one').siblings('dt').find('p').text(); //dt text
							console.log('this id ----------> ' + chkid);

							if (checked) {
								if (chkid == 'date1') { //평일 클릭했을때
									$label.css({'font-weight':'bold', 'border':'1px solid #2c609c', 'border-radius':'10px', 'background-color':'#f1f1f3'});
									$('#date3').next().css({'font-weight':'bold', 'border':'1px solid #2c609c', 'border-radius':'10px', 'background-color':'#f1f1f3'}); //월
									$('#date4').next().css({'font-weight':'bold', 'border':'1px solid #2c609c', 'border-radius':'10px', 'background-color':'#f1f1f3'}); //화
									$('#date5').next().css({'font-weight':'bold', 'border':'1px solid #2c609c', 'border-radius':'10px', 'background-color':'#f1f1f3'}); //수
									$('#date6').next().css({'font-weight':'bold', 'border':'1px solid #2c609c', 'border-radius':'10px', 'background-color':'#f1f1f3'}); //목
									$('#date7').next().css({'font-weight':'bold', 'border':'1px solid #2c609c', 'border-radius':'10px', 'background-color':'#f1f1f3'}); //금
									$('#date3').attr('checked', true);
									$('#date4').attr('checked', true);
									$('#date5').attr('checked', true);
									$('#date6').attr('checked', true);
									$('#date7').attr('checked', true);
									
									$('.items li[name=week]').remove();
									$('.items').append('<li id='+ chkid + ' name=' + chkname + ' data-group='+ chkid + '><button>'+ $label.text() +'<span class="ico">-'+ lb_value +'삭제</span></button></li>');
									$('.items li').data('group', chkid);
								} else if (chkid == 'date2') { //주말 클릭했을때
									$label.css({'font-weight':'bold', 'border':'1px solid #2c609c', 'border-radius':'10px', 'background-color':'#f1f1f3'});
									$('#date8').next().css({'font-weight':'bold', 'border':'1px solid #2c609c', 'border-radius':'10px', 'background-color':'#f1f1f3'}); //토
									$('#date9').next().css({'font-weight':'bold', 'border':'1px solid #2c609c', 'border-radius':'10px', 'background-color':'#f1f1f3'}); //일
									$('#date8').attr('checked', true);
									$('#date9').attr('checked', true);
									
									$('.items li[name=weekend]').remove();
									$('.items').append('<li id='+ chkid + ' name=' + chkname + ' data-group='+ chkid + '><button>'+ $label.text() +'<span class="ico">-'+ lb_value +'삭제</span></button></li>');
									$('.items li').data('group', chkid);
								} else if (wlen >= 4) { //월,화,수,목,금 모두 클릭했을때
									console.log('week all');
									$label.css({'font-weight':'bold', 'border':'1px solid #2c609c', 'border-radius':'10px', 'background-color':'#f1f1f3'});
									$('#date1').next().css({'font-weight':'bold', 'border':'1px solid #2c609c', 'border-radius':'10px', 'background-color':'#f1f1f3'});
									$('#date1').prop('checked', true);
									
									$('.items li[name=week]').remove(); //검색창에 월,화,수,목,금 모두 삭제
									//검색창에 평일 추가
									$('.items').append('<li id="date1" name="date" data-group="date1"><button>'+ $('#date1').next().text() +'<span class="ico">-com_work_days삭제</span></button></li>');
								} else if (wklen >= 1) { //토,일 모두 클릭했을때
									$label.css({'font-weight':'bold', 'border':'1px solid #2c609c', 'border-radius':'10px', 'background-color':'#f1f1f3'});
									$('#date2').next().css({'font-weight':'bold', 'border':'1px solid #2c609c', 'border-radius':'10px', 'background-color':'#f1f1f3'});
									$('#date2').prop('checked', true);
									
									$('.items li[name=weekend]').remove(); //검색창에 토,일 모두 삭제
									//검색창에 주말 추가
									$('.items').append('<li id="date2" name="date" data-group="date2"><button>'+ $('#date2').next().text() +'<span class="ico">-com_work_days삭제</span></button></li>');
								} else {
									$label.css({'font-weight':'bold', 'border':'1px solid #2c609c', 'border-radius':'10px', 'background-color':'#f1f1f3'});
									$('.items').append('<li id='+ chkid + ' name=' + chkname + ' data-group='+ chkid + '><button>'+ $label.text() +'<span class="ico">-'+ lb_value +'삭제</span></button></li>');
									$('.items li').data('group', chkid);
								}
								//console.log('1---------');
								//console.log($('.items li').data('group'));
								
								//조건이 있으면 검색창 생성
								if ($('.items').find('li').length > 0) {
									$('.resultSetWrap').show();
								}
							} else {
								if (chkid == 'date1') { //평일 click해제
									$label.css({'font-weight':'unset', 'border':'none', 'border-radius':'0px', 'background-color':'white'});
									$('#date3').next().css({'font-weight':'unset', 'border':'none', 'border-radius':'0px', 'background-color':'white'}); //월
									$('#date4').next().css({'font-weight':'unset', 'border':'none', 'border-radius':'0px', 'background-color':'white'}); //화
									$('#date5').next().css({'font-weight':'unset', 'border':'none', 'border-radius':'0px', 'background-color':'white'}); //수
									$('#date6').next().css({'font-weight':'unset', 'border':'none', 'border-radius':'0px', 'background-color':'white'}); //목
									$('#date7').next().css({'font-weight':'unset', 'border':'none', 'border-radius':'0px', 'background-color':'white'}); //금
								
									var gdata = '[data-group*=' + chkid + ']';
									$('.items li').remove(gdata);
								} else if (chkid == 'date2') { //주말 click해제
									$label.css({'font-weight':'unset', 'border':'none', 'border-radius':'0px', 'background-color':'white'});
									$('#date8').next().css({'font-weight':'unset', 'border':'none', 'border-radius':'0px', 'background-color':'white'}); //토
									$('#date9').next().css({'font-weight':'unset', 'border':'none', 'border-radius':'0px', 'background-color':'white'}); //일
									
									var gdata = '[data-group*=' + chkid + ']';
									$('.items li').remove(gdata);
								} else if (chkid == 'date3' || chkid == 'date4' || chkid == 'date5' || chkid == 'date6' || chkid == 'date7') {
									//월,화,수,목,금 모두 선택 아닐시
									$label.css({'font-weight':'unset', 'border':'none', 'border-radius':'0px', 'background-color':'white'});
									var gdata = '[data-group*=' + chkid + ']';
									$('.items li').remove(gdata);
									var len = $('.items li[name=week]').length;
									console.log('len-----------'+len);
									
									$('#date1').next().css({'font-weight':'unset', 'border':'none', 'border-radius':'0px', 'background-color':'white'});
									$('#date1').prop('checked', false);
									$('.items li[id=date1]').remove(); //검색창에 평일 삭제
									
									//검색창에 요일추가
									if (len == 0 && wlen == 0) {
										switch (chkid) {
											case 'date3': //월 check해제
												$('.items').append('<li id="date4" name="week" data-group="date4"><button>'+ $('#date4').next().text() +'<span class="ico">-com_work_day삭제</span></button></li>');
												$('.items').append('<li id="date5" name="week" data-group="date5"><button>'+ $('#date5').next().text() +'<span class="ico">-com_work_day삭제</span></button></li>');
												$('.items').append('<li id="date6" name="week" data-group="date6"><button>'+ $('#date6').next().text() +'<span class="ico">-com_work_day삭제</span></button></li>');
												$('.items').append('<li id="date7" name="week" data-group="date7"><button>'+ $('#date7').next().text() +'<span class="ico">-com_work_day삭제</span></button></li>');
												break;
											case 'date4': //화 check해제
												$('.items').append('<li id="date3" name="week" data-group="date3"><button>'+ $('#date3').next().text() +'<span class="ico">-com_work_day삭제</span></button></li>');
												$('.items').append('<li id="date5" name="week" data-group="date5"><button>'+ $('#date5').next().text() +'<span class="ico">-com_work_day삭제</span></button></li>');
												$('.items').append('<li id="date6" name="week" data-group="date6"><button>'+ $('#date6').next().text() +'<span class="ico">-com_work_day삭제</span></button></li>');
												$('.items').append('<li id="date7" name="week" data-group="date7"><button>'+ $('#date7').next().text() +'<span class="ico">-com_work_day삭제</span></button></li>');
												break;
											case 'date5': //수 check해제
												$('.items').append('<li id="date3" name="week" data-group="date3"><button>'+ $('#date3').next().text() +'<span class="ico">-com_work_day삭제</span></button></li>');
												$('.items').append('<li id="date4" name="week" data-group="date4"><button>'+ $('#date4').next().text() +'<span class="ico">-com_work_day삭제</span></button></li>');
												$('.items').append('<li id="date6" name="week" data-group="date6"><button>'+ $('#date6').next().text() +'<span class="ico">-com_work_day삭제</span></button></li>');
												$('.items').append('<li id="date7" name="week" data-group="date7"><button>'+ $('#date7').next().text() +'<span class="ico">-com_work_day삭제</span></button></li>');
												break;
											case 'date6': //목 check해제
												$('.items').append('<li id="date3" name="week" data-group="date3"><button>'+ $('#date3').next().text() +'<span class="ico">-com_work_day삭제</span></button></li>');
												$('.items').append('<li id="date4" name="week" data-group="date4"><button>'+ $('#date4').next().text() +'<span class="ico">-com_work_day삭제</span></button></li>');
												$('.items').append('<li id="date5" name="week" data-group="date5"><button>'+ $('#date5').next().text() +'<span class="ico">-com_work_day삭제</span></button></li>');
												$('.items').append('<li id="date7" name="week" data-group="date7"><button>'+ $('#date7').next().text() +'<span class="ico">-com_work_day삭제</span></button></li>');
												break;
											case 'date7': //금 check해제
												$('.items').append('<li id="date3" name="week" data-group="date3"><button>'+ $('#date3').next().text() +'<span class="ico">-com_work_day삭제</span></button></li>');
												$('.items').append('<li id="date4" name="week" data-group="date4"><button>'+ $('#date4').next().text() +'<span class="ico">-com_work_day삭제</span></button></li>');
												$('.items').append('<li id="date5" name="week" data-group="date5"><button>'+ $('#date5').next().text() +'<span class="ico">-com_work_day삭제</span></button></li>');
												$('.items').append('<li id="date6" name="week" data-group="date6"><button>'+ $('#date6').next().text() +'<span class="ico">-com_work_day삭제</span></button></li>');
												break;
										}
									}
								} else if (chkid == 'date8' || chkid == 'date9') {
									//토,일 모두 선택 아닐시
									$label.css({'font-weight':'unset', 'border':'none', 'border-radius':'0px', 'background-color':'white'});
									var gdata = '[data-group*=' + chkid + ']';
									$('.items li').remove(gdata);
									var len = $('.items li[name=weekend]').length;
									console.log('len-------'+len);
									
									$('#date2').next().css({'font-weight':'unset', 'border':'none', 'border-radius':'0px', 'background-color':'white'});
									$('#date2').prop('checked', false);
									$('.items li[id=date2]').remove(); //검색창에 주말 삭제
									
									//검색창에 요일추가
									if (len == 0 && wklen == 0) {
										switch (chkid) {
										case 'date8': //토 check해제
											$('.items').append('<li id="date9" name="weekend" data-group="date9"><button>'+ $('#date9').next().text() +'<span class="ico">-com_work_day삭제</span></button></li>');
											break;
										case 'date9': //일 check해제
											$('.items').append('<li id="date8" name="weekend" data-group="date8"><button>'+ $('#date8').next().text() +'<span class="ico">-com_work_day삭제</span></button></li>');
											break;
										}
									}
								} else {
									$label.css({'font-weight':'unset', 'border':'none', 'border-radius':'0px', 'background-color':'white'});
									//console.log('2---------');
									var gdata = '[data-group*=' + chkid + ']';
									$('.items li').remove(gdata);
								}
								//조건이 없으면 검색창 없애기
								if ($('.items').find('li').length == 0) {
									$('.resultSetWrap').hide();
								}
							}
						});
						//console.log('3---------');
						//console.log($('.items li').data());
					}
				}
			});

			//검색창-선택한 조건 삭제할때
			$('.items').on('click', 'li', function() {
				var clkid = $(this).attr('id');
				console.log(clkid);
				console.log($('.detailBox .one, .detailBox .two').find('.input[id='+clkid+']'));
				$('.detailBox .one, .detailBox .two').find('input[id='+ clkid +']').next().css({'font-weight':'unset', 'border':'none', 'border-radius':'0px', 'background-color':'white'});
				$(this).remove();

				//조건이 없을 때 검색창 없애기
				if ($('.items').find('li').length == 0) {
					$('.resultSetWrap').hide();
				}
			});

			//검색창-초기화 버튼 클릭 시
			$('.item_reset').click(function() {
				$('.resultSetWrap').hide();
				$('.items li').remove();
				$('.lb_tag').css({'font-weight':'unset', 'border':'none', 'border-radius':'0px', 'background-color':'white'});
				$('.item input').prop('checked', false);
				//$('.detailBox>dl>dt').css({'background-color':'rgb(241, 241, 243)'});
				//$('.detailBox>dl>dt').find('p').css({'color':'rgb(100, 100, 100)'});
				
				$.ajax({
					type : 'post',
					url : 'workingholiday.jj?page=whclear',
					success : function(data) {
						$('.list_form').html(data);
						$('.wh_list').hide();
						$('.wh_list').slice(0, 15).css('display', 'inline-block');
						$('.more_div').show();
					}
				});
			});

			//검색조건-큰 조건 선택 시(글자색)
			function clchange(e) {
				var cl = e ? '#f1f1f3' : '#646464';
				onclk1 = !onclk1;
				return cl;
			};

			//검색조건-큰 조건 선택 시(배경색)
			function backclchange(e) {
				var backcl = e ? '#2c609c' : '#f1f1f3';
				onclk2 = !onclk2;
				return backcl;
			};

			//검색조건-미선택된 큰 조건(글자색)
			function clchange2(e) {
				var cl2 = e ? '#646464' : '#646464';
				offclk1 = !offclk1;
				return cl2;
			};

			//검색조건-미선택된 큰 조건(배경색)
			function backclchange2(e) {
				var backcl2 = e ? '#f1f1f3' : '#f1f1f3';
				offclk2 = !offclk2;
				return backcl2;
			}
			
			
			//선택된 조건 버튼 클릭시
			$('.btn_sch').click(function() {
				var txt = $('.items button').text();
				//$('form[name=btn]').attr('action', 'workingholiday.jj?page=whsearch&txt='+txt);
				
				
				//console.log(txt);
				
				$.ajax({
					type : 'post',
					url : 'workingholiday.jj?page=whsearch&txt='+txt,
					success : function(data) {
						$('.list_form').html(data);
						
						if ($('.wh_list').length > 15) {
							$('.wh_list').hide();
							$('.wh_list').slice(0, 15).css('display', 'inline-block');	
						} else {
							$('.wh_list').css('display', 'inline-block');	
							$('.more_div').hide();
						}
					}
				});
			});
			
			//사이드바 
			$('.sideBar_cont li').click(function() {
				$('.modal_contents').empty(); //내용칸 비워두기
				
				var $li = $(this).text();
				$('.modal_title').text($li);
				
				if ($li == '해외취업 통계정보') {
					$.ajax({
						type : 'post',
						url : 'workingholiday.jj?page=publicInfo1',
						success : function(data) {
							$('.modal_contents').html(data);
						}
					});
				} else if ($li == '해외취업 모집공고 정보') { //해외진출정보
					$.ajax({
						type : 'post',
						url : 'workingholiday.jj?page=publicInfo2',
						success : function(data) {
							$('.modal_contents').html(data);
						}
					});
				} else if ($li == '해외취업 News 소식') {
					$.ajax({
						type : 'post',
						url : 'workingholiday.jj?page=publicInfo3',
						success : function(data) {
							$('.modal_contents').html(data);
						}
					});
				}
				
				$('.modal_wrap').show();
				
				//스크롤 막기
				$('body').css({'overflow' : 'hidden'});
				/*$('.workingholiday').on('scroll touchmove mousewheel', function(event) {
					event.preventDefault();
					event.stopPropagation();
					return false;
				});*/
			});
			
			//모달창 close 클릭시
			$('.modal_close').click(function() {
				$('.modal_wrap').hide();
				$('body').css({'overflow' : 'auto'});
			});
			
			//페이징
			$('.wh_list').hide();
			$('.wh_list').slice(0, 15).css('display', 'inline-block');
			
			$('.more_div').click(function() {
				$('.wh_list:hidden').slice(0, 9).css('display', 'inline-block');
				
				if ($('.wh_list:hidden').length == 0)
					$('input[name=more_btn]').hide();
			});
		});
	</script>
</head>
<body>
	<jsp:include page="main_header.jsp" />
	
	<div class="workingholiday">
		<section>
			<article>
				<div id="detailArea">
					<h2>워킹홀리데이 > 상세검색</h2>
					<div id="boxcenter">
						<!-- 상세검색-직종,국가,도시,학력,전공,언어수준 메뉴바 -->
						<div class="detailBox">
							<dl class="job">
								<dt>
									<p>직종</p>
									<img src="img/icon/arrow_down.png" class="arrdown" />
									<img src="img/icon/arrow_up.png" class="arrup" />
								</dt>
								<dd class="nano">
									<ul>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="jb1" name="duty">
											<label class="lb_tag" for="jb1">외식음료</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="jb2" name="duty">
											<label class="lb_tag" for="jb2">유통판매</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="jb3" name="duty">
											<label class="lb_tag" for="jb3">문화/여가/생활</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="jb4" name="duty">
											<label class="lb_tag" for="jb4">서비스</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="jb5" name="duty">
											<label class="lb_tag" for="jb5">사무회계</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="jb6" name="duty">
											<label class="lb_tag" for="jb6">생산/건설</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="jb7" name="duty">
											<label class="lb_tag" for="jb7">교육/강사</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="jb8" name="duty">
											<label class="lb_tag" for="jb8">미디어</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="jb9" name="duty">
											<label class="lb_tag" for="jb9">운전/배달</label>
										</li>
									</ul>
								</dd>
								<dd class="ly_sub">
									<!-- 직종 상세 레이어 -->
									<div class="ly_sub_cnt">
										<dl class="detail_sec">
											<!-- 대분류 -->
											<dt class="blind">1차직종</dt>
											<dd class="d_nano">
												<ul>
													<li class="item">
														<input type="checkbox" class="inp_chk" id="job1" name="duty">
														<label class="lb_tag" for="job1" value="com_job1">외식음료</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk" id="job2" name="duty">
														<label class="lb_tag" for="job2" value="com_job1">유통판매</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk" id="job3" name="duty">
														<label class="lb_tag" for="job3" value="com_job1">문화/여가/생활</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk" id="job4" name="duty">
														<label class="lb_tag" for="job4" value="com_job1">서비스</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk" id="job5" name="duty">
														<label class="lb_tag" for="job5" value="com_job1">사무회계</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk" id="job6" name="duty">
														<label class="lb_tag" for="job6" value="com_job1">생산/건설</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk" id="job7" name="duty">
														<label class="lb_tag" for="job7" value="com_job1">교육/강사</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk" id="job8" name="duty">
														<label class="lb_tag" for="job8" value="com_job1">미디어</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk" id="job9" name="duty">
														<label class="lb_tag" for="job9" value="com_job1">운전/배달</label>
													</li>
												</ul>
											</dd>
										</dl>
										<dl class="detail_sec two">
											<!-- 검색결과 -->
											<dt class="blind">2차직종</dt>
											<dd class="d_nano">
												<ul>
													<%-- 외식음료 --%>
													<li class="item">
														<input type="checkbox" class="inp_chk sub1" id="job1_c1" name="duty1">
														<label class="lb_tag" for="job1_c1">전체</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub1" id="job1_c2" name="duty1">
														<label class="lb_tag" for="job1_c2" value="com_job2">일반음식점</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub1" id="job1_c3" name="duty1">
														<label class="lb_tag" for="job1_c3" value="com_job2">레스토랑</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub1" id="job1_c4" name="duty1">
														<label class="lb_tag" for="job1_c4" value="com_job2">패스트푸드</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub1" id="job1_c5" name="duty1">
														<label class="lb_tag" for="job1_c5" value="com_job2">커피/디저트</label>
													</li>
													
													<%-- 유통판매 --%>
													<li class="item">
														<input type="checkbox" class="inp_chk sub2" id="job2_c1" name="duty2">
														<label class="lb_tag" for="job2_c1">전체</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub2" id="job2_c2" name="duty2">
														<label class="lb_tag" for="job2_c2" value="com_job2">백화점/면세점</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub2" id="job2_c3" name="duty2">
														<label class="lb_tag" for="job2_c3" value="com_job2">대형마트</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub2" id="job2_c4" name="duty2">
														<label class="lb_tag" for="job2_c4" value="com_job2">편의점</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub2" id="job2_c5" name="duty2">
														<label class="lb_tag" for="job2_c5" value="com_job2">의류/잡화매장</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub2" id="job2_c6" name="duty2">
														<label class="lb_tag" for="job2_c6" value="com_job2">서점/문구</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub2" id="job2_c7" name="duty2">
														<label class="lb_tag" for="job2_c7" value="com_job2">약국</label>
													</li>
													
													<%-- 문화/여가/생활 --%>
													<li class="item">
														<input type="checkbox" class="inp_chk sub3" id="job3_c1" name="duty3">
														<label class="lb_tag" for="job3_c1">전체</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub3" id="job3_c2" name="duty3">
														<label class="lb_tag" for="job3_c2" value="com_job2">놀이공원/테마파크</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub3" id="job3_c3" name="duty3">
														<label class="lb_tag" for="job3_c3" value="com_job2">호텔/숙박</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub3" id="job3_c4" name="duty3">
														<label class="lb_tag" for="job3_c4" value="com_job2">영화/공연</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub3" id="job3_c5" name="duty3">
														<label class="lb_tag" for="job3_c5" value="com_job2">피트니스/스포츠</label>
													</li>
													
													<%-- 서비스 --%>
													<li class="item">
														<input type="checkbox" class="inp_chk sub4" id="job4_c1" name="duty4">
														<label class="lb_tag" for="job4_c1">전체</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub4" id="job4_c2" name="duty4">
														<label class="lb_tag" for="job4_c2" value="com_job2">서빙</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub4" id="job4_c3" name="duty4">
														<label class="lb_tag" for="job4_c3" value="com_job2">주방보조/설거지</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub4" id="job4_c4" name="duty4">
														<label class="lb_tag" for="job4_c4" value="com_job2">캐셔/카운터</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub4" id="job4_c5" name="duty4">
														<label class="lb_tag" for="job4_c5" value="com_job2">바리스타</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub4" id="job4_c6" name="duty4">
														<label class="lb_tag" for="job4_c6" value="com_job2">안내데스크/매표</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub4" id="job4_c7" name="duty4">
														<label class="lb_tag" for="job4_c7" value="com_job2">주차관리</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub4" id="job4_c8" name="duty4">
														<label class="lb_tag" for="job4_c8" value="com_job2">헤어/미용</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub4" id="job4_c9" name="duty4">
														<label class="lb_tag" for="job4_c9" value="com_job2">청소/미화</label>
													</li>
													
													<%-- 사무회계 --%>
													<li class="item">
														<input type="checkbox" class="inp_chk sub5" id="job5_c1" name="duty5">
														<label class="lb_tag" for="job5_c1">전체</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub5" id="job5_c2" name="duty5">
														<label class="lb_tag" for="job5_c2" value="com_job2">사무보조</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub5" id="job5_c3" name="duty5">
														<label class="lb_tag" for="job5_c3" value="com_job2">번역/통역</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub5" id="job5_c4" name="duty5">
														<label class="lb_tag" for="job5_c4" value="com_job2">복사/출력/제본</label>
													</li>
													
													<%-- 생산/건설 --%>
													<li class="item">
														<input type="checkbox" class="inp_chk sub6" id="job6_c1" name="duty6">
														<label class="lb_tag" for="job6_c1">전체</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub6" id="job6_c2" name="duty6">
														<label class="lb_tag" for="job6_c2" value="com_job2">제조/가공</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub6" id="job6_c3" name="duty6">
														<label class="lb_tag" for="job6_c3" value="com_job2">상하차/소화물분류</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub6" id="job6_c4" name="duty6">
														<label class="lb_tag" for="job6_c4" value="com_job2">공사/건설현장</label>
													</li>
													
													<%-- 교육/강사 --%>
													<li class="item">
														<input type="checkbox" class="inp_chk sub7" id="job7_c1" name="duty7">
														<label class="lb_tag" for="job7_c1" value="com_job2">보조교사</label>
													</li>
													
													<%-- 미디어 --%>
													<li class="item">
														<input type="checkbox" class="inp_chk sub8" id="job8_c1" name="duty8">
														<label class="lb_tag" for="job8_c1">전체</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub8" id="job8_c2" name="duty8">
														<label class="lb_tag" for="job8_c2" value="com_job2">보조출연/방청</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub8" id="job8_c3" name="duty8">
														<label class="lb_tag" for="job8_c3" value="com_job2">방송스텝/촬영보조</label>
													</li>
													
													<%-- 운전/배달 --%>
													<li class="item">
														<input type="checkbox" class="inp_chk sub9" id="job9_c1" name="duty9">
														<label class="lb_tag" for="job9_c1">전체</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub9" id="job9_c2" name="duty9">
														<label class="lb_tag" for="job9_c2" value="com_job2">운반/이사</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub9" id="job9_c3" name="duty9">
														<label class="lb_tag" for="job9_c3" value="com_job2">대리운전/일반운전</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub9" id="job9_c4" name="duty9">
														<label class="lb_tag" for="job9_c4" value="com_job2">택배/퀵서비스</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub9" id="job9_c5" name="duty9">
														<label class="lb_tag" for="job9_c5" value="com_job2">배달</label>
													</li>
												</ul>
											</dd>
										</dl>
									</div>
								</dd>
							</dl>
							<dl class="nation">
								<dt>
									<p>국가</p>
									<img src="img/icon/arrow_down.png" class="arrdown" />
									<img src="img/icon/arrow_up.png" class="arrup" />
								</dt>
								<dd class="nano">
									<ul>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="nt1" name="nation">
											<label class="lb_tag" for="nt1">일본</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="nt2" name="nation">
											<label class="lb_tag" for="nt2">캐나다</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="nt3" name="nation">
											<label class="lb_tag" for="nt3">필리핀</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="nt4" name="nation">
											<label class="lb_tag" for="nt4">미국</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="nt5" name="nation">
											<label class="lb_tag" for="nt5">호주</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="nt6" name="nation">
											<label class="lb_tag" for="nt6">뉴질랜드</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="nt7" name="nation">
											<label class="lb_tag" for="nt7">동남아</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="nt8" name="nation">
											<label class="lb_tag" for="nt8">중국</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="nt9" name="nation">
											<label class="lb_tag" for="nt9">유럽</label>
										</li>
									</ul>
								</dd>
								<dd class="ly_sub">
									<!-- 국가 상세 레이어 -->
									<div class="ly_sub_cnt">
										<dl class="detail_sec">
											<!-- 대분류 -->
											<dt class="blind">1차-국가</dt>
											<dd class="d_nano">
												<ul>
													<li class="item">
														<input type="checkbox" class="inp_chk" id="nat1" name="nation">
														<label class="lb_tag" for="nat1" value="com_country">일본</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk" id="nat2" name="nation">
														<label class="lb_tag" for="nat2" value="com_country">캐나다</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk" id="nat3" name="nation">
														<label class="lb_tag" for="nat3" value="com_country">필리핀</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk" id="nat4" name="nation">
														<label class="lb_tag" for="nat4" value="com_country">미국</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk" id="nat5" name="nation">
														<label class="lb_tag" for="nat5" value="com_country">호주</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk" id="nat6" name="nation">
														<label class="lb_tag" for="nat6" value="com_country">뉴질랜드</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk" id="nat7" name="nation">
														<label class="lb_tag" for="nat7" value="com_country">동남아</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk" id="nat8" name="nation">
														<label class="lb_tag" for="nat8" value="com_country">중국</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk" id="nat9" name="nation">
														<label class="lb_tag" for="nat9" value="com_country">유럽</label>
													</li>
												</ul>
											</dd>
										</dl>
										<dl class="detail_sec two">
											<!-- 검색결과 -->
											<dt class="blind">2차-도시</dt>
											<dd class="d_nano">
												<ul>
													<%-- 일본 --%>
													<li class="item">
														<input type="checkbox" class="inp_chk sub10" id="nat1_step1" name="nation1">
														<label class="lb_tag" for="nat1_step1">전체</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub10" id="nat1_step2" name="nation1">
														<label class="lb_tag" for="nat1_step2" value="com_city">도쿄</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub10" id="nat1_step3" name="nation1">
														<label class="lb_tag" for="nat1_step3" value="com_city">오사카</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub10" id="nat1_step4" name="nation1">
														<label class="lb_tag" for="nat1_step4" value="com_city">후쿠오카</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub10" id="nat1_step5" name="nation1">
														<label class="lb_tag" for="nat1_step5" value="com_city">교토</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub10" id="nat1_step6" name="nation1">
														<label class="lb_tag" for="nat1_step6" value="com_city">나고야</label>
													</li>
													
													<%-- 캐나다 --%>
													<li class="item">
														<input type="checkbox" class="inp_chk sub11" id="nat2_step1" name="nation2">
														<label class="lb_tag" for="nat2_step1">전체</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub11" id="nat2_step2" name="nation2">
														<label class="lb_tag" for="nat2_step2" value="com_city">벤쿠버</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub11" id="nat2_step3" name="nation2">
														<label class="lb_tag" for="nat2_step3" value="com_city">토론토</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub11" id="nat2_step4" name="nation2">
														<label class="lb_tag" for="nat2_step4" value="com_city">캘거리</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub11" id="nat2_step5" name="nation2">
														<label class="lb_tag" for="nat2_step5" value="com_city">빅토리아</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub11" id="nat2_step6" name="nation2">
														<label class="lb_tag" for="nat2_step6" value="com_city">몬트리올</label>
													</li>
													
													<%-- 필리핀 --%>
													<li class="item">
														<input type="checkbox" class="inp_chk sub12" id="nat3_step1" name="nation3">
														<label class="lb_tag" for="nat3_step1">전체</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub12" id="nat3_step2" name="nation3">
														<label class="lb_tag" for="nat3_step2" value="com_city">세부</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub12" id="nat3_step3" name="nation3">
														<label class="lb_tag" for="nat3_step3" value="com_city">바기오</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub12" id="nat3_step4" name="nation3">
														<label class="lb_tag" for="nat3_step4" value="com_city">마닐라</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub12" id="nat3_step5" name="nation3">
														<label class="lb_tag" for="nat3_step5" value="com_city">일로일로</label>
													</li>
													
													<%-- 미국 --%>
													<li class="item">
														<input type="checkbox" class="inp_chk sub13" id="nat4_step1" name="nation4">
														<label class="lb_tag" for="nat4_step1">전체</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub13" id="nat4_step2" name="nation4">
														<label class="lb_tag" for="nat4_step2" value="com_city">뉴욕</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub13" id="nat4_step3" name="nation4">
														<label class="lb_tag" for="nat4_step3" value="com_city">보스턴</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub13" id="nat4_step4" name="nation4">
														<label class="lb_tag" for="nat4_step4" value="com_city">샌프란시스코</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub13" id="nat4_step5" name="nation4">
														<label class="lb_tag" for="nat4_step5" value="com_city">시카고</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub13" id="nat4_step6" name="nation4">
														<label class="lb_tag" for="nat4_step6" value="com_city">로스앤젤레스</label>
													</li>
													
													<%-- 호주 --%>
													<li class="item">
														<input type="checkbox" class="inp_chk sub14" id="nat5_step1" name="nation5">
														<label class="lb_tag" for="nat5_step1">전체</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub14" id="nat5_step2" name="nation5">
														<label class="lb_tag" for="nat5_step2" value="com_city">시드니</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub14" id="nat5_step3" name="nation5">
														<label class="lb_tag" for="nat5_step3" value="com_city">브리즈번</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub14" id="nat5_step4" name="nation5">
														<label class="lb_tag" for="nat5_step4" value="com_city">멜버른</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub14" id="nat5_step5" name="nation5">
														<label class="lb_tag" for="nat5_step5" value="com_city">퍼스</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub14" id="nat5_step6" name="nation5">
														<label class="lb_tag" for="nat5_step6" value="com_city">골드코스트</label>
													</li>
													
													<%-- 뉴질랜드 --%>
													<li class="item">
														<input type="checkbox" class="inp_chk sub15" id="nat6_step1" name="nation6">
														<label class="lb_tag" for="nat6_step1">전체</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub15" id="nat6_step2" name="nation6">
														<label class="lb_tag" for="nat6_step2" value="com_city">오클랜드</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub15" id="nat6_step3" name="nation6">
														<label class="lb_tag" for="nat6_step3" value="com_city">웰링턴</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub15" id="nat6_step4" name="nation6">
														<label class="lb_tag" for="nat6_step4" value="com_city">퀸스타운</label>
													</li>
													
													<%-- 동남아 --%>
													<li class="item">
														<input type="checkbox" class="inp_chk sub16" id="nat7_step1" name="nation6">
														<label class="lb_tag" for="nat7_step1">전체</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub16" id="nat7_step2" name="nation6">
														<label class="lb_tag" for="nat7_step2">방콕</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub16" id="nat7_step3" name="nation6">
														<label class="lb_tag" for="nat7_step3">세부</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub16" id="nat7_step4" name="nation6">
														<label class="lb_tag" for="nat7_step4">싱가포르</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub16" id="nat7_step5" name="nation6">
														<label class="lb_tag" for="nat7_step5">다낭</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub16" id="nat7_step6" name="nation6">
														<label class="lb_tag" for="nat7_step6">타이베이</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub16" id="nat7_step7" name="nation6">
														<label class="lb_tag" for="nat7_step7">마닐라</label>
													</li>
													
													<%-- 중국 --%>
													<li class="item">
														<input type="checkbox" class="inp_chk sub17" id="nat8_step1" name="nation6">
														<label class="lb_tag" for="nat8_step1">전체</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub17" id="nat8_step2" name="nation6">
														<label class="lb_tag" for="nat8_step2">상하이</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub17" id="nat8_step3" name="nation6">
														<label class="lb_tag" for="nat8_step3">베이징</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub17" id="nat8_step4" name="nation6">
														<label class="lb_tag" for="nat8_step4">광저우</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub17" id="nat8_step5" name="nation6">
														<label class="lb_tag" for="nat8_step5">청도</label>
													</li>
													
													<%-- 유럽 --%>
													<li class="item">
														<input type="checkbox" class="inp_chk sub18" id="nat9_step1" name="nation6">
														<label class="lb_tag" for="nat9_step1">전체</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub18" id="nat9_step2" name="nation6">
														<label class="lb_tag" for="nat9_step2">로마</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub18" id="nat9_step3" name="nation6">
														<label class="lb_tag" for="nat9_step3">프랑크푸르트</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub18" id="nat9_step4" name="nation6">
														<label class="lb_tag" for="nat9_step4">런던</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub18" id="nat9_step5" name="nation6">
														<label class="lb_tag" for="nat9_step5">바르셀로나</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub18" id="nat9_step6" name="nation6">
														<label class="lb_tag" for="nat9_step6">파리</label>
													</li>
													<li class="item">
														<input type="checkbox" class="inp_chk sub18" id="nat9_step7" name="nation6">
														<label class="lb_tag" for="nat9_step7">프라하</label>
													</li>
												</ul>
											</dd>
										</dl>
									</div>
								</dd>
							</dl>
							<dl class="edu">
								<dt>
									<p>학력</p>
									<img src="" />
								</dt>
								<dd class="nano one">
									<ul>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="edu1" name="edu" value="1">
											<label class="lb_tag" for="edu1" value="com_edu_level">대학교졸업(4년)</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="edu2" name="edu" value="2">
											<label class="lb_tag" for="edu2" value="com_edu_level">대학졸업(2,3년)</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="edu3" name="edu" value="3">
											<label class="lb_tag" for="edu3" value="com_edu_level">고등학교졸업</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="edu4" name="edu" value="4">
											<label class="lb_tag" for="edu4" value="com_edu_level">학력무관</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="edu5" name="edu" value="5">
											<label class="lb_tag" for="edu5" value="com_edu_level">대학원 석사졸업</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="edu6" name="edu" value="6">
											<label class="lb_tag" for="edu6" value="com_edu_level">대학원 박사졸업</label>
										</li>
									</ul>
								</dd>
							</dl>
							<dl class="major">
								<dt>
									<p>전공</p>
									<img src="" />
									<%--
									<img src="img/icon/arrow_down.png" class="arrdown" />
									<img src="img/icon/arrow_up.png" class="arrup" />
									--%>
								</dt>
								<dd class="nano one">
									<ul>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="mjr1" name="major">
											<label class="lb_tag" for="mjr1" value="com_major">공학계열</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="mjr2" name="major">
											<label class="lb_tag" for="mjr2" value="com_major">자연계열</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="mjr3" name="major">
											<label class="lb_tag" for="mjr3" value="com_major">사회계열</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="mjr4" name="major">
											<label class="lb_tag" for="mjr4" value="com_major">인문계열</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="mjr5" name="major">
											<label class="lb_tag" for="mjr5" value="com_major">예체능계열</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="mjr6" name="major">
											<label class="lb_tag" for="mjr6" value="com_major">교육계열</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="mjr7" name="major">
											<label class="lb_tag" for="mjr7" value="com_major">의약계열</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="mjr8" name="major">
											<label class="lb_tag" for="mjr8" value="com_major">전공무관</label>
										</li>
									</ul>
								</dd>
								<%-- 
								<dd class="ly_sub">
									<!-- 전공 상세 레이어 -->
									<div class="ly_sub_cnt">
										<dl class="detail_sec">
											<!-- 대분류 -->
											<dt class="blind">계열</dt>
											<dd class="d_nano">
												<ul></ul>
											</dd>
										</dl>
										<dl class="detail_sec">
											<!-- 검색결과 -->
											<dt class="blind">전공</dt>
											<dd class="d_nano">
												<ul></ul>
											</dd>
										</dl>
									</div>
								</dd>
								--%>
							</dl>
							<dl class="license">
								<dt>
									<p>자격증</p>
									<img src="" />
								</dt>
								<dd class="nano one">
									<ul>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="lics1" name="license">
											<label class="lb_tag" for="lics1" value="com_license">TOEIC</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="lics2" name="license">
											<label class="lb_tag" for="lics2" value="com_license">TOEFL</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="lics3" name="license">
											<label class="lb_tag" for="lics3" value="com_license">JPT</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="lics4" name="license">
											<label class="lb_tag" for="lics4" value="com_license">보건증</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="lics5" name="license">
											<label class="lb_tag" for="lics5" value="com_license">면허증</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="lics6" name="license">
											<label class="lb_tag" for="lics6" value="com_license">일본어가능자</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="lics7" name="license">
											<label class="lb_tag" for="lics7" value="com_license">중국어가능자</label>
										</li>
									</ul>
								</dd>
							</dl>
						</div>
						<div class="detailBox">
							<!-- 급여,복리후생,근무기간,근무요일,근무시간 메뉴바 -->
							<dl class="salary">
								<dt>
									<p>급여</p>
									<img src="" />
								</dt>
								<dd class="nano one">
									<ul>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="sal1" name="salary">
											<label class="lb_tag" for="sal1" value="com_salary">시급</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="sal2" name="salary">
											<label class="lb_tag" for="sal2" value="com_salary">일급</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="sal3" name="salary">
											<label class="lb_tag" for="sal3" value="com_salary">주급</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="sal4" name="salary">
											<label class="lb_tag" for="sal4" value="com_salary">월급</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="sal5" name="salary">
											<label class="lb_tag" for="sal5" value="com_salary">연봉</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="sal6" name="salary">
											<label class="lb_tag" for="sal6" value="com_salary">건별</label>
										</li>
									</ul>
								</dd>
							</dl>
							<dl class="benefit">
								<dt>
									<p>복리후생</p>
									<img src="" />
								</dt>
								<dd class="nano one">
									<ul>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="bnf1" name="benefit">
											<label class="lb_tag" for="bnf1" value="com_benefits">인센티브</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="bnf2" name="benefit">
											<label class="lb_tag" for="bnf2" value="com_benefits">휴게실</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="bnf3" name="benefit">
											<label class="lb_tag" for="bnf3" value="com_benefits">휴가비</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="bnf4" name="benefit">
											<label class="lb_tag" for="bnf4" value="com_benefits">셔틀버스</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="bnf5" name="benefit">
											<label class="lb_tag" for="bnf5" value="com_benefits">식비</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="bnf6" name="benefit">
											<label class="lb_tag" for="bnf6" value="com_benefits">퇴직금</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="bnf7" name="benefit">
											<label class="lb_tag" for="bnf7" value="com_benefits">기숙사지원</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="bnf8" name="benefit">
											<label class="lb_tag" for="bnf8" value="com_benefits">야간근로수당</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="bnf9" name="benefit">
											<label class="lb_tag" for="bnf9" value="com_benefits">정기휴가</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="bnf10" name="benefit">
											<label class="lb_tag" for="bnf10" value="com_benefits">포상휴가</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="bnf11" name="benefit">
											<label class="lb_tag" for="bnf11" value="com_benefits">임직원할인</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="bnf12" name="benefit">
											<label class="lb_tag" for="bnf12" value="com_benefits">헬스지원</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="bnf13" name="benefit">
											<label class="lb_tag" for="bnf13" value="com_benefits">해외연수</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="bnf14" name="benefit">
											<label class="lb_tag" for="bnf14" value="com_benefits">사내대출</label>
										</li>
									</ul>
								</dd>
							</dl>
							<dl class="term">
								<dt>
									<p>근무기간</p>
									<img src="" />
								</dt>
								<dd class="nano one">
									<ul>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="term1" name="term">
											<label class="lb_tag" for="term1" value="com_work_period">1일</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="term2" name="term">
											<label class="lb_tag" for="term2" value="com_work_period">1주일이내</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="term3" name="term">
											<label class="lb_tag" for="term3" value="com_work_period">1주일~1개월</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="term4" name="term">
											<label class="lb_tag" for="term4" value="com_work_period">1개월~3개월</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="term5" name="term">
											<label class="lb_tag" for="term5" value="com_work_period">3개월~6개월</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="term6" name="term">
											<label class="lb_tag" for="term6" value="com_work_period">6개월~1년</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="term7" name="term">
											<label class="lb_tag" for="term7" value="com_work_period">1년이상</label>
										</li>
									</ul>
								</dd>
							</dl>
							<dl class="date">
								<dt>
									<p>근무요일</p>
									<img src="" />
								</dt>
								<dd class="nano one">
									<ul>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="date1" name="date">
											<label class="lb_tag" for="date1" value="com_work_days">평일(월~금)</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="date2" name="date">
											<label class="lb_tag" for="date2" value="com_work_days">주말(토,일)</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="date3" name="week">
											<label class="lb_tag" for="date3" value="com_work_day">월</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="date4" name="week">
											<label class="lb_tag" for="date4" value="com_work_day">화</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="date5" name="week">
											<label class="lb_tag" for="date5" value="com_work_day">수</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="date6" name="week">
											<label class="lb_tag" for="date6" value="com_work_day">목</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="date7" name="week">
											<label class="lb_tag" for="date7" value="com_work_day">금</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="date8" name="weekend">
											<label class="lb_tag" for="date8" value="com_work_day">토</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="date9" name="weekend">
											<label class="lb_tag" for="date9" value="com_work_day">일</label>
										</li>
									</ul>
								</dd>
							</dl>
							<dl class="time">
								<dt>
									<p>근무시간</p>
									<img src="" />
								</dt>
								<dd class="nano one">
									<ul>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="time1" name="time">
											<label class="lb_tag" for="time1" value="wtime">오전</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="time2" name="time">
											<label class="lb_tag" for="time2" value="wtime">오후</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="time3" name="time">
											<label class="lb_tag" for="time3" value="wtime">저녁</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="time4" name="time">
											<label class="lb_tag" for="time4" value="wtime">새벽</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="time5" name="time">
											<label class="lb_tag" for="time5" value="wtime">오전~오후</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="time6" name="time">
											<label class="lb_tag" for="time6" value="wtime">오후~저녁</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="time7" name="time">
											<label class="lb_tag" for="time7" value="wtime">저녁~새벽</label>
										</li>
										<li class="item">
											<input type="checkbox" class="inp_chk" id="time8" name="time">
											<label class="lb_tag" for="time8" value="wtime">새벽~오전</label>
										</li><li class="item">
											<input type="checkbox" class="inp_chk" id="time9" name="time">
											<label class="lb_tag" for="time9" value="wtime">종일</label>
										</li>
									</ul>
								</dd>
							</dl>
						</div>
						<div class="resultSetWrap">
							<form name="btn" method="post">
								<div class="resultSet">
									<dl class="listWrap">
										<dt class="blind">선택된 조건값</dt>
										<dd class="resultList">
											<ul class="items"></ul>
											<div class="item_reset">
												<button type="reset">
													<span></span>초기화
												</button>
											</div>
										</dd>
										<dd class="btnSet">
											<button class="btn_sch" type="button">선택된 조건 검색하기</button>
										</dd>
									</dl>
								</div>
							</form>
						</div>
					</div>
				</div>
			</article>
			<article>
				<form class="list_form">
					<div class="wrap_form">
						<%
							List<Company> list = (List<Company>)request.getAttribute("list");
							
							for (Company com : list) {
						%>
						<div class="wh_list">
							<a href="workingholiday.jj?page=whlist&com_no=<%= com.getCom_no() %>">
							<ul>
								<li>
									<p class="com_title"><%= com.getCom_title() %></p>
									<p class="com_name"><%= com.getCom_name() %></p>
									<hr>
									<p class="com_country"><%= com.getCom_country() %>(<%= com.getCom_city() %>)</p>
									<p class="com_job"><%= com.getCom_job1() %> > <%= com.getCom_job2() %></p>
									<p class="com_wtime"><%= com.getCom_start_time() + ":00~" + com.getCom_end_time() + ":00" %></p>
									
									<fmt:parseNumber var="end_time" integerOnly="true" type="number" value="<%= com.getCom_end_time() %>" />
	                            	<fmt:parseNumber var="start_time" integerOnly="true" type="number" value="<%= com.getCom_start_time() %>" />
	                            	<c:set var="etime" value="${ end_time }" />
	                            	<c:set var="stime" value="${ start_time }" />
	                            	<c:set var="wtime" value="${ etime-stime<0 ? -(etime-stime) : etime-stime }" />
	                            	
	                            	<c:set var="sal_name" value="<%= com.getCom_sal_name() %>" />
	                            	<c:set var="salary" value="<%= com.getCom_salary() %>" />
	                            	<fmt:formatNumber var="sal" value="${ salary }" /> <%-- 시급/건별 --%>
	                            	
	                            	<c:set var="day" value="${ salary*wtime }" /> <%-- 일급 --%>
	                            	<fmt:formatNumber var="result1" value="${ day }" />
	                            	
	                            	<c:set var="workdays" value="<%= com.getCom_work_days() %>" />
	                            	<c:set var="days" value="${ fn:split(workdays, ',') }" />
	                            	<c:set var="week" value="${ salary*wtime*fn:length(days) }" /> <%-- 주급 --%>
	                            	<fmt:formatNumber var="result2" value="${ week }" />
	                            	
	                            	<c:set var="month" value="${ salary*wtime*fn:length(days)*4 }" /> <%-- 월급 --%>
	                            	<fmt:formatNumber var="result3" value="${ month }" />
	                            	
	                            	<c:set var="year" value="${ salary*wtime*fn:length(days)*4*12 }" /> <%-- 연봉 --%>
	                            	<fmt:formatNumber var="result4" value="${ year }" />
	                            	
	                            	<c:if test="${ sal_name eq '시급' }">
	                            		<p class="com_sal"><%= com.getCom_sal_name() %> ${ sal }원</p>
	                            	</c:if>
	                            	<c:if test="${ sal_name eq '일급' }">
	                            		<p class="com_sal"><%= com.getCom_sal_name() %> ${ result1 }원</p>
	                            	</c:if>
	                            	<c:if test="${ sal_name eq '주급' }">
	                            		<p class="com_sal"><%= com.getCom_sal_name() %> ${ result2 }원</p>
	                            	</c:if>
	                            	<c:if test="${ sal_name eq '월급' }">
	                            		<p class="com_sal"><%= com.getCom_sal_name() %> ${ result3 }원</p>
	                            	</c:if>
	                            	<c:if test="${ sal_name eq '연봉' }">
	                            		<p class="com_sal"><%= com.getCom_sal_name() %> ${ result4 }원</p>
	                            	</c:if>
	                            	<c:if test="${ sal_name eq '건별' }">
	                            		<p class="com_sal"><%= com.getCom_sal_name() %> ${ sal }원</p>
	                            	</c:if>
	                            	
									<p class="com_etime">~<%= com.getCom_term() %></p>
								</li>
							</ul>
							</a>
						</div>
						<% } %>
					</div>
				</form>
			</article>
		</section>
		<div class="sideBar_wrap">
			<div class="sideBar_name">
				<p>해외일자리 정보</p>
			</div>
			<div class="sideBar_cont">
				<ul>
					<li>해외취업 통계정보</li>
					<li>해외취업 모집공고 정보</li>
					<li>해외취업 News 소식</li>
				</ul>
			</div>
		</div>
		<div class="more_div"><input type="button" name="more_btn" value="+ 더보기"></div>
	</div>
	<div class="modal_wrap">
		<div class="modal">
			<div class="modal_title"></div>
			<div class="modal_contents"></div>
			<div class="modal_close"><img src="img/icon/btn-layer.png"></div>
		</div>
	</div>
	
	<jsp:include page="main_footer.jsp" />
</body>
</html>