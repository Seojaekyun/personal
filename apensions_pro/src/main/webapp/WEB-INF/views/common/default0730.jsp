<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%

%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
    @font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
   body {
      margin:0px;
   }
   #outer {
      width:100%;
      height:40px;
      background:green;
   }
   #outer #first {
      width:1000px;
      height:40px;
      line-height:40px;
      margin:auto;
      background:green;
      text-align:center;
      color:white;
      font-family: 'GmarketSansMedium';
   }
   #outer #first #left {
      width:960px;
      float:left;
   }
   #outer #first #right {
      width:40px;
      float:right;
   }
   header {
      width:1000px;
      height:60px;
      line-height:60px;
      margin:auto;
      font-family: 'GmarketSansMedium';
    
   }
   header #left {
      width:200px;
      height:60px;
      display:inline-block;
      text-align:center;
   }
   header #right {
      width:790px;
      height:60px;
      display:inline-block;
      text-align:right;
     
   }
   nav {
      width:1000px;
      height:50px;
      line-height:50px;
      margin:auto;
      font-family: 'GmarketSansMedium';
    
   }
   nav a {
      text-decoration:none;
      color:black;
   }
   nav a:hover {
      text-decoration:underline;
      color:green;
      
   }
   nav #main {
      padding-left:0px;
      margin-left:30px;
   }
   nav #main > li { /* 주메뉴 */
      display:inline-block;
      list-style-type:none;
      width:150px;
      height:50px;
      line-height:50px;
      /* border:1px solid black; */
      text-align:center;
      font-weight:900;
      position:relative;
   }
   nav #main > li > .menu { /* 하위메뉴 ul태그 */
      padding-left:0px;
      position:absolute;
      left:0px;
      top:48px;
      background:white;
      visibility:hidden;
   }
   nav #main > li > .menu > li { /* 하위메뉴내의 메뉴 */
      list-style-type:none;
      width:150px;
      height:35px;
      line-height:35px;
      
   }
   section {
      font-family: 'GmarketSansMedium';
   }
   
   footer {
      padding-top:10px;
      width:100%;
      height:120px;
      margin:auto;
      font-family: 'GmarketSansMedium';
      margin-top:30px;
      font-size:13px;
      background:green;
      color:white;
   }
 </style>
 <script>
   function viewMenu(n)
   {
	   
	   // 객실현황에 마우스가 올라왔을때 ajax
	   if(n==3 && document.getElementById("roomMenu").innerHTML.trim()=="")
	   {
		   var chk=new XMLHttpRequest();
		   chk.onload=function()
		   {
			   //alert(chk.responseText);
			   var rlist=JSON.parse(chk.responseText);
			   for(rdto of rlist)
			   {
				   //alert(rdto.id+" "+rdto.title);
				   var new1=document.createElement("li");
				   new1.innerHTML="<a href='roomView?id="+rdto.id+"'>"+rdto.title+"</a>";
				   document.getElementById("roomMenu").appendChild(new1);
			   }	   
		   }
		   chk.open("get","../virtual/getRooms");
		   chk.send();
	   }	   
	   document.getElementsByClassName("menu")[n].style.visibility="visible";
   }
   function hideMenu(n)
   {
	   document.getElementsByClassName("menu")[n].style.visibility="hidden";
   }
   
   var h=40;
   function hideX()
   {
	   
	   ss=setInterval(function()
	   {
		   h--;
		   document.getElementById("first").style.height=h+"px";
		   document.getElementById("outer").style.height=h+"px";
		   
		   if(h==0)
	       {
			   document.getElementById("outer").style.display="none";
			   clearInterval(ss);
	       }
	   },10);
   }
 </script>
 <decorator:head/>
</head>
<body> <!-- index.jsp -->
   <div id="outer">
     <div id="first"> 
          <div id="left" class="first"> 펜션 오픈 기념으로 1박하면 3박이 공짜입니다. </div> 
          <div id="right" class="first"> <span onclick="hideX()" style="cursor:pointer"> X </span> </div>
     </div>
   </div>
   <header> 
       <div id="left"> <a href="../main/index"> <img src="../resources/logo.png" width="70%" valign="middle"> </a> </div>
       <div id="right"> 
         <c:if test="${userid==null}">  
           <a href="../member/login"> 로그인 </a> | 
           <a href="../member/member"> 회원가입 </a> | 
         </c:if>
         <c:if test="${userid=='admin'}">           
           <a href="../adminRoom/list"> 객실관리 </a> |
           예약관리 |
           문의관리 |           
         </c:if>
         <c:if test="${userid!=null}">
           ${name}님 |
           <a href="../member/logout"> 로그아웃 </a> | 
         </c:if>  
           문의하기 
       </div> 
   </header>
   <nav>    
     <ul id="main">
       <li onmouseover="viewMenu(0)" onmouseout="hideMenu(0)"> 펜션소개 
         <ul class="menu">
           <li> 펜션지기 </li>
           <li> 오시는길 </li>
           <li> ?????? </li>
         </ul>
       </li>
       <li onmouseover="viewMenu(1)" onmouseout="hideMenu(1)"> 주변볼거리 
         <ul class="menu">
           <li> 호수공원 </li>
           <li> 킨 텍 스 </li>
           <li> 한류월드 </li>
           <li> 서 오 능 </li>
         </ul>
       </li>
       <li onmouseover="viewMenu(2)" onmouseout="hideMenu(2)"> 주변맛집 
         <ul class="menu">
           <li> 대 동 관 </li>
           <li> 버 거 킹 </li>
           <li> 서 가 원 </li>
           <li> 김밥천국 </li>
         </ul>
       </li>
       <li onmouseover="viewMenu(3)" onmouseout="hideMenu(3)"> 객실현황 
         <ul class="menu" id="roomMenu"></ul>
       </li>
       <li onmouseover="viewMenu(4)" onmouseout="hideMenu(4)"> 예약관련 
         <ul class="menu">
           <li> 예약 안내 </li>
           <li> 실시간 예약 </li>
         </ul>
       </li>
       <li onmouseover="viewMenu(5)" onmouseout="hideMenu(5)"> 커뮤니티
         <ul class="menu">
           <li> <a href="../gongji/list"> 공지사항 </a> </li>
           <li> 여행후기 </li>
           <li> <a href="../board/list"> 회원게시판 </a> </li>
           <li> 문의하기 </li>
         </ul>
       </li>
     </ul>
   </nav>

  <decorator:body/>
  
   <footer>
    <table width="1000" align="center">
     <tr>
       <td align="center" rowspan="5"> <img valign="middle"  src="../resources/logo2.png" width="65%"> </td>
       <td> 상호명 : 차니펜션 </td>
       <td> 365고객센터 </td>
     </tr>
     <tr>
       <td> 대표이사 : 차니박 </td>
       <td> 1999-1999(무료) </td>
     </tr>
     <tr>
       <td> 충남 태안군 도황면 연포리 1234 </td>
       <td> email : channy@channy.co.kr </td>
     </tr>
     <tr>
       <td> 사업자 등록번호 : 111-11-12345 </td>
       <td> 전화번호 : 010-1234-5678 </td>
     </tr>
     <tr>
       <td> 통신판매업신고 : 2023-충남태안-1234 </td>
       <td> </td>
     </tr>
   </table>    </footer>
</body>
</html>

