<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section {
		width:1000px;
		margin:auto;
	}
	sectin table {
		border-spacing:0px;
	}
	section table td {
		height:40px;
	}
	section #img {
		height:280px;
	}
	section #cont {
		height:280px;
	}
	section select {
		width:120px;
		height:24px;
	}
</style>
<script>
	function chgPrice() {
		var suk=parseInt(document.rform.suk.value);    
		var inwon=parseInt(document.rform.inwon.value);
		var bbq=parseInt(document.rform.bbq.value);
		var chacol=parseInt(document.rform.chacol.value); 
        
		var sukprice=suk*${rdto.price};
		var inwonprice=(inwon-${rdto.min})*10000;
		inwonprice=inwonprice*suk;
		var bbqprice=bbq*50000;
		var chacolprice=chacol*20000;
		
		var total=sukprice+inwonprice+bbqprice+chacolprice;
		document.rform.chgprice.value=total;
		
		total=new Intl.NumberFormat().format(total);
		document.getElementById("chgprice").innerText=total;
	}
	
	function chgImg(my) {
		document.getElementById("maxImg").src="../resources/room/"+my;
	}
</script>
</head>
<body> <!-- reserve/reserveNext.jsp : 예약하고자 하는 객실의 정보
       몇박  ,  입실인원 , 옵션추가
 -->
<section>
	<form name="rform" action="reserveOk">
	<input type="hidden" name="inday" value="${date }">
	<input type="hidden" name="chgprice" value="${rdto.price }">
	<input type="hidden" name="rid" value="${rdto.id }">
	<table width="900" align="center">
		<caption> <h3> ${rdto.title} 객실 현황 </h3> </caption>
		<tr>
			<td width="170"> 입실일 </td>
			<td width="280"> ${date} </td>
			<td width="180"> 숙박일수 </td>
			<td width="280"> 
			<select name="suk" onchange="chgPrice()">
				<c:forEach begin="1" end="${suk }" var="i">
					<option value="${i}"> ${i}박 </option>
				</c:forEach>
			</select>
			</td>
		</tr>
		<tr>
			<td> 기본정보 </td>
			<td> ${rdto.min}명 / ${rdto.max}명 </td>
			<td> 입실인원(1인:10,000원) </td>
			<td> 
			<select name="inwon" onchange="chgPrice()">
				<c:forEach begin="${rdto.min}" end="${rdto.max}" var="i">
					<option value="${i}"> ${i}명 </option>
				</c:forEach>
			</select>
			</td>
		</tr>
		<tr>
			<td> BBQ(50,000원) </td>
			<td> 
				<select name="bbq" onchange="chgPrice()" ${aa}>
					<option value="0"> 선택안함 </option>
					<option value="1"> 1세트 </option>
					<option value="2"> 2세트 </option>
					<option value="3"> 3세트 </option>
					<option value="4"> 4세트 </option>
					<option value="5"> 5세트 </option>
					<option value="6"> 6세트 </option>
				</select>
			</td>
			<td> 숯불패키지(20,000원) </td>
			<td> 
				<select name="chacol" onchange="chgPrice()">
					<option value="0"> 선택안함 </option>
					<option value="1"> 1회분 </option>
					<option value="2"> 2회분 </option>
					<option value="3"> 3회분 </option>
					<option value="4"> 4회분 </option>
					<option value="5"> 5회분 </option>
					<option value="6"> 6회분 </option>
				</select>
			</td>
		</tr>
		<tr id="img">
			<td> 객실사진 </td>
			<td colspan="3" align="center">
				<img src="../resources/room/${rdto.imgs[0]}" width="400" height="260" id="maxImg"> <hr>
				<c:forEach items="${rdto.imgs}" var="img">
				<img src="../resources/room/${img}" width="50" height="30" onclick="chgImg('${img}')">
				</c:forEach>
			</td>
		</tr>
		<tr id="cont">
			<td> 객실정보 </td>
			<td colspan="3"> ${rdto.content} </td>
		</tr>
		<tr>
			<td> 총 결제 금액 </td>
			<td colspan="3"><span id="chgprice">${rdto.price2}</span>원 </td>
		</tr>
		<tr>
			<td colspan="4" align="center"><input type="submit" value="예약 완료"></td>
		</tr>
	</table>
	</form>
</section>
</body>
</html>