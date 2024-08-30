<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script>
  function srcview()
   {
	   document.getElementById("src").innerText=document.getElementsByTagName("body")[0].innerHTML;
   }
 
  function add()
  {
	  var len=document.getElementsByClassName("file").length;
	  
	  //var inner=document.getElementById("one").cloneNode(true); 
	  //document.getElementById("outer").appendChild(inner);
	  var one=document.getElementById("one");
	  var inner=one.cloneNode(true);
	  var outer=document.getElementById("outer");
	  outer.appendChild(inner);
	  
	  // 추가된 class="file"의 name을 지정
	  document.getElementsByClassName("file")[len].name="fname"+len;
	  document.getElementsByClassName("file")[len].value="";
  }
  function del()
  {
	  var len=document.getElementsByClassName("file").length;
	  document.getElementsByClassName("one")[len-1].remove();
  }
 </script>
</head>
<body> <!-- adminRoom/chuga4.jsp -->
   <input type="button" value="소스보기" onclick="srcview()">
   <input type="button" onclick="add()" value="추가">
   <input type="button" onclick="del()" value="삭제">
   <hr style="border-color:red">
    <div id="outer">
      <p class="one" id="one"> <input type="file" name="fname0" class="file"> </p>
    </div>  
   <hr style="border-color:red">
    <div id="src"></div>
</body>
</html>



