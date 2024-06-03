
var txt = document.getElementsByTagName("label");

const regName = /^[가-힣]{2,10}$/; //이름 : 한글(2~10자)
const regPhone = /^[0-9]{4}$/; //휴대폰번호 : 숫자만
const regId = /^[0-9a-zA-Z]{6,20}$/; //아이디 : 영문소/대문자+숫자(6~20자)
const regPw = /^(?=.*[a-zA-Z0-9])(?=.*[!@#$%^*+=-]).{8,30}$/; //비번 : 영문소/대문자+숫자+특수문자(꼭)(8~30자)
const regEmail = /^[0-9a-zA-Z]{2,30}$/; //이메일 : 영문소/대문자+숫자(2~30자)
const regAddr = /^[0-9a-zA-Z가-힣,-]{2,50}$/; //주소 : 영문소/대문자+한글+숫자+특수문자(-/,)(~50자)

//입력 조건 체크
function txt_check(name){
	if(name == "id"){
		if(joinForm.id.value == ''){
			txt[0].innerHTML= name+"는 필수입력 값입니다.";
		}else if(!regId.test(joinForm.id.value)){
			txt[0].innerHTML= "입력값을 확인해주세요(영문소문자+숫자 6~20자)";
		}else{
			txt[0].innerHTML="아이디 중복확인을 해주세요.";
		}
	}

	if(name == "pw"){
		if(joinForm.pw.value == ''){
			txt[1].innerHTML= name+"는 필수입력 값입니다.";
		}else if(!regPw.test(joinForm.pw.value)){
			txt[1].innerHTML= "입력값을 확인해주세요(영문/숫자+특수문자 1개이상 8~30자)";
		}else{
			txt[1].innerHTML= "";
		}
	}

	if(name == "pwChk"){
		if(joinForm.pwChk.value == '' | joinForm.pw.value != joinForm.pwChk.value){
			txt[2].innerHTML= "비밀번호가 일치하지 않습니다.";
		}else{
			txt[2].innerHTML= "";
		}
	}

	if(name == "name"){
		if(joinForm.name.value == ''){
			txt[3].innerHTML = name+"는 필수입력 값입니다.";
		}else if(!regName.test(joinForm.name.value)){
			txt[3].innerHTML = "입력값을 확인해주세요(한글)";
		}else{
			txt[3].innerHTML = "";
		}
	}

	if(name == "nickname"){
		if(joinForm.nickname.value == ''){
			txt[4].innerHTML = name+"는 필수입력 값입니다.";
		}else if(joinForm.nickname.value.length>=1){
			txt[4].innerHTML = "";
		}
	}

	if(name == "phone1" | name == "phone2"){
		if(!regPhone.test(joinForm.phone1.value) | !regPhone.test(joinForm.phone2.value)){
			txt[5].innerHTML = "입력값을 확인해주세요(숫자)";
		}else if(joinForm.phone1.value.length <4 | joinForm.phone2.value.length<4){
			txt[5].innerHTML = "필수입력 값입니다.";
		}else{
			txt[5].innerHTML ="";
		}
	}

	if(name == "year" | name == "month" | name == "day"){
		if(joinForm.year.options[0].selected | joinForm.month.options[0].selected | joinForm.day.options[0].selected){
			txt[6].innerHTML = "필수입력 값입니다.";
		}else{
			txt[6].innerHTML = "";
		}
	}

	if(name == "email" | name == "emailAddr"){
		if(joinForm.email.value == '' | joinForm.emailAddr.options[0].selected){
			txt[7].innerHTML = "필수입력 값입니다.";
		}else if(!regEmail.test(joinForm.email.value)){
			txt[7].innerHTML = "입력값을 확인해주세요(영문소/대문자+숫자 2~30자)";
		}else{
			txt[7].innerHTML = "";
		}
	}

	if(name == "addr1" | name=="addr2" | name=="addr3"){
		if(joinForm.addr2.value == '' | joinForm.addr3.value.value == ''){
			txt[8].innerHTML = "필수입력 값입니다.";
		}else if(!regAddr.test(joinForm.addr2.value)){
			txt[8].innerHTML = "입력값을 확인해주세요";
		}else if(!regAddr.test(joinForm.addr3.value)){
			txt[8].innerHTML = "입력값을 확인해주세요";
		}else{
			txt[8].innerHTML = "";
		}
	}
}

//아이디 - 중복확인
function id_chk() {
	if(regId.test(joinForm.id.value) && joinForm.id.readOnly == false){
		txt[0].innerHTML = '사용가능한 아이디 입니다.';
		txt[0].style.color = "blue";
		joinForm.id.readOnly=true;
		joinForm.id.style.backgroundColor="#e4e4e4";
	}else{
		txt[0].innerHTML="입력값을 확인해주세요(영문소문자+숫자 6~20자)";
		joinForm.id.focus();
	}
}

//닉네임 - 중복확인 버튼 클릭
function nickname_chk(){
	if(joinForm.nickname.value.length>=1){
		txt[4].innerHTML = '사용가능한 닉네임입니다.';
		txt[4].style.color = "blue";
	}else{
		txt[4].innerHTML = "닉네임을 입력해주세요.";
		joinForm.nickname.focus();
	}
}

function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample4_postcode').value = data.zonecode;
            document.getElementById("sample4_roadAddress").value = roadAddr;
            
            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            if(roadAddr !== ''){
                document.getElementById("sample4_roadAddress").value = roadAddr + extraRoadAddr;
            } else {
                document.getElementById("sample4_roadAddress").value = '';
            }

            var guideTextBox = document.getElementById("guide");
            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            }
        }
    }).open();
}

