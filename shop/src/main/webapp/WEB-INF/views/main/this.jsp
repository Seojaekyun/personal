<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script src="https://code.jquery.com/jquery-latest.js"></script>
 <script>
   $(function()
   {
	   // li가 클릭되었을때 
	   $("li").click(function()
	   {
		   // 클릭된 태그의 텍스트를 전달
		   var str=$(this).text();
		   $("#aa").text(str);
		   //$(this).css("background","yellow");
		   
		   // 클릭된 요소와 변화가 주어질 요소가 다른경우 (단 인덱스는 동일)
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
   <div> 선택된 산 : <span id="aa"></span> </div>
   <ul>
     <li class="name"> 홍길동 </li>
     <li class="name"> 슈퍼맨 </li>
     <li class="name"> 배트맨 </li>
     <li class="name"> 원더우먼 </li>
     <li class="name"> 뽀로로 </li>
     <li class="name"> 에 디 </li>
     <li class="name"> 포 비 </li>
     <li class="name"> 코 난 </li>
   </ul>
</body>
</html>
