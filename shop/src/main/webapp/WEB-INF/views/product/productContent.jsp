<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
   main {
     width:1100px;
     margin:auto;
     font-family:'GmarketSansLight';
   }
   main section {
     width:1100px;
     margin:auto;
   }
   main #first {
     width:1100px;
     height:500px;
   }
   main #first > div {
     display:inline-block;
   }
   main #first #left {
     width:500px;
     height:500px;
     text-align:center;
    }
   main #first #right {
     width:594px;
     height:500px;
     vertical-align:top;
     margin-top:20px;
   }
   main #first #right > div {
     margin-top:30px;
   }
   main #first #right #ptitle {
     font-family:'GmarketSansMedium';
     font-size:24px; 
   }
   main #first #right #ptitle #leftT {
     width:420px;
     float:left;
   }
   main #first #right #ptitle #rightT {
     width:80px;
     float:left;
     text-align:left;
   }
   main #first #right #pstar {
     clear:both;
     font-size:12px;
     margin-top:0px;
     padding-bottom:8px;
     border-bottom:1px solid purple;
     font-family:'GmarketSansMedium';
   }
   main #first #right #phalin {
     
   }
   main #first #right #pprice {
     font-size:22px;
     font-family:'GmarketSansMedium';
     color:#CB1400;
     margin-top:0px;
     padding-bottom:8px;
     border-bottom:1px solid purple;
   }
   main #first #right #pbaeprice {
     font-family:'GmarketSansMedium';
   }
   main #first #right #pbaeEx {
     color:green;
     font-size:18px;
     font-family:'GmarketSansMedium';
     margin-top:0px;
     padding-bottom:8px;
     border-bottom:1px solid purple;
   }
   main #first #right #pjuk{
     font-family:'GmarketSansMedium';
     padding-bottom:8px;
     border-bottom:1px solid purple;
   }
   main #first #right #su {
     width:40px;
     height:25px;
     text-align:center;
     outline:none;
     vertical-align:bottom;
   }
   main #first #right #btn {
     width:230px;
     height:40px;
     background:white;
     border:1px solid purple;
     vertical-align:top;
     border-radius:4px;
   }
   main #first #right #submit {
     width:230px;
     height:40px;
     background:purple;
     color:white;
     border:1px solid purple;
     vertical-align:top;
     border-radius:4px;
   }
   main #first #right #pbutton { /* 장바구니 버튼이 있는 div태그 */
     position:relative;
   }
   main #first #right #pbutton #confirm { /* 레이어 창 */
     position:absolute;
     left:70px;
     top:-100px;
     width:260px;
     height:70px;
     border:1px solid purple;
     background:white;
     visibility:hidden;
   }
   main #first #right #pbutton #confirm div { /* 레이어 안의 2개의 div */
     text-align:center;
     width:260px;
     height:35px;
     line-height:35px;
     font-family:'GmarketSansMedium';     
   }
   main #first #right #pbutton #confirm div input{ /* 레이어 안의 button */
     width:100px;
     height:30px;
     border:1px solid purple;
     background:purple;
     color:white
     
   }
 </style>
  <script src="https://code.jquery.com/jquery-latest.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script> 
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
  <script>
    $(function()
    {
    	// 상품의 원래가격
    	var price=${pdto.price};
    	// 상품의 할인율
    	var halin=${pdto.halin};
    	// 상품의 적립율
    	var juk=${pdto.juk};
    	// 숫자입력칸을 jquery에서 지원하는 spinner를 사용
    	$("#su").spinner(
    			{
    				min:1,
    				max:10,
    				spin:function(e,ui) // 버튼이 클리되었을때 실행되는 함수
    				{
    					// ui.value(수량)를 이용하여 상품의 원래가격, 할인후 가격, 적립금
    					var su2=ui.value;
    					// 원래가격*수량
    					var jsprice=price*su2; 
    					// ( 원래가격-(원래가격*할인율/100) )*수량
    					var jshalinprice= ( price-(price*halin/100) )*su2;
    					// ( (원래가격-(원래가격*할인율/100))*(적립율/100) )*수량
    					var jsjukprice= ( (price)*(juk/100) )*su2;
    					
    					// 브라우저의 요소에 값 전달
    					$("#input1").text(comma(jsprice));
    					document.getElementById("input2").innerText=comma(jshalinprice);
    				    document.getElementById("input3").innerText=comma(jsjukprice);
    				}
    			});
    });
    
    function comma(value)
    {
    	return new Intl.NumberFormat().format(value);
    }
    function jjimOk(pcode)
    {
    	// 파일명만 분리
		var imgName=document.getElementById("img").src; // http://.../../jjim1.png
    	var fname=imgName.substring( imgName.lastIndexOf("/")+1 );
    	var chk=new XMLHttpRequest();
    	chk.onload=function()
    	{
    		//alert(chk.responseText);
    		if(chk.responseText=="0")
    			location="../login/login?pcode="+pcode;
    		else // 정상적으로 찜테이블에 저장이 되었다..
    		{
    			// jjim1.png => jjim2.png로 변경해야 된다.. (찜선택)
    			//alert(document.getElementById("img").src); // http://.../../jjim1.png
    			
    			if(fname=="jjim1.png")  
    		    {
    			   document.getElementById("img").src="../static/main/jjim2.png";
    			// jjim2.png => jjim1.png로 변경해야 된다.. (찜해제)
    		    }
    			else
    			{
    				document.getElementById("img").src="../static/main/jjim1.png";
    			}	
    			
    		}	
    	}
    	chk.open("get","jjimOk?pcode="+pcode+"&fname="+fname);
    	chk.send();
    }
    
    function addCart()
    {
    	var pcode="${pdto.pcode}";
    	var su=document.gform.su.value;
    	
    	var chk=new XMLHttpRequest();
    	chk.onload=function()
    	{
    		//alert(chk.responseText);
    		if(chk.responseText=="0")
    		{
    			/*
    			if(confirm("장바구니로 이동하시겠습니다"))
    			{
    				location="../product/cartView";
    			}
    			*/
    			// 요즘은 레이어를 보여주고 몇 초뒤에 숨긴다.
    			document.getElementById("confirm").style.visibility="visible";
    			// setTimeout(함수,시간); 함수는 호출도 가능, 익명함수도 가능 function(){}
    			setTimeout(function()
    			{
    				document.getElementById("confirm").style.visibility="hidden";
    			},3000);
    		}	
    		else
    		{
    			alert("잠시 오류가 발생하였습니다");
    		}	
    	}
    	chk.open("get","addCart?pcode="+pcode+"&su="+su);
    	chk.send();
    	
    }
  </script>