//회원가입
function join(){
	if(joinForm.id.value == ''){
		txt[0].innerHTML="아이디를 입력해주세요.";
		joinForm.id.focus();
		return false;
	}else if(joinForm.id.readOnly == false){
		alert("아이디 중복확인을 해주세요");
		return false;
	}else if(joinForm.pw.value == ''){
		txt[1].innerHTML="비밀번호를 입력해주세요.";
		joinForm.pw.focus();
		return false;
	}else if(!regPw.test(joinForm.pw.value)){
		txt[1].innerHTML ="입력값을 확인해주세요(영문/숫자+특수문자 1개이상 8~30자)";
		joinForm.pw.focus();
		return false;
	}else if(joinForm.pwChk.value == '' | joinForm.pw.value != joinForm.pwChk.value){
		txt[2].innerHTML = "비밀번호가 일치하지 않습니다.";
		joinForm.pwChk.focus();
		joinForm.pwChk.select();
		return false;
	}else if(joinForm.name.value == ''){
		txt[3].innerHTML = "이름을 입력해주세요.";
		joinForm.name.focus();
		return false;
	}else if(!regName.test(joinForm.name.value)){
		txt[3].innerHTML = "입력값을 확인해주세요(한글)";
		return false;
	}else if(joinForm.nickname.value == ''){
		txt[4].innerHTML = "닉네임을 입력해주세요.";
		joinForm.nickname.focus();
		return false;
	}else if(joinForm.nickname.value.length>=1 && txt[4].innerHTML == ''){
		alert("닉네임 중복확인을 해주세요.");
		return false;
	}else if(joinForm.phone1.value.length<4 | joinForm.phone2.value.length<4){
		txt[5].innerHTML ="휴대폰 번호를 입력해주세요.";
		if(joinForm.phone1.value.length<4){
			joinForm.phone1.focus();
			return false;
		}else{
			joinForm.phone2.focus();
			return false;
		}
	}else if(!regPhone.test(joinForm.phone1.value) | !regPhone.test(joinForm.phone2.value)){
		txt[5].innerHTML = "입력값을 확인해주세요(숫자)";
		return false;
	}else if(joinForm.year.options[0].selected | joinForm.month.options[0].selected | joinForm.day.options[0].selected){
		txt[6].innerHTML = "생년월일을 선택해주세요.";
		return false;
		if(joinForm.year.options[0].selected){
			joinForm.year.focus();
			return false;
		}else if(joinForm.month.options[0].selected){
			joinForm.month.focus();
			return false;
		}else{
			joinForm.day.focus();
			return false;
		}
	}else if(joinForm.email.value == '' | joinForm.emailAddr.options[0].selected){
		txt[7].innerHTML = "이메일을 입력해주세요.";
		return false;
		if(joinForm.email.value == ''){
			joinForm.email.focus();
			return false;
		}else{
			joinForm.emailAddr.focus();
			return false;
		}
	}else if(!regEmail.test(joinForm.email.value)){
		txt[7].innerHTML = "입력값을 확인해주세요(영문소/대문자+숫자 2~30자)";
		return false;
	}else if(joinForm.addr2.value == '' | joinForm.addr3.value == ''){
		txt[8].innerHTML = "주소를 입력해주세요";
		return false;
		if(joinForm.addr2.value == ''){
			joinForm.addr2.focus();
			return false;
		}else{
			joinForm.addr3.focus();
			return false;
		}
	}else if(!regAddr.test(joinForm.addr2.value) || !regAddr.test(joinForm.addr3.value)){
		txt[8].innerHTML = "입력값을 확인해주세요";
	}else{
		alert("아이디: "+joinForm.id.value + " 이름: " +joinForm.name.value+" 닉네임: "+joinForm.nickname.value+" 휴대폰번호: "+joinForm.phone.value+joinForm.phone1.value+joinForm.phone2.value+" 생년월일: "+joinForm.year.value+"/"+joinForm.month.value+"/"+joinForm.day.value+" 이메일: "+joinForm.email.value+joinForm.emailAddr.value+" 주소: "+joinForm.addr2.value+" 성별: "+joinForm.gender.value);
	}
}