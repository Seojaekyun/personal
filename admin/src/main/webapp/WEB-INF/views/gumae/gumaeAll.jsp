<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body> <!-- gumae/gumaeAll.jsp -->

<main>
	<table width="1100" align="center">
		<caption> <h3> 주문 내역 </h3></caption>
		<tr>
			<td> 주문자 </td>
			<td colspan="2"> 주문상품 </td>
			<td> 배송지 </td>
			<td> 상 태 </td>
			<td> 처 리 </td>
		</tr>
		<c:forEach items="${mapAll}" var="map">
		<tr>
			<td> ${map.userid } </td>
			<td><img src="../static/product/${map.pimg }" width="60" height="60"></td>
			<td width="400"> ${map.title } </td>
			<td> ${map.zip } </td>
			<td> ${map.stateMsg } </td>
			<td>
				<c:if test="${map.state==0}">
				<input type="button" value="상품준비중" onclick="location='chgState?state=1&id=${map.id}'">
				</c:if>
				<c:if test="${map.state==1}">
				<input type="button" value="배송중" onclick="location='chgState?state=2&id=${map.id}'">
				</c:if>
				<c:if test="${map.state==2}">
				<input type="button" value="배송완료" onclick="location='chgState?state=3&id=${map.id}'">
				</c:if>
				<c:if test="${map.state==5}">
				<input type="button" value="반품완료" onclick="location='chgState?state=6&id=${map.id}'">
				</c:if>
				<c:if test="${map.state==7}">
				<input type="button" value="교환완료" onclick="location='chgState?state=8&id=${map.id}'">
				</c:if>
			</td>
		</tr>
		</c:forEach>
	</table>
</main>

</body>
</html>