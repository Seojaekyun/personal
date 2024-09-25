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
    	isTime();
    	setInterval(isTime,1000);
    }
 
    function isTime()
    {
        var xday=new Date("2024-09-18 10:00:00"); // 특정일
        var today=new Date(); // 현재
        var sigan=xday-today; // 1/1000초
        
        sigan=Math.floor(sigan/1000); // 두 날짜간의 초
        
        var sec=sigan%60;
        
        sigan=Math.floor(sigan/60);   // 두 날짜간의 분
        
        var min=sigan%60;
        
        sigan=Math.floor(sigan/60);   // 두 날짜간의 시간
        
        var hour=sigan%24;
        
        sigan=Math.floor(sigan/24);   // 두 날짜간의 일수
        
        document.getElementById("now").innerText=sigan+"일 "+hour+"시 "+min+"분 "+sec+"초";
    }
 </script>
</head>
<body>
 <main>
    남은시간 <span id="now"></span>
 </main>
</body>
</html>






