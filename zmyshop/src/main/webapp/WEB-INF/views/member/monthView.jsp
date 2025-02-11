<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <style>
  main {
      width:1100px;
      margin:auto;
      margin-top:40px;
   }
   main table {
   
   }
   main table td {
     width:150px;
     height:120px;
     font-size:12px;
   }
   main table tr:first-child td {
     height:28px;
     text-align:center;
   }
  main #head {
     font-size:20px;
     font-weight:900;
  }
  
  main a {
     text-decoration:none;
     color:black;
  }
  </style>
  <script>
   window.onpageshow=function()
   {
	   var writeday=[${writeday}];
	   var title=[${title}];
 	   
	   var pro=document.getElementsByClassName("pro");
	   var chk=0; // 구매날짜를 저장
	   var num=0;
	   for(i=0;i<writeday.length;i++)
	   {
		   var n=writeday[i];
		   if(n!=chk)
		   {	   
			  num=0;
			  pro[n-1].innerHTML=title[i];
			  pro[n-1].parentNode.parentNode.style.background="#FFC6FF";
			  chk=writeday[i];  
		   }
		   else
		      num++;
		   
		   if(num>0) // 상품을 2개 이상 구입했다면
			   pro[n-1].innerHTML=title[i]+"외 "+num+"건";  
	   }	   
   }
  </script>
</head>
<body>  
  <main> ${mapAll.size() }
    <h2 align="center"> 월별 주문 현황 </h2>
    <table align="center" border="1">
      <caption> 
         <a href="monthView?year=${year}&month=${month-1}"> 이전 </a>
         <span id="head" style="margin-left:20px;margin-right:20px;"> ${year}년 ${month}월 </span>
         <a href="monthView?year=${year}&month=${month+1}"> 다음 </a>
      </caption>
      <tr>
        <td> 일 </td>
        <td> 월 </td>
        <td> 화 </td>
        <td> 수 </td>
        <td> 목 </td>
        <td> 금 </td>
        <td> 토 </td>
      </tr>
     <c:set var="day" value="1"/> <!-- pageContext -->
     <c:forEach begin="1" end="${ju}" var="i">
      <tr> <!-- ${i} -->
        <c:forEach begin="0" end="6" var="j">
         <c:if test="${ (i==1 && j<yoil) || day>chong }">
          <td> </td>
         </c:if>
         <c:if test="${ !((i==1 && j<yoil) || day>chong) }">
          <td valign="top"> ${day} <p> 
            <span class="pro"></span>
          </td>
          <c:set var="day" value="${day+1}"/> 
         </c:if> 
        </c:forEach>
      </tr> 
     </c:forEach>
    </table>
  </main>
</body>
</html>








