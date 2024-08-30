<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>白원 Mall</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@100..900&display=swap');
	body {
		margin: 0px;
		font-family: "Hahmlet", serif;
		font-optical-sizing: auto;
		font-weight: <weight>;
		font-style: normal;
	}
	article {
		width: 1500px;
		height: 350px;
		margin: auto;
		background: lightpink;
		overflow: hidden;
	}
	article #inner {
		width:10000px;
	}
	main {
		width: 1100px;
		margin: auto;
	}
	main #p1 {
		width: 1100px;
		height: 500px;
		margin: auto;
		background: #94FF8C;
	}
	main #p2 {
		width: 1100px;
		height: 500px;
		margin: auto;
		background: #FFB8A6;
	}
	main #p3 {
		width: 1100px;
		height: 500px;
		margin: auto;
		background: #FDFD96;
	}
	main #p4 {
		width: 1100px;
		height: 500px;
		margin: auto;
		background: #C4F4FF;
	}
	

</style>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
	$(function() {
		setInterval(function() {
			$("#inner").animate( {
				marginLeft:"-1500px"
			}, 1500, function() {
				$("#inner").css("margin-left", "0px");
				$(".mimg").eq(0).insertAfter($(".mimg").eq(5));
			});
		}, 3500);
	});
</script>
<script>
	
</script>
</head>
<body><!-- main/index.jsp -->
	<article>
		<div id="inner">
			<img class="mimg" src="../static/main/s2.png" width="1500" height="350"><img class="mimg" src="../static/main/s3.png" width="1500" height="350"><img class="mimg" src="../static/main/s4.png" width="1500" height="350"><img class="mimg" src="../static/main/s5.png" width="1500" height="350"><img class="mimg" src="../static/main/s6.png" width="1500" height="350"><img class="mimg" src="../static/main/s7.png" width="1500" height="350">
		</div>
	</article>
	<main>
		<section id="p1"></section>
		<section id="p2"></section>
		<section id="p3"></section>
		<section id="p4"></section>	
	</main>
</body>
</html>