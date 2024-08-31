<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <style>
  section {
      width:1000px;
      height:700px;
      margin:auto;
   }
   section div {
      width:400px;
      margin:auto;
      height:40px;
   }
   section #con {
      height:200px;
      overflow:auto;
   }
   section #first {
      width:570px;
      height:310px;
      font-size:24px;
    }
    #reser {
    	width:105px;
    	height:45px;
    	border-radius:5px;
    	font-size:20px
    }
</style>
<script>
	var imgs=[${imsi}];  // ["그림파일1","그림파일2","그림파일3"]
	var num=0;
	
	function move(n){
		// 오른쪽이동인지 왼쪽이동인지
		/* if(n==0)
			num--;
			else
				num++; */
		num=num+n;
		
		if(num<0)
			num=imgs.length-1;
		
		if(num>=imgs.length)
			num=0;
		
		document.getElementById("mImg").src="../static/resources/room/"+imgs[num];
	}
	
</script>
</head>
<body> <!-- room/roomView.jsp -->
<section>
	<h3 align="center"> ${rdto.title}객실 현황</h3>
	<div id="first">
		<!-- <span onclick="moveLeft()"> ◀ </span> -->
		<span onclick="move(-1)"> ◀ </span>
		<img src="../static/resources/room/${rdto.rimg}" id="mImg" width="500" height="300" valign="middle">
		<span onclick="move(1)"> ▶ </span>
		<!-- <span onclick="moveRight()"> ▶ </span> -->
	</div> <!-- 사진 -->
	<div> 최소인원 : ${rdto.min}명 | 최대인원 : ${rdto.max}명 </div>
	<div> 1박 가격 : ${rdto.price2}원 </div>
	<div id="con"> ${rdto.content}</div>
	<div align="center"><a href="../reserve/reserve"><input type="button" id="reser" value="예약하기"></a>
</section>
</body>
</html>