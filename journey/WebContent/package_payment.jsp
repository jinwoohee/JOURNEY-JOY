<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>네이버페이 결제</title>

	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	
	<!-- 네이버페이 -->
	<script src="https://nsp.pay.naver.com/sdk/js/naverpay.min.js"></script>
</head>
<script>

//네이버 페이
$(function(){
 var oPay = Naver.Pay.create({
      "mode" : "production", // development or production
      "clientId": "u86j4ripEt8LRfPGzQ8" // clientId
}); 
	
	//직접 만드신 네이버페이 결제버튼에 click Event를 할당하세요
	
	var title_get = opener.document.getElementsByClassName("title");
	var title = title_get[0].innerText; 
	var nick_name = opener.document.getElementById("nick_name").innerText;

	var total = opener.document.getElementById("total").innerText;	
	
	var total_value = total.replaceAll("원","").replaceAll(",","");
     oPay.open({	
      "merchantUserKey": "aaaa",
      "merchantPayKey": "bbb",
      "productName": title+" by "+nick_name,
      "totalPayAmount": total_value,
      "taxScopeAmount": total_value,
      "taxExScopeAmount": "0",
      "returnUrl": "ddddd"
    }); 
}); 
</script>
<body>
	
</body>

</html>