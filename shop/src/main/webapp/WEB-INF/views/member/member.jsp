<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
   main {
     width:1100px;
     height:700px;
     margin:auto;
     text-align:center;
   }
   main div {
     margin-top:20px;
   }
   main #txt {
     width:400px;
     height:40px;
     outline:none;
     border:1px solid purple;
   }
   main #submit {
     width:406px;
     height:44px;
     outline:none;
     border:1px solid purple;
     background:purple;
     color:white;
   }
   main #txt2 {
     width:126px;
     height:40px;
     outline:none;
     border:1px solid purple;
   }
   main select {
     width:107px;
     height:44px;
     border:1px solid purple;
   }
 </style>
 <script>
  var uchk=0;
  function useridCheck(userid)
  {
	  if(userid.trim().length>=6) // 아이디 길이는 6자 이상
	  {
		  var chk=new XMLHttpRequest();
		  chk.onload=function()
		  {
			  if(chk.responseText=="0")
			  {
				  document.getElementById("umsg").innerText="사용 가능한 아이디 입니다";
				  document.getElementById("umsg").style.fontSize="11px";
				  document.getElementById("umsg").style.color="blue";
				  uchk=1;
			  }	  
			  else
			  {
				  document.getElementById("umsg").innerText="사용불가능한 아이디 입니다";
				  document.getElementById("umsg").style.fontSize="11px";
				  document.getElementById("umsg").style.color="red";
				  uchk=0;
			  }	  
		  }
		  chk.open("get","useridCheck?userid="+userid);
		  chk.send();
	  }	  
	  else
	  {
		  document.getElementById("umsg").innerText="아이디를 다시 입력하고 체크하세요";
		  document.getElementById("umsg").style.fontSize="11px";
		  document.getElementById("umsg").style.color="red";
		  uchk=0;
	  }	  
  }
  
  function chgServer(server)
  {
	  document.mform.e2.value=server;
  }
  var pchk=0;
  function pwdCheck(n)
  {
	  // 2개의 비밀번호를 비교
	  var pwd=document.mform.pwd.value;
	  var pwd2=document.mform.pwd2.value;
	 
	  if(n==1 || (n==0 && pwd2!=""))
	  {	  
		   
		   
		   if(pwd==pwd2)
		   {
			   document.getElementById("pmsg").innerText="비밀번호가 일치합니다";
			   document.getElementById("pmsg").style.color="blue";
			   document.getElementById("pmsg").style.fontSize="11px";
			   pchk=1;
		   }
		   else
		   {
			   document.getElementById("pmsg").innerText="비밀번호가 일치하지 않습니다";
			   document.getElementById("pmsg").style.color="red";
			   document.getElementById("pmsg").style.fontSize="11px";
			   pchk=0;
		   }	   
	  }
   
  }
  
  function check()
  {
	  var email=document.mform.e1.value+"@"+document.mform.e2.value;
	  document.mform.email.value=email;
	  
	  if(uchk==0)
	  {
		  alert("아이디를 체크하세요");
		  return false;
	  }	  
	  else if(document.mform.name.value=="")
		   {
		       alert("이름을 입력하세요");
		       return false;
		   }
	       else if(pchk==0)
	    	    {
	    	        alert("비밀번호 체크하세요");
	    	        return false;
	    	    }
	            else
 	            {
		           return true;
 	            }	   
  }
 </script>
</head>
<body> <!-- member/m -->
   <main>
    <form name="mform" method="post" action="memberOk" onsubmit="return check()">
     <input type="hidden" name="email">
     <h3 align="center"> 회원 등록 </h3>
     <div> 
      <input type="text" name="userid" id="txt" placeholder="아이디(6자이상)" onblur="useridCheck(this.value)">
      <br> <span id="umsg"></span> 
     </div>
     <div> <input type="text" name="name" id="txt" placeholder="이 름"> </div>
     <div> <input type="password" name="pwd" onkeyup="pwdCheck(0)" id="txt" placeholder="비밀번호"> </div>
     <div>
       <input type="password" name="pwd2" onkeyup="pwdCheck(1)" id="txt" placeholder="비밀번호 확인"> 
      <br> <span id="pmsg"></span>
     </div>
     <div>
       <input type="text" name="e1" id="txt2" placeholder="이메일아이디"> @
       <input type="text" name="e2" id="txt2" placeholder="이메일서버">
       <select  onchange="chgServer(this.value)">
         <option value=""> 직접입력 </option>
         <option value="naver.com"> 네이버 </option>
         <option value="daum.net"> 다음 </option>
         <option value="google.com"> 구글 </option>
         <option value="hotmail.com"> 핫메일 </option>
         <option value="channy.co.kr"> 차니 </option>
       </select>
     </div>
     <div> <input type="text" name="phone" id="txt" placeholder="전화번호"> </div>
     <div> <input type="submit" value="회원 등록" id="submit"> </div>
    </form>
   </main>
</body>
</html>