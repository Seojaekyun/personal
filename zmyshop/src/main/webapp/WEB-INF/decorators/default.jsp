<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>우리동네 구멍가게</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@100..900&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Gugi&family=Hahmlet:wght@100..900&display=swap');
	* {
		margin: 0;
		padding: 0;
		box-sizing: border-box;
	}
	body {
		margin: auto;
		font-family: Arial, sans-serif;
		font-weight: 600;
	}
	a {
		text-decoration: none;
	}
	#fouter {
		width:100%;
		height:40px;
		background:#5F007F;
    }
	#fouter #first {
		width: 1100px;
		height: 40px;
		margin: auto;
		background: #5F007F;
	}
	#fouter #first #left {
		display: inline-block;
		width: 45px; 
		height: 40px;
	}
	#fouter #first #center {
		display: inline-block;
		width: 1000px; 
		height: 40px;
		text-align: center;
		line-height: 40px;
		font-size: 12px;
		color: #f4f4f4;
	}
	#fouter #first #right {
		display: inline-block;
		width: 45px; 
		height: 40px;
		text-align: center;
		line-height: 40px;
		font-size: 18px;
		color: gray;
	}
	#fouter #xx {
		cursor:pointer;
	}
	header {
		width: 1100px;
		height: 70px;
		margin: auto;
	}
	header #logo {
		display: inline-block;
		width: 300px;
		height: 70px;
		line-height: 70px;
	}
	header #search {
		display: inline-block;
		width: 480px;
		height: 70px;
		line-height: 70px;
	}
	header #search #searchForm {
		width: 350px;
		height: 44px;
		border: 1px solid black;
		line-height:44px;
		border-radius: 5px;
	}
	header #search #searchForm input[type=search] {
		width: 300px;
		border: none;
		outline: none;
		margin-left: 15px;
	}
	input[type="search"]::-webkit-search-cancel-button {
		background: url('../static/resources/x.png') no-repeat center center !important;
		background-size: contain !important;
	}
	header #memMenu {
		display: inline-block;
		width: 300px;
		height: 70px;
		line-height: 70px;
		font-size: 13px;
    }
    header a {
		color: #5F007F;
	}
	header #memMenu #myMenu {
		position:relative;
		display:inline-block;
	}
	header #memMenu #myMenuList {
		padding-left:0px;
		position:absolute;
		left:-19px;
		top:60px;
		visibility:hidden;
		border:1px solid purple;
		background:white;
		z-index: 10;
	}
	header #memMenu #myMenuList li {   
		list-style-type:none;
		height:28px;
		line-height:28px;
		width:100px;
		text-align:center;
		cursor:pointer;
		/* border:1px solid black;
		border-bottom:none;
		border-top:none; */
	}
	header #memMenu #myMenuList li:hover {
		background:#FFF5FF;
	}   
	header #memMenu #myMenuList li:first-child { 
	   /* border-top:1px solid black; */
	}
	
	header #memMenu #myMenuList li:last-child { 
	   /* border-bottom:1px solid black; */
	}
    #cartNum {
    	position: absolute;
    	top: 10px;
    	right: -10px;
    	background-color: #5F007F;
    	color: white;
    	border-radius: 50%;
    	padding: 2px;
    	font-size: 8px;
    	font-weight: bold;
    	min-width: 16px;
    	height: 16px;
    	line-height: 13px;
    	text-align: center;
	}
	nav {
		width: 1100px;
		height: 60px;
		margin: auto;
	}
	nav > ul {
		padding-left: 0px;
	}
	nav > ul > li {
		font-size: 16px;
		color: #4d4d4d;
		display: inline-block;
		width: 150px;
		height: 60px;
		line-height: 60px;
	}
	nav > ul > li:first-child {
		width: 250px;
	}
	nav > ul > li:last-child {
		width: 220px;
		text-align: right;
	}
	
	nav a {
		color: black;
	}
	nav #cate {  /* 카테고리메뉴 */
		position: relative;
		display: block;
		width: 90px;
		height: 58px;
		z-index: 1000;
	}
	nav #daeMenu {  /* ul */
		position: absolute;
		left: -12px;
		top: 50px;
		padding-left: 0px;
		width: 102px;
		height: 212px;
		background: white;
		display: none;
		border: 1px solid purple;
		border-radius: 5px;
	}
	nav #daeMenu > li {   /* 대분류 메뉴 */
		list-style-type: none;
		width: 100px;
		height: 30px;
		line-height: 30px;
		text-align: center;
		background: none;
		cursor: pointer;
		position: relative;
		
	}
	nav #daeMenu > li:hover { 
		background: #FFF5FF;
		border-radius: 5px;
	}
	nav #daeMenu > li > .jungMenu { /* 중분류메뉴의 UL태그 */
		position: absolute;
		left: 100px;
		top: -1px;
		padding-left: 0px;
		background: white;
		border: 1px solid purple;
		border-radius: 5px;
	}
	nav #daeMenu > li .jungMenu > li {
		list-style-type: none;
		width: 100px;
		height: 30px;
		position: relative;
		background: none;
	}
	nav #daeMenu > li .jungMenu > li:hover {
		background: #FFF5FF;
		border-radius: 5px;
	}
	nav #daeMenu > li .jungMenu > li > .soMenu {
		position: absolute;
		left: 100px;
		top: -1px;
		padding-left: 0px;
		background: white;
		border: 1px solid purple;
		border-radius: 5px;
	}
	nav #daeMenu > li .jungMenu > li .soMenu > li {
		list-style-type: none;
		width: 100px;
		height: 30px;
		background: none;
	}
	nav #daeMenu > li .jungMenu > li .soMenu > li:hover {
		background: #FFF5FF;
		border-radius: 5px;
	}
	nav > #mainMenu {  
		padding-left: 0px;
	}
	nav > #mainMenu > li {
		list-style-type: none;
		display: inline-block;
		width: 170px;
		height: 50px;
		line-height: 50px;
		text-align: center;
	}
	nav > #mainMenu > li:first-child {
		width: 220px;
		text-align: left;
	}
	footer {
		padding: 10px 0;
		width: 100%;
		background: lightgray;
		color: white;
		text-align: center;
		font-family: 'Hahmlet';
		font-size: 13px;
	}
	.footer-container {
		display: flex;
		justify-content: space-around;
		align-items: center;
		max-width: 1000px;
		margin: auto;
		flex-wrap: wrap;
	}
	.footer-logo img {
		height: 80px;
	}
	.footer-info, .footer-contact {
		text-align: left;
	}
	.footer-info div, .footer-contact div {
		margin-bottom: 5px;
	}
	
