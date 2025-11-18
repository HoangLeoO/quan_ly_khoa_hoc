<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 11/18/2025
  Time: 10:11 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg bg-white fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#">
            <i class="bi bi-mortarboard-fill me-2"></i>CODEGYM Teacher
        </a>
        <button
                class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarNav"
                aria-controls="navbarNav"
                aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="course-management.html"
                    >Trang chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="course-management.html"
                    >📋 Điểm danh</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                        📝 Nhật kí</a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">Nhật kí lớp học</a>
                        <a class="dropdown-item" href="#">Nhật kí học sinh</a>
                    </div>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                        📊 Thống kê</a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">Chuyên cần</a>
                        <a class="dropdown-item" href="#">Tiến độ học tập</a>
                    </div>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                        👤 Tài Khoản</a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">Thông tin cá nhân</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Đăng xuất</a>
                    </div>
                </li>

            </ul>
        </div>
    </div>
</nav>
