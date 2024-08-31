<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
   #section form {
     text-align:center;
   }
   #section input[type=text] {
     width:330px;
     height:30px;
     border:1px solid green;
     outline:none;
   }
   #section input[type=submit] {
     width:336px;
     height:34px;
     border:1px solid green;
     background:green;
     color:white;
     font-size:15px;
   }
   #section div {
     margin-top:8px;
   }
 </style>
</head>
<body> <!-- member/usForm.jsp -->
   <div id="section">
    <form method="post" action="reMember">
     <h3> 북구 신청 </h3>
     <div> <input type="text" name="userid" placeholder="아이디"> </div>
     <div> <input type="text" name="pwd" placeholder="비밀번호"> </div>
     <div> <input type="submit" value="복구신청"> </div>
    <c:if test="${err!=null}">
     <div style="font-size:12px;color:red;"> 입력하신 정보가 일치하지 않습니다. </div>
    </c:if>
    </form>
   </div>
</body>
</html>