</head>
<body> <!-- product/productContent.jsp -->
  <main>
    <form name="gform" method="post" action="gumae">
    <section id="first">
     
      <div id="left"> 
        <div style="height:40px;"></div>
        <img src="../static/product/${pdto.pimg}" width="470" height="400"> 
      </div>
      <div id="right">
        <div id="ptitle">  
          <div id="leftT">   
           ${pdto.title}   
          </div>
          <div id="rightT">
           <a href="javascript:jjimOk('${pdto.pcode}')">
            <img id="img" src="../static/main/${jImg}" valign="middle" style="margin-left:100px"> 
           </a>
          </div>    
        </div>
        <div style="letter-spacing:-3px" id="pstar"> 
             <c:forEach begin="1" end="5">
               <img src="../static/pro/star1.png" width="10">
             </c:forEach>
            <span style="letter-spacing:0px"> ${pdto.review}개 상품평 </span>
        </div>  
       
        <div id="phalin"> 
         <c:if test="${pdto.halin!=0}">
          ${pdto.halin}%  <s id="input1"><fmt:formatNumber value="${pdto.price}" type="number"/></s>
         </c:if>  
        </div>
       
       <div id="pprice"> <span id="input2"><fmt:formatNumber value="${pdto.halinPrice}" type="number"/></span>원 </div>
       <div id="pbaeprice">
        <c:if test="${pdto.baeprice==0}">
          무료배송
        </c:if>
        <c:if test="${pdto.baeprice!=0}">
          배송비 <fmt:formatNumber value="${pdto.baeprice}" type="number"/>원
        </c:if>        
       </div>
       <div id="pbaeEx"> ${pdto.baeEx}</div>
       <div id="pjuk"> 적립예정 : <span id="input3"><fmt:formatNumber value="${pdto.jukPrice}" type="number"/></span>원 </div>
       
       <div id="pbutton">
         <input type="text" name="su" value="1" readonly id="su"> 
         <input type="button" onclick="addCart()" value="장바구니" id="btn" valign="middle"> 
         <input type="submit" value="바로구매" id="submit">
         <div id="confirm">
           <div> 장바구니로 이동하시겠습니까? </div> 
           <div> <input type="button" value="장바구니 이동" onclick="location='../member/cartView'"> </div>
         </div>
       </div>
       
     </div> <!-- id="right"의 끝 -->
     
    </section>
    </form>
    <section id="second"></section>
    <section id="third"></section>
    <section id="fourth"></section>
    <section id="fifth">
<!--      <img src="../static/main/exch.png"> -->
    </section>
  </main>
</body>
</html>