<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>         
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
   @font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
   }
 
   article {
      width:1500px;
      height:350px;
      margin:auto;
      background:pink;
      overflow:hidden;
      }
   article #inner {
      width:10000px;
   }
   main {
      width:1100px;
      margin:auto;
      font-family:'GmarketSansMedium';
   }
   main #p1 {
      width:1100px;
      height:550px;
      margin:auto;
   }
   main #p2 {
      width:1100px;
      height:550px;
      margin:auto;
   }
   main #p3 {
      width:1100px;
      height:550px;
      margin:auto;
   }
   main #p4 {
      width:1100px;
      height:550px;
      margin:auto;
   }
   main section table {
     border-spacing:12px;
   }
   main section table td {
     cursor:pointer;
     width:270px;
     height:360px;
     border:1px solid #eeeeee;
     padding:4px;
     outline:2px solid white;
   }
   main section table td:hover {
     outline:2px solid #cccccc;
   }
 
   main table td:last-child { /* 페이지 출력되는 행 */
     height:60px;
   }
   main table td > div {
     width:270px;
     margin-top:5px;
   }
    main section table td > div:first-child { /* 상품이미지 */
     text-align:center;
   }
   main section table td > #ptitle {
   
   }
   main section table td > #phalin {
     font-size:12px;
   }
   main section table td > #phalinPrice {
     font-size:18px;
     color:#CB1400;
     font-family:'GmarketSansMedium';
   }
   main section table td > #pbaeEx {
     color:green;
   }
 </style>
 <script src="https://code.jquery.com/jquery-latest.js"></script>
 <script>
   var ss;
   $(function()
   {
	    setInterval(function()
	    {
	    	 $("#inner").animate(
	    	 {
	    		 marginLeft:"-1500px"
	    	 },2000,function()
	    	        {
	    		        $("#inner").css("margin-left","0px");
	    		        $(".mimg").eq(0).insertAfter($(".mimg").eq(5));
	    	        });
	    },4000);
	    
	    isTime();
	    ss=setInterval(isTime,1000);
   });
   
   function isTime()
   {
       var xday=new Date("${plist1.get(0).salesDay}"); // 특정일
       //var xday=new Date("2024-09-13 15:00:00"); // 특정일
       var today=new Date(); // 현재
       var sigan=xday-today; // 1/1000초
       if(sigan>0)
       {
    	   sigan=Math.floor(sigan/1000); // 두 날짜간의 초
           
           var sec=sigan%60;
           
           sigan=Math.floor(sigan/60);   // 두 날짜간의 분
           
           var min=sigan%60;
           
           sigan=Math.floor(sigan/60);   // 두 날짜간의 시간
           
           var hour=sigan%24;
           
           sigan=Math.floor(sigan/24);   // 두 날짜간의 일수
           
           document.getElementById("now").innerText=sigan+"일 "+hour+"시 "+min+"분 "+sec+"초";
       }	
       else
       {
    	   clearInterval(ss);
    	   document.getElementById("now").innerText="종료됨";
       }	   
       
   }
 </script>
