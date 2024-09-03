<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<style>
	main {
		width: 1100px;
		margin: auto;
		font-family: 'GmarketSansMedium';
	}
	main table {
		margin-top: 50px;
		margin-bottom: 50px;
		border-spacing: 0;
	}
	main table td {
		border-bottom: 1px solid purple;
		padding: 5px 0;
	}
	main table tr:first-child td {
		border-top: 2px solid purple;
	}
	main #mainChk {
		width: 18px;
		height: 18px;
	}
	main .subChk {
	}
	main .su {
		width: 20px;
		outline: none;
		text-align: center;
	}
</style>
<script>
	function mainClick(my) {
		var subChk = document.getElementsByClassName("subChk");
		for (var i = 0; i < subChk.length; i++) {
			subChk[i].checked = my.checked;
		}
		totalCal();
	}
	function subClick() {
		var subChk = document.getElementsByClassName("subChk");
		var cnt = 0;
		for (var i = 0; i < subChk.length; i++) {
			if (subChk[i].checked) {
				cnt++;
			}
		}
		document.getElementById("mainChk").checked = (cnt === subChk.length);
		totalCal();
	}
	function totalCal() {
		var subChk = document.getElementsByClassName("subChk");
		var hp = document.getElementsByClassName("hp");
		var jp = document.getElementsByClassName("jp");
		var bp = document.getElementsByClassName("bp");
		var hpAll = 0;
		var jpAll = 0;
		var bpAll = 0;
		var chkNum = 0;
		for (var i = 0; i < subChk.length; i++) {
			if (subChk[i].checked) {
				chkNum++;
				var hpImsi = parseInt(hp[i].innerText.replace(/[,]/g, ""));
				var jpImsi = parseInt(jp[i].innerText.replace(/[,]/g, ""));
				var bpImsi = (bp[i].innerText === "무료배송") ? 0 : parseInt(bp[i].innerText.replace(/[,]/g, ""));
				hpAll += hpImsi;
				jpAll += jpImsi;
				bpAll += bpImsi;
				document.getElementById("hpTot").innerText = comma(hpAll);
				document.getElementById("jpTot").innerText = comma(jpAll);
				document.getElementById("bpTot").innerText = comma(bpAll);
				document.getElementById("hpbpTot").innerText = comma(hpAll + bpAll);
			}
		}
		if (chkNum === 0) {
			document.getElementById("hpTot").innerText = 0;
			document.getElementById("jpTot").innerText = 0;
			document.getElementById("bpTot").innerText = 0;
			document.getElementById("hpbpTot").innerText = 0;
		}
	}
	function comma(value) {
		return new Intl.NumberFormat().format(value);
	}
</script>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script>
	$(function() {
		$(".su").spinner({
			min: 1,
			max: 10,
			spin: function(e, ui) {
				var index = $(".su").index(this);
				chgSu(ui.value, index);
			}
		});
	});
	function chgSu(su, index) {
		var pcode = document.getElementsByClassName("subChk")[index].value;
		var chk = new XMLHttpRequest();
		chk.onload = function() {
			var data = JSON.parse(chk.responseText);
			document.getElementsByClassName("hp")[index].innerText = comma(data[0]);
			document.getElementsByClassName("jp")[index].innerText = comma(data[1]);
			document.getElementsByClassName("bp")[index].innerText = (data[2] === 0) ? "무료배송" : comma(data[2]);
			totalCal();
		}
		chk.open("get", "chgSu?su=" + su + "&pcode=" + pcode);
		chk.send();
	}
	function selDel() {
		var subChk = document.getElementsByClassName("subChk");
		var pcode = "";
		for (var i = 0; i < subChk.length; i++) {
			if (subChk[i].checked) {
				pcode += subChk[i].value + "/";
			}
		}
		if (pcode !== "") {
			location = "cartDel?pcode=" + pcode;
		}
	}
	function gumaeAll() {
		var subChk = document.getElementsByClassName("subChk");
		var su = document.getElementsByClassName("su");
		var pcodes = "";
		var sues = "";
		for (var i = 0; i < subChk.length; i++) {
			if (subChk[i].checked) {
				pcodes += subChk[i].value + "/";
				sues += su[i].value + "/";
			}
		}
		if(pcodes!="")
			location = "../product/gumae?pcode=" + pcodes + "&su=" + sues;
		else
			alert("선택하신 상품이 없습니다.");
	}
</script>
</head>
<body>
<main>
	<table width="1100" align="center">
		<caption><h2>장바구니 현황</h2></caption>
		<c:set var="cnum" value="0"/>
		<c:forEach items="${pMapAll}" var="map">
			<c:set var="str" value=""/>
			<c:if test="${map.days <= 1}">
				<c:set var="str" value="checked"/>
				<c:set var="cnum" value="${cnum + 1}"/>
			</c:if>
			<tr height="80">
				<td width="30">
					<input type="checkbox" value="${map.pcode}" ${str} class="subChk" onclick="subClick()">
				</td>
				<td width="100" align="center">
					<img src="../static/product/${map.pimg}" height="80" width="80">
				</td>
				<td align="left">${map.title}</td>
				<td width="140">${map.baeEx}</td>
				<td width="110" align="right">
					<span class="hp"><fmt:formatNumber value="${map.halinprice}" type="number"/></span>원
				</td>
				<td width="110" align="right">
					<span class="jp"><fmt:formatNumber value="${map.jukprice}" type="number"/></span>원
				</td>
				<td width="80" align="right">
					<input type="text" name="su" value="${map.csu}" class="su">
				</td>
				<td width="110" align="right">
					<c:if test="${map.baeprice == 0}">
						<span class="bp">무료배송</span>
					</c:if>
					<c:if test="${map.baeprice != 0}">
						<span class="bp"><fmt:formatNumber value="${map.baeprice}" type="number"/></span>원
					</c:if>
					<br>
					<input type="button" value="삭제" onclick="location='cartDel?pcode=${map.pcode}'">
				</td>
			</tr>
		</c:forEach>
		<tr>
			<td height="40">
				<c:if test="${pMapAll.size() == cnum && cnum != 0}">
					<c:set var="mchk" value="checked"/>
				</c:if>
				<input type="checkbox" ${mchk} id="mainChk" onclick="mainClick(this)">
			</td>
			<td height="40" colspan="5">
				전체선택
				<input type="button" value="선택상품 삭제" onclick="selDel()">
			</td>
			<td colspan="2">
				<input type="button" value="선택상품 구매" onclick="gumaeAll()">
			</td>
		</tr>
		<tr>
			<td colspan="8" align="center">
				총상품금액
				 <span id="hpTot"><fmt:formatNumber value="${halinpriceTot}" type="number"/></span>원
				+ 배송비
				 <span id="bpTot"><fmt:formatNumber value="${baepriceTot}" type="number"/></span>원
				= 총결제금액
				 <span id="hpbpTot"><fmt:formatNumber value="${halinpriceTot + baepriceTot}" type="number"/></span>원
				(적립예정 : <span id="jpTot"><fmt:formatNumber value="${jukpriceTot}" type="number"/></span>원)
			</td>
		</tr>
	</table>
</main>
</body>
</html>