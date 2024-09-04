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
		font-family: 'GmarketSansMedium';
	}
	main #sudan .sub {
		display:none;
	}
	main #sudan #fsub {
		display:block;
	}
	main #sudan #sudanFirst {
		width:1100px;
		height:180px;
		border:1px solid purple;
		padding:10px;
	}
	main #sudan #sudanSecond {
		width:1100px;
		height:40px;
		border:1px solid purple;
		border-top:none;
		padding:10px;
	}
	main #sudan .subMain {
		display:none;
	}
	main #sudan #up {
		display:none;
	}
	main #sudan #down {
	}
	main #sudan select {
		width:120px;
		height:28px;
		margin-left:10px;
	}
	main table {
		border-spacing:0px;
		margin-top:30px;
	}
	main table tr:first-child td {
		border-top:2px solid purple;
	}
	main table tr:last-child td {
		border-bottom:1px solid purple;
	}
	main table td {
		font-size:14px;
		height:40px;
		padding-left:10px;
		border-bottom:1px solid purple;
	}
	main table tr td:first-child {
		background:#efefef;
	}
	main table #useJuk {
		width:50px;
		outline:none;
		text-align:right;
	}
</style>
<script>
	function jusoChuga() {
		open("jusoWrite","","width=480,height=500");
	}
	function jusoChange() {
		open("jusoList","","width=480,height=500");
	}
	function viewSrc() {
		document.getElementById("src").innerText=document.getElementById("baesong").innerHTML;
	}
	function viewSub(n) {
		var sub=document.getElementsByClassName("sub");
		for(i=0;i<sub.length;i++)
			sub[i].style.display="none";
		sub[n].style.display="block";
	}
	function down() {
		document.getElementById("sudanSecond").style.height="180px";
		var subMain=document.getElementsByClassName("subMain");
		for(i=0;i<subMain.length;i++) {
			subMain[i].style.display="block";
		}
		document.getElementById("up").style.display="inline";
		document.getElementById("down").style.display="none";
	}
	function up() {
		document.getElementById("sudanSecond").style.height="40px";
		var subMain=document.getElementsByClassName("subMain");
		for(i=0;i<subMain.length;i++) {
			subMain[i].style.display="none";
		}
		document.getElementById("up").style.display="none";
		document.getElementById("down").style.display="inline";
	}
	function numCheck(my) {
		my.value=my.value.replace(/[^0-9]/g,"");
	}
	
	function init(my) {
		if (my.value === "0") {
			my.value = "";
		}
		// init() 함수에서 적립금과 총 결제금액 업데이트
		jukCal(my);
	}
	
	var jukImsi=${juk};
	var chongPrice=${halinPrice+baePrice};
	function jukCal(my) {
		if (my.value === "") {
			my.value="0";
		}
		var inputValue=parseInt(my.value)||0; // 공백이나 비어있는 경우 0으로 처리
		
		if (inputValue>jukImsi) {
			alert("보유적립금을 초과합니다");
			my.value="0";
			inputValue=0;
		}
		// 적립금 및 총 결제금액 재계산
		document.getElementById("myJuk").innerText=comma(jukImsi - inputValue);
		document.getElementById("chong").innerText=comma(chongPrice - inputValue);
	}
	
	function comma(value) {
		return new Intl.NumberFormat().format(value);
	}
	
	function chgPhone() {
		var mPhone=document.getElementById("memberPhone").value;
		
		if(mPhone.trim().length==0) {
			alert("전화번호가 없습니다");
		}
		else {
			var chk=new XMLHttpRequest();
			chk.onload=function() {
				
			}
			
			chk.open("get","chgPhone?mPhone="+mPhone);
			chk.send();
		}
	}
	
