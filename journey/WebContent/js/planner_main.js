window.onload = function() {
  const kindWrap =  document.querySelector('.kind_wrap');
  const slider = kindWrap.querySelector('.slider');
  const slideLis = slider.querySelectorAll('li');

  /* ul 넓이 계산해 주기 */
  const liWidth = slideLis[0].clientWidth;
  const sliderWidth = liWidth * slideLis.length;
  slider.style.width = `${sliderWidth}px` ;

  /* 리스너 설치하기 */
  let currentIdx = 0; // 슬라이드 현재 번호
  let translate = 0; // 슬라이드 위치 값

  $("#right, .next").click(function(){   //오른쪽화살표 눌렀을때 슬라이드
      if (currentIdx !== slideLis.length -1) {
        translate -= liWidth;
        slider.style.transform = `translateX(${translate}px)`;
        currentIdx += 1;
      }
  });
   $("#left").click(function(){  //왼쪽 화살표 눌렀을 때 슬라이드
        if (currentIdx !== 0) {
          translate += liWidth;
          slider.style.transform = `translateX(${translate}px)`;
          currentIdx -= 1;
        }
      });
   

  $("#air").change(function(){ /*항공권 여부 체크박스 */
      if($("#air").is(":checked")){``
        $("#airplane").css({"border":"1px solid black", "color":"black"});
        $("#air_check").attr("src","img/icon/airplane_checked.png");
      }else{
        $("#airplane").css({"border":"1px solid gray", "color":"gray"});
        $("#air_check").attr("src","img/icon/airplane_check.png");
      }
    });
   $("#ho").change(function(){ /*숙소 여부 체크박스 */
      if($("#ho").is(":checked")){
        $("#hotel").css({"border":"1px solid black", "color":"black"});
        $("#hotel_check").attr("src","img/icon/hotel_checked.png");
      }else{
        $("#hotel").css({"border":"1px solid gray", "color":"gray"});
        $("#hotel_check").attr("src","img/icon/hotel_check.png");
      }
    });
   
   $(".departure_one").click(function(){
	  $("#departure_text").attr("value",$(this).text());
	  $("#departure_text_div").hide();
   });
   $(".nation_one, .city_one").mouseover(function(){
	   $(this).css({"text-decoration":"underline", "font-weight" :"bold"});
   });
   $(".nation_one, .city_one").mouseout(function(){
	   $(this).css({"text-decoration":"none", "font-weight" :"normal"});
   });
   $(".nation_one").click(function(){
	   $("#nation_text").attr("value",$(this).text());
	   $("#nation_text_div").hide();
	   $("table[id*='city_table_']").hide();
	   $("#plz_pick_nation").hide();
	   var text = $("#nation_text").val();
	   if(text == "베트남"){
		   $("table[id='city_table_vi']").show();
	   }else  if(text == "대만"){
		   $("table[id='city_table_taiw']").show();
	   }else  if(text == "태국"){
		   $("table[id='city_table_thai']").show();
	   }else  if(text == "필리핀"){
		   $("table[id='city_table_phil']").show();
	   }else  if(text == "미주"){
		   $("table[id='city_table_usa']").show();
	   }else  if(text == "캐나다"){
		   $("table[id='city_table_can']").show();
	   }else  if(text == "호주"){
		   $("table[id='city_table_aust']").show();
	   }else  if(text == "뉴질랜드"){
		   $("table[id='city_table_newz']").show();
	   }
	   
	   $("#city_text").attr("value","목적지(도시)");
   });
   $(".city_one").click(function(){
	   $("#city_text").attr("value",$(this).text());
	   $("#city_text_div").hide();
   });
   
   setInterval(fnSlide1, 3000);

   function fnSlide1() {
	   for(var i = 1 ; i <= 117 ; i++){
		   var ma = -160*i ; 
     $("#exchange_div1").animate({ "margin-left": ma+"px" }, 2500, function () {
     
     
     	});
	   }
   };
}

 function checking(id){ /*테마 체크 여부 */
  if($("input[id="+id+"]").is(":checked")){
    $("label[for="+id+"]").css({"background-color":"#0D112D", "color":"white"});
  }else{
    $("label[for="+id+"]").css({"background-color":"transparent", "color":"#0D112D"});
  }
 }
function login_check(){
	alert("로그인을 해주세요.");
}
function select_check(){
	var place_check = document.querySelectorAll("input[name='place']:checked").length;
	var eat_check = document.querySelectorAll("input[name='eat']:checked").length;
	
	if(document.getElementById("city_text").value === "목적지(도시)"){
		alert("목적지를 선택해주세요.");
		return false;
	}else if(document.getElementById("startDt").value == ''){
		alert("여행 시작일을 입력해주세요.");
		return false;
	}else if(document.getElementById("endDt").value == ''){
		alert("여행 종료일을 입력해주세요.");
		return false;
	}else if(place_check == 0){
		alert("테마를 입력해주세요.");
		return false;
	}else if(eat_check == 0){
		alert("음식취향을 입력해주세요.")
		return false;
	}else{

	}
	
}
function text_div(id){
	var div = document.getElementById(id+"_div");
	var input = document.getElementById(id);
	
	if(div.style.display == "block"){
		div.style.display= "none";
	}else{
		div.style.display= "block";
	}
}

function nation_open(id){
	var na_btn = document.getElementById("na_"+id);
	
	if(id === "a"){
		var text = document.getElementById("nation_text");
		text.setAttribute("value","일본");
		document.getElementById("nation_text_div").style.display = "none";
		$("table[id*='city_table_']").hide();
		$("table[id='city_table_jp']").show();
		$("#plz_pick_nation").hide();
		$("table[id*='nation_table']").hide();
		$("table[id='nation_table_empty']").show();
		$("#city_text").attr("value","목적지(도시)");
		$("td[id*='na_']").css({'font-weight':'normal', 'border' : '1px solid #6C94B8'});
	}else{
	var open_table = document.getElementById("nation_table_"+id);
	$("td[id*='na_']").css({'font-weight':'normal', 'border' : '1px solid #6C94B8'});
	$("td[id='na_"+id+"']").css({'font-weight':'bold', 'border' : '1px solid #285b89'});
	$("table[id*='nation_table']").hide();
	
	open_table.style.display = "block";
	}
}
function aa(){
	document.getElementById("city_text_div").style.display = "none";
}