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
		width: 1100px;
		margin: auto;
		margin-top: 20px;
		font-family: Arial, sans-serif;
		font-weight: 900;
	}
	main #juk {
		border: 1px solid #cccccc;
		padding: 2px;
		padding-left: 8px;
		padding-right: 8px;
		border-radius: 15px;
		font-size: 12px;
	}
	main a {
		text-decoration: none;
		color: black;
	}
	main table {
		border-spacing: 12px;
	}
	main table td {
		cursor: pointer;
		width: 270px;
		height: 360px;
		padding: 4px;
	}
	main table td img {
		transition: transform 0.4s, outline 0.4s;
	}
	main table td img:hover {
		transform: scale(1.1);
	}
	main table tr:last-child td:hover {
		outline: 2px solid white;
	}
	main table td:last-child { /* 페이지 출력되는 행 */
		height: 60px;
	}
	main table td > div {
		width: 270px;
		margin-top: 5px;
	}
	main table td > div:first-child { /* 상품이미지 */
		text-align: center;
	}
	main table td > #ptitle {
		
	}
	main table td > #phalin {
		font-size: 12px;
	}
	#op {
		text-decoration: line-through;
	}
	main table td > #phalinPrice {
		font-size: 18px;
		color: #CB1400;
		font-family: Arial, sans-serif;
	}
	main table td > #pbaeEx {
		color: green;
	}
</style>
<script>
	/*
	window.onload=function() { // 카트갯수랑 충돌
		document.getElementsByClassName("order")[${order-1}].style.color="#FF007F";
	}
	function over(my) {
		my.style.outline="2px solid #cccccc";
	}
	function out(my) {
		my.style.outline="2px solid white";
	}
	*/
</script>
</head>
<body> <!-- product/productList.jsp -->
	<main>
		<h4 align="left" style="letter-spacing:2px;font-size:13px;float:left;"> ${pos} </h4>
		<h4 style="float:right;font-size:13px;">
			<a href="productList?pcode=${pcode}&order=1" class="order"> 판매량순 </a> |
			<a href="productList?pcode=${pcode}&order=2" class="order"> 가격높은순 </a> |
			<a href="productList?pcode=${pcode}&order=3" class="order"> 가격낮은순 </a> |
			<a href="productList?pcode=${pcode}&order=4" class="order"> 별점순 </a> |
			<a href="productList?pcode=${pcode}&order=5" class="order"> 최신상품순 </a>
		</h4>
		<table style="width: 1100px; align: center;">
			<tr>
			<c:forEach items="${plist}" var="pdto" varStatus="sts">
				<!-- onmouseover="over(this)" onmouseout="out(this)" -->
				<td  onclick="location='productContent?pcode=${pdto.pcode}'" valign="top">
					<div> <img src="../static/product/${pdto.pimg}" width="200" height="200"> </div>
					<div id="ptitle"> ${pdto.title} </div>
					<c:if test="${pdto.halin!=0}"> <!-- 할인율이 0이면 의미없다 -->
						<div id="phalin"> ${pdto.halin}% <span id="op"><fmt:formatNumber value="${pdto.price}" type="number"/>원 </span></div>
					</c:if>
					<div id="phalinPrice"> <fmt:formatNumber value="${pdto.halinPrice}" type="number"/>원 </div>
					<div id="pbaeEx"> ${pdto.baeEx} </div>
					<div style="letter-spacing:-4px;font-size:12px">
						<c:forEach begin="1" end="${pdto.ystar}">
						<img src="../static/pro/star1.png" width="10">
						</c:forEach>
						<c:if test="${pdto.hstar==1}">
						<img src="../static/pro/star3.png" width="10">
						</c:if>
						<c:forEach begin="1" end="${pdto.gstar}">
						<img src="../static/pro/star2.png" width="10">
						</c:forEach>
						&nbsp;<span style="letter-spacing:0px;font-size:12px"> (${pdto.review}) </span>
					</div>   
					<c:if test="${pdto.juk!=0}"> <!-- 적립금이 있다면 -->
					<div>
						<span id="juk">
							<img src="../static/pro/juk.png" width="10">
							최대 <fmt:formatNumber value="${pdto.jukPrice}" type="number"/>원 적립
						</span>
					</div>
					</c:if>
				</td>
			<c:if test="${sts.count%4 == 0}">
			</tr>
			<tr>
			</c:if>
			</c:forEach>
			</tr>
			<!-- 페이지 출력 tr -->
			<tr height="60">
				<td colspan="4" align="center">
					<!-- 이전 그룹 -->
					<c:if test="${pstart!=1}">
					<a href="productList?page=${pstart-1}&pcode=${pcode}&order=${order}"> ◁◁ </a>
					</c:if>
					<c:if test="${pstart==1}">
					◁◁
					</c:if>
					<!-- 이전 페이지 -->
					<c:if test="${page != 1}">
					<a href="productList?page=${page-1}&pcode=${pcode}&order=${order}"> ◁ </a>
					</c:if>
					<c:if test="${page == 1}">
					◁
					</c:if>
					<c:forEach var="i" begin="${pstart}" end="${pend}">
						<c:if test="${page == i}"> <!-- 현재페이지랑 출력된 i의 값이 같을때 -->
						<a href="productList?page=${i}&pcode=${pcode}&order=${order}" style="color:red;"> ${i} </a>
						</c:if>
						<c:if test="${page != i}">
						<a href="productList?page=${i}&pcode=${pcode}&order=${order}"> ${i} </a>
						</c:if>
					</c:forEach>
					<!-- 다음페이지 -->
					<c:if test="${page != chong}">
					<a href="productList?page=${page+1}&pcode=${pcode}&order=${order}"> ▷ </a>
					</c:if>
					<c:if test="${page == chong}">
					▷
					</c:if>
					<!-- 다음 그룹 -->
					<c:if test="${pend!=chong}">
					<a href="productList?page=${pend+1}&pcode=${pcode}&order=${order}"> ▷▷ </a>
					</c:if>
					<c:if test="${pend==chong}">
					▷▷
					</c:if>
				</td>
			</tr>
		</table>
	</main>
</body>
</html>
