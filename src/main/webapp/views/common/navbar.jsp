<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 17/11/2025
  Time: 10:04 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar navbar-expand-lg bg-white fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#">
            <i class="bi bi-mortarboard-fill me-2"></i> CODEGYM
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">

                <!-- ADMIN -->
                <c:if test="${sessionScope.role == 'Admin'}">
                    <li class="nav-item"><a class="nav-link" href="#">Quản lý người dùng</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Quản lý khóa học</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Quản lý Module</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Quản lý Bài học</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Quản lý Lớp học</a></li>
                </c:if>

                <!-- TEACHER -->
                <c:if test="${sessionScope.role == 'Teacher'}">
                    <li class="nav-item"><a class="nav-link" href="/teacher">Trang chủ</a></li>
                    <li class="nav-item"> <a class="nav-link" href="/attendance?action=listToday">📋Điểm danh</a></li>
                    <li class="nav-item"> <a class="nav-link" href="/teacher">Thông tin cá nhân</a></li>
                </c:if>

                <!-- STUDENT -->
                <c:if test="${sessionScope.role == 'Student'}">
                    <li class="nav-item"><a class="nav-link" href="/students">Trang của tôi</a></li>
                    <li class="nav-item"><a class="nav-link" href="/students?action=profile">Hồ sơ của tôi</a></li>
                </c:if>

                <!-- LOGOUT -->
                <li class="nav-item">
                    <a class="nav-link text-danger" href="/logout">Đăng xuất</a>
                </li>

            </ul>
        </div>
    </div>
</nav>