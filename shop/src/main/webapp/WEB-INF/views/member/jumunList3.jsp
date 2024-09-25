<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
    main {
     width:1100px;
     margin:auto;
    <c:if test="${mapAll.size()<6}">
     height:600px;
    </c:if>
    <c:if test="${mapAll.size()>=6}">
     margin-bottom:100px;
    </c:if>
     
     font-family: 'GmarketSansMedium';
   }
   .onePro {
     border:1px solid purple;
     width:1100px;
     padding:20px;
     margin-top:10px;
   }
 
   .onePro #pro1 {
     display:inline-block;
     width:600px;
   }
   .onePro #pro2 {
     display:inline-block;
     width:200px;
   }
   .onePro #pro3 {
     display:inline-block;
     width:100px;
   }
   .onePro #pro4 {
     display:inline-block;
     width:100px;
   }
 </style>
 
</head>
<body> <!-- jumunList3 -->
  <main>
    <c:set var="i" value="0"/> <!-- 출력하는 상품의 인덱스를 위한 변수 -->
    <c:forEach begin="1" end="${mapAll.size()}"> <!-- 상품의 갯수만큼 반복 -->
     
       <c:if test="${i<mapAll.size()}"> <!-- i의 값이 상품의 갯수보다 크면 동작 X -->
       
       <c:set var="chk" value="0"/> <!-- 동일한 주문코드에 2개 이상의 상품이 있을 경우 날짜를 1번만 출력하기 위해 변수에 값을 저장 -->
       
         <!-- 주문코드가 같을 경우 갯수만큼 반복하여 실행 -->
         <c:forEach begin="0" end="${mapAll.get(i).cnt-1}" varStatus="sts">
         
           <c:if test="${chk==0}"> <!-- 최초로 실행될때는 0이다 마지막줄에 1로 바꾸게 되므로 동일한 주문코드는 2번째부터 날짜가출력 안된다.-->
            <div class="onePro" id="left">
              <h3>  ${mapAll.get(i).writeday}  <span style="font-size:15px">${mapAll.get(i).stateMsg} </span></h3> 
           </c:if>  
           
              <div id="pro1">
                 <img src="../static/product/${mapAll.get(i).pimg}" width="40" height="40" valign="middle">
                 ${mapAll.get(i).title}
              </div>
               
           <c:if test="${mapAll.get(i).cnt-1 != sts.index }"> <!-- 동일한 주문코드의 마지막 상품을 출력후 i의 값을 증가시키지 않는다 -->
            <c:set var="i" value="${i+1}"/>    <!-- 동일한 주문코드의 다음 상품을 출력하기 위해 i의 값을 증가 -->
           </c:if>
           
           <c:set var="chk" value="1"/> <!-- 1번 실행 된 후 1로 변경한다.. -->
           
         </c:forEach>
          </div>  <!--  onePro -->

        </c:if>
      <c:set var="i" value="${i+1}"/> <!-- 다음 상품의 출력을 위해 i값을 증가 -->
    </c:forEach>
  </main>
</body>
</html>






