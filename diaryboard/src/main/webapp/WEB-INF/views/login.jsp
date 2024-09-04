<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Diphylleia&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>딴지의 여행기</title>
<style>
	body {
		margin: 0;
		font-family: 'Diphylleia', sans-serif;
		background-color: #e0f7e9;
		display: flex;
		justify-content: center;
		align-items: center;
		height: 100vh;
	}
	.cont {
		width: 300px;
		background: white;
		padding: 20px;
		box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
		border-radius: 8px;
		text-align: center;
	}
	table {
		width: 100%;
		border: 1px solid #ddd;
		border-collapse: collapse;
		background: #f4fff9;
		border-radius: 5px;
	}
	tr {
		border: 1px solid #ddd;
		height: 35px;
	}
	td {
		border: 1px solid #ddd;
		text-align: center;
		padding: 8px;
	}
	thead tr {
		background: #d0f0df;
	}
	thead td {
		font-weight: bold;
		color: #3c763d;
	}
	h1 {
		margin-bottom: 15px;
		font-size: 34px;
		color: #8904B1;
	}
	h3 {
		margin: 0;
		color: #D7DF01;
	}
	input[type="button"], [type="submit"] {
		background-color: #5cb85c;
		color: white;
		border: none;
		padding: 5px 8px;
		text-align: center;
		text-decoration: none;
		display: inline-block;
		font-family: 'Diphylleia', sans-serif;
		font-size: 14px;
		border-radius: 7px;
		cursor: pointer;
		transition: background-color 0.3s ease;
	}
	input[type="button"], [type="submit"]:hover {
		background-color: #4cae4c;
	}
	a {
		text-decoration: none;
	}
	#lgin {
		width: 180px;
		height: 30px;
		border-radius: 10px;
	}
</style>
</head>
<body>
	<div class="cont">
		<h1>딴지의 여행기</h1>
		<h3>허락된 사람만 들어갈 수 있어요</h3>
		<form method="post" action="loginOk">
			<table>
				<tr>
					<td colspan="2" style="text-align: right;">
						<a href="member"><input type="button" value="가입하기"></a>
					</td>
				</tr>
				<thead>
					<tr>
						<td width="50"><div>ID</div></td>
						<td class="log"><input type="text" id="lgin" name="uid"></td>
					</tr>
					<tr>
						<td width="50"><div>PW</div></td>
						<td class="log"><input type="password" id="lgin" name="pwd" value='123456789'></td>
					</tr>
					<c:if test="${not empty param.err }">
					<tr>
						<td colspan="2">
							<span class="errmsg" style="color: red">정보를 확인하세요.</span>
						</td>
					</tr>
					</c:if>
					<tr>
						<td colspan="2"><input type="submit" value="입장하기"></td>
					</tr>
				</thead>
			</table>
		</form>
	</div>
</body>
</html>
