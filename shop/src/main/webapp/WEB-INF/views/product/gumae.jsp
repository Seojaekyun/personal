<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function jusoChuga() {
		open("jusoWrite","","width=450,height=500");
	}
	function jusoChange() {
		open("jusoList","","width=450,height=500");
	}

</script> 

</head>
<body> <!-- product/gumae.jsp -->
	
	<main>
		<section id="member">
			<table width="1100" align="center">
				<caption><h3 align="left"> 구매자 정보 </h3></caption>
				<tr>
					<td> 이름 </td>
					<td> ${mdto.name} </td>
				</tr>
				<tr>
					<td> 이메일 </td>
					<td> ${mdto.email} </td>
				</tr>
				<tr>
					<td> 연락처 </td>
					<td>
						<input type="text" name="phone" value="${mdto.phone}">
						<input type="button" value="수정">
					</td>
				</tr>
			</table>
		</section>
		<section id="baesong">
			<table width="1100" align="center">
				<caption><h3 align="left">
					 배송 정보 
					<c:if test="${bdto!=null}">
						<input type="button" value="배송지변경" onclick="jusoChange()">
					</c:if>
					<c:if test="${bdto==null}">
						<input type="button" value="배송지등록" onclick="jusoChuga()">
					</c:if>
				</h3></caption>
				<tr>
					<td> 이름 </td>
					<td id="bname"> ${bdto.name} </td>
				</tr>
				<tr>
					<td> 배송주소 </td>
					<td id="bjuso"> ${bdto.juso} ${bdto.jusoEtc} </td>
				</tr>
				<tr>
					<td> 연락처 </td>
					<td id="bphone"> ${bdto.phone} </td>
				</tr>
				<tr>
					<td> 배송요청사항 </td>
					<td id="breq"> ${bdto.breq} </td>
				</tr>
			</table>
		</section>
		<section id="product">
			
		</section>
		<section id="price">
			
		</section>
		<section id="sudan">
			
		</section>
	
	</main>
	
</body>
</html>