<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Dokdo&display=swap" rel="stylesheet">
<title>Insert title here</title>
<style>
	body {
		font-family: "Do Hyeon", sans-serif;
	}
	section {
		width:1000px;
		margin:auto;
	}
	section table {
		border-spacing:0px;
		margin-top:6px;
	}
	section table td {
		border:1px solid green;
	}
	section #inTxt {
		width:746px;
		height:98px;
		overflow:auto;
	}
	section textarea {
		width:746px;
		height:98px;
		outline:none;
		border:none;
	}
</style>
</head>
<body>  
<section>
	<h3 align="center">문의 사항</h3>
	<a href="../main/index">돌아가기</a>
	<c:forEach items="${ilist}" var="idto">
	<form method="post" action="inquiryOk">
	<input type="hidden" name="id" value="${idto.id}">
	<table width="1000" align="center">
		<tr>
			<td rowspan="2" width="140" align="center"> ${idto.title2} </td>
			<td width="750" height="100"><div id="inTxt"> ${idto.content} </div></td>
			<td rowspan="2" width="100" align="center">
				${idto.writeday}<br>
				<input type="submit" value="답변">
			</td>
		</tr>
		<tr>
			<td height="100"><textarea name="answer" id="answer"> ${idto.answer} </textarea> </td>
		</tr>
	</table>
	</form>
	</c:forEach>
</section>
</body>
</html>