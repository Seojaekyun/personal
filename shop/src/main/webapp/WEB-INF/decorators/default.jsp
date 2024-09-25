<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
   @font-face {
    font-family: 'GmarketSansBold';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansBold.woff') format('woff');
    font-weight: normal;
    font-style: normal;
   }
   @font-face {
    font-family: 'GmarketSansLight';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansLight.woff') format('woff');
    font-weight: normal;
    font-style: normal;
   }
   @font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
   }
   body {
      margin:0px;
   }
   #ads {
      width:100%;
      height:40px;
      background:purple;
   }
   #ads #first {
      width:1100px;
      height:40px;
      margin:auto;
      font-family:'GmarketSansMedium';
   }
   #ads #first #left {
      width:1000px;
      height:40px;
      line-height:40px;
      float:left;
      text-align:center;
      color:white;
   }
   #ads #first #right {
      width:100px;
      height:40px;
      line-height:40px;
      float:left;
      text-align:right;
      color:white;
   }
   header {
      width:1100px;
      height:70px;
      line-height:70px;
      margin:auto;
      font-family:'GmarketSansMedium';
   }
   header a {
     text-decoration:none;
     color:black;
   }
   header #logo {
      width:300px;
      height:70px;
      line-height:70px;
      float:left;
   }
   header #search {
      width:420px;
      height:70px;
      float:left;
   }
   header #search #searchForm {  /* 둘러싸고 있는 div태그 */
      width:300px;
      height:40px;
      line-height:40px;
      border:1px solid purple; 
      margin-top:15px;
      border-radius:10px;
   }
   header #search #searchForm #searchTxt { /* type="text" */
      width:220px;
      margin-left:14px;
      border:none;
      outline:none;
   }
   header #search #searchForm #xx {  /* x표시 그림 */
      visibility:hidden;
      cursor:pointer;
   }
   header #member {
      width:380px;
      height:70px;
      line-height:70px;
      float:left;
      text-align:right;
   }
   header #member #cartNum {
      color:purple;
   }
   header #member #myMenu {
      position:relative;
      display:inline-block;
    }
   header #member #myMenuList {
      padding-left:0px;
      position:absolute;
      left:-19px;
      top:30px;
      visibility:hidden;
      border:1px solid purple;
      background:white;
   }
   header #member #myMenuList li {   
      list-style-type:none;
      height:28px;
      line-height:28px;
      width:100px;
      text-align:center;
      cursor:pointer;
      /* border:1px solid black;
      border-bottom:none;
      border-top:none; */
   }
   header #member #myMenuList li:hover {
       background:#FFF5FF;
   }   
   header #member #myMenuList li:first-child { 
      /* border-top:1px solid black; */
   }
   
   header #member #myMenuList li:last-child { 
      /* border-bottom:1px solid black; */
   }
   
   nav {
      width:1100px;
      height:50px;
      line-height:50px;
      margin:auto;
      font-family:'GmarketSansMedium';
   }
   nav a {
      text-decoration:none;
      color:black;
   }
   nav #cate {  /* 카테고리메뉴 */
      position:relative;
      display:block;
      width:90px;
      height:58px;
   }
   nav #daeMenu {  /* ul */
      position:absolute;
      left:-6px;
      top:50px;
      padding-left:0px;
      width:100px;
      height:210px;
      background:white;
      display:none;
      border:1px solid purple;
   }
   nav #daeMenu > li {   /* 대분류 메뉴 */
      list-style-type:none;
      width:100px;
      height:30px;
      line-height:30px;
      text-align:center;
      background:white;
      cursor:pointer;
      position:relative;
   }
   nav #daeMenu > li:hover { 
      background:#FFF5FF;
   }
   nav #daeMenu > li > .jungMenu { /* 중분류메뉴의 UL태그 */
      position:absolute;
      left:100px;
      top:-1px;
      padding-left:0px;
      background:white;
      border:1px solid purple;
   }
   nav #daeMenu > li .jungMenu > li {
      list-style-type:none;
      width:100px;
      height:30px;
      position:relative;
   }
   nav #daeMenu > li .jungMenu > li:hover {
      background:#FFF5FF;
   }
   nav #daeMenu > li .jungMenu > li > .soMenu {
      position:absolute;
      left:100px;
      top:-1px;
      padding-left:0px;
      background:white;
      border:1px solid purple;
   }
   nav #daeMenu > li .jungMenu > li .soMenu > li {
      list-style-type:none;
      width:100px;
      height:30px;
   }
   nav #daeMenu > li .jungMenu > li .soMenu > li:hover {
      background:#FFF5FF;
   }
   
   nav > #mainMenu {  
      padding-left:0px;
   }
   nav > #mainMenu > li {
      list-style-type:none;
      display:inline-block;
      width:170px;
      height:50px;
      line-height:50px;
      text-align:center;
   }
   nav > #mainMenu > li:first-child {
      width:220px;
      text-align:left;
   }
   
   
   footer {
      width:1100px;
      height:150px;
      margin:auto;
    }
 </style>
 <script src="https://code.jquery.com/jquery-latest.js"></script>
 <script>
   function xCheck(val)
   {
	  if(val.length==0)
      {
		  document.getElementById("xx").style.visibility="hidden";
      }		
	  else
	  {
		  document.getElementById("xx").style.visibility="visible";
	  }	  
   }
   
   function clearTxt()
   {
	   document.getElementById("searchTxt").value="";
	   xCheck("");
   }
   
   // dae테이블에서 대분류메뉴읽어오기
   mchk=0;
   function viewMenu()
   {
	     document.getElementById("daeMenu").style.display="block"; // 대분류메뉴 보이기
	       
	     if(mchk==0) // 한번만 실행
	     {  
		   var chk=new XMLHttpRequest();
		   chk.onload=function()
		   {
			   //alert(chk.responseText);
			   var daeAll=JSON.parse(chk.responseText);
			   var str="";
			 
			   for(dae of daeAll)
			   {
				   var pcode="p"+dae.code;
				   str=str+"<li onmouseover='jungView("+dae.code+")' onmouseout='jungHide("+dae.code+")'> <a href='../product/productList?pcode="+pcode+"'> "+dae.name+" </a> <ul class='jungMenu'> </ul> </li>";
			   }	  
			   document.getElementById("daeMenu").innerHTML=str;
 
		   }
		   chk.open("get","../main/getDae");
		   chk.send();
		   mchk++;
	     }
   }
   function hideMenu()
   {
	   document.getElementById("daeMenu").style.display="none";
   }
   //var jungEx=[0,0,0,0,0,0,0]; // 대분류의 중분류를 가져왔는지 체크하는 배열
 
   var jungEx=new Array(10); // 대분류의 배열갯수를 지정
   for(i=0;i<jungEx.length;i++)
   {
	   jungEx[i]=0;
   }	   
   
   function jungView(daecode) // 중분류의 레코드들을 가져와서 중분류의 메뉴를 출력
   {
	   
	   document.getElementsByClassName("jungMenu")[daecode-1].style.display="block";
	   
	   
	   if(jungEx[daecode-1]==0) // 읽어오지 않은 중분류만 실행
	   {
		   var chk=new XMLHttpRequest();
		   chk.onload=function()
		   {
			   //alert(chk.responseText);
			   var jungAll=JSON.parse(chk.responseText);
			   var str="";
			   var i=0;
			   for(jung of jungAll)
			   {    
                   var pcode="p"+jung.daecode+jung.code;
                    
				   str=str+"<li onmouseover='soView(this,"+(daecode+""+jung.code)+","+i+")' onmouseout='soHide("+i+")'><a href='../product/productList?pcode="+pcode+"'> "+jung.name+" </a><ul class='soMenu'></ul> </li>";
				   
				   i++;
			   }	   
			   document.getElementsByClassName("jungMenu")[daecode-1].innerHTML=str;
		   }
		   chk.open("get","../main/getJung?daecode="+daecode);
		   chk.send();
		   
		   jungEx[daecode-1]=1;
	   }
	   
	   
   }
   function jungHide(daecode)
   {
	   document.getElementsByClassName("jungMenu")[daecode-1].style.display="none";
   }
   /*
   var soEx=new Array(100); // 대분류의 배열갯수를 지정
   for(i=0;i<soEx.length;i++)
   {
	   soEx[i]=0;
   }
   */
   function soView(my,daejung,i)
   {
	   //document.getElementsByClassName("soMenu")[i].style.display="block";
	   my.childNodes[1].style.display="block";
	   // this로보낸 li태그의 자식노트 1번인덱스를 보여라
	   //console.log(daejung+" : "+i);
       //alert(my.childNodes.length);
	   //alert(my.childNodes[3]);
	   if(my.childNodes[1].innerHTML=="")
	   {
		   
		 //alert(daejung);
		   var chk=new XMLHttpRequest();
		 
		   chk.onload=function()
		   {
			   //alert(chk.responseText);
			   var soAll=JSON.parse(chk.responseText);
			   var str="";
			   for(so of soAll)
			   {
				   var pcode="p"+so.daejung+so.code;
				   str=str+"<li> <a href='../product/productList?pcode="+pcode+"'> "+so.name+" </a> </li>";
			   }	   
			    
			   //document.getElementsByClassName("soMenu")[i].innerHTML=str;
			   my.childNodes[1].innerHTML=str;
		   }
		   chk.open("get","../main/getSo?daejung="+daejung);
		   chk.send();
		   
		   
	   }	   
	   
   }
   function soHide(my)
   {
	   for(i=0;i<document.getElementsByClassName("soMenu").length;i++)
	      document.getElementsByClassName("soMenu")[i].style.display="none";
	    
	    
   }
   function viewSrc()
   {
	   document.getElementById("src").innerText=document.getElementsByTagName("html")[0].innerHTML;
   }
    
   window.onload=function()
   {
	   var chk=new XMLHttpRequest();
	   chk.onload=function()
	   {
		   //alert(chk.responseText);
		   document.getElementById("cartNum").innerText=chk.responseText;
	   }
	   chk.open("get","../main/cartNum");
	   chk.send();
	   
	   <c:if test="${order!=null}">
	      // 상품리스트에서 어떤 정렬순서인지 색으로 구분
	      document.getElementsByClassName("order")[${order-1}].style.color="#FF007F";
	   </c:if>
   }
   
   function myMenuView()
   {
	   document.getElementById("myMenuList").style.visibility="visible";
   }
   function myMenuHide()
   {
	   document.getElementById("myMenuList").style.visibility="hidden";
   }
 </script>
 
 <sitemesh:write property="head"/>
 
