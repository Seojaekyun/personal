<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Diphylleia&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>회원가입</title>
<style>
	body {
		margin: auto;
		font-family: 'Diphylleia', sans-serif;
		background-color: #e0f7e9;
	}
	.container {
		width: 850px;
		background: white;
		margin: 50px auto;
		padding: 20px;
		box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
		border-radius: 8px;
		text-align: center;
	}
	form > div {
		margin: auto;
		margin-top: 10px;
		width: 300px;
	}
	span {
		display: block;
		padding: 3px;
		text-align: left;
	}
	input[type=text], input[type=password] {
		width: 300px;
		height: 30px;
		border: 1px solid purple;
		border-radius: 5px;
	}
	input[type=submit] {
		width: 305px;
		height: 40px;
		background-color: #5cb85c;
		color: white;
		font-weight: 1000;
		border: none;
		border-radius: 7px;
		cursor: pointer;
		transition: background-color 0.3s ease;
	}
	input[type=submit]:hover {
		background-color: #4cae4c;
	}
</style>
<script>
	function usidChk() {
		var uid=document.jk.uid.value.trim();
		uid=uid.replace(/ /g, "");
		if(uid.length<=7) {
			document.getElementById("msg1").innerText="아이디는 8자 이상 이어야 합니다.";
			document.getElementById("msg1").style.color="red";
		}
		else {
			var chk=new XMLHttpRequest();
			chk.onload=function () {
				var rst=chk.responseText.trim();
				if(rst==0) {
					document.getElementById("msg1").innerText="사용 가능 아이디 입니다.";
					document.getElementById("msg1").style.color="green";
				}
				else {
					document.getElementById("msg1").innerText="사용 불가 아이디 입니다.";
					document.getElementById("msg1").style.color="red";
				}
			}
			
			chk.open("get", "uidChk?uid="+uid);
			chk.send();
		}
	}
	
	function recheck() {
		var pw=document.getElementById("pwd").value.trim();
		if(pw.length<8) {
			document.getElementById("msg2").innerText="너무 짧다..";
			document.getElementById("msg2").style.color="red";
		}
		else {
			document.getElementById("msg2").innerText="적당하다..";
			document.getElementById("msg2").style.color="green";
		}
	}
	
	function isEqual() {
		var pw1=document.getElementById("pwd").value;
		var pw2=document.getElementById("pwd2").value;
		if(pw2!="") {
			if(pw2.length>=1) {
				if(pw1==pw2) {
					document.getElementById("msg3").innerText="일치합니다.";
					document.getElementById("msg3").style.color="green";
				}
				else {
					document.getElementById("msg3").innerText="확실합니까?";
					document.getElementById("msg3").style.color="red";
				}
			}
		}
	}
	
	function pspa(event) {
		if (event.key===' ') {
			event.preventDefault();
		}
	}
</script>
</head>
<body>
	<div class="container">
		<form name="jk" method="post" action="memberOk">
			<div>
				<input type="text" name="uid" placeholder="아이디" onkeydown="pspa(event)" onblur="usidChk()">
				<br><span id="msg1" style="font-size: 10px; color: gray;">아이디를 입력하세요.</span>
			</div>
			<div><input type="text" name="name" placeholder="이름"></div>
			<br>
			<div>
				<input type="password" id="pwd" name="pwd" placeholder="비밀번호" maxlength="20" onkeyup="isEqual()" onblur="recheck()">
				<br><span id="msg2" style="font-size: 10px; color: gray;">비밀번호를 입력하세요.</span>
			</div>
			<div>
				<input type="password" id="pwd2" name="pwd2" placeholder="비밀번호 확인" onkeyup="isEqual()">
				<br><span id="msg3" style="font-size: 10px; color: gray;">비밀번호를 확인하세요.</span>
			</div>
			<div><input type="text" name="email" placeholder="이메일"></div>
			<div><input type="text" name="phone" placeholder="전화번호"></div>
			<br>
			<div><input type="submit" value="회원가입"></div>
		</form>
	</div>
</body>
</html>