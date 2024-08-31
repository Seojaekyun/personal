<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://jakarta.ee/jsp/jstl/core" prefix="c" %>
<html>
<head>
<style>
	section {
		width:1200px;
		height:600px;
		margin:auto;
	}
	section #image {
		width:1200px;
		height:400px;
		margin:auto;
	}
	section #community {
		width:1000px;
		height:300px;
		margin:auto;
		text-align:center;
		margin-top:10px;
	}
	section #community .comm {
		float:left;     
		width:325px;
		height:200px;
		border:2px dashed green;
	}
	section #community .comm .name {
		display:inline-block;
		width:90px;
		height:26px;
		font-size:13px;
		padding-left:7px;
		overflow:hidden;
	}
	section #community .comm .title {
		display:inline-block;
		width:220px;
		height:26px;
		font-size:16px;
		overflow:hidden;
	}
	section #community a {
		color:black;
		text-decoration:none;
	}
</style>
</head>
<body>
<section>
	<div id="image"> <img src="../resources/main.jpg" width="1200" height="400"> </div>
	<div id="community">
		<div class="comm">
			<div align="center" style="font-size:20px;margin-top:5px;margin-bottom:5px;"> 공지사항 </div>
				<c:forEach items="${glist}" var="gdto">
				<div class="name" align="left">관리자</div>
				<div class="title" align="left"><a href="../gongji/readnum?id=${gdto.id}"> ${gdto.title} </a></div>
				</c:forEach>
		</div>
		<div class="comm">
			<div align="center" style="font-size:20px;margin-top:5px;margin-bottom:5px;"> 게시판 </div>
				<c:forEach items="${blist}" var="bdto">
				<div class="name" align="left">${bdto.userid}</div>
				<div class="title" align="left"><a href="../board/readnum?id=${bdto.id}"> ${bdto.title} </a></div>
				</c:forEach>
		</div> 
		<div class="comm">
			<div align="center" style="font-size:20px;margin-top:5px;margin-bottom:5px;"> 여행후기 </div>
				<c:forEach items="${tlist}" var="tdto">
				<div class="name" align="left">${tdto.userid}</div>
				<div class="title" align="left"><a href="../tour/readnum?id=${tdto.id}"> ${tdto.title} </a></div>
				</c:forEach>
		</div>
	</div>
</section>
</body>
</html>