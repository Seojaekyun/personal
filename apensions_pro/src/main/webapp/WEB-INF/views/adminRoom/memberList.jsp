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
	section table {
		border-spacing:0px;  
		margin-bottom:200px;
	}
	section table td {
		border-bottom:1px solid green;
		padding:5px;
		height:35px;
		font-size:12px;
	}
	section table tr:first-child td {
		border-top:2px solid green;
		border-bottom:2px solid green;
		font-size:15px;
		text-align:center;
	}
	section table tr:last-child td {
		border-bottom:2px solid green;
	}
</style>
</head>
<body>

<section>
	<table width="800" align="center">
		<caption> <h3> 회원 현황 </h3></caption>
		<tr>
			<td> 회원명 </td>
			<td> 아이디 </td>
			<td> 연락처 </td>
			<td> 이메일 </td>
			<td> 등록일 </td>
			<td> 상 태 </td>
			<td> 변 경 </td>
			<td> 처 리 </td>
		</tr>
		<c:forEach items="${mapAll}" var="map">
		<tr>
			<td> ${map.name} </td>
			<td> ${map.userid} </td>
			<td> ${map.phone} </td>
			<td> ${map.email} </td>
			<td> ${map.writeday} </td>
			<td>
				<c:if test="${map.state == 0}"> 일반회원 </c:if>
				<c:if test="${map.state == 1}"> 불량회원 </c:if>
				<c:if test="${map.state == 2}"> 탈퇴신청 </c:if>
				<c:if test="${map.state == 3}"> 탈퇴회원 </c:if>
				<c:if test="${map.state == 4}"> 복구신청 </c:if>
			</td>
			<td>
				<c:if test="${map.state == 0}">
				<a href="../adminRoom/memberUp?id=${map.id}&state=1"><input type="button" value="불량"></a>
				<a href="../adminRoom/memberUp?id=${map.id}&state=3"><input type="button" value="추방"></a>
				</c:if>
				<c:if test="${map.state == 1}">
				<a href="../adminRoom/memberUp?id=${map.id}&state=0"><input type="button" value="일반"></a>
				<a href="../adminRoom/memberUp?id=${map.id}&state=3"><input type="button" value="추방"></a>
				</c:if>
				<c:if test="${map.state == 2}">
				<a href="../adminRoom/memberUp?id=${map.id}&state=1"><input type="button" value="불량"></a>
				<a href="../adminRoom/memberUp?id=${map.id}&state=3"><input type="button" value="추방"></a>
				</c:if>
				<c:if test="${map.state == 3}">
				<a href="../adminRoom/memberUp?id=${map.id}&state=0"><input type="button" value="복구"></a>
				</c:if>
				<c:if test="${map.state == 4}">
				<a href="../adminRoom/memberUp?id=${map.id}&state=1"><input type="button" value="불량"></a>
				<a href="../adminRoom/memberUp?id=${map.id}&state=3"><input type="button" value="추방"></a>
				</c:if>
			</td>
			<td>
				<c:if test="${map.state == 2}">
				<a href="../adminRoom/memberUp?id=${map.id}&state=3"><input type="button" value="탈퇴승인"></a>
				</c:if>
				<c:if test="${map.state == 4}">
					<a href="../adminRoom/memberUp?id=${map.id}&state=0"><input type="button" value="탈퇴취소"></a>
				</c:if>
				<c:if test="${map.state == 5}">
					<a href="../adminRoom/memberUp?id=${map.id}&state=0"><input type="button" value="복구승인"></a>
				</c:if>
			</td>
		</tr>
		</c:forEach>
	</table>
</section>

</body>
</html>





