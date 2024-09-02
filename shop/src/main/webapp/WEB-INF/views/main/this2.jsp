<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script src="https://code.jquery.com/jquery-latest.js"></script>
 <script>
   $(function()
   {
 	   $("li").click(function()
	   {
 		  var n=$(this).index(); // 요소가 연속적으로 있을때 가능하다
		   //alert(n);
		   $(".name").eq(n).css("background","yellow");
	   });
   });
 </script>
</head>
<body> <!-- main/this.jsp -->
   <ul>
     <li> 백두산 </li>
     <li> 한라산 </li>
     <li> 설악산 </li>
     <li> 태백산 </li>
     <li> 월악산 </li>
     <li> 지리산 </li>
     <li> 무등산 </li>
     <li> 금강산 </li>
   </ul>
   <hr>
   <ul>
     <li class="name"> 홍길동 </li>
     <a href=""> 하하하 </a><div>하하하</div><b>하하하</b> <b> 안녕하세요</b>
     <li class="name"> 슈퍼맨 </li>
     <div>하하하</div><b>하하하</b> <b> 안녕하세요</b>
     <li class="name"> 배트맨 </li>
     <li class="name"> 원더우먼 </li>
     <li class="name"> 뽀로로 </li>
     <div>몰라요</div>
     <li class="name"> 에 디 </li>
     <li class="name"> 포 비 </li>
     <li class="name"> 코 난 </li>
   </ul>
</body>
</html>
