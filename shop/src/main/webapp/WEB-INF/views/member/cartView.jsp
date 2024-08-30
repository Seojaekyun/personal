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
		margin-top: 50px;
		margin: auto;
		
	}
	#outbox {
		margin: auto;
		width: 1090px;
		border: solid 1px skyblue;
		border-radius: 10px;
	}
	main table {
		margin-top: 50px;     
		margin-bottom: 50px;
		border-spacing: 0px;
	}
	main table tr td{
		
		border-bottom: 1px solid purple;
		padding-top: 5px;
		padding-bottom: 5px;
	}
	main table tr:first-child td {
		border-top: 2px solid purple;
		text-align: center;
	}
	main #mainChk {
		
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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script>
	function allChk() {
		var checkAll=document.getElementById('mainChk');
		var subChks=document.getElementsByClassName('subChk');
		
		for (var i = 0; i < subChks.length; i++) {
			subChks[i].checked=checkAll.checked;
		}
	}
	
	function subChk() {
		var chkouts=document.getElementsByClassName('subChk');
		var mainChk=document.getElementById('mainChk');
		var allChecked=true;
		for(var i=0;i<chkouts.length;i++) {
			if (!chkouts[i].checked) {
				allChecked=false;
				break;
			}
		}
		
		mainChk.checked=allChecked;
	}
	
	$(function() {
		// 숫자입력칸을 jquery에서 지원하는 spinner를 사용
		$(".su").spinner( {
			min:1,
			max:10,
			spin:function(e,ui) {
				
			}
		});
	});

</script>
</head>
<body>

<main>
	<div id="outbox">
	<table width="1000" align="center">
		<caption><h2> 장바구니 </h2></caption>
		<tr>
			<td colspan="3"> 상품명 </td>
			<td> 구매수량 </td>
			<td> 배송예정일 </td>
			<td> 가격 </td>
			<td> 적립급 </td>
			<td> 배송비 </td>
		</tr>
			<c:forEach items="${pMapAll}" var="map">
		<tr height="80">
			<td width="30"><input type="checkbox" class="subChk" onchange="subChk()"></td>
			<td width="100" align="center"><img src="../static/product/${map.pimg}" width="80"> </td>
			<td align="left"> ${map.title} </td>
			<td align="center"><input type="text" name="su" value="${map.csu}" class="su"></td>
			<td width="140" align="right"> ${map.baeEx} </td>
			<td width="110" align="right">￦<fmt:formatNumber value="${map.halinprice}" type="number"/></td>
			<td width="110" align="right">￦<fmt:formatNumber value="${map.jukprice}" type="number"/></td>
				<c:if test="${map.baeprice==0}">
			<td width="110" align="center"> 무료배송 </td>
				</c:if>
				<c:if test="${map.baeprice!=0}">
			<td width="110" align="right">￦<fmt:formatNumber value="${map.baeprice}" type="number"/></td>
				</c:if>
		</tr>
			</c:forEach>
		<tr>
			<td height="40"><input type="checkbox" id="mainChk" onchange="allChk()"></td>
			<td colspan="7"> 전체선택 </td>
		</tr>
	</table>
	</div>
</main>

</body>
</html>