<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section {
		width:1000px;
		margin:auto;
		margin-bottom:300px;
	}
	section table {
		border-spacing:0px; /* 셀과 셀 간격 == cellspacing */
	}
	section table td {
		border-bottom:1px solid green;
		padding:5px;
		height:35px;
	}
	section table tr:first-child td {
		border-top:2px solid green;
	}
	section table tr:last-child td {
		border-bottom:2px solid green;
	}
	section table input[type=text] {
		width:300px;
		height:24px;
		border:1px solid green;
		outline:none;
	}
	section table select {
		width:304px;
		height:28px;
		border:1px solid green;
		outline:none;
	}
	section table textarea {
		width:300px;
		height:200px;
		border:1px solid green;
		outline:none;
	}
	section table input[type=button] {
		width:150px;
		height:28px;
		background:green;
		color:white;
		border:1px solid green;
	}
	section table input[type=submit] {
		width:304px;
		height:28px;
		background:green;
		color:white;
		border:1px solid green;
	}
	section table .label {
		display:inline-block;
		font-size:12px;
		width:60px;
		height:24px;
		line-height:24px;
		border:1px solid green;
		color:white;
		text-align:center;
	}
</style>
<script>
	function srcview() {
		document.getElementById("src").innerText=document.getElementsByTagName("body")[0].innerHTML;
	}
	
	function add() {
		var len=document.getElementsByClassName("file").length;
		
		if(len<10) {
			var one=document.getElementById("one");
			var inner=one.cloneNode(true);  // p태그를 복사했다
			var outer=document.getElementById("outer"); // td태그
			outer.appendChild(inner); // td태그에 복사한 p태그를 추가
			
			document.getElementsByClassName("file")[len].name="fname"+len; // name을 다르게 주기위해
			document.getElementsByClassName("file")[len].value="";
			document.getElementsByClassName("img")[len].innerHTML="";
			
			document.getElementsByClassName("label")[len].setAttribute("for","fileUp"+len);
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
		var n=parseInt(my.name.substring(5));	// fname0  fname111
		for( var image of event.target.files ) {
			var reader=new FileReader();
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
	
	window.onload=function() {
		document.uform.min.value=${rdto.min};
		document.uform.max.value=${rdto.max};
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
		
		document.uform.delimg.value=delimg;
		document.uform.safeimg.value=safeimg;
		
		return true;
	}
	
</script>
</head>
<body> <!-- adminRoom/update.jsp -->
 
<section> 
	<form name="uform" method="post" action="updateOk" onsubmit="return check()" enctype="multipart/form-data">
	<input type="hidden" name="delimg">
	<input type="hidden" name="safeimg">
	<input type="hidden" name="id" value="${rdto.id}">
	<table width="600" align="center">
		<caption> <h3> 객실 등록 </h3></caption>
		<tr>
			<td> 객실명 </td>
			<td><input type="text" name="title" value="${rdto.title}"></td>
		</tr>
		<tr>
			<td> 최소인원 </td>
			<td>
				<select name="min">
					<option value="1"> 1명 </option>
					<option value="2"> 2명 </option>
					<option value="3"> 3명 </option>
					<option value="4"> 4명 </option>
					<option value="5"> 5명 </option>
					<option value="6"> 6명 </option>
					<option value="7"> 7명 </option>
					<option value="8"> 8명 </option>
				</select>
			</td>
		</tr>
		<tr>
			<td> 최대인원 </td>
			<td>   
				<select name="max">
					<option value="1"> 1명 </option>
					<option value="2"> 2명 </option>
					<option value="3"> 3명 </option>
					<option value="4"> 4명 </option>
					<option value="5"> 5명 </option>
					<option value="6"> 6명 </option>
					<option value="7"> 7명 </option>
					<option value="8"> 8명 </option>
				</select>
			</td>
		</tr>
		<tr>
			<td> 객실가격 </td>
			<td><input type="text" name="price" value="${rdto.price}"></td>
		</tr>
		<tr>
			<td> 객실요약 </td>
			<td><textarea name="content">${rdto.content}</textarea></td>
		</tr>
		<tr>
			<td rowspan="3"> 객실사진 </td>
			<td> <!-- 사진출력 --> 
				삭제하실 사진을 체크해주세요 <p>
				<c:forEach items="${imgs}" var="img">
				<input type="checkbox" value="${img}" class="imgList">
				<img src="../resources/room/${img}" width="50" height="30">
				</c:forEach>
			</td>
		</tr>
		<tr>
			<td>
				<input type="button" value="추가" onclick="add()"> 
				<input type="button" value="삭제" onclick="del()">
			</td>
		</tr>
		<tr>
			<td id="outer">
				<p class="one" id="one">
					<label for="fileUp0" class="label"> 사진추가 </label>
					<input id="fileUp0" style="width:0px;" type="file" name="fname0" class="file" onchange="miniView(this)">
					<span class="img"></span> <!-- 선택한 그림을 미리보기 --> 
				</p>  
			</td>
		</tr>
		<tr>
			<td> &nbsp; </td>
			<td><input type="submit" value="객실수정"></td>
		</tr>
	</table>
    </form> 
</section>

</body>
</html>