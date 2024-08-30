<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>白원 Mall - 회원 가입</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Dokdo&family=Jua&family=Nanum+Brush+Script&display=swap');
	main {
		width: 400px;
		padding: 30px;
		margin: 50px auto;
		background: white;
		box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
		border-radius: 10px;
		text-align: center;
	}
	main h3 {
		font-size: 24px;
		color: #2c3e50;
		margin-bottom: 20px;
	}
	main input[type="text"], input[type="password"], input[type="submit"] {
		width: calc(100% - 20px);
		padding: 10px;
		margin: 10px 0;
		border: 1px solid #ccc;
		border-radius: 5px;
		font-size: 16px;
		box-sizing: border-box;
	}
	main input[type="text"]:focus, input[type="password"]:focus {
		border-color: #3498db;
		outline: none;
	}
	main input[type="submit"] {
		background: #6a1b9a;
		color: white;
		border: none;
		cursor: pointer;
		transition: background 0.3s;
		font-size: 18px;
		font-family: 'Hahmlet';
	}
	main input[type="submit"]:hover {
		background: #4a148c;
	}
	main select {
		width: 90%;
		padding: 15px;
		margin: 10px 0;
		border-radius: 5px;
		border: 1px solid #ddd;
		font-size: 16px;
	}
	main #umsg {
		font-size: 11px;
		margin-top: 5px;
	}
	main #txt2 {
		width: 32%;
		padding: 15px;
		margin: 10px 0;
		border-radius: 5px;
		border: 1px solid #ddd;
		font-size: 13px;
		display: inline-block;
	}
	main #txt2 + select {
		width: 30%;
		font-size: 13px;
	}
</style>
<script>
	var uchk=0;
	function useridCheck(userid) {
		if(userid.trim().length>=6) {
			var chk=new XMLHttpRequest();
			chk.onload=function() {
				if(chk.responseText=="0") {
					document.getElementById("umsg").innerText="사용 가능한 아이디 입니다";
					document.getElementById("umsg").style.fontSize="11px";
					document.getElementById("umsg").style.color="blue";
					uchk=1;
				}
				else {
					document.getElementById("umsg").innerText="존재하는 아이디 입니다";
					document.getElementById("umsg").style.fontSize="11px";
					document.getElementById("umsg").style.color="red";
					uchk=0;
				}
			}
			
			chk.open("get","useridCheck?userid="+userid);
			chk.send();
		}
		else {
			document.getElementById("umsg").innerText="아이디를 입력하세요";
			document.getElementById("umsg").style.fontSize="11px";
			document.getElementById("umsg").style.color="red";
			uchk=0;
		}	
	}
	
	function chgServer(server) {
		document.mform.e2.value=server;
	}
	
	var pchk=0;
	function pwdCheck(n) {
		var pwd=document.mform.pwd.value;
		var pwd2=document.mform.pwd2.value;
		
		if(n==1 || (n==0 && pwd2!="")) {
			if(pwd==pwd2) {
				document.getElementById("pmsg").innerText="비밀번호가 일치합니다";
				document.getElementById("pmsg").style.color="blue";
				document.getElementById("pmsg").style.fontSize="11px";
				pchk=1;
			}
			else {
				document.getElementById("pmsg").innerText="비밀번호가 일치하지 않습니다";
				document.getElementById("pmsg").style.color="red";
				document.getElementById("pmsg").style.fontSize="11px";
				pchk=0;
			}
		}
	}
	
	function check() {
		var email=document.mform.e1.value+"@"+document.mform.e2.value;
		document.mform.email.value=email;
		
		if(uchk==0) {
			alert("아이디를 체크하세요");
			return false;
		}
		else if(document.mform.name.value=="") {
			alert("이름을 입력하세요");
			return false;
		}
		else if(pchk==0) {
			alert("비밀번호를 체크하세요");
			return false;
		}
		else {
			return true;
		}
	}
	
 </script>
</head>
<body>
<main>
	<form name="mform" method="post" action="memberOk" onsubmit="return check()">
	<input type="hidden" name="email">
		<h3>회원 가입</h3>
		<div>
			<input type="text" name="userid" id="txt" placeholder="아이디 (6자 이상)" onblur="useridCheck(this.value)">
			<br><span id="umsg"></span>
		</div>
		<div><input type="text" name="name" id="txt" placeholder="이 름"></div>
		<div><input type="password" name="pwd" id="txt" placeholder="비밀번호" onkeyup="pwdCheck(0)"></div>
		<div>
			<input type="password" name="pwd2" id="txt" placeholder="비밀번호 확인" onkeyup="pwdCheck(1)">
			<br><span id="pmsg"></span>
		</div>
		<div>
			<input type="text" name="e1" id="txt2" placeholder="이메일아이디">
			<input type="text" name="e2" id="txt2" placeholder="이메일서버">
			<select onchange="chgServer(this.value)">
				<option value="">직접입력</option>
				<option value="naver.com">네이버</option>
				<option value="daum.net">다음</option>
				<option value="gmail.com">구글</option>
				<option value="hotmail.com">핫메일</option>
				<option value="channy.co.kr">차니</option>
			</select>
		</div>
		<div><input type="text" name="phone" id="txt" placeholder="전화번호"></div>
		<div><input type="submit" value="회원 가입" id="submit"></div>
    </form>
</main>
</body>
</html>