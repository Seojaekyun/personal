<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <style>
    table tr td {
      width:10px;
      height:10px;
      border:1px solid black;
      font-size:12px;
    }
   table #cen {
     border:none;
   }
  </style>
  <script>
    var chk=new Array(20);
   chk[0]=${bdto.a0};
   chk[1]=${bdto.a1};
   chk[2]=${bdto.a2};
   chk[3]=${bdto.a3};
   chk[4]=${bdto.a4};
   chk[5]=${bdto.a5};
   chk[6]=${bdto.a6};
   chk[7]=${bdto.a7};
   chk[8]=${bdto.a8};
   chk[9]=${bdto.a9};
   chk[10]=${bdto.a10};
   chk[11]=${bdto.a11};
   chk[12]=${bdto.a12};
   chk[13]=${bdto.a13};
   chk[14]=${bdto.a14};
   chk[15]=${bdto.a15};
   chk[16]=${bdto.a16};
   chk[17]=${bdto.a17};
   chk[18]=${bdto.a18};
   chk[19]=${bdto.a19};
   
   window.onload=function()
   {
	    var bb=document.getElementsByClassName("bb");
	    for(i=0;i<bb.length;i++)
	    {
	    	if(chk[i]==1)
	    	{
	    		bb[i].style.background="red";
	    	}	
	    	else
	        {
	    		bb[i].setAttribute("onclick","selSeat(this)");
	        }
	    }	
   }
   var seat="";
   function selSeat(my)
   { 
	    var imsi=seat.split("/");
	 
	    
	    	if(my.style.background!="blue")
		    {
	    		if(imsi.length<=4)
	    	    {
		    	  seat=seat+my.innerText+"/";
			      my.style.background="blue";
	    	    }
		    }		
		    else
		    {
		    	seat=seat.replace(my.innerText+"/","");
			    my.style.background="white";
    	    }
	    	document.getElementById("aa").innerText=seat;
	    	
	    
	    
	    
   }
  </script>
</head>
<body>
   <div id="aa"></div>
   <table align="center">
     ${bdto.busGubun }
     <tr>
       <td class="bb">a0</td>
       <td class="bb">a1</td>
       <td class="bb">a2</td>
       <td class="bb">a3</td>
       <td class="bb">a4</td>
       <td class="bb">a5</td>
       <td class="bb">a6</td>
       <td class="bb">a7</td>
       <td class="bb">a8</td>
       <td class="bb">a9</td>
     </tr>
      <tr>
       <td class="bb">a10</td>
       <td class="bb">a11</td>
       <td class="bb">a12</td>
       <td class="bb">a13</td>
       <td class="bb">a14</td>
       <td class="bb">a15</td>
       <td class="bb">a16</td>
       <td class="bb">a17</td>
       <td class="bb">a18</td>
       <td class="bb">a19</td>
     </tr>
     
   </table>
</body>
</html>