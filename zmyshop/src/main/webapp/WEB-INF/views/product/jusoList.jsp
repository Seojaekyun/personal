<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.baeJuso {
		width:420px;
		height:130px;
		margin:auto;
		border:1px solid purple;
		margin-top:5px;
		padding:4px;
		font-family: Arial, sans-serif;;
	}
	.baeJuso > div {
		margin-top:4px;
	}
	input[type=button] {
		width:430px;
		height:36px;
		background:purple;
		border:1px solid purple;
		color:white;
		font-family: Arial, sans-serif;;
	}
	#submit {
		text-align:center;
		margin-top:5px;
	}
	#gibon {
		border:1px solid purple;
		padding:1px 4px;
		font-size:12px;
		border-radius:10px;
	}
	button {
		width:70px;
		height:24px;
		background:white;
		border:1px solid purple;
		color:purple;
		font-family: Arial, sans-serif;;
	}
</style>
<script>
	function transJuso(n) { //  부모창 = 자식창의 값;
		opener.document.getElementById("bname").innerText=document.getElementsByClassName("bname")[n].innerText;
		opener.document.getElementById("bjuso").innerText=document.getElementsByClassName("bjuso")[n].innerText;
		opener.document.getElementById("bphone").innerText=document.getElementsByClassName("bphone")[n].innerText;
		opener.document.getElementById("breq").innerText=document.getElementsByClassName("breq")[n].innerText;
		opener.document.gform.baeId.value=document.getElementsByClassName("id")[n].value;
		// 주소변경후
		close();
	}
</script>
</head>
<body>
	<c:forEach items="${blist}" var="bdto" varStatus="sts">
	<input type="hidden" name="id" value="${bdto.id}" class="id">
	<div class="baeJuso">
		<div class="bname">${bdto.name}</div>
		<c:if test="${bdto.gibon==1}">
		<div> <span id="gibon">기본 배송지</span> </div>
		</c:if>
		<div class="bjuso">${bdto.juso} ${bdto.jusoEtc }</div>
		<div class="bphone">${bdto.phone}</div>
		<div>
			<div style="float:left;" class="breq"> ${bdto.breq} </div>
			<div style="float:right;">
				<button type="button" onclick="location='jusoUpdate?id=${bdto.id}'"> 수정 </button>
				<button type="button" onclick="location='jusoDel?id=${bdto.id}'"> 삭제 </button>
				<button type="button" onclick="transJuso(${sts.index})"> 선택 </button>
			</div>
		</div>
	</div>
	</c:forEach>
	<div id="submit"> <input type="button" value="배송지 추가" onclick="location='jusoWrite?tt=1'"> </div>
</body>
</html>