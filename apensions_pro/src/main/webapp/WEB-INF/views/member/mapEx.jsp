<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <c:forEach items="${mapAll}" var="map">
    <p align="center">  ${map.userid} : ${map.name} : ${map.email} </p>
   </c:forEach>
</body>
</html>



