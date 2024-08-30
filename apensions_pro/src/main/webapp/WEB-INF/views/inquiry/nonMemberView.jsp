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
      height:600px;
      margin:auto;
   }
   section table {
      border-spacing:0px;
      margin-top:6px;
   }
   section table td {
      border-bottom:1px solid green;
   }
  </style>
</head>
<body>  <!-- inquiry/nonMemberView -->
  <section>
     <table width="700" align="center">
       <tr>
         <td width="150"> 문의 사항 </td>
         <td> ${idto.title2} </td>
       </tr>
       <tr>
         <td> 등록 일자 </td>
         <td> ${idto.writeday} </td> 
       </tr>
       <tr height="200">
         <td> 문의 내용 </td>
         <td> ${idto.content} </td> 
       </tr>
       <tr height="200">
         <td> 답변 내용 </td>
         <td> ${idto.answer} </td> 
       </tr>
     </table>
  </section>
</body>
</html>