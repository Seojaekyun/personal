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
		font-family:'hahmlet';
	}
	main table {
		margin-top:50px;     
		margin-bottom:50px;
		border-spacing:0px;
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
	
	}
	main .subChk {
	
	}
	main .su {
		width:20px;
		outline:none;
		text-align:center;
	}
	#delone {
		display: table-cell;
		cursor: pointer;
		vertical-align: top;
	}
</style>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script> 
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
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
			if(subChk[i].checked)
				cnt++;
		}
		
		if(cnt==subChk.length) {
			document.getElementById("mainChk").checked=true;
		}
		else {
			document.getElementById("mainChk").checked=false;
		}
	}
	
</script>    
</head>
<body>

<main>
	<table width="1000" align="center">
		<caption><h2> 찜 리스트 </h2></caption>
		<c:forEach items="${plist}" var="pdto">
		<tr>
			<td width="30" align="center">
				<input type="checkbox" class="subChk" value="${pdto.pcode}" onclick="subClick()">
			</td>
			<td width="100"><img src="../static/product/${pdto.pimg}" width="80" height="80"></td>
			<td> ${pdto.title} </td>
			<td width="140" align="center">
				<c:if test="${pdto.baeprice==0}"> 무료배송 </c:if>
				<c:if test="${pdto.baeprice!=0}">
				￦<fmt:formatNumber value="${pdto.baeprice}" type="number"/>
				</c:if>
			</td>
			<td width="120" align="right">￦<fmt:formatNumber value="${pdto.halinPrice}" type="number"/></td>
			<td width="100" align="center" style="line-height:24px">
				<input type="button" value="장바구니"><br><input type="button" value="삭제">
			</td>
		</tr>
		</c:forEach>
		<tr>
			<td colspan="6">
				<input type="checkbox" id="mainChk" onclick="mainClick(this)"> 전체선택 <input type="button" value="선택삭제">
			</td>
		</tr>
	</table>
</main>

</body>
</html>