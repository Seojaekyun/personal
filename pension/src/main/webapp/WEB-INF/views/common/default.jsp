<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="kr.co.pension.util.Utils" %>
<% Utils.getRooms(request); %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	@font-face {
		font-family: 'GmarketSansMedium';
		src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
		font-weight: normal;
		font-style: normal;
	}
	body {
		margin:0px;
	}
	#outer {
		width:100%;
		height:40px;
		background:green;
	}
	#outer #first {
		width:1000px;
		height:40px;
		line-height:40px;
		margin:auto;
		background:green;
		text-align:center;
		color:white;
		font-family: 'GmarketSansMedium';
	}
	#outer #first #left {
		width:960px;
		float:left;
	}
	#outer #first #right {
		width:40px;
		float:right;
	}
	header {
		width:1000px;
		height:80px;
		line-height:60px;
		margin:auto;
		font-family: 'GmarketSansMedium';
	}
	header a {
		text-decoration:none;
		color:black;
	}
	header a:hover {
		text-decoration:underline;
		color:green;
	}
	header #left {
		width:400px;
		height:80px;
		display:inline-block;
		text-align:left;
	}
	header #right {
		width:590px;
		height:60px;
		display:inline-block;
		text-align:right;
	}
	header #right #myInfo{
		position:relative;
	}
	header #right #myInfo #myMenu { /* ul태그 */
		position:absolute;
		padding-left:0px;
		left:-10px;
		top:0px;
		width:100px;
		height:80px; 
		z-index:10;
		background:white;
		visibility:hidden;
	}
	header #right #myInfo #myMenu li {
		list-style-type:none;
		width:100px;
		
		line-height:26px;
		text-align:center;
		border:1px solid black;
		border-bottom:none;
		background:white;
	}
	header #right #myInfo #myMenu li:last-child {
		border-bottom:1px solid black;
	}
	header #right #comInfo{
		position:relative;
	}
	header #right #comInfo #comMenu { /* ul태그 */
		position:absolute;
		padding-left:0px;
		left:0px;
		top:0px;
		width:100px;
		height:80px; 
		z-index:10;
		background:white;
		visibility:hidden;
	}
	header #right #comInfo #comMenu li {
		list-style-type:none;
		width:100px;
		height:26px;
		line-height:26px;
		text-align:center;
		border:1px solid black;
		border-bottom:none;
	}
	header #right #comInfo #comMenu li:last-child {
		border-bottom:1px solid black;
	}
	nav {
		width:1000px;
		height:50px;
		line-height:50px;
		margin:auto;
		font-family: 'GmarketSansMedium';
	}
	nav a {
		text-decoration:none;
		color:black;
	}
	nav a:hover {
		text-decoration:underline;
		color:green;
	}
	nav #main {
		padding-left:0px;
		margin-left:30px;
	}
	nav #main > li { /* 주메뉴 */
		display:inline-block;
		list-style-type:none;
		width:150px;
		height:50px;
		line-height:50px;
		/* border:1px solid black; */
		text-align:center;
		font-weight:900;
		position:relative;
	}
	nav #main > li > .menu { /* 하위메뉴 ul태그 */
		padding-left:0px;
		position:absolute;
		left:0px;
		top:48px;
		background:white;
		visibility:hidden;
	}
	nav #main > li > .menu > li { /* 하위메뉴내의 메뉴 */
		list-style-type:none;
		width:150px;
		height:35px;
		line-height:35px;
	}
	section {
		font-family: 'GmarketSansMedium';
	}
	footer {
		padding-top:10px;
		padding-bottom:5px;
		width:100%;
		height:130px;
		margin:auto;
		font-family: 'GmarketSansMedium';
		margin-top:30px;
		font-size:13px;
		background:#9AB973;
		color:white;
	}
</style>
<script>
	function viewMenu(n) {
		document.getElementsByClassName("menu")[n].style.visibility="visible";
	}
	
	function hideMenu(n) {
		document.getElementsByClassName("menu")[n].style.visibility="hidden";
	}
	
	var h=40;
	function hideX() {
		ss=setInterval(function() {
			h--;
			document.getElementById("first").style.height=h+"px";
			document.getElementById("outer").style.height=h+"px";
			
			if(h==0) {
				document.getElementById("outer").style.display="none";
				clearInterval(ss);
			}
		},10);
	}
	
	function viewMy() {
		document.getElementById("myMenu").style.visibility="visible";
	}
	
	function hideMy() {
		document.getElementById("myMenu").style.visibility="hidden";
	}
	
	function viewCom() {
		document.getElementById("comMenu").style.visibility="visible";
	}
	
	function hideCom() {
		document.getElementById("comMenu").style.visibility="hidden";
	}
	
	function outCheck() {
		if(confirm("정말 회원 탈퇴 신청을 하시겠습니까?")) {	   
			location="../member/outMember";
		}
	}
	
	function clsCheck() {
		if(confirm("회원 탈퇴 신청을 취소 하시겠습니까?")) {	   
			location="../member/clsMember";
		}
	}
</script>
 <decorator:head/>
