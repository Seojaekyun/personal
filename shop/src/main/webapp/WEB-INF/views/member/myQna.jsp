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
     <c:if test="${plist.size()<=3}">
      height:500px; /* 배송주소가 많아지면 if를 통해 늘여주기 */
     </c:if>
      margin:auto;
     <c:if test="${plist.size()>3}">
      margin-bottom:70px;
     </c:if>
      
      font-family:'GmarketSansMedium';
      position:relative;
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
    main #answer {
      position:absolute;
      width:300px;
      height:200px;
      overflow:auto;
      border:1px solid purple;
      visibility:hidden;
      background:white;
      padding:4px;
      left:400px;
    }
  </style>
  <script>
   function viewAnswer(ref)
   {
	   var chk=new XMLHttpRequest();
	   chk.onload=function()
	   {
		   //alert(chk.responseText);
		   document.getElementById("answer").style.visibility="visible";
		   document.getElementById("answer").innerHTML=chk.responseText;
	   }
	   chk.open("get","viewAnswer?ref="+ref);
	   chk.send();
   }
   function hide(my)
   {
	   my.style.visibility="hidden";
   }
  </script>
</head>
<body> <!-- member/myQna.jsp -->
  <main>
    <div id="answer" onclick="hide(this)"></div>
    <table width="1100" align="center">
      <caption> <h2> 나의 문의 </h2> </caption>
      <tr align="center">
        <td> 상품명 </td>
        <td> 문의내용 </td>
        <td> 답변여부 </td>
        <td> 작성일 </td>
      </tr>
     <c:forEach items="${plist}" var="pdto">
      <tr>
        <td align="center"> ${pdto.title} </td>
        <td width="500"> ${pdto.content} </td>
        <td align="center">  
          <c:if test="${pdto.cnt==1}">
            <span onclick="viewAnswer(${pdto.ref})" style="cursor:pointer;"> 답변완료 </span>
          </c:if>
          <c:if test="${pdto.cnt==0}">
            답변 전
          </c:if>
          <br> <input type="button" id="dbtn" value="문의삭제" onclick="location='qnaDel?id=${pdto.id}'">
        </td>
        <td align="center"> ${pdto.writeday} </td>
      </tr>
     </c:forEach>
    </table>
  </main>
</body>
</html>



