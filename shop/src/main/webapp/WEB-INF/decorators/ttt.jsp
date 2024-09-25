<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 
 <ul id="daeMenu" style="display: none;">
   <li onmouseover="jungView(01)" onmouseout="jungHide(01)"> 가전제품 
     <ul class="jungMenu" style="display: none;">
       <li onmouseover="soView(101,0)" onmouseout="soHide(0)"> TV 
         <ul class="soMenu" style="display: none;">
            <li> 대형TV </li>
            <li> 중형TV </li>
            <li> 소형TV </li>
            <li> 휴대용TV </li>
         </ul> 
      </li>
      <li onmouseover="soView(102,1)" onmouseout="soHide(1)"> 냉장고 
         <ul class="soMenu" style="display: none;">
           <li> 양문형냉장고 </li>
           <li> 김치냉장고 </li>
           <li> 와인냉장고 </li>
           <li> 소형냉장고 </li>
         </ul> 
     </li>
     <li onmouseover="soView(103,2)" onmouseout="soHide(2)"> 세탁기 
         <ul class="soMenu" style="display: none;">
           <li> 드럼세탁기 </li>
           <li> 일반세탁기 </li>
           <li> 미니세탁기 </li>
           <li> 건조기 </li>
         </ul> 
     </li>
     <li onmouseover="soView(104,3)" onmouseout="soHide(3)"> 컴퓨터 
         <ul class="soMenu" style="display: none;">
           <li> 데스크탑 </li>
           <li> 노트북 </li>
           <li> 서버 </li>
           <li> 미니PC </li>
         </ul> 
     </li>
     <li onmouseover="soView(105,4)" onmouseout="soHide(4)"> 청소기 
         <ul class="soMenu" style="display: none;">
           <li> 유선청소기 </li>
           <li> 무선청소기 </li>
           <li> 휴대용청소기 </li>
         </ul> 
     </li>
    </ul> 
   </li>
   <li onmouseover="jungView(02)" onmouseout="jungHide(02)"> 패션제품 
    <ul class="jungMenu" style="display: none;">
     <li onmouseover="soView(201,0)" onmouseout="soHide(0)"> 남성의류 
       <ul class="soMenu">
       </ul> 
     </li>
     <li onmouseover="soView(202,1)" onmouseout="soHide(1)"> 여성의류 
       <ul class="soMenu">
       </ul> 
     </li>
     <li onmouseover="soView(203,2)" onmouseout="soHide(2)"> 아동의류 
       <ul class="soMenu">
       </ul> 
     </li>
     <li onmouseover="soView(204,3)" onmouseout="soHide(3)"> 잡화 
       <ul class="soMenu">
       </ul> 
     </li>
   </ul> 
  </li>
  <li onmouseover="jungView(03)" onmouseout="jungHide(03)"> 농수산물 
    <ul class="jungMenu"> 
    </ul> 
  </li>
  <li onmouseover="jungView(04)" onmouseout="jungHide(04)"> 주방용품 
    <ul class="jungMenu"> 
    </ul> 
  </li>
  <li onmouseover="jungView(05)" onmouseout="jungHide(05)"> 생활용품 
    <ul class="jungMenu"> 
    </ul> 
  </li>
  <li onmouseover="jungView(06)" onmouseout="jungHide(06)"> 자동차용품 
    <ul class="jungMenu"> 
    </ul> 
  </li>
  <li onmouseover="jungView(07)" onmouseout="jungHide(07)"> 스포츠/레저 
    <ul class="jungMenu"> 
    </ul> 
  </li>
 </ul>

</body>
</html>
</body>
</html>