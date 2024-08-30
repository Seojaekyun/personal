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
      width:300px;
      height:24px;
      border:1px solid green;
      outline:none;
   } 
   section textarea {
      width:300px;
      height:200px;
      border:1px solid green;
      outline:none;
   } 
   section input[type=button] {
      width:150px;
      height:28px;
      background:green;
      color:white;
      border:1px solid green;
   } 
   section input[type=submit] {
      width:304px;
      height:28px;
      background:green;
      color:white;
      border:1px solid green;
   } 
</style>
<script>
	function srcview() {
		document.getElementById("src").innerText=document.getElementsById("outer2").innerHTML;
	}
	function add() {
		var len=document.getElementsByClassName("file").length;
		
		var one=document.getElementById("one"); // p태그
		var inner=one.cloneNode(true);
		
		var outer2=document.getElementById("outer2");
		outer2.appendChild(inner);
		
		document.getElementsByClassName("file")[len].name="fname"+len;
		document.getElementsByClassName("file")[len].value="";
	}
	function del()
	{
		var len=document.getElementsByClassName("one").length;
		if(len>1)
			document.getElementsByClassName("one")[len-1].remove();
	}
	
</script>
</head>
<body>  <!-- tour/write.jsp -->
  <section>
    <form method="post" action="writeOk" enctype="multipart/form-data">
     <h3 align="center"> 여행 후기 등록 </h3>
     <div> <input type="text" name="title" placeholder="제 목"> </div>
     <div> <textarea name="content" placeholder="여행 후기"></textarea></div>
     <div>
       <input type="button" value="추가" onclick="add()">
       <input type="button" value="삭제" onclick="del()">
     </div>
     <div id="outer2">
       <p id="one" class="one"> 
         <input type="file" name="fname0" class="file"> 
       </p>
     </div>
     <div> <input type="submit" value="후기 등록"> </div>
    </form>
  </section>
</body>
</html>