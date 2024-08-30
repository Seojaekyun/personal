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
	}
	section table {
		border-spacing:0px;  
		margin-bottom:200px;
	}
	section table td {
		border-bottom:1px solid green;
		padding:5px;
		height:35px;
	}
	section table tr:first-child td {
		border-top:2px solid green;
		border-bottom:2px solid green;
	}
	section table tr:last-child td {
		border-bottom:2px solid green;
	}
	section table a {
		text-decoration:none;
		color:black;
	}
</style>
</head>
<body>  
<section>
	<table width="800" align="center">
		<caption> <h3> 여행 후기 </h3> </caption>
		<tr align="center">
			<td> 작성자 </td>
			<td> 제 목 </td>
			<td> 조회수 </td>
			<td> 작성일 </td>
		</tr>
		<c:forEach items="${tlist}" var="tdto">
		<tr>
			<td> ${tdto.userid} </td>
			<td><a href="readnum?id=${tdto.id}"> ${tdto.title} </a></td>
			<td> ${tdto.readnum} </td>
			<td> ${tdto.writeday} </td>
		</tr>
		</c:forEach>
		<tr>
			<td colspan="4" align="center"> 
				<a href="write"> 후기 등록 </a>
			</td>
		</tr>
	</table>
</section>
</body>
</html>