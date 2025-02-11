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
		font-size: 24px;
		font-weight: 600;
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
</style>
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
		var subChk=document.getElementsByClassName("subChk");
		var cnt=0;
		
		for(i=0;i<subChk.length;i++) {
			if(subChk[i].checked) {
				cnt++;
			}
		}
		if(cnt==subChk.length) {
			document.getElementById("mainChk").checked=true;
		}
		else {
			document.getElementById("mainChk").checked=false;
		}	
	}
	
	function addCart(pcode) {
		var chk=new XMLHttpRequest();
    	chk.onload=function() {
    		if(chk.responseText=="-1") {
    			location="../login/login";
    		}	
    		else {
    			document.getElementById("cartNum").innerText=chk.responseText;
    		}
    	}
    	chk.open("get","addCart?pcode="+pcode);
    	chk.send();
	}
	
	function selDel() {
		var subChk=document.getElementsByClassName("subChk");
		
		var pcode="";
		for(i=0;i<subChk.length;i++) {
			if(subChk[i].checked) {
				pcode=pcode+subChk[i].value+"/";
			}
		}
		
		location="jjimDel?pcode="+pcode;
	}
</script>
</head>
<body> <!-- member/jjimList -->
	<main>
		<table>
			<caption id="h2"> 찜 리스트 현황 </caption>
			<c:forEach items="${plist}" var="pdto">
			<tr>
				<td width="30" align="center"> 
					<input type="checkbox" class="subChk" value="${pdto.pcode}" onclick="subClick()"> 
				</td>
				<td width="100"> <img src="../static/product/${pdto.pimg}" width="80" height="80"> </td>
				<td> ${pdto.title} </td>
				<td width="140" align="center"> 
					<c:if test="${pdto.baeprice==0}">
					무료배송
					</c:if>
					<c:if test="${pdto.baeprice!=0}">
					<fmt:formatNumber value="${pdto.baeprice}" type="number"/>원
					</c:if>
				</td>
				<td width="120" align="right"> <fmt:formatNumber value="${pdto.halinPrice}" type="number"/>원  </td>
				<td width="100" align="center" style="line-height:24px"> 
					<input type="button" value="장바구니" onclick="addCart('${pdto.pcode}')"> <br>
					<input type="button" value="삭제" onclick="location='jjimDel?pcode=${pdto.pcode}'">
				</td>
			</tr>
			</c:forEach>
			<tr>
				<td colspan="6">
					전체 선택 <input type="checkbox" id="mainChk" onclick="mainClick(this)"> 
					<input type="button" value="선택상품 삭제" onclick="selDel()">
				</td>
			</tr>     
		</table>
	</main>
</body>
</html>