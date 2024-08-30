<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		font-family: 'GmarketSansMedium';
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
	section #write {
		display:inline-block;
		width:100px;
		height:20px;
		background:green;
		color:white;
		text-align:center;
		text-decoration:none;
		padding-top:5px;
		padding-bottom:5px;
	}
	section #s2 {
		background:#65FF5E;
		padding:3px;
		font-size:11px;
	}
	section #s1 {
		background:#65FF5E;
		padding:3px;
		font-size:11px;
	}
</style>
</head>
<body> <!-- board/list.jsp -->
<section>
	<table width="800" align="center">
		<caption> <h3> 회원 게시판 </h3> </caption>
		<tr align="center">
			<td> 작성자 </td>
			<td> 제 목 </td>
			<td> 작성일 </td>
			<td> 조회수 </td>
		</tr>
		<c:forEach items="${blist}" var="bdto">
		<tr align="center">
			<td width="200"> ${bdto.userid} </td>
			<td width="300" align="left"><a href="readnum?id=${bdto.id}"> ${bdto.title} </a></td>
			<td width="150"> ${bdto.writeday} </td>
			<td width="140"> ${bdto.readnum} </td>
		</tr>
		</c:forEach>
		<c:if test="${userid != null}"> <!-- 로그인 한 회원만 -->
		<tr align="right">
			<td colspan="4"><a href="write" id="write"> 글쓰기 </a></td>
		</tr>
		</c:if>
	</table>
</section>
</body>
</html>