<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table {
		border-spacing:0px;
	}
	table tr td {
		border-bottom:1px solid purple;
		height:100px;
	}
	table tr:first-child td {
		border-top:2px solid purple;
	}
	table tr:last-child td {
		border-bottom:2px solid purple;
	}
	table .answer {
		position:relative;
	}
	table .aform {
		position:absolute;
		left:100px;
		width:300px;
		height:150px;
		border:1px solid purple;
		visibility:hidden;
		background:white;
	}
	table textarea {
		width:298px;
		height:100px;
		outline: none;
	}
	table input[type=submit] {
		width:300px;
		height:30px;
	}
</style>
<script>
	function writeAnswer(n) {
		var aform=document.getElementsByClassName("aform");
		
		// 모든 aform을 숨기기
		for(i=0;i<aform.length;i++) {
			aform[i].style.visibility="hidden";
		}
		
		aform[n].style.visibility="visible";
	}
</script>
</head>
<body> <!-- qna/qnaList.jsp -->
	<table width="1100" align="center">
		<caption> <h3> 상품문의 </h3> </caption>
			<tr align="center">
				<td width="200"> 상품명 </td>
				<td width="100"> 질문/답변 </td>
				<td> 내 용 </td>
				<td width="100"> 작성자 </td>
				<td width="100"> 등록일 </td>
			</tr>
			<c:set var="ck" value="0"/>
			<c:forEach items="${plist}" var="pdto">
			<tr>
				<td> ${pdto.title} </td>
				<td align="center" class="answer">
					<c:if test="${pdto.qna==0}">
					<a href="javascript:writeAnswer(${ck})">질문</a>
					<form name="aform" method="post" action="writeAnswerOk" class="aform">
					<input type="hidden" name="ref" value="${pdto.ref}">
					<input type="hidden" name="pcode" value="${pdto.pcode}">
						<textarea name="content"></textarea> <br>
						<input type="submit" value="답변 달기">
					</form>
					</c:if>
					<c:if test="${pdto.qna==1}">
					답변
					</c:if>
				</td>
				<td> ${pdto.content} </td>
				<td align="center"> ${pdto.userid} </td>
				<td align="center"> ${pdto.writeday} </td>
			</tr>
			<c:if test="${pdto.qna==0}">
				<c:set var="ck" value="${ck+1}"/>
			</c:if>
			</c:forEach>
		</table>
	
</body>
</html>