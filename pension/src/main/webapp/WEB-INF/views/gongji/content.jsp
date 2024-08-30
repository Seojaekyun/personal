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
		text-align:center;
	}
	section div {
		width:700px;
		height:50px;
		line-height:50px;
		border:1px solid green;
		margin:auto;
		margin-top:8px;
	}
	section #content {
		height:300px;
		overflow:auto;
		line-height:30px;
	}
	section #rnum {
		font-size:11px;
		color:green;
	}
	section #btn a {
		display:inline-block;
		text-decoration:none;
		width:100px;
		height:28px;
		line-height:30px;
		border:1px solid green;
		color:green;
	}
</style>
</head>
<body> <!-- gongji/content.jsp -->
<section>
	<h3> 공지사항 내용 </h3>
	<div> ${gdto.title} </div>
	<div> ${gdto.readnum} <span id="rnum">(조회수)</span></div>
	<div id="content"> ${gdto.content} </div>
	<div id="btn">
		<a href="list"> 목록 </a>
		<c:if test="${userid=='admin'}">
		<a href="update?id=${gdto.id}"> 수정 </a>
		<a href="delete?id=${gdto.id}"> 삭제 </a>
		</c:if>
	</div>
</section>
</body>
</html>