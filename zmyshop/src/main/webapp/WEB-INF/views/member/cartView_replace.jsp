<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style>
	main {
		width:1100px;
		margin:auto;
		font-family:'GmarketSansMedium';
	}
	main table {
		margin-top:50px;     
		margin-bottom:50px;
		border-spacing:0px;
		width: 1100px;
		align: center;
	}
	#h2 {
		font-size: 18px;
		font-weight: bold;
	}
	main table td {
		border-bottom:1px solid purple;
		padding-top:5px;
		padding-bottom:5px;
	}
	main table tr:first-child td {
		border-top:2px solid purple;
	}
	main #mainChk {
		width:18px;
		height:18px;
	}
	main .subChk {
	
	}
	main .su {
		width:20px;
		outline:none;
		text-align:center;
	}
</style>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script>
	function mainClick(my) {
		var subChk=document.getElementsByClassName("subChk");
		
		if(my.checked) {
			for(i=0;i<subChk.length;i++) {
				subChk[i].checked=true;
			}
		}
		else {
			for(i=0;i<subChk.length;i++) {
				subChk[i].checked=false;
			}
		}
	}
	
	function subClick() {
		// 모든 class="subChk"인 요소가 체크가 된다면 => 전체선택 체크박스를 체크하면 된다.
		// class="subChk"중에서 하나라도 체크가 안된다면 => 전체선택 체크박스는 해제
		var subChk=document.getElementsByClassName("subChk");
		
		// subChk에서 몇개가 체크되었는지 카운드
		var cnt=0;
		for(i=0;i<subChk.length;i++) {
			if(subChk[i].checked) {
				cnt++;
			}
		}
		
		if(cnt == subChk.length) {
			document.getElementById("mainChk").checked=true;
		}
		else {
			document.getElementById("mainChk").checked=false;
		}
	}
	
	$(function() { // 숫자입력칸을 jquery에서 지원하는 spinner를 사용
		$(".su").spinner({
			min:1,
			max:10,
			spin:function(e,ui) {
				
			}
		});
	});

	function selDel() {
		// class="subChk"의 요소를 검사 => 체크가 되었다면 삭제할 상품 => 누적
		var subChk=document.getElementsByClassName("subChk");
		var su=document.getElementsByClassName("su");
		// 모든 subChk를 다 검사해야 된다.
		var pcode="";
		for(i=0;i<subChk.length;i++) {
			if(subChk[i].checked) {
				<c:if test="${userid!=null}">
				pcode=pcode+subChk[i].value+"/";  // 상품코드1/상품코드2/
				</c:if>
				<c:if test="${userid==null}">
				pcode=pcode+subChk[i].value+"-"+su[i].value+"/"; // 상품코드1-2/상품코드2-1/
				</c:if>
			}
		}
		
		if(pcode!="") {
			location="cartDel?pcode="+pcode;
		}
	}
	
</script>    
</head>
<body>
<main>
	<table>
		<caption id="h2"> 장바구니 현황 </caption>
		<c:set var="cnum" value="0"/>
		<c:forEach items="${pMapAll}" var="map">
		<c:set var="str" value=""/>
		<c:if test="${map.days<=1}">
		<c:set var="str" value="checked"/>
		<c:set var="cnum" value="${cnum+1}"/>
		</c:if>
		<tr height="80">
			<td width="30"> <input type="checkbox" value="${map.pcode}" ${str} class="subChk" onclick="subClick()"> </td>
			<td width="100" align="center"> <img src="../static/product/${map.pimg}" height="80" width="80"> </td>
			<td align="left"> ${map.title} </td>
			<td width="140"> ${map.baeEx} </td>
			<td width="110" align="right"> <fmt:formatNumber value="${map.halinprice}" type="number"/>원 </td>
			<td width="110" align="right"> <fmt:formatNumber value="${map.jukprice}" type="number"/>원 </td>
			<td width="80" align="right"> 
				<input type="text" name="su" value="${map.csu}" class="su" > 
			</td>
			<td width="110" align="right"> 
				<c:if test="${map.baeprice==0}">
				무료배송
				</c:if>
				<c:if test="${map.baeprice!=0}">
				<fmt:formatNumber value="${map.baeprice}" type="number"/>원
				</c:if>
				<!-- 쿠키변수에서 replace로 상품을 지우려고 하면  상품코드-수량/ 이 형태로 보내줘야된다. -->
				<c:if test="${userid==null}">
				<br> <input type="button" value="삭제" onclick="location='cartDel?pcode=${map.pcode}-${map.csu}'">
				</c:if>
				<c:if test="${userid!=null}">
				<br> <input type="button" value="삭제" onclick="location='cartDel?pcode=${map.pcode}'">
				</c:if>
			</td>
		</tr>
		</c:forEach>
		<tr>
			<td height="40"> 
				<c:if test="${pMapAll.size()==cnum}">
				<c:set var="mchk" value="checked"/>
				</c:if>
				<input type="checkbox" ${mchk} id="mainChk" onclick="mainClick(this)">  
			</td>
			<td height="40" colspan="7"> 
			전체선택  <input type="button" value="선택상품 삭제" onclick="selDel()">
			</td>
		</tr>
		<tr>
			<td colspan="8" align="center">
			총상품금액 
			<fmt:formatNumber value="${halinpriceTot}" type="number"/>원 
			+ 배송비 
			<fmt:formatNumber value="${baepriceTot}" type="number"/>원 = 총결제금액 
			<fmt:formatNumber value="${halinpriceTot+baepriceTot}" type="number"/>원  
			(적립예정 : <fmt:formatNumber value="${jukpriceTot}" type="number"/>원)
			</td>
		</tr>
	</table>
</main>
</body>
</html>