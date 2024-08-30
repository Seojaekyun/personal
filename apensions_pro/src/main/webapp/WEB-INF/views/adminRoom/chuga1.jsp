<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script>
   function srcview()
   {
	   document.getElementById("src").innerText=document.getElementsByTagName("body")[0].innerHTML;
   }
   function chuga()
   {
	   // id="aa"인 요소에 "<b> 오늘은 월요일 </b>" 를 추가
	   // 1. innerHTML이용
	   //document.getElementById("aa").innerHTML="<b> 오늘은 월요일 </b>";
	   
	   // 2. createElement를 이용 => 태그생성
	   var new1=document.createElement("b");  // 원하는 태그를 생성
	   
	   // 2-1 생성된 태그에 innerText 텍스트 넣기
	   // new1.innerText="오늘은 월요일";
	   // 2-2 createTextNode를 이용하여 텍스트 넣기
	   new1.appendChild(document.createTextNode("즐거운 월요일"));

	   document.getElementById("aa").appendChild(new1);
   }
   function chuga2()
   {
	   // input태그 만들기
	   var new1=document.createElement("input");
	   // 속성추가
	   new1.setAttribute("type","text"); // 속성 추가
	   new1.setAttribute("value","홍길동"); 
	   new1.setAttribute("name","name");
	   // id="aa"인 요소에 태그를 추가
	   document.getElementById("aa").appendChild(new1);
	   
	   // img태그를 만들고 추가
	   var new2=document.createElement("img");
	   new2.setAttribute("src","../resources/logo.png");
	   new2.setAttribute("width","300");
	   new2.setAttribute("height","100");
	   document.getElementById("aa").appendChild(new2);
	   
	   // appendChild는 추가하고자 하는 태그의 끝에 추가된다..
   }
 </script>
</head>
<body> <!-- adminRoom/chuga1.jsp -->
  <!-- 태그를 추가하는 방법 -->
  <input type="button" onclick="srcview()" value="소스보기">
  <input type="button" onclick="chuga()" value="태그추가">
  <input type="button" onclick="chuga2()" value="속성을 가진태그추가">
  <hr>
  <div id="aa"></div>
  
  <hr style="border-color:red">
  <div id="src"></div>
</body>
</html>










