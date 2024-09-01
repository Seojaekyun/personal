<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	section div {
		text-align:center;
		margin-top:10px;
	}
	section select {
		width:406px;
		height:30px;
		outline:none;
	}
	section input[type=submit] {
		width:406px;
		height:34px;
	}
	section textarea {
		width:400px;
		height:200px;
		outline:none;
	}
	section input[type=text] {
		width:400px;
		height:20px;
		outline:none;
	}
</style>
<script>
	function vform() {
		document.getElementById("vform").style.display="block";
	}
</script>
</head>
<body> <!-- inquiry/write.jsp -->

<section>
	<c:if test="${userid==null}"> 
      <div> <span onclick="vform()"> 비회원 문의 확인하기 </span> </div>
      <c:if test="${err!=null}">
       <div style="font-size:11px;color:red;"> 문의번호가 일치하지 않습니다 </div>
      </c:if>
      <div style="display:none;" id="vform">
         <form method="post" action="nonMemberView">
           <input type="text" name="inqNumber"><br>
           <input type="submit" value="문의 확인">
         </form>
      </div>
     </c:if>
     <form method="post" action="writeOk">
      <h3 align="center"> 관리자에게 문의하기 </h3>
      <div> 
         <select name="title">
           <option value="0"> 펜션예약 관련 문의 </option>
           <option value="1"> 입/퇴실 관련 문의 </option>
           <option value="2"> 주변맛집 관련 문의 </option>
           <option value="3"> 웹사이트 관련 문의 </option>
           <option value="4"> 커뮤니티 관련 문의 </option>
         </select>
      </div>
      <div> <textarea name="content" maxlength="200"></textarea> </div>
      <div> <input type="submit" value="문의 등록"> </div>
     </form>
    </section>
</body>
</html>