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
  function addTag()
  {
	  var new1=document.createElement("li");
	  new1.appendChild(document.createTextNode("전가복"));
	  
	  // 생성된 요소를 뒤에 붙이기
	  //document.getElementById("aa").appendChild(new1);
	  
	  // 생성된 요소를 특정구성요소 이전에 추가
	  var aa=document.getElementById("aa");
	  aa.insertBefore(new1, document.getElementsByTagName("li")[1]);
  }
  function delTag()
  {
	  // removeChild => 부모요소내의 자식노드를 삭제
	  var aa=document.getElementById("aa");
	  aa.removeChild(aa.childNodes[0]);
  }
  function lengthTag()
  {
	  alert( document.getElementById("aa").childNodes.length );
  }
  function rep()
  {
	  var old=document.getElementById("aa").childNodes[2];
	  var new1=document.createTextNode("육개장");
	  
	  old.replaceChild(new1, old.childNodes[0]);	  
  }
 </script>
</head>
<body> <!-- adminRoom/chuga2.jsp -->
  <input type="button" value="소스보기" onclick="srcview()">
  <input type="button" value="요소추가" onclick="addTag()">
  <input type="button" value="요소삭제" onclick="delTag()">
  <input type="button" value="요소길이" onclick="lengthTag()">
  <input type="button" value="요소내용교체" onclick="rep()">
  <hr>
  <ul id="aa"><li> 짜장면 </li><li> 짬 뽕 </li><li> 탕수육 </li><li> 팔보채 </li></ul>
  
  
  <hr style="border-color:red">
  <div id="src"></div>
</body>
</html>