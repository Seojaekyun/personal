<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	// 부모창을 새로 로딩하여 정보를 다시 읽기
	//opener.location.reload(); // 부모창 새로읽기
	window.onload=function() {
		// 부모창을 새로읽기 하지 않고 전달하기
		opener.document.getElementById("bname").innerText="${bname}";
		opener.document.getElementById("bjuso").innerText="${bjuso}";
		opener.document.getElementById("bphone").innerText="${bphone}";
		opener.document.getElementById("breq").innerText="${breq}";
		opener.document.gform.baeId.value=${id};
		
		opener.document.getElementById("fbtn").setAttribute("onclick","jusoChange()");
		opener.document.getElementById("fbtn").value="배송지변경";
		
		close(); // 창닫기
	}
</script>
</head>
<body> <!-- product/jusoWriteOk.jsp -->
  
</body>
</html>