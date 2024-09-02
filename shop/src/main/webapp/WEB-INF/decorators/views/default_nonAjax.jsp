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
      width:500px;
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
      width:300px;
      height:70px;
      line-height:70px;
      float:left;
      text-align:right;
   }
   
   nav {
      width:1100px;
      height:50px;
      line-height:50px;
      margin:auto;
      font-family:'GmarketSansMedium';
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
   nav #daeMenu > li > .jungMenu { /* 중분류메뉴의 UL태그 */
      position:absolute;
      left:100px;
      top:0px;
      padding-left:0px;
      background:white;
      display:none;
   }
   nav #daeMenu > li .jungMenu > li {
      list-style-type:none;
      width:100px;
      height:30px;
      position:relative;
   }
   nav #daeMenu > li .jungMenu > li > .soMenu {
      position:absolute;
      left:100px;
      top:0px;
      padding-left:0px;
      background:white;
      display:none;
   }
   nav #daeMenu > li .jungMenu > li .soMenu > li {
      list-style-type:none;
      width:100px;
      height:30px;
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

   function viewDae()
   {
	   document.getElementById("daeMenu").style.display="block";
   }
   function hideDae()
   {
	   document.getElementById("daeMenu").style.display="none";
   }
   function viewJung(n)
   {
	   document.getElementsByClassName("jungMenu")[n].style.display="block";
   }
   function hideJung(n)
   {
	   document.getElementsByClassName("jungMenu")[n].style.display="none";
   }
   function viewSo(n)
   {
	   document.getElementsByClassName("soMenu")[n].style.display="block";
   }
   function hideSo(n)
   {
	   document.getElementsByClassName("soMenu")[n].style.display="none";
   }
 </script>
 
 <sitemesh:write property="head"/>
 
</head>
<body> <!-- main/index.jsp -->
 <input type="button" value="소스보기" onclick="viewSrc()">
 <div id="src"></div> 
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
      <c:if test="${userid == null}">
       <a href="../member/member"> 회원가입 </a> | 
       <a href="../login/login"> 로그인 </a> |
      </c:if>
      <c:if test="${userid != null}">
       ${name}님 | 
       나의메뉴 |
       <a href="../login/logout"> 로그아웃 </a> | 
      </c:if>      
        고객센터 
     </div>
   </header> <!-- 로고, 상품검색, 회원가입,로그인등등 -->
   <nav>
     <ul id="mainMenu">
       <li> 
         <span id="cate" onmouseover="viewDae()" onmouseout="hideDae()">
          <img src="../static/main/3.png" valign="middle"> 카테고리
          
          <ul id="daeMenu">
            <li onmouseover="viewJung(0)" onmouseout="hideJung(0)"> 가전제품 
              <ul class="jungMenu">
                <li onmouseover="viewSo(0)" onmouseout="hideSo(0)"> TV 
                  <ul class="soMenu">
                    <li> 대형TV </li>
                    <li> 중형TV </li>
                    <li> 소형TV </li>
                    <li> 휴대용TV </li>
                  </ul>
                </li>
                <li onmouseover="viewSo(1)" onmouseout="hideSo(1)"> 냉장고 
                  <ul class="soMenu">
                    <li> 양문형냉장고 </li>
                    <li> 김치냉장고 </li>
                    <li> 와인냉장고 </li>
                    <li> 소형냉장고 </li>
                  </ul>
                </li>
                <li onmouseover="viewSo(2)" onmouseout="hideSo(2)"> 세탁기 
                  <ul class="soMenu">
                    <li> 드럼세탁기 </li>
                    <li> 일반세탁기 </li>
                    <li> 미니세탁기 </li>
                    <li> 건조기 </li>
                  </ul>
                </li>
                <li onmouseover="viewSo(3)" onmouseout="hideSo(3)"> 컴퓨터 
                  <ul class="soMenu">
                    <li> 데스크탑 </li>
                    <li> 노트북 </li>
                    <li> 서 버 </li>
                    <li> 미니PC </li>
                  </ul>  
                </li>
                <li onmouseover="viewSo(4)" onmouseout="hideSo(4)"> 청소기 
                  <ul class="soMenu">
                    <li> 유선청소기 </li>
                    <li> 무선청소기 </li>
                    <li> 휴대용청소기 </li>
                  </ul>
                </li>
              </ul>
            </li>
            <li onmouseover="viewJung(1)" onmouseout="hideJung(1)"> 패션제품 
              <ul class="jungMenu">
                <li onmouseover="viewSo(5)" onmouseout="hideSo(5)"> 남성의류 
                  <ul class="soMenu">
                    <li> 양 복 </li>
                    <li> 스포츠 </li>
                    <li> 캐주얼 </li>
                  </ul>
                </li>
                <li onmouseover="viewSo(6)" onmouseout="hideSo(6)"> 여성의류 
                  <ul class="soMenu">
                    <li> 정 장 </li>
                    <li> 스포츠 </li>
                    <li> 캐주얼 </li>
                  </ul>
                </li> 
                <li onmouseover="viewSo(7)" onmouseout="hideSo(7)"> 아동의류 
                  <ul class="soMenu">
                    <li> 캐주얼</li>
                    <li> 스포츠 </li>
                    <li> 내 의 </li>
                  </ul>
                </li>
                <li onmouseover="viewSo(8)" onmouseout="hideSo(8)"> 잡 화 
                  <ul class="soMenu">
                    <li> 가 방 </li>
                    <li> 핸드백 </li>
                    <li> 지 갑 </li>
                  </ul>
                </li>
              </ul>
            </li>
            <li> 농수산물 </li>
            <li> 주방용품 </li>
            <li> 생활용품 </li>
            <li> 자동차용품 </li>
            <li> 스포츠/레저 </li>
          </ul>
           
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
 