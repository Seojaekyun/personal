<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section {
		width:1000px;
		height:600px;
		margin:auto;
	}
	section div {
		text-align:center;
		margin-top:10px;
	}
	section input[type=text] {
		width:500px;
		height:28px;
		border:1px solid green;
		outline:none;
	}
	section  textarea {
		width:500px;
		height:200px;
		border:1px solid green;
		outline:none;
	}
	section input[type=button] {
		width:250px;
		height:30px;
		background:green;
		color:white;
		border:1px solid green;
	}
	section input[type=file] {
		width:0px;
	}
	section input[type=submit] {
		width:506px;
		height:30px;
		background:green;
		color:white;
		border:1px solid green;
	}
	section .label {
		border:1px solid green;
		padding:3px;
		padding-left:5px;
		padding-top:5px;
		color:green;
	}
</style>
<script>
	function srcview() {
		document.getElementById("src").innerText=document.getElementById("outer2").innerHTML;
	}
	
	function add() {
		var len=document.getElementsByClassName("file").length;
		var one=document.getElementById("one"); // p태그
		var inner=one.cloneNode(true);
		var outer2=document.getElementById("outer2");
		outer2.appendChild(inner);
		// 새로 생성된 class="file" 요소의 name을 기존의 값과 다르게  => 바로 이전의 값보다 1이 크게
		// 새로 생성되기전의 class="file"의 length를 fname뒤에 추가
		document.getElementsByClassName("file")[len].name="fname"+len;
		document.getElementsByClassName("file")[len].value="";
		// 새로 추가될때 cloneNode에 값이 있을경우
		document.getElementsByClassName("img")[len].innerHTML="";
		// class="label"의 for속성을 "fileUp"+len
		document.getElementsByClassName("label")[len].setAttribute("for","fileUp"+len);
		// class="file"의 id속성 "fileUp"+len
		document.getElementsByClassName("file")[len].id="fileUp"+len;
	}
	
	function del() {
		// class="one"인 요소의 마지막 인덱스를 지운다
		var len=document.getElementsByClassName("one").length; 
		if(len>1) // 최소한 1개를 업로드할 수 있게
			document.getElementsByClassName("one")[len-1].remove();
	}
	
	function check() {
		var delimg="";  // 삭제할 이미지
		var safeimg=""; // 삭제하지 않는 이미지
		var imgList=document.getElementsByClassName("imgList");
		
		for(i=0;i<imgList.length;i++) {
			if(imgList[i].checked) {
				delimg=delimg+imgList[i].value+"/";
			}	  
			else {
				safeimg=safeimg+imgList[i].value+"/";
			}
		}
		//alert(delimg+"\n"+safeimg);
		// delimg, safeimg를 서버에 전송
		document.uform.delimg.value=delimg;
		document.uform.safeimg.value=safeimg;
		
		return true;
	}
	
	function miniView(my) {
		var n=parseInt(my.name.substring(5));	// fname0  fname111
		//alert(n);
		for(var image of event.target.files) {
			var reader=new FileReader();
			// class="img"인 요소에 그림을 넣기
			reader.onload=function() {
				var new1=document.createElement("img");
				new1.setAttribute("src",event.target.result);
				new1.setAttribute("width","40");
				new1.setAttribute("valign","middle");
				
				if(document.getElementsByClassName("img")[n].innerHTML!="") {
					document.getElementsByClassName("img")[n].innerHTML="";
				}
				
				document.getElementsByClassName("img")[n].appendChild(new1);
			};
			
			reader.readAsDataURL(image);
		}
	}
</script>
</head>
<body> <!-- tour/update.jsp -->
<!-- <input type="button" value="소스보기" onclick="srcview()">
  <div id="src"></div> -->
<section>
	<form name="uform" method="post" action="updateOk" onsubmit="return check()" enctype="multipart/form-data">
	<input type="hidden" name="delimg">
	<input type="hidden" name="safeimg">
	<input type="hidden" name="id" value="${tdto.id}">
	<h3 align="center"> 여행 후기 등록 </h3>
		<div><input type="text" name="title" placeholder="제 목" value="${tdto.title}"></div>
     	<div><textarea name="content" placeholder="후기 내용">${tdto.content}</textarea></div>
		<div id="imgs">
			삭제하실 사진을 체크해주세요 <p>
			<c:forEach items="${timg}" var="img">
			<input type="checkbox" value="${img}" class="imgList">
			<img src="../static/resources/tour/${img}" width="60" height="40">
			</c:forEach>
		</div>
		<div>
			<input type="button" value="추가" onclick="add()">
			<input type="button" value="삭제" onclick="del()">
		</div>
		<div id="outer2">
			<p id="one" class="one"> 
				<label for="fileUp0" class="label"> 사진등록 </label>
				<input type="file" id="fileUp0" name="fname0" class="file" onchange="miniView(this)"> 
				<span class="img"></span>
			</p>       
		</div>
		<div><input type="submit" value="후기 수정"></div>
	</form>
</section>
</body>
</html>