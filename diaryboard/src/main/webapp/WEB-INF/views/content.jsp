<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Diphylleia&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>게시판 내용</title>
<style>
	body {
		font-family: 'Diphylleia', sans-serif;
		font-size: 16px;
		background-color: #e8f1f9;
		margin: 0;
		padding: 0;
		line-height: 1.6;
		
	}
	table {
		width: 900px;
		margin: 20px auto;
		border-collapse: collapse;
		background-color: #fff;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		border-radius: 8px;
		font-size: 15px;
	}
	caption {
		padding: 20px;
		font-size: 25px;
		font-weight: bold;
		color: #0056b3;
	}
	th, td {
		border: 1px solid #ddd;
		padding: 10px;
		text-align: center;
		font-size: 14px;
	}
	tr:first-child th, tr:first-child td {
		border-top: 2px solid #0056b3;
	}
	tr:last-child td {
		border-bottom: 2px solid #0056b3;
	}
	.center {
		text-align: center;
	}
	.comment-input {
		width: 95%;
		padding: 10px;
		border: 1px solid #28a745;
		border-radius: 4px;
		outline: none;
		transition: border-color 0.3s;
	}
	.comment-input:focus {
		border-color: #ff0000;
	}
	.comment-form, .popup-form {
		text-align: center;
		margin: 20px auto;
	}
	.popup-overlay {
		display: none;
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background: rgba(0, 0, 0, 0.5);
		z-index: 999;
	}
	.popup-form {
		display: none;
		position: fixed;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		background: white;
		padding: 20px;
		width: 500px;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		border-radius: 8px;
		z-index: 1000;
		background: #F2F2F2;
	}
	.popup-form .comment-input {
		width: calc(100% - 22px);
		margin-bottom: 10px;
	}
	.popup-form .comment-textarea {
		height: 120px;
	}
	.form-buttons {
		display: flex;
		justify-content: center;
		margin-top: 20px;
	}
	.half-width {
		width: calc(50% - 11px);
		display: inline-block;
	}
	#btn1, #btn2, #btn3, #btn4, #commentBtn {
		display: inline-block;
		width: 40px;
		height: 25px;
		line-height: 25px;
		background: #0056b3;
		border: none;
		text-decoration: none;
		color: #fff;
		border-radius: 4px;
		text-align: center;
		margin: 5px;
		cursor: pointer;
		transition: background 0.3s;
	}
	#btn1:hover, #btn2:hover, #btn3:hover, #commentBtn:hover {
		background: #003d80;
	}
	#btn2 {
		background: #28a745;
	}
	#btn2:hover {
		background: #218838;
	}
	#btn3 {
		background: #dc3545;
	}
	#btn3:hover {
		background: #c82333;
	}
	#delform {
		display: none;
	}
	.dat-table {
		width: 900px;
		margin: 20px auto;
		border-collapse: collapse;
		background-color: #fff;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		border-radius: 8px;
	}
	.dat-table caption {
		padding: 10px;
		font-size: 20px;
		font-weight: bold;
		color: #0056b3;
	}
	.dat-table th, .dat-table td {
		border: 1px solid #ddd;
		padding: 5px;
		text-align: center;
		font-size: 12px;
	}
	.dat-table th {
		font-weight: bold;
	}
	.dat-table tr:first-child th, .dat-table tr:first-child td {
		border-top: 2px solid #0056b3;
	}
	.dat-table tr:last-child td {
		border-bottom: 2px solid #0056b3;
	}
	.comment-table {
		width: 100%;
	}
	.comment-table td {
		padding: 5px;
	}
	.comment-table input[type="text"], 
	.comment-table input[type="password"] {
		width: calc(100% - 20px);
	}
	.popup-form2 {
		position: fixed;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		background-color: white;
		border: 1px solid #ccc;
		padding: 20px;
		z-index: 1000;
		box-shadow: 0 0 10px rgba(0,0,0,0.1);
		display: none;
	}
</style>
<script>
	function showForm(id) {
		document.getElementById('popup-overlay').style.display='block';
		document.getElementById(id).style.display='block';
	}
	function hideForm(id) {
		document.getElementById(id).style.display='none';
		document.getElementById('popup-overlay').style.display='none';
	}
	function hide() {
		document.getElementById("comment-f").style.display='none';
	}
	function hide2() {
		document.getElementById("delform").style.display='none';
	}
	function hideAllForms() {
		document.getElementById('popup-overlay').style.display='none';
		var forms = document.getElementsByClassName('popup-form');
		for (var i=0;i<forms.length;i++) {
			forms[i].style.display='none';
		}
	}
	function viewform() {
		document.getElementById("delform").style.display="table-row";
	}
	function viewform1() {
		document.getElementById("comment-f").style.display="table-row";
	}
	function viewUpform(id, nick, content) {
		document.getElementById("update-popup-"+id).style.display="block";
		document.getElementById('popup-overlay').style.display='block';
		document.getElementById("update-nick-"+id).value=nick;
		document.getElementById("update-content-"+id).value=content;
	}
	function showErrorPopup() {
		var errorPopup=document.getElementById('dperr');
		var errParam='<c:out value="${param.err}" />';
		if(errParam){
			errorPopup.style.display = 'block';
		}
	}
