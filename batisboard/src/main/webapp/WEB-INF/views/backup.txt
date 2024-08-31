<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Diphylleia&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>내용 보기</title>
<style>
	body {
		font-family: 'Diphylleia', sans-serif;
		background-color: #e0f7e9;
		margin: 0;
		padding: 0;
		line-height: 1.6;
	}
	.cont {
		width: 700px;
		margin: 50px auto;
		padding: 20px;
		background-color: #fff;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		border-radius: 8px;
	}
	table {
		width: 100%;
		border-collapse: collapse;
		margin-top: 20px;
	}
	table caption {
		padding-bottom: 20px;
		font-size: 24px;
		font-weight: bold;
		color: #3c763d;
	}
	table, td {
		border: 1px solid #ddd;
	}
	td {
		padding: 15px;
		text-align: left;
	}
	td[colspan="4"] {
		text-align: center;
	}
	tr:first-child td {
		border-top: 2px solid #3c763d;
	}
	tr:last-child td {
		border-bottom: 2px solid #3c763d;
	}
	#btn1, #btn2, #btn3, #btn-cancel, input[type="submit"], input[type="button"] {
		display: inline-block;
		width: 80px;
		height: 30px;
		line-height: 30px;
		background: #5cb85c;
		border: 1px solid #4cae4c;
		text-decoration: none;
		color: white;
		text-align: center;
		border-radius: 4px;
		transition: background-color 0.3s ease;
		margin: 5px;
		cursor: pointer;
	}
	#btn2 {
		background: #f0ad4e;
		border-color: #eea236;
	}
	#btn3, #btn-cancel, input[type="submit"], input[type="button"] {
		background: #d9534f;
		border-color: #d43f3a;
	}
	#btn1:hover, #btn2:hover, #btn3:hover, #btn-cancel:hover, input[type="submit"]:hover, input[type="button"]:hover {
		background-color: #449d44;
		border-color: #398439;
	}
	#btn2:hover {
		background-color: #ec971f;
		border-color: #d58512;
	}
	#btn3:hover, #btn-cancel:hover, input[type="submit"]:hover, input[type="button"]:hover {
		background-color: #c9302c;
		border-color: #ac2925;
	}
	#delform {
		display: none;
	}
	.img-preview {
		margin-top: 10px;
		text-align: center;
	}
	.img-preview img {
		max-width: 100%;
		height: auto;
	}
</style>
<script>
	function viewform() {
		document.getElementById("delform").style.display="table-row";
	}
	function hide() {
		document.getElementById("delform").style.display="none";
	}
</script>
</head>
<body>
	<div class="cont">
		<table>
			<caption>내 용</caption>
			<tr>
				<td>제 목</td>
				<td colspan="3">${bdto.title }</td>
			</tr>
			<tr>
				<td width="100">작성자</td>
				<td width="250">${bdto.name }</td>
				<td width="100">조회수</td>
				<td width="250">${bdto.rnum }</td>
			</tr>
			<tr>
				<td>작성일</td>
				<td colspan="3">${bdto.writeday }</td>
			</tr>
			<tr height="300">
				<td>내 용</td>
				<td colspan="3">${bdto.content }</td>
			</tr>
			<tr>
				<td colspan="4">
					<a href="list?page=${page }&rec=${rec }" id="btn1">목록</a>
					<a href="update?id=${bdto.id }&page=${page }&rec=${rec }" id="btn2">수정</a>
					<a href="javascript:viewform()" id="btn3">삭제</a>
				</td>
			</tr>
			<tr id="delform">
				<td colspan="4">
					<form method="post" action="delete">
						<input type="hidden" name="id" value="${bdto.id }">
						<input type="hidden" name="page" value="${page }">
						<input type="hidden" name="rec" value="${rec }">
						비 번 <input type="password" name="pwd">
						<input type="submit" value="삭제">
						<input type="button" value="취소" onclick="hide()">
					</form>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>