</head>
<body>
   <article id="outer">
     <div id="inner">
       <img class="mimg" src="../static/main/s2.png" width="1500" height="350"><img class="mimg" src="../static/main/s3.png" width="1500" height="350"><img class="mimg" src="../static/main/s4.png" width="1500" height="350"><img class="mimg" src="../static/main/s5.png" width="1500" height="350"><img class="mimg" src="../static/main/s6.png" width="1500" height="350"><img class="mimg" src="../static/main/s7.png" width="1500" height="350">
     </div>
   </article> <!-- 그림 스크롤 -->
   <main>
    <section id="p1">
     <table width="1100" align="center">
      <caption> <h2> 타임세일 상품 <span style="font-size:12px" id="now"></span> </h2>   </caption>
      <tr>
     <c:forEach items="${plist1}" var="pdto">
        
        <td onclick="location='../product/productContent?pcode=${pdto.pcode}'" valign="top"> 
           <div> <img src="../static/product/${pdto.pimg}" width="200" height="200"> </div> 
           <div id="ptitle"> ${pdto.title} </div>
          <c:if test="${pdto.halin!=0}"> <!-- 할인율이 0이면 의미없다 -->
           <div id="phalin"> ${pdto.halin}%  <s> <fmt:formatNumber value="${pdto.price}" type="number"/>원  </s></div> 
          </c:if> 
           <div id="phalinPrice"> <fmt:formatNumber value="${pdto.halinPrice}" type="number"/>원 </div>
           <div id="pbaeEx"> ${pdto.baeEx} </div>     
           <div style="letter-spacing:-4px;font-size:12px"> 
             
             <c:forEach begin="1" end="${pdto.ystar}">
               <img src="../static/pro/star1.png" width="10">
             </c:forEach>
             <c:if test="${pdto.hstar==1}">
               <img src="../static/pro/star3.png" width="10">
             </c:if>
             <c:forEach begin="1" end="${pdto.gstar}">
               <img src="../static/pro/star2.png" width="10">
             </c:forEach>
             
             &nbsp;<span style="letter-spacing:0px;font-size:12px"> (${pdto.review}) </span>
           </div>   
          <c:if test="${pdto.juk!=0}"> <!-- 적립금이 있다면 -->   
           <div> 
             <span id="juk"> <img src="../static/pro/juk.png" width="10">  
              최대 <fmt:formatNumber value="${pdto.jukPrice}" type="number"/>원 적립
             </span>
           </div>
          </c:if>
         </td> 
        
     </c:forEach>
      </tr>
    </table>
    </section> <!-- 타임세일 -->
    <section id="p2">
      <table width="1100" align="center">
      <caption> <h2> 특가 상품 </h2> </caption>
      <tr>
     <c:forEach items="${plist2}" var="pdto">
        
        <td onclick="location='productContent?pcode=${pdto.pcode}'" valign="top"> 
           <div> <img src="../static/product/${pdto.pimg}" width="200" height="200"> </div> 
           <div id="ptitle"> ${pdto.title} </div>
          <c:if test="${pdto.halin!=0}"> <!-- 할인율이 0이면 의미없다 -->
           <div id="phalin"> ${pdto.halin}%  <s> <fmt:formatNumber value="${pdto.price}" type="number"/>원  </s></div> 
          </c:if> 
           <div id="phalinPrice"> <fmt:formatNumber value="${pdto.halinPrice}" type="number"/>원 </div>
           <div id="pbaeEx"> ${pdto.baeEx} </div>     
           <div style="letter-spacing:-4px;font-size:12px"> 
             
             <c:forEach begin="1" end="${pdto.ystar}">
               <img src="../static/pro/star1.png" width="10">
             </c:forEach>
             <c:if test="${pdto.hstar==1}">
               <img src="../static/pro/star3.png" width="10">
             </c:if>
             <c:forEach begin="1" end="${pdto.gstar}">
               <img src="../static/pro/star2.png" width="10">
             </c:forEach>
             
             &nbsp;<span style="letter-spacing:0px;font-size:12px"> (${pdto.review}) </span>
           </div>   
          <c:if test="${pdto.juk!=0}"> <!-- 적립금이 있다면 -->   
           <div> 
             <span id="juk"> <img src="../static/pro/juk.png" width="10">  
              최대 <fmt:formatNumber value="${pdto.jukPrice}" type="number"/>원 적립
             </span>
           </div>
          </c:if>
         </td> 
        
     </c:forEach>
      </tr>
    </table>
    </section> <!-- 특가상품 -->
    <section id="p3">
      <table width="1100" align="center">
      <caption> <h2> 최신 상품 </h2> </caption>
      <tr>
     <c:forEach items="${plist3}" var="pdto">
        
        <td onclick="location='productContent?pcode=${pdto.pcode}'" valign="top"> 
           <div> <img src="../static/product/${pdto.pimg}" width="200" height="200"> </div> 
           <div id="ptitle"> ${pdto.title} </div>
          <c:if test="${pdto.halin!=0}"> <!-- 할인율이 0이면 의미없다 -->
           <div id="phalin"> ${pdto.halin}%  <s> <fmt:formatNumber value="${pdto.price}" type="number"/>원  </s></div> 
          </c:if> 
           <div id="phalinPrice"> <fmt:formatNumber value="${pdto.halinPrice}" type="number"/>원 </div>
           <div id="pbaeEx"> ${pdto.baeEx} </div>     
           <div style="letter-spacing:-4px;font-size:12px"> 
             
             <c:forEach begin="1" end="${pdto.ystar}">
               <img src="../static/pro/star1.png" width="10">
             </c:forEach>
             <c:if test="${pdto.hstar==1}">
               <img src="../static/pro/star3.png" width="10">
             </c:if>
             <c:forEach begin="1" end="${pdto.gstar}">
               <img src="../static/pro/star2.png" width="10">
             </c:forEach>
             
             &nbsp;<span style="letter-spacing:0px;font-size:12px"> (${pdto.review}) </span>
           </div>   
          <c:if test="${pdto.juk!=0}"> <!-- 적립금이 있다면 -->   
           <div> 
             <span id="juk"> <img src="../static/pro/juk.png" width="10">  
              최대 <fmt:formatNumber value="${pdto.jukPrice}" type="number"/>원 적립
             </span>
           </div>
          </c:if>
         </td> 
        
     </c:forEach>
      </tr>
    </table>
    </section> <!-- 끝 -->
    <section id="p4">
      <table width="1100" align="center">
      <caption> <h2> 최다판매 상품 </h2> </caption>
      <tr>
     <c:forEach items="${plist4}" var="pdto">
        
        <td onclick="location='productContent?pcode=${pdto.pcode}'" valign="top"> 
           <div> <img src="../static/product/${pdto.pimg}" width="200" height="200"> </div> 
           <div id="ptitle"> ${pdto.title} </div>
          <c:if test="${pdto.halin!=0}"> <!-- 할인율이 0이면 의미없다 -->
           <div id="phalin"> ${pdto.halin}%  <s> <fmt:formatNumber value="${pdto.price}" type="number"/>원  </s></div> 
          </c:if> 
           <div id="phalinPrice"> <fmt:formatNumber value="${pdto.halinPrice}" type="number"/>원 </div>
           <div id="pbaeEx"> ${pdto.baeEx} </div>     
           <div style="letter-spacing:-4px;font-size:12px"> 
             
             <c:forEach begin="1" end="${pdto.ystar}">
               <img src="../static/pro/star1.png" width="10">
             </c:forEach>
             <c:if test="${pdto.hstar==1}">
               <img src="../static/pro/star3.png" width="10">
             </c:if>
             <c:forEach begin="1" end="${pdto.gstar}">
               <img src="../static/pro/star2.png" width="10">
             </c:forEach>
             
             &nbsp;<span style="letter-spacing:0px;font-size:12px"> (${pdto.review}) </span>
           </div>   
          <c:if test="${pdto.juk!=0}"> <!-- 적립금이 있다면 -->   
           <div> 
             <span id="juk"> <img src="../static/pro/juk.png" width="10">  
              최대 <fmt:formatNumber value="${pdto.jukPrice}" type="number"/>원 적립
             </span>
           </div>
          </c:if>
         </td> 
        
     </c:forEach>
      </tr>
    </table>
    </section> <!-- 최다판매 -->
   </main> <!-- 전체 내용 -->
 </body>
 </html>


