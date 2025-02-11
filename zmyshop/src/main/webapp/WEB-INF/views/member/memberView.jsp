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
      height:500px;
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
    main .memberTxt{
      width:150px;
      height:24px;
      border:1px solid purple;
      outline:none;
      vertical-align:middle;
    }
    main .memberTxt2{
      width:250px;
      height:24px;
      border:1px solid purple;
      outline:none;
      vertical-align:middle;
    }
    main #memberBtn {
      width:200px;
      height:28px;
      background:purple;
      color:white;
      border:1px solid purple;
      vertical-align:middle;
    }
    main #memberBtn2 {
      width:125px;
      height:28px;
      color:purple;
      background:white;
      border:1px solid purple;
      vertical-align:middle;
    }
    main #memberBtn3 {
      width:125px;
      height:28px;
      background:purple;
      color:white;
      border:1px solid purple;
      vertical-align:middle;
    }
    main #pwdForm {
      display:none;
    }
 </style>
 <script>
   function chgEmail()
   {
	   var email=document.getElementsByClassName("memberTxt")[0].value;
	   var chk=new XMLHttpRequest();
	   chk.onload=function()
	   {
		   if(chk.responseText=="0")
			   alert("오류 발생");
		   else
			   alert("정상적으로 이메일이 변경되었습니다");
	   }
	   chk.open("get","chgEmail?email="+email);
	   chk.send();
   }
   function chgPhone()
   {
	   var phone=document.getElementsByClassName("memberTxt")[1].value;
	   var chk=new XMLHttpRequest();
	   chk.onload=function()
	   {
		   if(chk.responseText=="0")
			   alert("오류 발생");
		   else
			   alert("정상적으로 전화번호가 변경되었습니다");
	   }
	   chk.open("get","chgPhone?phone="+phone);
	   chk.send();
   }
   
   function viewPform()
   {
	   document.getElementById("pwdForm").style.display="table-row";
	   document.getElementById("main").style.height="700px";
   }
   function hidePform()
   {
	   document.getElementById("pwdForm").style.display="none";
	   document.getElementById("main").style.height="500px";
   }
   
   function pwdChg(my)
   {
	   if(my.pwd.value!=my.pwd2.value)
	   { 
		   alert("변경할 비밀번호가 일치하지 않습니다");
		   return false;
	   }	   
	   else if(my.oldPwd.value.trim()=="")
		    {
		       alert("현재 비밀번호를 입력하세요");
		       return false;
		    }
	        else
	           return true;
		   
   }
 </script>
</head>
<body> <!-- member/memberView : 회원정보 보기및 수정 -->
  <main id="main">
    <table width="700" align="center">
      <caption> <h2> 회원 정보 </h2></caption>
      <tr>
        <td width="150"> 아이디 </td>
        <td> ${mdto.userid} </td>
      </tr>
      <tr>
        <td width="150"> 이 름 </td>
        <td> ${mdto.name} </td>
      </tr>
      <tr>
        <td width="150"> 이메일 </td>
        <td>
           <input type="text" name="email" value="${mdto.email}" class="memberTxt">
           <input type="button" onclick="chgEmail()" value="이메일 변경" id="memberBtn">
        </td>
      </tr>
      <tr>
        <td width="150"> 전화번호 </td>
        <td> 
           <input type="text" name="phone" value="${mdto.phone}" class="memberTxt">
           <input type="button" onclick="chgPhone()" value="전화번호 변경" id="memberBtn">
        </td>
      </tr>
      <tr>
        <td width="150"> 적립금 </td>
        <td> <fmt:formatNumber value="${mdto.juk}" type="number"/>원 </td>
      </tr>
      <tr>
        <td colspan="2" align="center">
           <input type="button" id="memberBtn" value="비밀번호 변경" onclick="viewPform()">
           <c:if test="${err==1}">
            <br> <span style="font-size:12px;color:red;"> 현재 비밀번호가 틀립니다 </span>
           </c:if>
        </td>
      </tr>
      <tr id="pwdForm">
        <td colspan="2" align="center">
         <form name="pform" method="post" action="pwdChg" onsubmit="pwdChg(this)">
          <p> <input type="password" name="oldPwd" class="memberTxt2" placeholder="현재 비밀번호"> </p>  
          <p> <input type="password" name="pwd" class="memberTxt2" placeholder="새 비밀번호"> </p>    
          <p> <input type="password" name="pwd2" class="memberTxt2" placeholder="비밀번호 확인"> </p>    
          <p>
            <input type="submit" value="변경하기" id="memberBtn2"> 
            <input type="button" value="변경취소" id="memberBtn3" onclick="hidePform()"> 
          </p>  
         </form>
        </td>
      </tr>
    </table>
  </main>
</body>
</html>





