<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	#bgd {
		background: #F5FFFA;
		border-radius: 10px;
		width: 1000px;
		padding: 20px;
	}
	section table {
		border-spacing:0px;
	}
	section table tr td {
		height:120px;
		border:1px dashed black;
		text-align: center;
	}
	section table tr:first-child td {
		width:120px;
		height:30px;
		background:skyblue;
	}
	#calti {
		height:50px;
		font-size:25px;
	}
</style>
</head>
<body>
<section>
	<div id="bgd">
	<table width="900" align="center">
		<caption>
			<div id="calti">
				<a href="reserve?year=${year}&month=${month-1}"><input type="button" value="이전"></a>&nbsp;&nbsp;
				${year }년 ${month }월&nbsp;&nbsp;
				<a href="reserve?year=${year}&month=${month+1}"><input type="button" value="다음"></a>
			</div>
		</caption>
		<tr>
			<td> 일 </td>
			<td> 월 </td>
			<td> 화 </td>
			<td> 수 </td>
			<td> 목 </td>
			<td> 금 </td>
			<td> 토 </td>
		</tr>
		<c:set var="day" value="1"/> <!-- pageContext -->
		<c:forEach begin="1" end="${ju}" var="i">
		<tr> <!-- ${i} -->
			<c:forEach begin="0" end="6" var="j">
			<c:if test="${ (i==1 && j<yoil) || day>chong }">
			<td> </td>
			</c:if>
			<c:if test="${ !((i==1 && j<yoil) || day>chong) }">
			<td valign="top"> ${day} <p>
			<c:set var="xday" value="${year }-${month }-${day }"/>
			<fmt:parseDate value="${xday}" var="day1" pattern="yyyy-MM-dd"/>
			<fmt:formatDate value="<%=new java.util.Date() %>" pattern="yyyy-MM-dd" var="today"/>
			<fmt:parseDate value="${today }" pattern="yyyy-MM-dd" var="day2"/>
			<c:if test="${day1 >= day2}">
			<c:forEach items="${rlist}" var="rdto"> <!-- 객실명 출력 시작 -->
			<c:set var="key" value="${day}-${rdto.id}"/> <!-- 키를 생성 -->
				<c:if test="${map.get(key)==0}"> <!-- 예약이 되지 않은 객실 -->
				<div align="right"><a href="reserveNext?year=${year}&month=${month}&day=${day}&id=${rdto.id}"> ${rdto.title} </a></div>  
				</c:if>
				<c:if test="${map.get(key)==1}"> <!-- 예약이 된 객실 -->
				<div align="right" style="color:red;"> ${rdto.title} </div>
				</c:if>
			</c:forEach>  <!-- 객실명 출력 끝 -->
			</c:if>
			</td>
			<c:set var="day" value="${day+1}"/> 
			</c:if> 
			</c:forEach>
		</tr> 
		</c:forEach>
	</table>
    </div>
</section>
</body>
</html>