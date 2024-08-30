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
		margin:auto;
	}
</style>
</head>
<body>  <!-- adminRoom/list.jsp -->
<section>
    <table width="700" align="center">
	<caption><h3> 객실 현황 </h3></caption>
		<tr>
			<td> 객실명 </td>
			<td> 최소인원 </td>
			<td> 최대인원 </td>
			<td> 가 격 </td>
			<td> 등록일 </td>
		</tr>
		<c:forEach items="${rlist}" var="rdto">
		<tr>
			<td> <a href="content?id=${rdto.id}"> ${rdto.title} </a> </td>
			<td> ${rdto.min}명 </td>
			<td> ${rdto.max}명 </td>
			<td> ${rdto.price2}원 </td>
			<td> ${rdto.writeday} </td>
		</tr>
		</c:forEach>
		<tr>
			<td colspan="5" align="center">
				<a href="write"> 객실 추가 </a> | <a href="../main/index">돌아가기</a>
			</td>
		</tr>
	</table>
</section>
</body>
</html>