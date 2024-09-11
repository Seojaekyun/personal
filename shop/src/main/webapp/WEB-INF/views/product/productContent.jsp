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
		font-family: 'GmarketSansLight';
	}
	main section {
		width: 1100px;
		margin: auto;
	}
	main #first {
		width: 1100px;
		height: 500px;
	}
	main #first > div {
		display: inline-block;
	}
	main #first #left {
		width: 500px;
		height: 500px;
		text-align: center;
	}
	main #first #right {
		width: 594px;
		height: 500px;
		vertical-align: top;
		margin-top: 20px;
	}
	main #first #right > div {
		margin-top: 30px;
	}
	main #first #right #ptitle {
		font-family: 'GmarketSansMedium';
		font-size: 24px; 
	}
	main #first #right #ptitle #leftT {
		width: 420px;
		float: left;
	}
	main #first #right #ptitle #rightT {
		width: 80px;
		float: left;
		text-align: left;
	}
	main #first #right #pstar {
		clear: both;
		font-size: 12px;
		margin-top: 0;
		padding-bottom: 8px;
		border-bottom: 1px solid purple;
		font-family: 'GmarketSansMedium';
	}
	main #first #right #pprice {
		font-size: 22px;
		font-family: 'GmarketSansMedium';
		color: #CB1400;
		margin-top: 0;
		padding-bottom: 8px;
		border-bottom: 1px solid purple;
	}
	main #first #right #pbaeprice {
		font-family: 'GmarketSansMedium';
	}
	main #first #right #pbaeEx {
		color: green;
		font-size: 18px;
		font-family: 'GmarketSansMedium';
		margin-top: 0;
		padding-bottom: 8px;
		border-bottom: 1px solid purple;
	}
	main #first #right #pjuk {
		font-family: 'GmarketSansMedium';
		padding-bottom: 8px;
		border-bottom: 1px solid purple;
	}
	main #first #right #su {
		width: 40px;
		height: 25px;
		text-align: center;
		outline: none;
		vertical-align: bottom;
	}
	main #first #right #btn {
		width: 230px;
		height: 40px;
		background: white;
		border: 1px solid purple;
		vertical-align: top;
		border-radius: 4px;
	}
	main #first #right #submit {
		width: 230px;
		height: 40px;
		background: purple;
		color: white;
		border: 1px solid purple;
		vertical-align: top;
		border-radius: 4px;
	}
	main #first #right #pbutton {
		position: relative;
	}
	main #first #right #pbutton #confirm {
		position: absolute;
		left: 70px;
		top: -100px;
		width: 260px;
		height: 70px;
		border: 1px solid purple;
		background: white;
		visibility: hidden;
	}
	main #first #right #pbutton #confirm div {
		text-align: center;
		width: 260px;
		height: 35px;
		line-height: 35px;
		font-family: 'GmarketSansMedium';     
	}
	main #first #right #pbutton #confirm div input {
		width: 100px;
		height: 30px;
		border: 1px solid purple;
		background: purple;
		color: white;
	}
	main #allMenu {
		width:1000px;
      height:40px;
      margin: auto;
	}
	main #allMenu ul {
		width:1000px;
		height:40px;
		padding-left:0px;
	}
	main #allMenu ul li {
		list-style-type:none;
		display:inline-block;
		width:243px;
		height:40px;
		border:1px solid gray;
		border-radius: 10px;
		text-align:center;
		line-height:40px;
		margin: auto;
		background: white;
		
	}
	main #allMenu a:hover {
		text-decoration: underline;
		font-weight: bold;
	}
	main #second {
		
	}
	main #third {
		height: 200px;
	}
	main #fourth {
		height: 200px;
	}
	main #fifth {
	
	}
	
