<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
   main {
     width:400px;
     height:400px;
     margin:auto;
   }
 </style>
 <script>
   window.onload=function()
   {
	   // 현재 시간을 구해서 id="now"에 전달하기  시,분,초
	  isTime();
	  setInterval(isTime,1000);
   }
   function isTime()
   {
	   var today=new Date();
	   var h=today.getHours();
	   var m=today.getMinutes();
	   var s=today.getSeconds();
	   document.getElementById("now").innerText=h+"시 "+m+"분 "+s+"초";
   }
 </script>
</head>
<body>
 <main>
    현재시간 <span id="now"></span>
 </main>
</body>
</html>






