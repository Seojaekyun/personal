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
		height:50px;
	}
	section #pwd  {
		width:400px;
		height:50px;
	}
	section #sub {
		width:406px;
		height:54px;
		background:green;
		color:white;
	}
</style>
<script>
	function check(my) { // my=document.form
		if(my.userid.value.trim().length==0) {
      		alert("아이디를 입력하세요");
			return false;
		}
		else if(my.pwd.value.trim().length==0) {
			alert("비밀번호를 입력하세요");
			return false;
		}
		else {
			return true;
		}
	}
	
	var fs1=22;
	var fs2=22;
	function sizedown(n) {
  		var num;
		if(n==0) {
			num=fs1;
		}
		else {
			num=fs2;
		}
      	
		if(num!=11) {
			s1=setInterval(function() {   
				num--;
				document.getElementsByClassName("inner")[n].style.fontSize=num+"px";
 	    		
				if(num==11) {	
					clearInterval(s1);
					if(n==0) {
						fs1=11;
					}
					else {
						fs2=11;
					}
				}
			},10);
		}
	}
	
	function init(my,n) {
		if(my.value.trim().length==0) {
			if(n==0) {
				num=fs1;
			}
			else {
				num=fs2;
			}
			
			s2=setInterval(function() {
				num++;
				document.getElementsByClassName("inner")[n].style.fontSize=num+"px";
				
				if(num>=22) {	
					console.log(num);
					clearInterval(s2);
					if(n==0) {
						fs1=22;
					}
					else {
						fs2=22;
					}
				}
			},20);
		}
	}

	window.onload=function() {
		document.getElementById("txt").focus();
	}
	function useridSearch() {
		son=open("usForm","","width=300,height=300");
		son.moveTo(800,200);
	}
	function pwdSearch() {
		son=open("psForm","","width=300,height=370");
		son.moveTo(800,200);
	}
	function reMember() {
		son=open("reForm","","width=300,height=300");
		son.moveTo(800,200);
  	}
</script>
</head>
<body>  
<section>
	<form method="post" action="loginOk" onsubmit="return check(this)">
	<c:if test="${year!=null }">
	<input type="hidden" name="year" value="${year}">
	<input type="hidden" name="month" value="${month}">
	<input type="hidden" name="day" value="${day}">
	<input type="hidden" name="id" value="${id}">
	</c:if>
		<h3> 로 그 인 </h3>
		<div> <input type="text" name="userid" value="admin" placeholder="아 이 디" id="txt"> </div>
		<div> <input type="password" name="pwd" value="1234" placeholder="비밀번호" id="pwd"> </div>
		<div> <input type="submit" value="로그인" id="sub"> </div>
	    <c:if test="${err==1}">
	    <div style="font-size:12px;color:red;"> 아이디 혹은 비밀번호가 일치하지 않습니다 </div>
	    </c:if>
    </form>
    <div>
       <span id="btn" onclick="useridSearch()"> 아이디 찾기 | </span> 
       <span id="btn" onclick="pwdSearch()"> 비밀번호 찾기 | </span>
       <span id="btn" onclick="reMember()"> 복구신청 </span>
    </div>
  </section>
</body>
</html>