</style>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
	window.onload=function() {
		var chk=new XMLHttpRequest();
		chk.onload=function() {
			var n=chk.responseText;
			if(n=="1") {
				document.getElementById("fouter").style.display="none";
			}
		}
		chk.open("get","../fcookOk");
		chk.send();
	}
	
	var h=40;
	function fclose() {
		ss=setInterval(function() {
			h--;
			document.getElementById("fouter").style.height=h+"px";
			document.getElementById("first").style.height=h+"px";
			
			if(h==0) {
				clearInterval(ss);
				document.getElementById("fouter").style.display="none";
			}
		},10);
		
		var chk=new XMLHttpRequest();
		chk.onload=function() {
			if(chk.responseText=="0") {
				alert("오류");
			}
		}
		chk.open("get", "../firstCookie");
		chk.send();
	}
	
	mchk=0;
	function viewMenu() {
		document.getElementById("daeMenu").style.display="block";
		
		if(mchk==0) {
			var chk=new XMLHttpRequest();
			chk.onload=function() {
				var daeAll=JSON.parse(chk.responseText);
				var str="";
				
				for(dae of daeAll) {
					var pcode="p"+dae.code;
					str=str+"<li onmouseover='jungView("+dae.code+")' onmouseout='jungHide("+dae.code+")'> <a href='../product/productList?pcode="+pcode+"'> "+dae.name+" </a> <ul class='jungMenu'> </ul> </li>";
				}
				
				document.getElementById("daeMenu").innerHTML=str;
				
			}
			chk.open("get","../main/getDae");
			chk.send();
			mchk++;
		}
	}
	
	function hideMenu() {
		document.getElementById("daeMenu").style.display="none";
	}
	
	var jungEx=new Array(10);
	for(i=0;i<jungEx.length;i++) {
		jungEx[i]=0;
	}
	
	function jungView(daecode) {
		document.getElementsByClassName("jungMenu")[daecode-1].style.display="block";
		if(jungEx[daecode-1]==0) {
			var chk=new XMLHttpRequest();
			chk.onload=function() {
				var jungAll=JSON.parse(chk.responseText);
				var str="";
				var i=0;
				for(jung of jungAll) {
					var pcode="p"+jung.daecode+jung.code;
					str=str+"<li onmouseover='soView(this,"+(daecode+""+jung.code)+","+i+")' onmouseout='soHide("+i+")'><a href='../product/productList?pcode="+pcode+"'> "+jung.name+" </a><ul class='soMenu'></ul> </li>";
					
					i++;
				}
				
				document.getElementsByClassName("jungMenu")[daecode-1].innerHTML=str;
			}
			chk.open("get","../main/getJung?daecode="+daecode);
			chk.send();
			
			jungEx[daecode-1]=1;
		}
	}
	
	function jungHide(daecode) {
		document.getElementsByClassName("jungMenu")[daecode-1].style.display="none";
	}
	
	function soView(my,daejung,i) {
		my.childNodes[1].style.display="block";
		
		if(my.childNodes[1].innerHTML=="") {
			var chk=new XMLHttpRequest();
			
			chk.onload=function() {
				var soAll=JSON.parse(chk.responseText);
				var str="";
				for(so of soAll) {
					var pcode="p"+so.daejung+so.code;
					str=str+"<li> <a href='../product/productList?pcode="+pcode+"'> "+so.name+" </a> </li>";
				}
				console.log("pcode:", pcode); // 디버깅용 로그 추가
				
				my.childNodes[1].innerHTML=str;
			}
			chk.open("get","../main/getSo?daejung="+daejung);
			chk.send();
		}
	}
	
	function soHide(my) {
		for(i=0;i<document.getElementsByClassName("soMenu").length;i++)
			document.getElementsByClassName("soMenu")[i].style.display="none";
	}
	
	function viewSrc() {
		document.getElementById("src").innerText=document.getElementsByTagName("html")[0].innerHTML;
	}
	
	window.onload=function() {
		var chk=new XMLHttpRequest();
		chk.onload = function() {
		    var cartNumElement = document.getElementById("cartNum");
		    if (cartNumElement) {
		        cartNumElement.innerText = chk.responseText || "0"; // 기본 값 설정
		    } else {
		        console.error("'cartNum' 요소를 찾을 수 없습니다.");
		    }
		};
		
		chk.open("get","../main/cartNum");
		chk.send();
		
		<c:if test="${order!=null}">
			document.getElementsByClassName("order")[${order-1}].style.color="#FF007F";
		</c:if>
	}
	
	function myMenuView() {
		document.getElementById("myMenuList").style.visibility="visible";
	}
	
	function myMenuHide() {
		document.getElementById("myMenuList").style.visibility="hidden";
	}
	