</style>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script> 
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
<script>
	$(function() {
		var price = ${pdto.price};
		var halin = ${pdto.halin};
		var juk = ${pdto.juk};
		$("#su").spinner({
			min: 1,
			max: 10,
			spin: function(e, ui) {
				var su2 = ui.value;
				var jsprice = price * su2; 
				var jshalinprice = (price - (price * halin / 100)) * su2;
				var jsjukprice = (price * juk / 100) * su2;
				$("#input1").text(comma(jsprice));
				document.getElementById("input2").innerText = comma(jshalinprice);
				document.getElementById("input3").innerText = comma(jsjukprice);
			}
		});
	});
	function comma(value) {
		return new Intl.NumberFormat().format(value);
	}
	function jjimOk(pcode) {
		var imgName = document.getElementById("img").src;
		var fname = imgName.substring(imgName.lastIndexOf("/") + 1);
		var chk = new XMLHttpRequest();
		chk.onload = function() {
			if (chk.responseText == "0")
				location = "../login/login?pcode=" + pcode;
			else {
				if (fname == "jjim1.png") {
					document.getElementById("img").src = "../static/main/jjim2.png";
				} else {
					document.getElementById("img").src = "../static/main/jjim1.png";
				}
			}	
		}
		chk.open("get", "jjimOk?pcode=" + pcode + "&fname=" + fname);
		chk.send();
	}
	function addCart() {
		var pcode = "${pdto.pcode}";
		var su = document.gform.su.value;
		var chk = new XMLHttpRequest();
		chk.onload = function() {
			if (chk.responseText == "-1") {
				alert("잠시 오류가 발생하였습니다");
			} else {
				document.getElementById("confirm").style.visibility = "visible";
				setTimeout(function() {
					document.getElementById("confirm").style.visibility = "hidden";
				}, 3000);		
			}
		}
		chk.open("get", "addCart?pcode=" + pcode + "&su=" + su);
		chk.send();
	}
	function scrollMove() {
		/* document.getElementById("aa").innerText=document.documentElement.scrollTop; */
		var st=document.documentElement.scrollTop;
		if(st>=720) {
			document.getElementById("allMenu").style.position="fixed";
			document.getElementById("allMenu").style.top="-16px";
			document.getElementById("allMenu").style.left="123px";
		}
		else {
			document.getElementById("allMenu").style.position="relative";
    		document.getElementById("allMenu").style.top="0px";
    		document.getElementById("allMenu").style.left="0px";
		}
	}
	
	window.onscroll=scrollMove;
</script>
</head>
<body>
	<main>
		<form name="gform" method="post" action="gumae">
			<input type="hidden" name="pcode" value="${pdto.pcode}">
			<section id="first">
				<div id="left"> 
					<img src="../static/product/${pdto.pimg}" width="470" height="400"> 
				</div>
				<div id="right">
					<div id="ptitle">  
						<div id="leftT">${pdto.title}</div>
						<div id="rightT">
							<a href="javascript:jjimOk('${pdto.pcode}')">
								<img id="img" src="../static/main/${jImg}" valign="middle" style="margin-left: 100px"> 
							</a>
						</div>    
					</div>
					<div style="letter-spacing:-3px" id="pstar">
						<c:forEach begin="1" end="${ystar}">
							<img src="../static/pro/star1.png" width="10">
						</c:forEach>
						<c:if test="${hstar==1}">
							<img src="../static/pro/star3.png" width="10">
						</c:if>
						<c:forEach begin="1" end="${gstar}">
							<img src="../static/pro/star2.png" width="10">
						</c:forEach>
						<span style="letter-spacing:0px"> ${pdto.review}개 상품평 </span>
					</div>
					<div id="phalin"> 
						<c:if test="${pdto.halin != 0}">
							${pdto.halin}% <s id="input1"><fmt:formatNumber value="${pdto.price}" type="number"/></s>
						</c:if>  
					</div>
					<div id="pprice"><span id="input2"><fmt:formatNumber value="${pdto.halinPrice}" type="number"/></span>원</div>
					<div id="pbaeprice">
						<c:if test="${pdto.baeprice == 0}">무료배송</c:if>
						<c:if test="${pdto.baeprice != 0}">배송비 <fmt:formatNumber value="${pdto.baeprice}" type="number"/>원</c:if>
					</div>
					<div id="pbaeEx">${pdto.baeEx}</div>
					<div id="pjuk">적립예정: <span id="input3"><fmt:formatNumber value="${pdto.jukPrice}" type="number"/></span>원</div>
					<div id="pbutton">
						<input type="text" name="su" value="1" readonly id="su"> 
						<input type="button" onclick="addCart()" value="장바구니" id="btn"> 
						<input type="submit" value="바로구매" id="submit">
						<div id="confirm">
							<div>장바구니로 이동하시겠습니까?</div> 
							<div><input type="button" value="장바구니 이동" onclick="location='../member/cartView'"></div>
						</div>
					</div>
				</div> <!-- id="right"의 끝 -->
			</section>
		</form>
		
		<div id="allMenu">
			<ul>
				<li><a href="#menu1"> 상품 상세 </a></li>
				<li><a href="#menu2"> 상품평 </a></li>
				<li><a href="#menu3"> 상품문의 </a></li>
				<li><a href="#menu4"> 교환/반품 </a></li>
			</ul>
		</div>
		
		<section id="second">
			<h3 class="cmenu" id="menu1"> 상품 상세 정보 </h3>
			<img src="../static/product/${pdto.dimg}" width="1100">
		</section>
		
		<section id="third">
			<h3 class="cmenu" id="menu2"> 상품평 </h3>
		</section>
		
		<section id="fourth">
			<h3 class="cmenu" id="menu3"> 상품문의 </h3>
		</section>
		
		<section id="fifth">
			<h3 class="cmenu" id="menu4"> 교환/반품 </h3>
			<img src="../static/main/exch.png">
		</section>
	</main>
</body>
</html>