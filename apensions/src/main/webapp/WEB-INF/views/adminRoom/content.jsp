<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>  
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
      text-align:center;
    }
   section div {
      width:500px;
      height:40px;
      line-height:40px;
      text-align:center;
      margin:auto;
      border:1px solid green;
   }
   section #con {
      height:300px;
      overflow:auto;
   }
  </style>
</head>
<body>  
  <section>
     <h3 align="center"> ${rdto.title} 객실 내용 </h3>
     <div> 최소 : ${rdto.min}명 , 최대 : ${rdto.max}명 </div>
     <div> 1박 가격 : ${rdto.price2}원 </div>
     <%-- <div> 1박 가격 : <fmt:formatNumber value="${rdto.price}" type="number" pattern="#,###"/>원</div> --%>
     <div id="con"> ${rdto.content} </div>
     <div>
      <c:forEach items="${imgs}" var="img">
        <img src="../resources/room/${img}" width="60" height="30" valign="middle">
      </c:forEach>
     </div>
     <div>
       <span id="btn"> <a href="list"> 목록 </a></span>
       <span id="btn"> <a href="update?id=${rdto.id}"> 수정 </a></span> 
       <span id="btn"> <a href="delete?id=${rdto.id}"> 삭제 </a></span>
     </div>
  </section>
</body>
</html>
