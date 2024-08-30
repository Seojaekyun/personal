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
    main {
      width:1100px;
      
      margin:auto;
      font-family:'GmarketSansMedium';
    }
    main table {
      margin-top:50px;     
      margin-bottom:50px;
      border-spacing:0px;
    }
    main table td {
      border-bottom:1px solid purple;
      padding-top:5px;
      padding-bottom:5px;
    }
    main table tr:first-child td {
      border-top:2px solid purple;
    }
    main #mainChk {
      width:18px;
      height:18px;
    }
    main .subChk {
    
    }
    main .su {
      width:20px;
      outline:none;
      text-align:center;
    }
  </style>
  <script>
    function mainClick(my) // 전체선택 체크박스
    {
    	var subChk=document.getElementsByClassName("subChk");
    	
    	if(my.checked) //document.getElementById("mainChk").checked
    	{
    		for(i=0;i<subChk.length;i++)
    		{
    			subChk[i].checked=true;
    		}	
    	}	
    	else
    	{
    		for(i=0;i<subChk.length;i++)
    		{
    			subChk[i].checked=false;
    		}	
    	}	
    	
    	totalCal();
    	
    }
    function subClick() // 상품별 체크박스
    {
    	// 모든 class="subChk"인 요소가 체크가 된다면 => 전체선택 체크박스를 체크하면 된다.
    	// class="subChk"중에서 하나라도 체크가 안된다면 => 전체선택 체크박스는 해제
    	
    	var subChk=document.getElementsByClassName("subChk");
    	
    	// subChk에서 몇개가 체크되었는지 카운드
    	var cnt=0;
    	for(i=0;i<subChk.length;i++)
    	{
    		if(subChk[i].checked) // 체크가 되었다면
    		{	
    			cnt++;
    		}
    	}	
    	
    	
    	if(cnt == subChk.length)
    		document.getElementById("mainChk").checked=true;
    	else
    		document.getElementById("mainChk").checked=false;
     	
    	totalCal();
    }
    
    function totalCal() // 전체계산
    {
    	var subChk=document.getElementsByClassName("subChk");
    	var hp=document.getElementsByClassName("hp");
    	var jp=document.getElementsByClassName("jp");
    	var bp=document.getElementsByClassName("bp");
    	
    	var hpAll=0; 
    	var jpAll=0;
    	var bpAll=0;
    	var chkNum=0;
    	for(i=0;i<subChk.length;i++)
    	{
    		if(subChk[i].checked)
    		{
    			chkNum++;
    			hpImsi=parseInt( hp[i].innerText.replace(/[,]/g, "") );
    			jpImsi=parseInt( jp[i].innerText.replace(/[,]/g, "") );
    			if(bp[i].innerText=="무료배송")
    				bpImsi=0;
    			else
    			    bpImsi=parseInt( bp[i].innerText.replace(/[,]/g, "") );
    			
    			//alert(hpImsi+" "+jpImsi+" "+bpImsi);
    			
    			hpAll=hpAll+hpImsi;
    			jpAll=jpAll+jpImsi;
    			bpAll=bpAll+bpImsi;
    			//alert(hpAll+" "+jpAll+" "+bpAll);
    			
    			document.getElementById("hpTot").innerText=comma(hpAll);
    			document.getElementById("jpTot").innerText=comma(jpAll);
    			document.getElementById("bpTot").innerText=comma(bpAll);
    			document.getElementById("hpbpTot").innerText=comma(hpAll+bpAll);
    		} // if의 끝
    	} // for의 끝
    	
    	if(chkNum==0)
    	{
    		document.getElementById("hpTot").innerText=0;
			document.getElementById("jpTot").innerText=0;
			document.getElementById("bpTot").innerText=0;
			document.getElementById("hpbpTot").innerText=0;
    	}	
    }
    
    function comma(value)
    {
    	return new Intl.NumberFormat().format(value);
    }
  </script>
  <script src="https://code.jquery.com/jquery-latest.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script> 
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
  <script>
    $(function()
    {
    	 
    	// 숫자입력칸을 jquery에서 지원하는 spinner를 사용
    	$(".su").spinner(
    			{
    				min:1,
    				max:10,
    				spin:function(e,ui) // 버튼이 클리되었을때 실행되는 함수
    				{
    				    chgSu(ui.value);
                        console.log(ui);
    				}
    			});
    });
    
    function chgSu(su)
    {
    	console.log(su);
    }
    function selDel()
    {
    	// class="subChk"의 요소를 검사 => 체크가 되었다면 삭제할 상품 => 누적
    	var subChk=document.getElementsByClassName("subChk");
    	
    	// 모든 subChk를 다 검사해야 된다.
    	var pcode="";
    	for(i=0;i<subChk.length;i++)
    	{
    		if(subChk[i].checked)
    			pcode=pcode+subChk[i].value+"/";
    	}	
    	
    	if(pcode!="")
    	  location="cartDel?pcode="+pcode;
    }
 </script>    
</head>
<body>
 <main>
  <table width="1100" align="center">
    <caption> <h2> 장바구니 현황 ${pMapAll.size() } </h2> </caption>
    <c:set var="cnum" value="0"/>
   <c:forEach items="${pMapAll}" var="map">
     <c:set var="str" value=""/>
     <c:if test="${map.days<=1}">
       <c:set var="str" value="checked"/>
       <c:set var="cnum" value="${cnum+1}"/>
     </c:if>
     <tr height="80">
       <td width="30"> <input type="checkbox" value="${map.pcode}" ${str} class="subChk" onclick="subClick()"> </td>
       <td width="100" align="center"> <img src="../static/product/${map.pimg}" height="80" width="80"> </td>
       <td align="left"> ${map.title} </td>
       <td width="140"> ${map.baeEx} </td>  
       <td width="110" align="right"> <span class="hp"><fmt:formatNumber value="${map.halinprice}" type="number"/></span>원 </td>
       <td width="110" align="right"> <span class="jp"><fmt:formatNumber value="${map.jukprice}" type="number"/></span>원 </td>
       <td width="80" align="right"> 
         <input type="text" name="su" value="${map.csu}" class="su" > 
       </td>
       <td width="110" align="right"> 
        <c:if test="${map.baeprice==0}">
          <span class="bp">무료배송</span>
        </c:if>
        <c:if test="${map.baeprice!=0}">
          <span class="bp"><fmt:formatNumber value="${map.baeprice}" type="number"/></span>원
        </c:if>
        <br> <input type="button" value="삭제" onclick="location='cartDel?pcode=${map.pcode}'">
       </td>
     </tr>
   </c:forEach>
     <tr>
       <td height="40"> 
        <c:if test="${pMapAll.size()==cnum}">
         <c:set var="mchk" value="checked"/>
        </c:if>
          <input type="checkbox" ${mchk} id="mainChk" onclick="mainClick(this)">  
       </td>
       <td height="40" colspan="7"> 
          전체선택  <input type="button" value="선택상품 삭제" onclick="selDel()">
       </td>
     </tr>
     <tr>
       <td colspan="8" align="center">
           총상품금액 
           <span id="hpTot"><fmt:formatNumber value="${halinpriceTot}" type="number"/></span>원 
           + 배송비 
           <span id="bpTot"><fmt:formatNumber value="${baepriceTot}" type="number"/></span>원 = 총결제금액 
           <span id="hpbpTot"><fmt:formatNumber value="${halinpriceTot+baepriceTot}" type="number"/></span>원  
           (적립예정 : <span id="jpTot"><fmt:formatNumber value="${jukpriceTot}" type="number"/></span>원)
       </td>
     </tr>
  </table>
 </main>
</body>
</html>