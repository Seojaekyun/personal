<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 상품등록</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Dokdo&family=Jua&family=Nanum+Brush+Script&display=swap');
	body {
		font-family: "Jua", sans-serif;
		font-weight: 400;
		font-style: normal;
		background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
		color: #333;
		margin: auto;
		padding: 0;
	}
	#cap {
		font-size:25px;
		text-align: center;
		color: #2c3e50;
	}
	table {
		width: 900px;
		margin: auto;
		margin-top: 20px;
		border-spacing: 0px;
		align: center;
	}
	td {
		padding: 10px;
		border-bottom: 1px solid black;
	}
	select, input[type="button"] {
		width: 24%;
		padding: 10px;
		margin: 5px 0;
		border-radius: 5px;
		border: 1px solid #ddd;
	}
	#pcode {
		width: 58%;
		padding: 10px;
		margin: 5px 0;
		border-radius: 5px;
		border: 1px solid #ddd;
	}
	input[type="text"], input[type="file"] {
		width: 71%;
		padding: 10px;
		margin: 5px 0;
		border-radius: 5px;
		border: 1px solid #ddd;
	}
	input[type="submit"] {
		width: 30%;
		padding: 10px;
		margin: 5px 0;
		border-radius: 5px;
		background: #3498db;
		color: white;
		border: none;
		cursor: pointer;
		transition: background 0.3s;
	}
	input[type="submit"]:hover {
		background: #2980b9;
	}
	#src {
		background: #ecf0f1;
		padding: 10px;
		border-radius: 5px;
		margin-top: 20px;
		overflow: auto;
		max-height: 200px;
		font-family: monospace;
	}
</style>
<script>
	function getJung(dae) {
		if(dae=="") {
			
		}
		else {
			var chk=new XMLHttpRequest();
			chk.onload=function() {
				var jungs=JSON.parse(chk.responseText);
				document.pform.jung.options.length=jungs.length+1;
				
				var i=1;
				for(jung of jungs) {
					document.pform.jung.options[i].value=jung.code;
					document.pform.jung.options[i].text=jung.name;
					i++;
				}
				
			}
			chk.open("get","getJung?dae="+dae);
			chk.send();
		}
	}
	
	function getSo(jung) {
		var dae=document.pform.dae.value;
		var daejung=dae+jung;
		
		if(jung=="") {
			
		}
		else {
			var chk=new XMLHttpRequest();
			chk.onload=function() {
				var sos=JSON.parse(chk.responseText);
				document.pform.so.options.length=sos.length+1;
				
				var i=1;
				for(so of sos) {
					document.pform.so.options[i].value=so.code;
					document.pform.so.options[i].text=so.name;
					i++;
				}
				
			}
			chk.open("get","getSo?daejung="+daejung);
			chk.send();
		}
	}
	
	function genPcode() {
		var d=document.pform.dae.value;
		var j=document.pform.jung.value;
		var s=document.pform.so.value;
		var c=document.pform.company.value;
		
		var pcode='p'+d+j+s+c;
		var chk=new XMLHttpRequest();
		chk.onload=function() {
			document.pform.pcode.value=chk.responseText;
		}
		
		chk.open("get", "genPcode?pcode="+pcode);
		chk.send();
	}
	
	function init() {
		document.pform.pcode.value="";
	}
	
	function add() {
		var len=document.getElementsByClassName("one").length;
		var copy=document.getElementById("one").cloneNode(true);
		document.getElementById("outer").appendChild(copy);
		document.getElementsByClassName("file")[len].name="fname"+len;
		document.getElementsByClassName("file")[len].value="";
	}
	
	function del() {
		var len=document.getElementsByClassName("one").length;
		if(len>1) {
			document.getElementsByClassName("one")[len-1].remove();
		}
	}
	
	function check() {
		if(document.pform.pcode.value=="") {
			alert("상품코드를 입력하세요");
			return false;
		}
		else if(document.pform.price.value=="") {
			alert("상품가격을 입력하세요");
			return false;
		}
		else {
			return true;
		}
	}
	
	function numCheck(my) {
		my.value=my.value.replace(/[^0-9]/g,"");
	}

</script>
</head>
<body>
	<form name="pform" method="post" action="proWriteOk" enctype="multipart/form-data">
		<table>
		<caption id="cap"> 상품 등록 </caption>
			<tr>
				<td> 상품코드 </td>
				<td colspan="5">
					<input type="text" name="pcode" readonly>
					<input type="button" onclick="genPcode()" value="코드생성">
					<select name="dae" onchange="getJung(this.value)">
						<option value=""> 대분류 </option>
						<c:forEach items="${dlist}" var="ddto">
							<option value="${ddto.code}"> ${ddto.name} </option>
						</c:forEach>
					</select>
					<select name="jung" onchange="getSo(this.value)">
						<option> 중분류 </option>
					</select>
					<select name="so">
						<option> 소분류 </option>
						<c:forEach items="${slist}" var="sdto">
							<option value="${sdto.code}"> ${sdto.name} </option>
						</c:forEach>
					</select>
					<select name="company" onchange="init()">
						<option> 제조회사 </option>
						<c:forEach items="${clist}" var="cdto">
							<option value="${cdto.code}"> ${cdto.name} </option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td> 이미지 </td>
				<td colspan="5">
					<input type="button" value="사진추가" onclick="add()">
					<input type="button" value="사진삭제" onclick="del()">
					<div id="outer">
						<p id="one" class="one"><input type="file" name="fname0" class="file"></p>
					</div>
				</td>
			</tr>
			<tr>
				<td> 상품명 </td>
				<td colspan="5"><input type="text" name="title"></td>
			</tr>
			<tr>
				<td> 상세정보 </td>
				<td colspan="5"><input type="file" name="dimgName"></td>
			</tr>
			<tr>
				<td>가격</td>
				<td><input type="text" name="price" onkeyup="numCheck(this)"></td>
			
				<td>할인율</td>
				<td><input type="text" name="halin" onkeyup="numCheck(this)"></td>
			
				<td>입고수량</td>
				<td><input type="text" name="su" onkeyup="numCheck(this)"></td>
			</tr>
			<tr>
				<td>배송비</td>
				<td><input type="text" name="baeprice" onkeyup="numCheck(this)"></td>
			
				<td>배송기간</td>
				<td><input type="text" name="baeday" onkeyup="numCheck(this)"></td>
			
				<td>적립율</td>
				<td><input type="text" name="juk" onkeyup="numCheck(this)"></td>
			</tr>
			<tr>
				<td colspan="6" align="center"><input type="submit" value="상품등록"></td>
			</tr>
		</table>
	</form>
	
</body>
</html>
