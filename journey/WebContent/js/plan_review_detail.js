$(function() {
	  const slider = document.getElementById('slider');
	  const slideLis = document.getElementsByClassName('li_sli');
	  
	  //ul 넓이 계산해 주기 
	  const liWidth = slideLis[0].clientWidth;
	  const sliderWidth =  liWidth * slideLis.length;
	  slider.style.width = `${sliderWidth}px` ;

	  //리스너 설치하기 
	  let currentIdx = 0; // 슬라이드 현재 번호
	  let translate = 0; // 슬라이드 위치 값
	  
	  $("#right_btn").click(function(){   //오른쪽화살표 눌렀을때 슬라이드
		  if (currentIdx !== slideLis.length -1) {
		        translate -= liWidth;
		        slider.style.transform = `translateX(${translate}px)`;
		        currentIdx += 1;
		      }
	  });
	  $("#left_btn").click(function(){  //왼쪽 화살표 눌렀을 때 슬라이드
		  if (currentIdx !== 0) {
	          translate += liWidth;
	          slider.style.transform = `translateX(${translate}px)`;
	          currentIdx -= 1;
	        }
	   });
});