</head>
<body> <!-- index.jsp -->
	<div id="outer">
		<div id="first"> 
			<div id="left" class="first"> 오픈 기념! 2연박하면 1박이 공짜! </div> 
			<div id="right" class="first"> <span onclick="hideX()" style="cursor:pointer"> X </span> </div>
		</div>
	</div>
	<header> 
		<div id="left"> <a href="../main/index"> <img src="../resources/Alogo.png" width="30%" valign="middle"> </a> </div>
		<div id="right"> 
			<c:if test="${userid==null}">  
				<a href="../member/login"> 로그인 </a> | 
				<a href="../member/member"> 회원가입 </a> | 
			</c:if>
			<c:if test="${userid=='admin'}">        
				<a href="../adminRoom/list"> 객실관리 </a> |
				<a href="../adminRoom/reserveList"> 예약관리 </a> |
				<a href="../adminRoom/inquiryList"> 문의관리 </a> |
				<a href="../adminRoom/memberList"> 회원관리 </a> |
				<span id="comInfo" onmouseover="viewCom()" onmouseout="hideCom()"> 커뮤니티관리 |
					<ul id="comMenu">
						<li><a href="../gongji/list"> 공지사항 </a></li>
						<li><a href="../tour/list"> 여행후기 </a></li>
						<li><a href="../board/list"> 회원게시판 </a></li>
					</ul>
				</span>
				<a href="../member/logout"> 로그아웃 </a>            
			</c:if>
			<c:if test="${userid!=null&&userid!='admin'}">
				<span id="myInfo" onmouseover="viewMy()" onmouseout="hideMy()"> ${name}님
					<ul id="myMenu">
						<li><a href="../member/memberView"> 회원정보 </a></li>
						<li><a href="../member/reserveList"> 예약정보 </a></li>
						<li><a href="../member/myWrite"> 나의 글 </a></li>
					<c:if test="${state!=2 && state!=4}">	
						<li><a href="javascript:outCheck()"> 회원탈퇴 </a></li>
					</c:if>
					<c:if test="${state==2 }"> 
						<li> 탈퇴신청중 <br><a href="javascript:clsCheck()"> 복구신청 </a></li>
					</c:if>
					<c:if test="${state==4 }"> 
						<li> 복구요청중 </li>
					</c:if>
					</ul>
				</span> |
				<a href="../member/logout"> 로그아웃 </a> |
			</c:if>
			<c:if test="${userid!='admin'}">
				<a href="../inquiry/write">문의하기</a>
			</c:if>
		</div> 
	</header>
	<c:if test="${userid!='admin'}">
	<nav>    
		<ul id="main">
			<li onmouseover="viewMenu(0)" onmouseout="hideMenu(0)"> 펜션소개 
				<ul class="menu">
					<li> 펜션지기 </li>
					<li> 오시는길 </li>
					<li> ?????? </li>
				</ul>
			</li>
			<li onmouseover="viewMenu(1)" onmouseout="hideMenu(1)"> 주변볼거리 
				<ul class="menu">
					<li> 호수공원 </li>
					<li> 킨 텍 스 </li>
					<li> 한류월드 </li>
					<li> 서 오 능 </li>
				</ul>
			</li>
			<li onmouseover="viewMenu(2)" onmouseout="hideMenu(2)"> 주변맛집 
				<ul class="menu">
					<li> 대 동 관 </li>
					<li> 버 거 킹 </li>
					<li> 서 가 원 </li>
					<li> 김밥천국 </li>
				</ul>
			</li>
			<li onmouseover="viewMenu(3)" onmouseout="hideMenu(3)"> 객실현황 
				<ul class="menu" id="roomMenu">
					<c:forEach items="${rlist}" var="rdto">
						<li> <a href="../room/roomView?id=${rdto.id}"> ${rdto.title} </a> </li>
					</c:forEach>
				</ul>
			</li>
			<li onmouseover="viewMenu(4)" onmouseout="hideMenu(4)"> 예약관련 
				<ul class="menu">
					<li> 예약 안내 </li>
					<li><a href="../reserve/reserve"> 실시간 예약 </a></li>
				</ul>
			</li>
			<li onmouseover="viewMenu(5)" onmouseout="hideMenu(5)"> 커뮤니티
				<ul class="menu">
					<li><a href="../gongji/list"> 공지사항 </a></li>
					<li><a href="../tour/list"> 여행후기 </a></li>
					<li><a href="../board/list"> 회원게시판 </a></li>
				</ul>
			</li>
		</ul>
	</nav>
	</c:if>
 <decorator:body/>
	
	<footer>
		<table width="1000" align="center">
			<tr>
				<td rowspan="5" width="200"></td>
				<td rowspan="5"><img alt="logo" src="../resources/Alogo.png" width="90" align="middle"></td>
				<td> 상호명 : 어펜션스 </td>
				<td> 365고객센터 </td>
			</tr>
			<tr>
				<td> 대표이사 : 주인장 </td>
				<td> 080-888-1234(무료) </td>
			</tr>
			<tr>
				<td> 본사 : 경기도 파주시 야당동 </td>
				<td> email : Emaster@earth.co.kr </td>
			</tr>
			<tr>
				<td> 사업자 등록번호 : 444-44-44444 </td>
				<td> 전화번호 : 010-1234-5678 </td>
			</tr>
			<tr>
				<td> 통신판매업신고 : 2023-경기환경-1234 </td>
				<td> </td>
			</tr>
		</table>
	</footer>
</body>
</html>