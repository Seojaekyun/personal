<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script>
  function juso_search()  // 우편번호 버튼 클릭시 호출 함수명
  {
    new daum.Postcode({
        oncomplete: function(data) {
          if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
              addr = data.roadAddress;
          } else { // 사용자가 지번 주소를 선택했을 경우(J)
              addr = data.jibunAddress;
          }

          // 우편번호와 주소 정보를 해당 필드에 넣는다.
          document.pkc.zip.value = data.zonecode; // 우편번호
          document.pkc.juso.value = addr;  // 주소
          // 커서를 상세주소 필드로 이동한다.
          document.pkc.jusoEtc.focus();
      }
    }).open();
  }
  
  window.onload=function()
  {
	  document.pkc.req.value=${bdto.req};
  }
 </script> 
 <style>
   @font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
   }
   h3 {
     text-align:center;
     font-family: 'GmarketSansMedium';
   }
   div {
     width:460px;
     height:30px;
     text-align:center;
     margin-top:20px;
     font-family: 'GmarketSansMedium';
   }
   div #zip {
     width:260px;
     vertical-align:middle;
   }
   div input[type=button] {
     width:134px;
     height:34px;
     vertical-align:middle;
     border:1px solid purple;
     background:purple;
     color:white;
     font-family: 'GmarketSansMedium';
   }
   div input[type=submit] {
     width:400px;
     height:34px;
     vertical-align:middle;
     border:1px solid purple;
     background:purple;
     color:white;
     font-family: 'GmarketSansMedium';
   }
   div input[type=text] {
     width:400px;
     height:30px;
     border:1px solid purple;
     outline:none;
     font-family: 'GmarketSansMedium';
   }
   div #gibon {
     margin-left:28px;
     width:18px;
     height:18px;
     vertical-align:middle;
   }
   div select {
     width:406px;
     height:34px;
     border:1px solid purple;
     font-family: 'GmarketSansMedium';
     outline:none;
   }
 </style>
</head>
<body><!-- product/jusoUpdate.jsp -->
   <form name="pkc" method="post" action="jusoUpdateOk">
     <input type="hidden" name="id" value="${bdto.id}">
     <h3> 배송지 수정 </h3>
     <div> <input type="text" name="name" value="${bdto.name}"> </div>
     <div> <input type="text" name="zip" id="zip" value="${bdto.zip}" readonly> <input type="button" value="주소검색" onclick="juso_search()"> </div>
     <div> <input type="text" name="juso" value="${bdto.juso}" readonly> </div>
     <div> <input type="text" name="jusoEtc" value="${bdto.jusoEtc}"> </div>
     <div> <input type="text" name="phone" value="${bdto.phone}"> </div>
     <div>
        <select name="req"> 
          <option value="0"> 문 앞 </option>
          <option value="1"> 직접받고 부재시 문앞 </option>
          <option value="2"> 경비실 </option>
          <option value="3"> 택배함 </option>
          <option value="4"> 공동현관 앞 </option> 
        </select>
     </div>
     <div style="text-align:left"> 
      <c:if test="${bdto.gibon==1}">
        <c:set var="chk" value="checked"/>
      </c:if>
       <input type="checkbox" name="gibon" value="1" ${chk} id="gibon"> 기본 배송지로 지정
     </div>
     <div> <input type="submit" value="주소등록"> </div>
   </form>
</body>
</html>





