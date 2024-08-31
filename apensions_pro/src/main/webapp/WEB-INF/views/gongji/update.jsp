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
		font-size:16px;
	}
	section div {
		margin-top:8px;
	}
</style>
<script>
	window.onload=function() {
		document.uform.state[${gdto.state}].checked=true;
	}
</script>
</head>
<body> <!-- gongji/update.jsp -->

<section>
	<form method="post" action="updateOk" name="uform">
	<input type="hidden" name="id" value="${gdto.id}">
		<h3> 공지사항 글수정 </h3>
		<div><input type="text" name="title" placeholder="제 목" value="${gdto.title}"></div>
		<div><textarea name="content" placeholder="공지사항 내용">${gdto.content}</textarea></div>
		<div> 
			<input type="radio" name="state" value="0"> 일반공지
			<input type="radio" name="state" value="1"> 상시공지
			<input type="radio" name="state" value="2"> 필수공지
		</div>
		<div><input type="submit" value="공지사항 등록"></div>
	</form>
</section>

</body>
</html>