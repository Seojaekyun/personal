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
     <c:if test="${mapAll.size()<=3}">
      height:500px; /* 배송주소가 많아지면 if를 통해 늘여주기 */
     </c:if>
      margin:auto;
     <c:if test="${mapAll.size()>3}">
      margin-bottom:70px;
     </c:if>
      
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
      height:100px;
    }
    main table tr:first-child td {
      border-top:2px solid purple;
      height:40px;
    }
    main table tr:last-child td {
      border-bottom:2px solid purple;
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
</head>
<body> <!-- member/myReview.jsp -->
  <main>
    <table width="1100" align="center">
      <caption> <h2> 나의 상품평 </h2> </caption>
      <tr align="center">
        <td> 상품명 </td>
        <td> 별점 </td>
        <td> 한줄평 </td>
        <td> 상품평 </td>
        <td> 작성일 </td>
        <td> 수정 </td>
        <td> 삭제 </td>
      </tr>
     <c:forEach items="${mapAll}" var="map">
      <tr>
        <td width="200" align="center"> ${map.title} </td>
        <td style="letter-spacing:-4px" align="center">  
          <c:forEach begin="1" end="${map.star}">
            <img src="../static/pro/star1.png" width="15">
          </c:forEach>
          <c:forEach begin="1" end="${5-map.star}">
            <img src="../static/pro/star2.png" width="15">
          </c:forEach>
        </td>
        <td align="center" width="200"> ${map.oneLine} </td>
        <td width="350"> ${map.content} </td>
        <td align="center"> ${map.writeday} </td>
        <td align="center"> <input type="button" value="수정" id="ubtn" onclick="location='reviewUpdate?id=${map.id}'"> </td>
        <td align="center"> <input type="button" value="삭제" id="dbtn" onclick="location='reviewDel?id=${map.id}'"> </td>
      </tr>
     </c:forEach>
    </table>
  </main>
</body>
</html>