</script>
</head>
<body>
	${name} / ${uid } / ${wuid }
	<table class="content-table">
		<caption>게시판 내용</caption>
		<tr>
			<td style="font-weight:bold">제목</td>
			<td colspan="3">${bdto.title}</td>
		</tr>
		<tr>
			<td style="font-weight:bold">작성자</td>
			<td>${bdto.writer}</td>
			<td style="font-weight:bold">조회수</td>
			<td>${bdto.rnum}</td>
		</tr>
		<tr>
			<td style="font-weight:bold">작성일</td>
			<td colspan="3">${bdto.writeday}</td>
		</tr>
		<tr>
			<td colspan="4">
				<div id="imgs">
					<c:forEach items="${imgs}" var="img">
						<img src="resources/pich/${img}" width="200">
					</c:forEach>
				</div>
			</td>
		</tr>
		<tr style="height: 200px;">
			<td style="font-weight:bold">내용</td>
			<td colspan="3" style="text-align: left;">${bdto.content}</td>
		</tr>
		<tr class="center">
			<td colspan="4">
				<a href="list?page=${page}&rec=${rec}" id="btn1">목록</a>
				<a href="javascript:viewform1()" id="btn4">댓글</a>
				<c:if test="${(uid eq wuid) || (uid eq 'alclstnp2')}">
				<a href="update?id=${bdto.id}&page=${page}&rec=${rec}" id="btn2">수정</a>
				<a href="javascript:viewform()" id="btn3">삭제</a>
				</c:if>
			</td>
		</tr>
		<tr id="delform" class="center">
			<td colspan="4">
				<form method="post" action="delete">
					<input type="hidden" name="id" value="${bdto.id}">
					<input type="hidden" name="page" value="${page}">
					<input type="hidden" name="rec" value="${rec}">
					비밀번호 <input type="password" name="pwd" class="comment-input" required>
					<input type="submit" value="삭제" id="btn3">
					<input type="button" value="취소" id="btn3" onclick="hide2()">
				</form>
			</td>
		</tr>
	</table>
	<div id="comment-f" class="popup-form">
		<form method="post" action="datOk">
			<input type="hidden" name="bid" value="${bdto.id}">
			<input type="hidden" name="page" value="${page}">
			<input type="hidden" name="rec" value="${rec}">
			<table id="comment" class="comment-table">
				<caption>댓글 작성</caption>
				<tr>
					<td><input type="text" name="nick" class="comment-input" placeholder="별명"></td>
					<td><input type="password" name="pwd" class="comment-input" placeholder="비밀번호"></td>
					<td width="140">
						<input type="submit" value="댓글" id="commentBtn">
						<input type="button" value="취소" id="btn3" onclick="hide()">
					</td>
				</tr>
				<tr>
					<td colspan="3"><textarea name="content" class="comment-input comment-textarea" placeholder="댓글을 달아주세요."></textarea></td>
				</tr>
			</table>
		</form>
	</div>
	<table class="dat-table">
		<caption>댓글 목록</caption>
		<tr>
			<th width="100">작성자</th>
			<th width="150">작성일</th>
			<th width="300">내용</th>
			<th width="120">작업</th>
		</tr>
		<c:forEach var="dat" items="${dlist}">
		<tr style="height: auto;">
			<td>${dat.nick}</td>
			<td>${dat.writeday}</td>
			<td style="text-align: left;">${dat.content}</td>
			<td>
				<input type="button" value="수정" id="btn2" onclick="viewUpform('${dat.id}', '${dat.nick}', '${dat.content}')">
				<input type="button" value="삭제" id="btn3" onclick="showForm('delete-popup-${dat.id}')">
			</td>
		</tr>
		<c:if test="${not empty param.err }">
			<div id="dperr" class="popup-form2" style="display:none;">
			<div class="errmsg" style="color:red">비번 오류</div>
			<input type="button" value="확인" onclick="this.parentElement.style.display='none';">
			</div>
		</c:if>
		<div id="update-popup-${dat.id}" class="popup-form">
			<form method="post" action="datupOk" name="uform">
				<input type="hidden" name="bid" value="${bdto.id}">
				<input type="hidden" name="page" value="${page}">
				<input type="hidden" name="rec" value="${rec}">
				<input type="hidden" name="id" value="${dat.id}">
				<input type="password" name="pwd" class="comment-input" placeholder="비밀번호">
				<input type="text" name="nick" class="comment-input" id="update-nick-${dat.id}" placeholder="별명">
				<textarea name="content" class="comment-input comment-textarea" id="update-content-${dat.id}" placeholder="내용"></textarea>
				<div class="form-buttons">
					<input type="submit" value="수정" id="btn2">
					<input type="button" value="취소" id="btn3" onclick="hideForm('update-popup-${dat.id}')">
				</div>
			</form>
		</div>
		<div id="delete-popup-${dat.id}" class="popup-form">
			<form method="post" action="datDel">
				<input type="hidden" name="bid" value="${bdto.id}">
				<input type="hidden" name="page" value="${page}">
				<input type="hidden" name="rec" value="${rec}">
				<input type="hidden" name="id" value="${dat.id}">
				<input type="password" name="pwd" class="comment-input" placeholder="비밀번호">
				<div class="form-buttons">
					<input type="submit" value="삭제" id="btn3">
					<input type="button" value="취소" id="btn3" onclick="hideForm('delete-popup-${dat.id}')">
				</div>
			</form>
		</div>
		</c:forEach>
	</table>
	<div id="popup-overlay" class="popup-overlay" onclick="hideAllForms()"></div>
</body>
</html>