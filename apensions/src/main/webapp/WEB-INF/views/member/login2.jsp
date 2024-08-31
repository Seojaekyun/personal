<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
      text-align:center;
   }
   section > form > div {
      
      position:relative;
      width:500px;
      height:60px;
      border:1px solid green;
      margin:auto;
      margin-top:10px;
      text-align:left;
   } 
   
   section > form > div > .inner {
      position:absolute;
      left:10px;
      top:17px;
      font-size:22px;
      opacity:0.6;
   }
   section div input {
      border:none;
      outline:none;
      margin-top:30px;
      margin-left:10px;
      font-size:16px;
      background:yellow;
   }
   
   section #txt {
      width:400px;
      height:25px;
   }
   section #pwd  {
      width:400px;
      height:25px;
   }
   section #sub {
      width:500px;
      height:60px;
      background:green;
      color:white;
      border:none;
      font-size:19px;
      font-family: 'GmarketSansMedium';
   }
  </style>
  <script>
    function check(my) // my=document.form
    {
        if(my.userid.value.trim().length==0)
        {
        	alert("아이디를 입력하세요");
        	return false;
        }	
        else if(my.pwd.value.trim().length==0)
        	 {
        	     alert("비밀번호를 입력하세요");
        	     return false;
        	 }
             else
            	 return true;
        	
    }
    var fs1=22;
    var fs2=22;
 
    function sizedown(n)
    {
    	var num;
        if(n==0)
           num=fs1;
        else
           num=fs2;
        	
        
    	ss=setInterval(function()
    	{   
    		num--;
    		document.getElementsByClassName("inner")[n].style.fontSize=num+"px";
    		
    		if(num==11)
    		{	
    			clearInterval(ss);
    			if(n==0)
    		       fs1=11;
    		    else
    		       fs2=11;
    		}
    	},10);
 
    	 
    }
    function init(my,n)
    {
       if(my.value.trim().length==0)
       {
    	    if(n==0)
               num=fs1;
            else
               num=fs2;
    	 
    	    ss=setInterval(function()
    	   	{   
    	   		num++;
    	   		document.getElementsByClassName("inner")[n].style.fontSize=num+"px";
    	   		
    	   		if(num==22)
    	   		{	
    	   			clearInterval(ss);
    	   		}
    	   	},20);
       }	   
    }
  </script>
</head>
<body>  
  <section>
    <form method="post" action="loginOk" onsubmit="return check(this)">
     <h3> 로 그 인 </h3>
     <div> 
       <div class="inner">아이디</div>
       <input type="text" name="userid" id="txt" class="ttt" onfocus="sizedown(0)" onblur="init(this,0)">
     </div>
     <div> 
       <div class="inner">비밀번호</div>
       <input type="password" name="pwd" id="pwd" class="ttt" onfocus="sizedown(1)" onblur="init(this,1)"> 
     </div>
     <p align="center"> <input type="submit" value="로그인" id="sub"> </p>
    <c:if test="${err==1}">
     <div style="font-size:12px;color:red;border:none;text-align:center;"> 아이디 혹은 비밀번호가 일치하지 않습니다 </div>
    </c:if>
    </form>
  </section>
</body>
</html>




