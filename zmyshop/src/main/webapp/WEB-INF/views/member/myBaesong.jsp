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
      height:500px; /* 배송주소가 많아지면 if를 통해 늘여주기 */
      margin:auto;
      font-family:'GmarketSansMedium';
    }
    main table {
      margin-top:50px;     
      margin-bottom:50px;
      border-spacing:0px;
    }
    main table td {
      border-bottom:1px solid purple;
      padding-top:5px;
      padding-bottom:5px;
      height:45px;
    }
    main table tr:first-child td {
      border-top:2px solid purple;
    }
    main table tr:last-child td {
      border-bottom:2px solid purple;
    }
    main table #baeChuga {
      font-size:12px;
      cursor:pointer;
      color:purple;
    }
    main #dbtn {
      padding:2px 4px;
      border:1px solid purple;
      background:purple;
      color:white;
    }
    main #ubtn {
      padding:2px 4px;
      border:1px solid purple;
      background:white;
      color:purple;
    }
  </style>
  <script>
   function baeChuga()
   {
	   open("jusoWrite","","width=480,height=500");
   }
   function baeUpdate(id)
   {
	   open("baeUpdate?id="+id,"","width=480,height=500");
   }
  </script>
</head>
<body> <!-- member/myBaesong.jsp -->
  <main>
    <table width="1100" align="center">
      <caption> <h2> 배송지 정보 <span id="baeChuga" onclick="baeChuga()">배송지추가</span></h2> </caption>
      <tr>
        <td> 받는 분 </td>
        <td> 배송주소 </td>
        <td> 전화번호 </td>
        <td> 요청사항 </td>
        <td> 배송지유형 </td>
        <td> 수정 </td>
        <td> 삭제 </td>
      </tr>
     <c:forEach items="${blist}" var="bdto">
      <tr>
        <td> ${bdto.name} </td>
        <td> ${bdto.juso} ${bdto.jusoEtc} </td>
        <td> ${bdto.phone} </td>
        <td> ${bdto.breq} </td>
        <td> 
          <c:if test="${bdto.gibon==1}">
            기본배송지
          </c:if>
        </td>
        <td> <input type="button" value="수정" id="ubtn" onclick="baeUpdate(${bdto.id})"> </td>
        <td> <input type="button" value="삭제" id="dbtn" onclick="location='baeDel?id=${bdto.id}'"> </td> <!-- 없네요 추가!! -->
      </tr>
     </c:forEach>
    </table>
  </main>
</body>
</html>






