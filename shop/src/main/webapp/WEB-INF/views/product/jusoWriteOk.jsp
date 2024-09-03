<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	opener.document.getElementById("bname").innerText="${bname}";
	opener.document.getElementById("bjuso").innerText="${bjuso}";
	opener.document.getElementById("bphone").innerText="${bphone}"; 
	opener.document.getElementById("breq").innerText="${breq}";
	
	opener.document.getElementById("fbtn").addEventListener("click",opener.jusoChange());
	opener.document.getElementById("fbtn").value="배송지변경";
	
	close(); // 창닫기
</script>
</head>
<body> <!-- product/jusoWriteOk.jsp -->
  
</body>
</html>