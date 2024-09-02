<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script>
   function up()  // su값을 증가
   {
	   var sus=parseInt(document.gform.sus.value);
	   if(sus<10)
	       document.gform.sus.value=++sus;
   }
   function down() // su값을 감소
   {
       var sus=parseInt(document.gform.sus.value);
	   if(sus>1)
	       document.gform.sus.value=--sus;
   }
 
 </script>
 <style>
   #outer {
       width:80px;
       height:48px;
       border:1px solid black;
       display:inline-block;
    }
    #outer #left {
       float:left;
       width:40px;
    }
    #outer #left input[type=text] {
       height:40px;
       margin-left:4px;
       border:none;
       outline:none;
       font-size:20px;
    }
  
   #outer #right {
       float:right;
       width:30px;
    }
 </style>
</head>
<body>
  <form name="gform">
   <div id="outer">
      <div id="left">
         <input type="text" name="sus" size="1" value="1">
      </div>
      <div id="right">
         <input type="button" value="△" onclick="up()"><br>
         <input type="button" value="▽" onclick="down()">
      </div>
   </div>
  </form>


</body>
</html>