</script>

<sitemesh:write property="head" />

</head>
<body> <!-- default.jsp -->
	<div id="fouter">
		<div id="first">
			<div id="left"> &nbsp; </div>
			<div id="center"> 회원 가입 후 첫 구매시 100만원 할인! </div>
			<div id="right"><span id="xx" onclick="fclose()">Ⅹ</span></div>
		</div>
	</div>
	<header>
		<div id="logo">
			<a href="../main/index">
				<img alt="logo" src="../static/resources/kurlylogo.png" width="30%" style="vertical-align: middle;">
			</a>
		</div>
		<div id="search">
			<div id="searchForm">
				<input type="search" name="sword" id="sword" placeholder="검색어를 입력하세요">
				<img src="../static/resources/s.png" style="vertical-align: middle;">
			</div>
		</div>
		<div id="memMenu">
			<div style="position: relative; display: inline-block;">
				<a href="../member/cartView">
					<img src="../static/main/cart.png" style="valign: middle; width: 24px">
					<span id="cartNum"></span>
				</a>
			</div>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<c:if test="${userid==null}">
				<a href="../login/login"> 로그인 </a> |
				<a href="../member/member"> 회원가입 </a> |
			</c:if>
			<c:if test="${userid!=null}">
				${name}님 |
				<span id="myMenu" onmouseover="myMenuView()" onmouseout="myMenuHide()"> 나의메뉴 
					<ul id="myMenuList">
						<li> <a href="../member/jjimList"> 찜리스트 </a> </li>
						<li> <a href="../member/memberView"> 회원정보 </a></li>
						<li> <a href="../member/jumunList"> 주문목록 </a></li>
						<li> <a href="../member/myBaesong"> 배송지관리 </a></li>
						<li> <a href="../member/myReview"> 나의상품평 </a></li>
						<li> <a href="../member/myQna"> 나의 문의 </a></li>
					</ul>
				</span> |
				<a href="../login/logout"> 로그아웃 </a> |
			</c:if>
			고객센터
		</div>
	</header>
	<nav>
		<ul id="mainMenu">
			<li>
				<div id="cate" onmouseover="viewMenu()" onmouseout="hideMenu()"> ☰ 카테고리
					<ul id="daeMenu"></ul> <!-- 대분류메뉴 -->
				</div>
			</li>
			<li> 신상품 </li>
			<li> 베스트 </li>
			<li> 알뜰쇼핑 </li>
			<li> 특가/혜택 </li>
			<li> 샛별·하루 배송안내 </li>
		</ul>
	</nav> 
	  
<sitemesh:write property="body" />

	<div class="footer" style="color: white">
		<span>© 모든 권리 보유.</span>
	</div>
	
	<footer>
		<div class="footer-container">
			<div class="footer-logo">
				<img alt="logo" src="../static/resources/kurlylogo.png"  align="middle">
			</div>
			<div class="footer-info">
				<div>(주)구멍가게</div>
				<div>대표이사 아줌마</div>
				<div>본사 : 경기도 파주시 야당동</div>
				<div>사업자 등록번호 444-44-44444</div>
				<div>통신판매업신고 : 2023-경기쇼핑-1233</div>
			</div>
			<div class="footer-contact">
				<div>365고객센터</div>
				<div>080-888-1234(무료)</div>
				<div>email : shopmaster@mart.co.kr</div>
				<div>전화번호 010-1234-5678</div>
				<div>&nbsp;</div>
			</div>
		</div>
	</footer>
	
</body>
</html>