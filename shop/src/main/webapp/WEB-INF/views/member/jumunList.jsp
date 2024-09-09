<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
     margin-top:6px;
   }
   .onePro #pro2 {
     display:inline-block;
     width:200px;
   }
   .onePro #pro3 {
     display:inline-block;
     width:80px;
   }
   .onePro #pro4 {
     display:inline-block;
     width:200px;
   }
   .onePro #pro4 input[type=button] {
     font-size:11px;
   }
 </style>
</head>
<body>
  <main>
    <c:set var="i" value="0"/>
    <c:forEach begin="1" end="${mapAll.size()}">
       <c:if test="${i<mapAll.size()}">
       <c:set var="chk" value="0"/>
         <c:forEach begin="0" end="${mapAll.get(i).cnt-1}" varStatus="sts">
           <c:if test="${chk==0}">
            <div class="onePro" id="left">
              <h3>  ${mapAll.get(i).writeday}  </h3> 
           </c:if>  
              <div id="pro1">
                 <img src="../static/product/${mapAll.get(i).pimg}" width="40" height="40" valign="middle">
                 ${mapAll.get(i).title}
              </div>
              <div id="pro2">
                <fmt:formatNumber value="${mapAll.get(i).chongPrice}" type="number"/>원 
                <span style="font-size:12px;"><br> 
                (사용적립금:<fmt:formatNumber value="${mapAll.get(i).useJuk}" type="number"/>원) 
                </span> 
              </div>
              <div id="pro3">
                ${mapAll.get(i).su}개 
                <br><span style="font-size:15px">${mapAll.get(i).stateMsg} </span>
                
              </div>
              <div id="pro4">
                  <c:if test="${mapAll.get(i).state==0 || mapAll.get(i).state==1 || mapAll.get(i).state==2}">
			        <input type="button" value="취소신청" id="btn" onclick="location='chgState?state=4&id=${mapAll.get(i).id}'">
			       </c:if>
			       <c:if test="${mapAll.get(i).state==3}">
			        <input type="button" value="반품신청" id="btn" onclick="location='chgState?state=5&id=${mapAll.get(i).id}'">
			       </c:if>
			       <c:if test="${mapAll.get(i).state==3}">
			        <input type="button" value="교환신청" id="btn" onclick="location='chgState?state=7&id=${mapAll.get(i).id}'">
			       </c:if>
			       <c:if test="${mapAll.get(i).state==3}">
			        <input type="button" value="리뷰쓰기" id="btn" onclick="location='reviewWrite?pcode=${mapAll.get(i).pcode}'">
			       </c:if>
			       <c:if test="${mapAll.get(i).state==5}"> 
			        <input type="button" value="반품취소" id="btn" onclick="location='chgState?state=3&id=${mapAll.get(i).id}'">
			       </c:if>
			       <c:if test="${mapAll.get(i).state==7}"> 
			        <input type="button" value="교환취소" id="btn" onclick="location='chgState?state=3&id=${mapAll.get(i).id}'">
			       </c:if> 
              </div>
           <c:if test="${mapAll.get(i).cnt-1 != sts.index }"> 
            <c:set var="i" value="${i+1}"/>
           </c:if>
           <c:set var="chk" value="1"/>
         </c:forEach>
          </div>  <!--  onePro -->
          <div id="right">
          </div>
        </c:if>
      <c:set var="i" value="${i+1}"/>
    </c:forEach>
  </main>
</body>
</html>