<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Diphylleia&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>새글</title>
<style>
	body {
		background-color: #E0F7E9;
		font-family: 'Diphylleia', sans-serif;
		color: #333;
	}
	#title, #name, #pwd, #content {
		border: 1px solid #2F855A;
		outline: none;
		border-radius: 5px;
		padding: 5px;
	}
	#content {
		width: 513px;
		height: 200px;
	}
	#title, #name, #pwd {
		height: 30px;
	}
	#nick {
		text-align: center;
		width:100px;
	}
	#title:focus, #name:focus, #pwd:focus, #content:focus {
		border-color: red;
	}
	#submit {
		border-radius: 10px;
		width: 150px;
		height: 35px;
		background: #2F855A; /* 진한 녹색 */
		border: none;
		color: white;
		cursor: pointer;
		font-weight: bold;
	}
	#submit:hover {
		background: #276749; /* 어두운 녹색 */
	}
	table {
		border-spacing: 0px;
		width: 700px;
		margin: auto;
		background: white;
		border-radius: 5px;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	}
	table td {
		border-bottom: 1px solid black;
		padding: 5px;
		height: 50px;
	}
	tr {
		align: center;
	}
	table tr:first-child td {
		border-top: 2px solid black;
	}
	table tr:last-child td {
		border-bottom: 2px solid black;
	}
	caption {
		font-size: 1.5em;
		font-weight: bold;
		color: #2F855A; /* 진한 녹색 */
		margin: 20px 0;
	}
	.error-message {
		font-size: 12px;
		color: red;
	}
</style>
<script>
	function add() {
		var len=document.getElementsByClassName("file").length;
		if(len<10) {
			var one=document.getElementById("one");
			var inner=one.cloneNode(true);
			var outer=document.getElementById("outer");
			outer.appendChild(inner);
			
			document.getElementsByClassName("file")[len].name="fname"+len;
			document.getElementsByClassName("file")[len].value="";
			document.getElementsByClassName("img")[len].innerHTML="";
			document.getElementsByClassName("label")[len].setAttribute("for", "fileUp"+len);
			document.getElementsByClassName("file")[len].id="fileUp"+len;
		}
	}
	
	function del() {
		var len=document.getElementsByClassName("file").length;
		if(len>1) {
			document.getElementsByClassName("one")[len-1].remove();
		}
	}
	
	function miniView(my) {
		var n=parseInt(my.name.substring(5));
		for(var image of event.target.files) {
			var reader=new FileReader();
			reader.onload=function() {
				var new1=document.createElement("img");
				new1.setAttribute("src",event.target.result);
				new1.setAttribute("width", "80");
				new1.setAttribute("valign", "middle");
				if(document.getElementsByClassName("img")[n].innerHTML!="") {
					document.getElementsByClassName("img")[n].innerHTML="";
				}
				document.getElementsByClassName("img")[n].appendChild(new1);
			};
			reader.readAsDataURL(image);
		}
	}
</script>
</head>
<body>
	<form method="post" action="writeOk" enctype="multipart/form-data">
		<input type="hidden" name="name" id="name" value="${name }">
		<input type="hidden" name="uid" id="uid" value="${uid }">
		<table>
			<caption>새 글</caption>
			<tr>
				<td id="nick">제 목</td>
				<td><input type="text" name="title" id="title"></td>
				<td id="nick">비밀번호</td>
				<td><input type="password" name="pwd" id="pwd"></td>
			</tr>
			<tr>
				<td id="nick">내 용</td>
				<td colspan="3"><textarea name="content" id="content"></textarea></td>
			</tr>
			<tr>
				<td colspan="4" id="nick">사진등록</td>
			</tr>
			<tr>
				<td id="nick">
					<input type="button" value="추가" onclick="add()"><br>
					<input type="button" value="삭제" onclick="del()">
				</td>
				<td id="outer" colspan="3">
					<p class="one" id="one">
						<label for="fileUp0" class="label"> 사진추가 </label>
						<input id="fileUp0" style="width:0px;" type="file" name="fname0" class="file" onchange="miniView(this)">
						<span class="img"></span>
					</p>
				</td>
			</tr>
			<tr align="center">
				<td colspan="4">
					<input type="submit" value="저장" id="submit">
					<a href="list"><input type="button" value="취소" id="submit" style="background: white; color: #2F855A; border: 1px solid #2F855A;"></a>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>