<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <style>
  section {
      width:1000px;
      margin:auto;
   }
   section hr {
      border:2px solid green;
   }
   section h3 {
      width:100px;
      border-bottom:4px solid green;
      text-align:center;
   }
   section table {
      border-spacing:0px;
      margin-top:6px;
   }
   section table td {
      border:1px solid green;
   }
   section #inTxt {
      width:746px;
      height:98px;
      overflow:auto;
   }
  </style>
</head>
<body>  <!-- member/myWrite -->
<script>
      function view(n)
      {
    	  var tr=document.getElementsByClassName("tr");
    	  // 하나만 보이게 하기
    	  for(i=0;i<tr.length;i++)
    	  {
    		  tr[i].style.display="none";
    	  }	  
    	  
    	  tr[n].style.display="table-row";
      }
</script>
  <section>
    <h3> 게시판 </h3>
    <hr>
    <h3> 여행 후기 </h3>
    <hr>
    <h3> 문의 내용 </h3>
     <c:forEach items="${ilist}" var="idto" varStatus="sts">
       <table width="1000" align="center">
         <tr>
           <td rowspan="2" width="140" align="center">
             <c:if test="${idto.state==1}"> 
              <span> ${idto.title2} </span> <br>
              <span style="color:blue;font-size:15px" onclick="view(${sts.index})"> 답변 완료 </span>
             </c:if>
             <c:if test="${idto.state==0}">
              <span> ${idto.title2} </span>
              <span style="color:red;font-size:11px"> <br>답변 대기중 </span>
             </c:if> 
           </td>
           <td width="750" height="100"> <div id="inTxt"> ${idto.content} </div> </td>
           <td rowspan="2" width="100" align="center"> ${idto.writeday} </td>
         </tr>
         <tr style="display:none" class="tr"> <!-- 답변 tr태그 -->
           <td height="100"> <div id="inTxt"> ${idto.answer} </div> </td>
         </tr>
       </table>
     </c:forEach>
    <hr>
    
  </section>
</body>
</html>