<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
   #mainUl {
     padding-left:0px;
   }
   #mainUl .mainMenu {
     display:inline-block;
     width:150px;
     height:30px;
     line-height:30px;
     text-align:center;
     position:relative;
   }
   #mainUl .mainMenu #daeMenu {
     position:absolute;
     left:0px;
     top:30px;
     display:none;
   }
   #mainUl .mainMenu #daeMenu  .dae {
     list-style-type:none;
     position:relative;
     width:100px;
     height:30px;
     line-height:30px;
     text-align:center;
   }
   #mainUl .mainMenu #daeMenu  .dae .jungMenu {
     position:absolute;
     left:100px;
     top:0px;
     padding-left:0px;
     display:none;
   }
   #mainUl .mainMenu #daeMenu  .dae .jungMenu .jung{
     list-style-type:none;
     width:100px;
     height:30px;
     line-height:30px;
     text-align:center;
     position:relative;
   }
   
   #mainUl .mainMenu #daeMenu  .dae .jungMenu .jung .soMenu{
     position:absolute;
     left:100px;
     top:0px;
     display:none;
   }
   #mainUl .mainMenu #daeMenu  .dae .jungMenu .jung .soMenu li {
     list-style-type:none;
     width:100px;
     height:30px;
     line-height:30px;
     text-align:center;
   }
 </style>
 <script>
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
</head>
<body>
  <ul id="mainUl">
    <li class="mainMenu" onmouseover="viewDae()" onmouseout="hideDae()"> 카테고리 
      <ul id="daeMenu">
        <li class="dae" onmouseover="viewJung(0)" onmouseout="hideJung(0)"> 가전제품 
           <ul class="jungMenu">
             <li class="jung" onmouseover="viewSo(0)" onmouseout="hideSo(0)"> TV 
               <ul class="soMenu">
                 <li> 대형TV </li>
                 <li> 중형TV </li>
                 <li> 소형TV </li>
                 <li> 휴대용 </li>
               </ul>
             </li>
             <li class="jung" onmouseover="viewSo(1)" onmouseout="hideSo(1)"> 냉장고 
               <ul class="soMenu">
                 <li> 대형냉장고 </li>
                 <li> 중형냉장고</li>
                 <li> 소형냉장고 </li>
                 <li> 휴대용냉장고 </li>
               </ul>
             </li>
             <li class="jung" onmouseover="viewSo(2)" onmouseout="hideSo(2)"> 세탁기 
               <ul class="soMenu">
                 <li> 대형세탁기 </li>
                 <li> 중형세탁기 </li>
                 <li> 소형세탁기 </li>
                 <li> 휴대용세탁기 </li>
               </ul>
             </li>
             <li class="jung" onmouseover="viewSo(3)" onmouseout="hideSo(3)"> 컴퓨터 
               <ul class="soMenu">
                 <li> 대형컴퓨터 </li>
                 <li> 중형컴퓨터 </li>
                 <li> 소형컴퓨터 </li>
                 <li> 휴대용컴퓨터 </li>
               </ul>
             </li>
           </ul>
        </li>
        <li class="dae" onmouseover="viewJung(1)" onmouseout="hideJung(1)"> 패션의류 
           <ul class="jungMenu">
             <li class="jung"> 남성의류 </li>
             <li class="jung"> 여성의류 </li>
             <li class="jung"> 아동의류 </li>
             <li class="jung"> 유아의류 </li>
           </ul>
        </li>
        <li class="dae" onmouseover="viewJung(2)" onmouseout="hideJung(2)"> 농수산물 
           <ul class="jungMenu">
             <li class="jung"> 농산물 </li>
             <li class="jung"> 수산물 </li>
             <li class="jung"> 축산물 </li>
             <li class="jung"> 이것저것 </li>
           </ul>
        </li>
        <li class="dae"> 요리식품 </li>
        <li class="dae"> 가공식품 </li>
        <li class="dae"> 이것저것 </li>
      </ul>
    </li>
    <li class="mainMenu"> 특별이벤트 </li>
    <li class="mainMenu"> 신상품 </li>
    <li class="mainMenu"> 매일특가 </li>
  </ul>
</body>
</html>

