</script>
</head>
<body>
	<main>
		<h2 style="border-bottom:3px solid purple">주문 / 결제</h2>
		<section id="member">
			<table width="1100" align="center">
				<caption><h3 align="left">구매자 정보</h3></caption>
				<tr>
					<td width="200">이 름</td>
					<td>${mdto.name}</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td>${mdto.email}</td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td>
						<input type="text" name="phone" value="${mdto.phone}" id="memberPhone">
						<input type="button" value="수정" onclick="chgPhone()">
					</td>
				</tr>
			</table>
		</section>
		<section id="baesong">
			<table width="1100" align="center">
				<caption>
					<h3 align="left">
						배송지 정보
						<c:if test="${bdto!=null}">
							<input type="button" value="배송지변경" onclick="jusoChange()">
						</c:if>
						<c:if test="${bdto==null}">
							<input type="button" id="fbtn" value="첫 배송지추가" onclick="jusoChuga()">
						</c:if>
					</h3>
				</caption>
				<tr>
					<td width="200">이름</td>
					<td id="bname">${bdto.name}</td>
				</tr>
				<tr>
					<td>배송주소</td>
					<td id="bjuso">${bdto.juso} ${bdto.jusoEtc}</td>
				</tr>
				<tr>
					<td>연락처</td>
					<td id="bphone">${bdto.phone}</td>
				</tr>
				<tr>
					<td>배송요청사항</td>
					<td id="breq">${bdto.breq}</td>
				</tr>
			</table>
		</section>
		<section id="product">
			<table width="1100" align="center">
				<caption>
					<h3 align="left">구매 상품 정보</h3>
					<c:forEach items="${plist}" var="pdto">
						<tr>
							<td colspan="2" bgcolor="#eeeeee">${pdto.baeEx}</td>
						</tr>
						<tr>
							<td width="600" style="background:white">${pdto.title}</td>
							<td>
								수량 ${pdto.su}개 /
								<c:if test="${pdto.baeprice==0}">무료배송</c:if>
								<c:if test="${pdto.baeprice!=0}">
									<fmt:formatNumber value="${pdto.baeprice}" type="number"/>원
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</caption>
			</table>
		</section>
		<section id="price">
			<table width="1100" align="center">
				<caption><h3 align="left">결제 정보</h3></caption>
				<tr>
					<td width="200">총상품가격</td>
					<td><fmt:formatNumber value="${halinPrice}" type="number"/>원</td>
				</tr>
				<tr>
					<td>배송비</td>
					<td>
						<c:if test="${baePrice==0}">무료배송</c:if>
						<c:if test="${baePrice!=0}">
							<fmt:formatNumber value="${baePrice}" type="number"/>원
						</c:if>
					</td>
				</tr>
				<tr>
					<td>적립예정금액</td>
					<td><fmt:formatNumber value="${jukPrice}" type="number"/>원</td>
				</tr>
				<tr>
					<td>적립금</td>
					<td>
						<input type="text" name="useJuk" value="0" id="useJuk" onfocus="init(this)" onblur="jukCal(this)" onkeyup="numCheck(this)">
						보유 : <span id="myJuk"><fmt:formatNumber value="${juk}" type="number"/></span>원
					</td>
				</tr>
				<tr>
				<tr>
					<td>총 결제금액</td>
					<td><span id="chong"><fmt:formatNumber value="${halinPrice+baePrice}" type="number"/></span>원</td>
				</tr>
			</table>
		</section>
		<section id="sudan">
			<h3 align="left">결제 수단</h3>
			<div id="sudanFirst">
				<div>
					<input type="radio" name="sudan" class="sudan" checked onclick="viewSub(0)"> 신용/체크카드
					<div class="sub" id="fsub">
						<select name="card">
							<option>선 택</option>
							<option>신한카드</option>
							<option>농협카드</option>
							<option>우리카드</option>
							<option>국민카드</option>
							<option>하나카드</option>
						</select>
						<select name="halbu">
							<option>일시불</option>
							<option>2개월</option>
							<option>3개월</option>
							<option>6개월</option>
							<option>12개월</option>
						</select>
					</div>
				</div>
				<div>
					<input type="radio" name="sudan" class="sudan" onclick="viewSub(1)"> 쿠페이머니
					<div class="sub">0원</div>
				</div>
			</div>
			<div id="sudanSecond">
				<div>다른 결제 수단
					<span id="down" onclick="down()">▼</span>
					<span id="up" onclick="up()">▲</span>
				</div>
				<div class="subMain">
					<input type="radio" name="sudan" class="sudan" onclick="viewSub(2)"> 계좌이체
					<div class="sub">
						<select name="bank">
							<option>선 택</option>
							<option>신한은행</option>
							<option>농협은행</option>
							<option>우리은행</option>
							<option>국민은행</option>
							<option>하나은행</option>
						</select>
					</div>
				</div>
				<div class="subMain">
					<input type="radio" name="sudan" class="sudan" onclick="viewSub(3)"> 법인카드
					<div class="sub">
						<select name="lcard">
							<option>선 택</option>
							<option>신한카드</option>
							<option>농협카드</option>
							<option>우리카드</option>
							<option>국민카드</option>
							<option>하나카드</option>
						</select>
					</div>
				</div>
				<div class="subMain">
					<input type="radio" name="sudan" class="sudan" onclick="viewSub(4)"> 휴대폰
					<div class="sub">
						<select name="tong">
							<option>선 택</option>
							<option>SKT</option>
							<option>KT</option>
							<option>LG</option>
							<option>별정통신</option>
						</select>
					</div>
				</div>
				<div class="subMain">
					<input type="radio" name="sudan" class="sudan" onclick="viewSub(5)"> 무통장입금
					<div class="sub">
						<select name="nbank">
							<option>선 택</option>
							<option>신한은행</option>
							<option>농협은행</option>
							<option>우리은행</option>
							<option>국민은행</option>
							<option>하나은행</option>
						</select>
					</div>
				</div>
			</div>
		</section>
	</main>
</body>
</html>