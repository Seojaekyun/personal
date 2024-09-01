<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	section input[type=text] {
		width:700px;
		height:50px;
		border:1px solid green;
		outline:none;
		font-family: 'GmarketSansMedium';
		font-size:16px;
	}
	section textarea {
		width:700px;
		height:300px;
		border:1px solid green;
		outline:none;
		font-family: 'GmarketSansMedium';
		font-size:16px;
	}
	section input[type=submit] {
		width:708px;
		height:54px;
		border:1px solid green;
		outline:none;
		background:green;
		color:white;
		font-family: 'GmarketSansMedium';
		font-size:17px;
	}
	section div {
		margin-top:8px;
	}
</style>
</head>
<body> <!-- board/write.jsp -->

<section>
	<form method="post" action="writeOk">
		<h3> 회원게시판 글쓰기 </h3>
		<div><input type="text" name="title" placeholder="제 목"></div>
		<div><textarea name="content" placeholder="내 용"></textarea></div>
		<div><input type="submit" value="글 등록"></div>
	</form>
</section>

</body>
</html>