</head>
<body> <!-- main/index.jsp -->
 <!-- <input type="button" value="소스보기" onclick="viewSrc()">
 <div id="src"></div>  -->
   <div id="ads">
     <div id="first">
       <div id="left"> 회원가입하고 상품 첫 주문시 100만원 드립니다. </div>
       <div id="right"> X </div>
     </div>
   </div>
   <header>
     <div id="logo"> 
      <a href="../main/index">
       <img src="../static/main/logo.png" width="150" valign="middle">
      </a> 
     </div>
     <div id="search"> 
      <div id="searchForm">
       <input type="text" name="search" onkeyup="xCheck(this.value)" id="searchTxt" placeholder="검색어를 입력하세요">
       <img src="../static/main/x.png" valign="middle" id="xx" onclick="clearTxt()">
       <img src="../static/main/s.png" valign="middle"> 
      </div>
     </div>
     <div id="member">
      <a href="../member/cartView">
       <img src="../static/main/cart.png" valign="middle" width="22">(<span id="cartNum"></span>) |
      </a>
      <c:if test="${userid == null}">
       <a href="../member/member"> 회원가입 </a> | 
       <a href="../login/login"> 로그인 </a> |
      </c:if>
      <c:if test="${userid != null}">
       ${name}님 | 
       <span id="myMenu" onmouseover="myMenuView()" onmouseout="myMenuHide()"> 나의메뉴 
         <ul id="myMenuList">
           <li> <a href="../member/jjimList"> 찜리스트 </a> </li>
           <li> <a href="../member/memberView"> 회원정보 </a></li>
           <li> <a href="../member/jumunList"> 주문목록 </a></li>
           <li> <a href="../member/myBaesong"> 배송지관리 </a></li>
           <li> <a href="../member/myReview"> 나의상품평 </a></li>
           <li> <a href="../member/myQna"> 나의 문의 </a></li>
         </ul>
       </span> |
       <a href="../login/logout"> 로그아웃 </a> | 
      </c:if>      
        고객센터 
     </div>
   </header> <!-- 로고, 상품검색, 회원가입,로그인등등 -->
   <nav>
     <ul id="mainMenu">
       <li> 
         <span id="cate" onmouseover="viewMenu()" onmouseout="hideMenu()">
            <img src="../static/main/3.png" valign="middle"> 카테고리 
            <ul id="daeMenu"></ul> <!-- 대분류메뉴 -->
         </span> 
         
       </li>
       <li> 신상품 </li>
       <li> 특가상품 </li>
       <li> 베스트 </li>
       <li> 이벤트 </li>
       <li> 일일특가 </li>
     </ul>
   </nav> <!-- 메뉴 -->   
    
   <sitemesh:write property="body"/>
    
   <footer>
     <img src="../static/main/footer.png">
   </footer> <!-- 쇼핑몰관련정보 -->
   
</body>
</html>
 