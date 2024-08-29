<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
      margin-top:10px;
   }
   section div input {
      border:1px solid green;
      outline:none;
   }
   section #txt {
      width:400px;
      height:40px;
   }
   section #pwdx {
      width:400px;
      height:40px;
   }
   section #sub {
      width:406px;
      height:44px;
      background:green;
      color:white;
   }
   section #userid #umsg {
      font-size:11px;
   }
   section #userid #pmsg {
      font-size:11px;
   }
 </style>
 <script>
   var uchk=0;
   function dupCheck(userid)
   {
	   
	   // 아이디는 4자 이상
	   if(userid.trim().length>=4)  
	   {
		// var userid=document.mform.userid.value
		   var chk=new XMLHttpRequest();
		   chk.onload=function()
		   {
			   //alert(chk.responseText);
			   if(chk.responseText=="0")
			   {
				   document.getElementById("umsg").innerText="사용이 가능한 아이디 입니다";
				   document.getElementById("umsg").style.color="blue";
				   uchk=1;
			   }	
			   else
			   {
				   document.getElementById("umsg").innerText="이미 사용하는 아이디 입니다.";
				   document.getElementById("umsg").style.color="red";
				   uchk=0;
			   }	   
		   }
		   chk.open("get","dupCheck?userid="+userid);
		   chk.send();
	   }	  
	   else
	   {
		   document.getElementById("umsg").innerText="아이디는 길이가 4자 이상입니다.";
		   document.getElementById("umsg").style.color="red";
		   uchk=0;
	   }	   
	   
   }
   var pchk=0;
   function pwdCheck()
   {
	   // 2개의 비밀번호를 비교
	   var pwd=document.mform.pwd.value;
	   var pwd2=document.mform.pwd2.value;
	   //alert(pwd+" | "+pwd2);
	   if(pwd==pwd2)
	   {
		   document.getElementById("pmsg").innerText="비밀번호가 일치합니다";
		   document.getElementById("pmsg").style.color="blue";
		   pchk=1;
	   }
	   else
	   {
		   document.getElementById("pmsg").innerText="비밀번호가 일치하지 않습니다";
		   document.getElementById("pmsg").style.color="red";
		   pchk=0;
	   }	   
   }
   function test()
   {
	   var pwd=document.pkc.pwd2.value;
	   alert(pwd);
   }
   
   function check()
   {
	   // uchk, pchk
	   if(uchk==0)
	   {
		   alert("아이디 중복체크를 완료해 주세요");
		   return false;
	   }	   
	   else if(pchk==0)
		    {
		        alert("비밀번호 체크를 하세요");
		        return false;
		    } 
	        else if(document.mform.email.value.trim().length==0)
	        	 {
	        	     alert("이메일을 입력하세요");
	        	     return false;
	        	 }
	             else
	            	 return true;
   }
 </script>
</head>
<body> <!-- member.jsp -->
  <section>
    <form method="post" name="mform" action="memberOk" onsubmit="return check()">
     <h3> 회원 가입 </h3>
     <div id="userid">
       <input type="text" name="userid" onblur="dupCheck(this.value)" placeholder="아 이 디" id="txt">
       <br><span id="umsg"></span> 
     </div>
     <div id="name"> <input type="text" name="name" placeholder="이 름" id="txt"> </div>
     <div id="pwd1"> <input type="password" name="pwd" placeholder="비밀번호" id="pwdx"> </div>
     <div id="pwd2"> 
        <input type="password" name="pwd2" onkeyup="pwdCheck()" placeholder="비밀번호 확인" id="pwdx">
        <br><span id="pmsg"></span> 
     </div>
     <div id="email"> <input type="text" name="email" placeholder="이 메 일" id="txt"> </div>
     <div id="phone"> <input type="text" name="phone" placeholder="전 화 번 호" id="txt"> </div>
     <div id="submit"> <input type="submit" value="회원가입" id="sub"> </div>
    </form>
  </section>
</body>
</html>






