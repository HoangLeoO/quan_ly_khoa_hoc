<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 17/11/2025
  Time: 10:02 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>

<h2>Đăng nhập</h2>

<form action="${pageContext.request.contextPath}/login" method="post">
    <label>Email:</label><br>
    <input type="email" name="email" required><br><br>

    <label>Mật khẩu:</label><br>
    <input type="password" name="password" required><br><br>

    <c:if test="${not empty error}">
        <p style="color:red">${error}</p>
    </c:if>

    <button type="submit">Login</button>
</form>

<%--</body>--%>
<%--</html>--%>
