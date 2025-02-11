<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
  main {
    width:600px;
    height:600px;
    margin:auto;
  }
  main div {
    width:600px;
    text-align:center;
    margin-top:15px;
  }
  main div input[type=text] {
    width:600px;
    height:30px;
  }
  main div textarea {
    width:600px;
    height:300px;
  }
  main div input[type=submit] {
    width:608px;
    height:34px;
  }
 </style>
 <script>
   function chgStar(n)
   {
	   // 0부터 n까지의 별은 노란별
	   for(i=0;i<=n;i++)
	   {
		   document.getElementsByClassName("star")[i].src="../static/pro/star1.png";
	   }	   
	   // n+1부터 끝까지는 회색별
	   for(i=n+1;i<5;i++)
	   {
		   document.getElementsByClassName("star")[i].src="../static/pro/star2.png";
	   }	   
	   
	   document.rform.star.value=n+1;
   }
   function myLen(my)
   {
	   document.getElementById("len").innerText=my.value.trim().length;
   }
   window.onpageshow=function()
   {
	   document.getElementById("len").innerText=document.rform.oneLine.value.trim().length;
	   var star=document.getElementsByClassName("star");
	   for(i=0;i<${rdto.star};i++)
	   {
		   star[i].src="../static/pro/star1.png";
	   }	   
   }
 </script>
</head>
<body> <!-- member/reviewUpdate.jsp -->
  <main>  
   <form name="rform" method="post" action="reviewUpdateOk">
    <input type="hidden" name="id" value="${rdto.id }"> <!-- review테이블의 id -->
    <!-- <input type="hidden" name="gid" value=""> --> <!-- gumae테이블의 id : 수정시에는 필요없음-->
    <input type="hidden" name="star">
    <input type="hidden" name="pcode" value="${rdto.pcode}">
    <h3 align="center"> 리뷰 수정하기 </h3>
    <div>  
      <img src="../static/pro/star2.png" class="star" onclick="chgStar(0)">
      <img src="../static/pro/star2.png" class="star" onclick="chgStar(1)">
      <img src="../static/pro/star2.png" class="star" onclick="chgStar(2)">
      <img src="../static/pro/star2.png" class="star" onclick="chgStar(3)">
      <img src="../static/pro/star2.png" class="star" onclick="chgStar(4)">
    </div>
    <div> 
       <input type="text" name="oneLine" value="${rdto.oneLine}" maxlength="30" onkeyup="myLen(this)">
       <br>(<span id="len">0</span>/30) 
     </div>
    <div> <textarea name="content">${rdto.content}</textarea> </div>
    <div> <input type="submit" value="상품 리뷰 수정"> </div>
   </form>
  </main>
</body>
</html>







