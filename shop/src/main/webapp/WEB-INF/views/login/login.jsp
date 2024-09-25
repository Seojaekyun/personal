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
      margin-top:100px;
   }
   section > form > div {
      
      position:relative;
      width:500px;
      height:60px;
      border:1px solid purple;
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
      margin-top:28px;
      margin-left:10px;
      font-size:16px;
      cursor:pointer;
   }
   
   section #txt {
      width:400px;
      height:30px;
      color:purple;
   }
   section #pwd  {
      width:400px;
      height:30px;
   }
    
   section #sub {
      width:500px;
      height:60px;
      background:purple;
      color:white;
      border:1px solid purple;
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
        	
        if(num!=11)
        {
        	s1=setInterval(function()
   	    	{   
   	    		num--;
   	    		document.getElementsByClassName("inner")[n].style.fontSize=num+"px";
   	    		
   	    		if(num==11)
   	    		{	
   	    			clearInterval(s1);
   	    			if(n==0)
   	    		       fs1=11;
         		    else
   	    		       fs2=11;
        		}
        	},10);
        }
    	 
    }
    
    function init(my,n)
    {
       if(my.value.trim().length==0)
       {
    	    if(n==0)
               num=fs1;
            else
               num=fs2;
    	 
    	    s2=setInterval(function()
    	   	{   
    	   		num++;
    	   		document.getElementsByClassName("inner")[n].style.fontSize=num+"px";
    	   		
    	   		if(num>=22)
    	   		{	
    	   			console.log(num);
    	   			clearInterval(s2);
    	   			if(n==0)
    	    		   fs1=22;
    	    		else
    	    		   fs2=22;
    	   		}
    	   	},20);
       }	   
    }
   /*  window.onload=function()
    {
    	document.getElementById("txt").focus();
    } */
    function useridSearch()
    {
    	son=open("usForm","","width=400,height=300");
    	son.moveTo(200,200);
    }
    function pwdSearch()
    {
    	son=open("psForm","","width=400,height=370");
    	son.moveTo(200,200);
    }
  </script>
</head>
<body>  

  <section>
    <form method="post" action="loginOk" onsubmit="return check(this)">
     <input type="hidden" name="pcode" value="${pcode}">
     <h2 style="color:purple"> 로 그 인 </h2>
     <div> 
       <div class="inner">아이디</div>
       <input type="text" name="userid" value="superman" id="txt"  onfocus="sizedown(0)" onblur="init(this,0)">
     </div>
     <div> 
       <div class="inner">비밀번호</div>
       <input type="password" name="pwd" value="1234" id="pwd"  onfocus="sizedown(1)" onblur="init(this,1)"> 
     </div>
     <p align="center"> <input type="submit" value="로그인" id="sub"> </p>
    <c:if test="${err==1}">
     <p align="center"> 아이디 혹은 비밀번호가 일치하지 않습니다 </p>
    </c:if>
    </form>
  
  </section>
</body>
</html>




