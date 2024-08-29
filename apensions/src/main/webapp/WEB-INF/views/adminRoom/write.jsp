<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section {
		width:1000px;
		margin:auto;
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
		var n=parseInt(my.name.substring(5));	// fname0  fname111
		//alert(n);
		for( var image of event.target.files ) {
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
<body> <!-- adminRoom/write --> 
<!-- <input type="button" value="소스" onclick="srcview()">
  <div id="src"></div> -->
<section> 
	<form method="post" action="writeOk" enctype="multipart/form-data">
	<table width="600" align="center">
		<caption> <h3> 객실 등록 </h3><br></caption>
		<tr>
			<td> 객실명 </td>
			<td><input type="text" name="title"></td>
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
			<td><input type="text" name="price"></td>
		</tr>
		<tr>
			<td> 객실요약 </td>
			<td><textarea name="content">	</textarea></td>
		</tr>
		<tr>
			<td rowspan="2"> 객실사진 </td>
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
					<span class="img"></span><!-- 선택한 그림을 미리보기 -->
				</p>
			</td>
		</tr>
		<tr>
			<td> &nbsp; </td>
			<td><input type="submit" value="객실등록"> | <a href="list">돌아가기</a>
		</tr>
	</table>
	</form> 
</section>
<!-- <input id="abc" type="checkbox"> <label for="abc">여기를 클릭하세요</label> -->
</body>
</html>