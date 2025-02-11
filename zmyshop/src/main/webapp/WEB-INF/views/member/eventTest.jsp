<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>me</title>
<style>
	#pkc {
		width:200px;
		height:200px;
		border:1px solid red;
	}
</style>
<script>
	function aa(e) {
		alert("a");
		//event.preventDefault();
		event.stopPropagation();
	}
	
	function bb() {
		alert("b");
	}
	document.onclick=bb;
	
</script>

</head>
<body>
	<!-- <div id="pkc" onclick="aa()"> </div> -->
	<a href="#" onclick="aa()">클릭</a>
</body>
</html>