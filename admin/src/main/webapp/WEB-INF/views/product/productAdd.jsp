<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html><head><meta charset="UTF-8"><title>白oneMARKET</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Dokdo&family=Jua&family=Nanum+Brush+Script&display=swap');
	body {
		font-family: "Jua", sans-serif;
		font-weight: 400;
		font-style: normal;
		background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
		color: #333;
		margin: 0;
		padding: 0;
	}
	section {
		padding: 20px;
		margin: 20px auto;
		width: 800px;
		background: white;
		box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
		border-radius: 10px;
	}
	h3 {
		font-size:25px;
		text-align: center;
		color: #2c3e50;
	}
	table {
		width: 100%;
		margin: 0 auto;
		border-spacing:0px;
	}
	td {
		padding: 10px;
		border-bottom:1px solid black;
	}
	select, input[type="button"] {
		width: 20%;
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
		width: 80%;
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
	function viewSrc() {
		document.getElementById("src").innerText=document.pform.innerHTML;
	}
	
	function getJung(daecode) {
		document.pform.so.options.length=1;
		
		var chk=new XMLHttpRequest();
		chk.onload=function() {
			var jungAll=JSON.parse(chk.responseText);
			var str="<option value='0'> 선 택 </option>";
			for(jung of jungAll) {
				str+="<option value='"+jung.code+"'> "+jung.name+" </option>";
			}
			
			document.pform.jung.innerHTML=str;
		}
		
		chk.open("get", "getJung?daecode="+daecode);
		chk.send();
	}
	
	function getSo(daejung) {
		var chk=new XMLHttpRequest();
		chk.onload=function() {
			var soAll=JSON.parse(chk.responseText);
			var str="<option value='0'> 선 택 </option>";
			for(so of soAll) {
				str+="<option value='"+so.code+"'> "+so.name+" </option>";
			}
			
			document.pform.so.innerHTML=str;
		}
		
		chk.open("get", "getSo?daejung="+daejung);
		chk.send();
	}
	
	function genPcode() {
		var d=document.pform.dae.value;
		var j=document.pform.jung.value;
		var s=document.pform.so.value;
		var c=document.pform.company.value;
		var pcode="p"+d+j+s+c;
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
		my.value.replace(/[^0-9]/g,"");
	}
	
</script>
</head>
<body>

<input type="button" onclick="viewSrc()" value="소스보기">
<div id="src"></div>

<section>
	<form name="pform" onsubmit="return check()" method="post" action="productAddOk" enctype="multipart/form-data">
		<table>
			<caption><h3>상품 등록</h3></caption>
			<tr>
				<td width="20%">상품코드</td>
				<td>
					<input type="text" id="pcode" name="pcode" readonly>
					<input type="button" onclick="genPcode()" value="상품코드등록">
					<select name="dae" onchange="getJung(this.value)">
						<option value="0">선 택</option>
						<c:forEach items="${daeAll}" var="dae">
							<option value="${dae.code}">${dae.name}</option>
						</c:forEach>
					</select>
					<select name="jung" onchange="getSo(document.pform.dae.value + this.value)">
						<option value="0" >선 택</option>
					</select>
					<select name="so" onchange="init()">
						<option value="0">선 택</option>
					</select>
					<select name="company" onchange="init()">
						<option value="0">선 택</option>
						<c:forEach items="${companyAll}" var="company">
							<option value="${company.code}">${company.name}</option>
						</c:forEach>
					</select>
					
				</td>
			</tr>
			<tr>
				<td>이미지</td>
				<td>
					<input type="button" value="사진추가" onclick="add()">
					<input type="button" value="사진삭제" onclick="del()">
					<div id="outer">
						<p id="one" class="one"><input type="file" name="fname0" class="file"></p>
					</div>
				</td>
			</tr>
			<tr>
				<td>상품명</td>
				<td><input type="text" name="title"></td>
			</tr>
			<tr>
				<td>상세정보</td>
				<td><input type="file" name="dimgName"></td>
			</tr>
			<tr>
				<td>가격</td>
				<td><input type="text" name="price"></td>
			</tr>
			<tr>
				<td>할인율</td>
				<td><input type="text" name="halin" onkeyup="numCheck(this)"></td>
			</tr>
			<tr>
				<td>입고수량</td>
				<td><input type="text" name="su" onkeyup="numCheck(this)"></td>
			</tr>
			<tr>
				<td>배송비</td>
				<td><input type="text" name="baeprice" onkeyup="numCheck(this)"></td>
			</tr>
			<tr>
				<td>배송기간</td>
				<td><input type="text" name="baeday" onkeyup="numCheck(this)"></td>
			</tr>
			<tr>
				<td>적립율</td>
				<td><input type="text" name="juk" onkeyup="numCheck(this)"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="상품등록"></td>
			</tr>
		</table>
	</form>
</section>

</body></html>