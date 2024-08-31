<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Diphylleia&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>수정</title>
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
	#title, #content {
		width: 513px;
	}
	#title, #name, #pwd {
		height: 30px;
	}
	#nick {
		text-align: center;
		width:100px;
	}
	#content {
		height: 200px;
	}
	#title:focus, #name:focus, #pwd:focus, #content:focus {
		border-color: red;
	}
	#submit {
		border-radius: 10px;
		width: 150px;
		height: 35px;
		background: #2F855A;
		border: none;
		color: white;
		cursor: pointer;
		font-weight: bold;
	}
	#submit:hover {
		background: #276749;
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
		color: #2F855A;
		margin: 20px 0;
	}
	.errmsg {
		font-size: 12px;
		color: red;
	}

</style>
</head>
<body>
<form method="post" action="updateOk">
	<input type="hidden" name="id" value="${bdto.id }">
	<input type="hidden" name="page" value="${page}">
	<input type="hidden" name="rec" value="${rec}">
	<table>
	<caption>수 정</caption>
		<tr>
			<td id="nick">제 목</td>
			<td colspan="3"><input type="text" name="title" id="title" value="${bdto.title }"></td>
		</tr>
		<tr>
			<td id="nick">작성자</td>
			<td><input type="text" name="name" id="name" value="${bdto.name }"></td>
			<td id="nick">비밀번호</td>
			<td>
				<input type="password" name="pwd" id="pwd">
				<c:if test="${not empty param.err }">
					<span class="errmsg">비밀번호 오류</span>
				</c:if>
			</td>
		</tr>
		<tr>
			<td id="nick">내 용</td>
			<td colspan="3"><textarea name="content" id="content">${bdto.content }</textarea></td>
		</tr>
		<tr align="center">
			<td colspan="4">
				<input type="submit" value="수정" id="submit">
				<a href="content?id=${bdto.id }&page=${page }&rec=${rec }"><input type="button" value="취소" id="submit" style="background: white; color: #2F855A; border: 1px solid #2F855A;"></a>
			</td>
		</tr>
	</table>
</form>
</body>
</html>