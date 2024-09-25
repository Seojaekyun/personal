<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
   #out {
     width:100px;
     height:100px;
     overflow:hidden;
     
   }
 </style>
 <script>
   var num=100;
   function sizeUp()
   {
	   ss=setInterval(function()
	   {
		   num++;
		   document.getElementById("img").style.width=num+"px";
		   document.getElementById("img").style.height=num+"px";
		   if(num==110)
		      clearInterval(ss);	   
	   },5);
	   
   }
   function sizeDown()
   {
	   ss=setInterval(function()
	   {
		   num--;
		   document.getElementById("img").style.width=num+"px";
		   document.getElementById("img").style.height=num+"px";
		   if(num==100)
		      clearInterval(ss);	   
	   },5);
   }
 </script>
</head>
<body>
  <div id="out" onmouseover="sizeUp()" onmouseout="sizeDown()">
    <img id="img" src="../static/product/001.jpg" width="100" height="100">
  </div>
</body>
</html>