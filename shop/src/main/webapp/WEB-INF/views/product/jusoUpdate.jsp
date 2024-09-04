<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소 등록</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 0;
    }
    h3 {
        color: #333;
    }
    form {
        max-width: 600px;
        padding: 20px;
    }
    div {
        margin-bottom: 15px;
    }
    input[type="text"] {
        width: calc(100% - 22px);
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }
    input[name="zip"] {
        width: calc(100% - 120px);
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }
    input[type="button"] {
        padding: 10px 15px;
        border: none;
        border-radius: 4px;
        background-color: #007bff;
        color: #fff;
        cursor: pointer;
        font-size: 14px;
        margin-left: 10px;
    }
    input[type="button"]:hover {
        background-color: #0056b3;
    }
    select {
        width: calc(100% - 22px);
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }
    input[type="checkbox"] {
        margin-right: 10px;
    }
</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function juso_search() {
        new daum.Postcode({
            oncomplete: function(data) {
                let addr;
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                }
                else { // 사용자가 지번 주소를 선택했을 경우(J)
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
    
    window.onload=function() {
    	document.pkc.req.value=${bdto.req};
    }
</script>
</head>
<body> <!-- product/jusoUpdate.jsp -->
    <form name="pkc" method="post" action="jusoUpdateOk">
    <input type="hidden" name="id" value="${bdto.id}">
        <h3>배송지 수정</h3>
        <div><input type="text" name="name" value="${bdto.name}"></div>
        <div>
            <input type="text" name="zip" readonly>
            <input type="button" value="주소검색" onclick="juso_search()">
        </div>
        <div><input type="text" name="juso" value="${bdto.juso}" readonly></div>
        <div><input type="text" name="jusoEtc" value="${bdto.jusoEtc}"></div>
        <div><input type="text" name="phone" value="${bdto.phone}"></div>
        <div>
            <select name="req">
                <option value="0">문 앞</option>
                <option value="1">직접 수령, 부재시 문 앞</option>
                <option value="2">경비실에 맡겨주세요.</option>
                <option value="3">택배함</option>
                <option value="4">공동현관 앞</option>
            </select>
        	</div>
			<div>
				<c:set var="chk" value=""/>
				<c:if test="${tt==null }">
					<c:set var="chk" value="checked"/>
				</c:if>
				<input type="checkbox" name="gibon" value="1" ${chk}> 기본 배송지로 지정
        </div>
        <div><input type="submit" value="주소등록"></div>
    </form>
</body>
</html>