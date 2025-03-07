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
		margin:auto;
		font-family:Arial, sans-serif;;
		margin-bottom:100px;
	}
	main h2 {
		border-bottom:2px solid purple;
	}
	main table {
		margin-bottom:50px;
		border-spacing:0px;
		width: 1100px;
	}
	caption {
		text-align: left;
	}
	#h3 {
		font-size: 20px;
		align: left;
	}
	main table td {
		border-bottom:1px solid purple;
		padding-top:5px;
		padding-bottom:5px;
		height:45px;
	}
	main table tr:first-child td {
		border-top:2px solid purple;
	}
	main table tr:last-child td {
		border-bottom:2px solid purple;
	}
	main table #baeChuga {
		font-size:12px;
		cursor:pointer;
		color:purple;
	}
	main #dbtn {
		padding:2px 4px;
		border:1px solid purple;
		background:purple;
		color:white;
	}
	main #ubtn {
		padding:2px 4px;
		border:1px solid purple;
		background:white;
		color:purple;
	}
</style>
</head>
<body> <!-- product/gumaeView.jsp -->
<main>
	<h2> 구매 정보 </h2>
	<div id="product">
		<table>
			<caption> <span id="h3"> 상품정보 </span> </caption>
			<c:forEach items="${mapAll}" var="map"> 
			<tr>
				<td> <img src="../static/product/${map.pimg}" width="90" height="90"> </td>
				<td> ${map.title} </td>
				<td> <fmt:formatNumber value="${map.price}" type="number"/> </td>
				<td> ${map.baeEx} </td>
				<td> 수량 : ${map.su}개 </td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<div id="baesong">
		<table>
			<caption> <span id="h3"> 배송지정보 </span> </caption>
			<tr>
				<td> 받는 사람 </td>
				<td> ${mapAll.get(0).name} </td>
			</tr>
			<tr>
				<td> 배송 주소 </td>
				<td> ${mapAll.get(0).juso} </td>
			</tr>
			<tr>
				<td> 요청 사항 </td>
				<td> ${breq} </td>
			</tr>
		</table>
	</div>
	<div id="pay">
		<table>
			<caption> <span id="h3"> 결제정보 </span> </caption>
			<tr>
				<td> 주문금액 </td>
				<td> <fmt:formatNumber value="${halinPrice}" type="number"/>원 </td>
			</tr>
			<tr>
				<td> 배송비 </td>
				<td> <fmt:formatNumber value="${cBaeprice}" type="number"/>원 </td>
			</tr>
			<tr>
				<td> 사용적립금 </td>
				<td> <fmt:formatNumber value="${mapAll.get(0).useJuk}" type="number"/>원</td>
			</tr>
			<tr>
				<td> 총결제금액 </td>
				<td> <fmt:formatNumber value="${halinPrice+cBaeprice}" type="number"/>원 </td>
			</tr>
		</table>
	</div>
</main>
</body>
</html>