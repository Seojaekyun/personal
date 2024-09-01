<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Diphylleia&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>수정</title>
<style>
	body {
		background-color: #E0F7E9;
		font-family: 'Diphylleia', sans-serif;
		color: #333;
	}
	#title, #name, #pwd, #content {
		border: 1px solid #2F855A;
		outline: none;
		border-radius: 5px;
		padding: 5px;
	}
	#content {
		width: 513px;
	}
	#title, #name, #pwd {
		height: 30px;
	}
	#nick {
		text-align: center;
		width:100px;
	}
	#content {
		height: 200px;
	}
	#title:focus, #name:focus, #pwd:focus, #content:focus {
		border-color: red;
	}
	#submit {
		border-radius: 10px;
		width: 150px;
		height: 35px;
		background: #2F855A;
		border: none;
		color: white;
		cursor: pointer;
		font-weight: bold;
	}
	#submit:hover {
		background: #276749;
	}
	table {
		border-spacing: 0px;
		width: 700px;
		margin: auto;
		background: white;
		border-radius: 5px;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	}
	table td {
		border-bottom: 1px solid black;
		padding: 5px;
		height: 50px;
	}
	tr {
		align: center;
	}
	table tr:first-child td {
		border-top: 2px solid black;
	}
	table tr:last-child td {
		border-bottom: 2px solid black;
	}
	caption {
		font-size: 1.5em;
		font-weight: bold;
		color: #2F855A;
		margin: 20px 0;
	}
	.errmsg {
		font-size: 12px;
		color: red;
	}

</style>
<script>
	function add() {
		var len=document.getElementsByClassName("file").length;
		if(len<10) {
			//var inner=document.getElementById("one").cloneNode(true); 
			//document.getElementById("outer").appendChild(inner);
			var one=document.getElementById("one");
			var inner=one.cloneNode(true);  // p태그를 복사했다
			var outer=document.getElementById("outer"); // td태그
			outer.appendChild(inner); // td태그에 복사한 p태그를 추가
			
			// 추가된 class="file"의 name을 지정
			document.getElementsByClassName("file")[len].name="fname"+len; // name을 다르게 주기위해
			document.getElementsByClassName("file")[len].value="";
			// 새로 추가될때 cloneNode에 값이 있을경우
			document.getElementsByClassName("img")[len].innerHTML="";
			
			// class="label"의 for속성을 "fileUp"+len
			document.getElementsByClassName("label")[len].setAttribute("for","fileUp"+len);
			// class="file"의 id속성 "fileUp"+len
			document.getElementsByClassName("file")[len].id="fileUp"+len;
		}
	}
	
	function del() {
		var len=document.getElementsByClassName("file").length;
		if(len>1) {
			document.getElementsByClassName("one")[len-1].remove();
		}
	}

	function miniView(my) {
		var n=parseInt(my.name.substring(5));	   // fname0  fname111
		//alert(n);
		for( var image of event.target.files ) {
			var reader=new FileReader();
			// class="img"인 요소에 그림을 넣기
			reader.onload=function() {
				var new1=document.createElement("img");
				new1.setAttribute("src",event.target.result);
				new1.setAttribute("width","80");
				new1.setAttribute("valign","middle");
				
				if(document.getElementsByClassName("img")[n].innerHTML!="") {
					document.getElementsByClassName("img")[n].innerHTML="";
				}
				document.getElementsByClassName("img")[n].appendChild(new1);
			};
			reader.readAsDataURL(image);
		}	  
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
</script>
</head>
<body>
<form method="post" action="updateOk" enctype="multipart/form-data">
	<input type="hidden" name="name" id="name" value="${name }">
	<input type="hidden" name="id" value="${bdto.id }">
	<input type="hidden" name="page" value="${page}">
	<input type="hidden" name="rec" value="${rec}">
	<table>
		<caption>수 정</caption>
		<tr>
			<td id="nick">제 목</td>
			<td><input type="text" name="title" id="title" value="${bdto.title }"></td>
			<td id="nick">비밀번호</td>
			<td>
				<input type="password" name="pwd" id="pwd">
				<c:if test="${not empty param.err }">
					<span class="errmsg">비밀번호 오류</span>
				</c:if>
			</td>
		</tr>
		<tr>
			<td id="nick">내 용</td>
			<td colspan="3"><textarea name="content" id="content">${bdto.content }</textarea></td>
		</tr>
		<tr>
	        <td colspan="4" id="nick">사진등록</td>
	    </tr>
	    <tr>
			<td colspan="4"> <!-- 사진출력 --> 
			삭제하실 사진을 체크해주세요 <p>
			<c:forEach items="${imgs}" var="img">
			<input type="checkbox" value="${img}" class="imgList">
			<img src="resources/pich/${img}" width="80" height="30">
			</c:forEach>
			</td>
		</tr>
	    <tr>
	        <td id="nick">
				<input type="button" value="추가" onclick="add()"><br>
	            <input type="button" value="삭제" onclick="del()">
	        </td>
           	<td id="outer" colspan="3">
				<p class="one" id="one">
					<label for="fileUp0" class="label"> 사진추가 </label>
					<input id="fileUp0" style="width:0px;" type="file" name="fname0" class="file" onchange="miniView(this)">
					<span class="img"></span> <!-- 선택한 그림을 미리보기 --> 
	            </p>  
         	</td>
        </tr>
		<tr align="center">
			<td colspan="4">
				<input type="submit" value="수정" id="submit">
				<a href="content?id=${bdto.id }&page=${page }&rec=${rec }"><input type="button" value="취소" id="submit" style="background: white; color: #2F855A; border: 1px solid #2F855A;"></a>
			</td>
		</tr>
	</table>
</form>
</body>
</html>