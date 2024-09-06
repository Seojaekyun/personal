<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	main {
		width:1100px;
		<c:if test="${mapAll.size()<6}">
		height:600px;
		</c:if>
		<c:if test="${mapAll.size()>=6}">
		margin-top:100px;
		</c:if>
		margin:auto;
		font-family: 'GmarketSansMedium';
	}
	main table {
		border-spacing:0px;
		margin-top:30px;
	}
	main table tr:first-child td {
		border-top:2px solid purple;
	}
	main table tr:last-child td {
		border-bottom:1px solid purple;
	}
	main table td {
		font-size:14px;
		height:40px;
		padding-left:10px;
		border-bottom:1px solid purple;
	}
	main #btn {
		font-size:11px;
		background:purple;
		color:white;
		border:1px solid purple;
	}
</style>

</head>
<body> <!-- member/jumunList.jsp -->

<main>
	<table width="1100" align="center">
		<tr>
			<td> 주문날짜 </td>
			<td> 상 태</td>
			<td colspan="2"> 주문상품 </td>
			<td> 결제금액 </td>
			<td> 수 량 </td>
			<td> 비 고 </td>
		</tr>
		<c:set var="jcode" value=""/>
		<c:forEach items="${mapAll}" var="map">
		<tr>
			<c:if test="${jcode!=map.jumuncode}">
			<td> ${map.writeday} </td>
			</c:if>
			<c:if test="${jcode==map.jumuncode}">
			<td> &nbsp; </td>
			</c:if>
			<c:if test="${jcode!=map.jumuncode}">
			<td> ${map.stateMsg} </td>
			</c:if>
			<c:if test="${jcode==map.jumuncode}">
			<td> &nbsp; </td>
			</c:if>
			<td> 
				<img src="../static/product/${map.pimg}" width="80" height="80">
			</td>
			<td width="380">
				${map.title}
			</td>
			<c:if test="${jcode!=map.jumuncode}">
			<td>  
				<fmt:formatNumber value="${map.chongPrice}" type="number"/>원 
				<span style="font-size:12px;"><br>
					(사용적립금:<fmt:formatNumber value="${map.useJuk}" type="number"/>원)
				</span> 
			</td>
			</c:if>
			<c:if test="${jcode==map.jumuncode}">
			<td> &nbsp; </td>
			</c:if>
			<td align="center"> ${map.su}개 </td>
			<c:if test="${jcode!=map.jumuncode}">
			<td align="center">
				<c:if test="${map.state==0}">
				<input type="button" value="취소신청" id="btn" onclick="location='chgState?state=4&id=${map.id}'">
				</c:if>
				<c:if test="${map.state==3}">
				<input type="button" value="반품신청" id="btn" onclick="location='chgState?state=5&id=${map.id}'">
				</c:if>
				<c:if test="${map.state==3}">
				<input type="button" value="교환신청" id="btn" onclick="location='chgState?state=7&id=${map.id}'">
				</c:if>
				<c:if test="${map.state==3}">
				<input type="button" value="리뷰쓰기" id="btn">
				</c:if>
				<c:if test="${map.state==5}">
				<input type="button" value="반품취소" id="btn" onclick="location='chgState?state=3&id=${map.id}'">
				</c:if>
				<c:if test="${map.state==7}">
				<input type="button" value="교환취소" id="btn" onclick="location='chgState?state=3&id=${map.id}'">
				</c:if>
			</td>
			</c:if>
			<c:if test="${jcode==map.jumuncode}">
			<td> &nbsp; </td>
			</c:if>
		</tr> 
		<c:set var="jcode" value="${map.jumuncode}"/>
		</c:forEach>
	</table>
</main>

</body>
</html>