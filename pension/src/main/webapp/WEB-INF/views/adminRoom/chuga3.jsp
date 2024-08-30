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
	  
	  // id="aa"인 요소에 input태그 추가하기
	  var new1=document.createElement("input");
	  new1.setAttribute("type","file");
	  new1.setAttribute("name","fname"+len);
	  new1.setAttribute("class","file");
 	  
	  document.getElementById("aa").appendChild(new1);
 
  }
  function del()
  {
	  // class="file"의 길이
	  var len=document.getElementsByClassName("file").length;
	  
	  // 삭제는 무조건 마지막 요소를 지우기
	  // class="file"인 요소의 마지막 인덱스를 알아내야 된다.
	  document.getElementsByClassName("file")[len-1].remove();
  }
 </script>
</head>
<body>
   <input type="button" value="소스보기" onclick="srcview()">
   <input type="button" onclick="add()" value="추가">
   <input type="button" onclick="del()" value="삭제">
   <hr style="border-color:red">
    <div id="aa">
      <input type="file" name="fname0" class="file">
    </div>
    
    <hr style="border-color:red">
    <div id="src"></div>
</body>
</html>