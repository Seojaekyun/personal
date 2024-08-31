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
		text-align:center;
		overflow:auto;
	}
	section div {
		width:700px;
		line-height:50px;
		border:1px solid green;
		margin:auto;
		margin-top:8px;
	}
	section #content {
		overflow:auto;
		padding-top:10px;
		padding-bottom:10px;
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
	section #imgs {
		overflow-y:none;
		padding-top:10px;
		padding-bottom:10px;
		padding-top:10px;
	}
</style>
</head>
<body> <!-- tour/content.jsp -->
<section>
	<h3> 여행 후기 </h3>
    <div> 글쓴이 : ${writer} </div>
    <div> ${tdto.title} : ${tdto.readnum} <span id="rnum">(조회수)</span></div>
    <div id="imgs">
		<c:forEach items="${timg}" var="img">
		<img src="../resources/tour/${img}" width="150">
		</c:forEach>
	</div>
	<div id="content"> ${tdto.content} </div>
	<div id="btn">
		<a href="list"> 목록 </a>
		<c:if test="${userid == tdto.userid}">
		<a href="update?id=${tdto.id}"> 수정 </a>
		<a href="delete?id=${tdto.id}"> 삭제 </a>
		</c:if>
		<c:if test="${userid == 'admin' && tdto.userid != 'admin'}">
		<a href="delete?id=${tdto.id}"> 삭제 </a>
		</c:if>
	</div>
</section>
</body>
</html>