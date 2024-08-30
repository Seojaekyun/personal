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
		height:600px;
		margin:auto;
	}
</style>
</head>
<body>  <!-- reserve/reserveView.jsp -->
	<section>
		<table width="800" align="center">
			<caption><h3> ${name}님의 예약 내용 </h3></caption>
			<tr>
				<td> 예약객실 </td>
				<td> ${rdto.rid} </td>
				<td> 예약일 </td>
				<td> ${rdto.writeday} </td>
			</tr>
			<tr>
				<td> 입실일 </td>
				<td> ${rdto.inday} </td>
				<td> 퇴실일 </td>
				<td> ${rdto.outday} </td>
			</tr>
			<tr>
				<td> 입실인원 </td>
				<td> ${rdto.inwon}명 </td>
				<td> 총결제금액 </td>
				<td> ${price2} </td>
			</tr>
			<tr>
				<td> bbq세트 </td>
				<td> ${rdto.bbq}세트 </td>
				<td> 숯불패키지 </td>
				<td> ${rdto.chacol}회분 </td>
			</tr>
		</table>
		
	</section>
</body>
</html>