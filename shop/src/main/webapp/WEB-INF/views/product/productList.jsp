<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>白원 Mall - </title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@100..900&display=swap');
	main {
		width: 1100px;
		margin: auto;
		margin-top: 20px;
		font-family: 'Hahmlet';
		font-weight: 600;
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
		border-spacing: 8px;
	}
	main table td {
		cursor: pointer;
		width: 270px;
		height: 360px;
		border: 1px solid #eeeeee;
		padding: 4px;
		outline: 2px solid white;
	}
	main table td:hover {
     outline: 3px solid #F1FFDB;
     border-radius: 15px;
   }
   main table tr:last-child td:hover {
     outline: none;
   }
	main table td:last-child {
		border: none;
		outline: none;
		height: 60px;
	}
	main table td > div {
		width: 270px;
		margin-top: 5px;
	}
	main table td > div:first-child {
		text-align: center;
	}
	main table td > #ptitle {
	
	}
	main table td > #phalin {
		font-size: 12px;
	}
	main table td > #phalinPrice {
		font-size: 18px;
		color: #CB1400;
		font-family: 'Hahmlet';
	}
	main table td > #pbaeEx {
		color: green;
	}
	#ptit {
		text-align: center;
	}
	#ppri {
		display: inline-block;
		font-size: 10px;
	}
	#phal {
		display: inline-block;
		font-size: 15px;
	}
</style>
<script>
	/* window.onload=function() {
		document.getElementsByClassName("order")[${order-1}].style.color="#FF007F";
	} */
</script>

</head>
<body> <!-- product/productList.jsp -->

<main>
	<table width="1100" align="center">
		<caption>
			<h4 align="left" style="letter-spacing:2px;font-size:13px;float:left;"> ${pos} </h4>
			<h4 style="float:right; font-size:13px;">
				<a href="productList?pcode=${pcode}&order=1" class="order"> 인기순 </a> | 
				<a href="productList?pcode=${pcode}&order=2" class="order"> 가격(높은순) </a> | 
				<a href="productList?pcode=${pcode}&order=3" class="order"> 가격(낮은순) </a> | 
				<a href="productList?pcode=${pcode}&order=4" class="order"> 평점순 </a> | 
				<a href="productList?pcode=${pcode}&order=5" class="order"> 최신상품순 </a> 
		</caption>
		<tr>
			<c:forEach items="${plist}" var="pdto" varStatus="sts">
			<td onclick="location='productContent?pcode=${pdto.pcode}'">
				<div><img src="../static/product/${pdto.pimg}" width="200" height="150"></div>
				<div id="ptit"> ${pdto.title} </div>
				<c:if test="${pdto.halin!=0}"> <!-- 할인율이 0이면 의미없다 -->
					<div id="ppri"> ${pdto.halin}%  <s>￦</s><s><fmt:formatNumber value="${pdto.price}" type="number"/></s></div> 
				</c:if> 
				<div id="phal"> ￦<fmt:formatNumber value="${pdto.halinPrice}" type="number"/></div>
				<div> ${pdto.baeEx} </div>     
				<div style="letter-spacing:-4px;font-size:12px">
					<%-- ${pdto.ystar} : ${pdto.hstar} : ${pdto.gstar} --%>
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
					<span id="juk"><img src="../static/pro/juk.png">최대 ￦<fmt:formatNumber value="${pdto.jukPrice}" type="number"/> 적립!</span>
				</div>
				</c:if>
			</td>
			<c:if test="${sts.count%4 == 0}">
			</tr><tr>
         </c:if>
			</c:forEach>
		</tr>
		<tr>
			<td colspan="4" align="center">
			<c:if test="${psta!=1 }">
				<a href="productList?page=${psta-1 }&pcode=${pcode}">◀◀</a>
			</c:if>
			<c:if test="${psta==1 }">
				◁◁
			</c:if>
			<c:if test="${page!=1 }">
				<a href="productList?page=${page-1 }&pcode=${pcode}">◀</a>
			</c:if>
			<c:if test="${page==1 }"> 
				◁
			</c:if>
			|
			<c:forEach var="i" begin="${psta }" end="${pend }">
			<c:if test="${page==i}">
				<a href="productList?page=${i }&pcode=${pcode}" style="color:red; font-size:20px; font-weight:1000; display: inline-block; width: 40px; text-align: center;"> ${i } </a>
			</c:if>
			<c:if test="${page!=i }">
				<a href="productList?page=${i }&pcode=${pcode}" style="display: inline-block; width: 40px; text-align: center;"> ${i } </a>
			</c:if>
			</c:forEach>
			|
			<c:if test="${page!=ptot }">
				<a href="productList?page=${page+1 }&pcode=${pcode}"> ▶ </a>
			</c:if>
			<c:if test="${page==ptot }"> 
				▷
			</c:if>
			<c:if test="${pend!=ptot }"> 
				<a href="productList?page=${pend+1 }&pcode=${pcode}"> ▶▶</a>
			</c:if>
			<c:if test="${pend==ptot }">
				▷▷
			</c:if>
			</td>
		</tr>
	</table>
</main>

</body>
</html>