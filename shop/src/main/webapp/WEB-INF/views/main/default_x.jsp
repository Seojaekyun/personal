<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>白원 Mall</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@100..900&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Gugi&display=swap');
	body {
		margin: 0px;
		font-family: "Hahmlet", serif;
		font-optical-sizing: auto;
		font-weight: <weight>;
		font-style: normal;
	}
	#ads {
		width: 100%;
		height: 40px;
		background: #8F00FF;
	}
	#ads #first {
		width: 1100px;
		height: 40px;
		margin: auto;
	}
	#ads #first #left {
		width: 650px;
		height: 40px;
		line-height: 40px;
		float:left;
		text-align: right;
		color: white;
		font-weight: bold;
	}
	#ads #first #right {
		width: 450px;
		height: 40px;
		line-height: 40px;
		float: left;
		text-align: center;
		color: gray;
	}
	header {
		width: 1100px;
		height: 70px;
		line-height: 50px;
		margin: auto;
	}
	header #logo {
		width: 300px;
		height: 70px;
		line-height: 40px;
		float: left;
	}
	header #search {
		width: 500px;
		height: 70px;
		float: left;
	}
	header #search #searchForm {
		width: 450px;
		height: 40px;
		line-height: 40px;
		border: 1px solid purple;
		margin-top: 15px;
		border-radius: 10px;
	}
	header #search #searchForm #searchTxt {
		width: 370px;
		margin-left: 14px;
		border: none;
		outline: none;
		font-size:15px;
	}
	header #search #searchForm #xx {
		visibility: hidden;
		cursor: pointer;
	}
	header #member {
		width: 300px;
		height: 70px;
		line-height: 70px;
		float: left;
	}
	nav {
		width:1100px;
		height:50px;
		line-height:50px;
		margin:auto;
		font-family:'Gugi';
	}
	nav #cate {
		position: relative;
		display: block;
		background: red;
		width: 100px;
		height: 50px;
	}
	nav #daeMenu {
		position: absolute;
		left: 0px;
		top: 50px;
		padding-left: 0px;
		width:100px;
		height:210px;
	}
	nav #daeMenu > li {
		list-style-type: none;
		width: 100px;
		height: 30px;
		line-height:30px;
		text-align: center;
		background: white;
		cursor: pointer;
		position: relative;
	}
	nav > #daeMenu > li > .jungMenu {
		position: absolute;
		left: 100px;
		top: 0px;
		padding-left: 0px;
		background: white;
	}
	nav > #daeMenu > li .jungMenu > li {
		list-style-type: none;
		width: 100px;
		height: 30px;
 
	}
	nav > #mainMenu {
		padding-left:0px;
	}
	nav > #mainMenu > li {
		list-style-type:none;
		display:inline-block;
		width:170px;
		height:50px;
		line-height:50px;
		text-align:center;
	}
	nav > #mainMenu > li:first-child {
		width:220px;
		text-align:left;
	}
	footer {
		width: 1100px;
		height: 150px;
		margin: auto;
	}
	a {
		text-decoration: none;
		color: purple;
		font-weight: bold;
	}
</style>
<script>
	function viewSrc() {
		document.getElementById("src").innerText=document.getElementsByTagName("html")[0].innerHTML;
	}
	
	function xCheck(val) {
		if(val.length==0) {
			document.getElementById("xx").style.visibility="hidden";
		}
		else {
			document.getElementById("xx").style.visibility="visible";
		}
	}
	
	function clearTxt() {
		document.getElementById("searchTxt").value="";
		xCheck("");
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
					str=str+"<li onmouseover='jungView("+dae.code+")' onmouseout='jungHide("+dae.code+")'> "+dae.name+" <ul class='jungMenu'></ul></li>";
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
	
	var jungEx=new Array(100);
	for(i=0;i<jungEx.length;i++) {
		jungEx[i]=0;
	}
	
	function jungView(daecode) {
		document.getElementsByClassName("jungMenu")[daecode-1].style.display="block";
		
		 
		if(jungEx[daecode-1]==0) {
			 
			var chk=new XMLHttpRequest();
			chk.onload=function() {
				//alert(chk.responseText);
				var jungAll=JSON.parse(chk.responseText);
				var str="";
				for(jung of jungAll) {
					str=str+"<li> "+jung.name+" </li>";
				}
				
				document.getElementsByClassName("jungMenu")[daecode-1].innerHTML=str;
			}
			
			chk.open("get", "getJung?daecode="+daecode);
			chk.send();
			
			jungEx[daecode-1]=1;
		}
		 
	}
	
	function jungHide(daecode) {
		document.getElementsByClassName("jungMenu")[daecode-1].style.display="none";
	}
	
	
</script>

<sitemesh:write property="head"/>

</head>
<body><!-- default.jsp -->
<input type="button" value="소스보기" onclick="viewSrc()">
 
<div id="src"></div>
	<div id="ads">
		<div id="first">
			<div id="left"> 회원가입 후 첫 주문시 100만원! </div>
			<div id="right"> ⓧ </div>
		</div>
	</div>
	<header>
		<div id="logo"><img src="../static/main/mlogo.png" width="60%" valign="middle"></div>
		<div id="search">
			<div id="searchForm">
				<input type="text" name="search" onkeyup="xCheck(this.value)" id="searchTxt" placeholder="검색어를 입력하세요">
				<img src="../static/main/x.png" valign="middle" id="xx" onclick="clearTxt()">
				<img src="../static/main/s.png" valign="middle">
			</div>
		</div>
		<div id="member">
			<c:if test="${userid == null}">
			<a href="../member/member">회원가입</a> | 
			<a href="../login/login">로그인</a> | 
			</c:if>
			<c:if test="${userid != null}">
			${name}님 | 
			나의메뉴 | 
			<a href="../login/logout"> 로그아웃 </a> | 
			</c:if>
			고객센터
		</div>
	</header>
	<nav>
		<ul id="mainMenu">
			<li>
				<span id="cate" onmouseover="viewMenu()"  onmouseout="hideMenu()">
					<img src="../static/main/3.png" valign="middle"> 카테고리 
					<ul id="daeMenu"></ul>
				</span>
			</li>
			<li> 신상품 </li>
			<li> 특가상품 </li>
			<li> 베스트 </li>
			<li> 이벤트 </li>
			<li> 일일특가 </li>
		</ul>
	</nav>
	
	<sitemesh:write property="body"/>
	
	<footer>
		<img src="../static/main/footer.png">
	</footer>
</body>
</html>