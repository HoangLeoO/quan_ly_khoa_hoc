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
    <c:import url="../common/header.jsp"/>
    <style>
        /* Optional custom styling for a better look */
        body {
            background-color: #f7f9fb; /* Light background */
        }
        .card {
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.1);
        }
        /* Custom hover effect for the button */
        .btn-primary:hover {
            transform: scale(1.01);
            transition: transform 0.15s ease-in-out;
        }
    </style>
</head>
<body class="d-flex align-items-center justify-content-center min-vh-100 p-3">

<div>
    <p><span>admin@codegym.com</span></p>
    <p><span>teacher2@codegym.com</span></p>
    <p><span>student11@codegym.com</span></p>
    <p><span>academic1@codegym.com</span></p>
</div>

<!-- Login Card Container -->
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-5 col-md-8 col-sm-10 col-12">
            <div id="login-card" class="card shadow-lg border-0 rounded-4 p-4 p-md-5">

                <div class="text-center mb-5">
                    <!-- Icon cho Đăng nhập (Bootstrap Icon) -->
                    <i class="bi bi-box-arrow-in-right text-primary" style="font-size: 3rem;"></i>
                    <h3 class="fw-bold mt-3">Đăng Nhập Hệ Thống</h3>
                    <p class="text-muted mt-1">Sử dụng tài khoản của bạn để tiếp tục</p>
                </div>

                <!-- Server-side Error Message (JSTL Integration) -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show rounded-3" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <!-- Login Form (POST to server) -->
                <form action="${pageContext.request.contextPath}/login" method="post">

                    <!-- Email/Tên đăng nhập -->
                    <div class="mb-4">
                        <label for="email" class="form-label fw-bold">Email</label>
                        <input
                                type="email"
                                id="email"
                                name="email"
                                placeholder="VD: tennguoidung@email.com"
                                required
                                class="form-control form-control-lg"
                                value="${param.email}"
                        />
                    </div>

                    <!-- Mật khẩu -->
                    <div class="mb-5">
                        <label for="password" class="form-label fw-bold">Mật khẩu</label>
                        <input
                                type="password"
                                id="password"
                                name="password"
                                placeholder="Nhập mật khẩu của bạn"
                                required
                                class="form-control form-control-lg"
                        />
                    </div>

                    <!-- Action Button -->
                    <button
                            type="submit"
                            class="w-100 btn btn-lg btn-primary shadow-sm fw-bold"
                    >
                        Đăng Nhập
                    </button>
                </form>

                <!-- Links for other actions -->
                <div class="mt-4 text-center small">
                    <a href="#" class="text-decoration-none d-block mb-1 text-primary">
                        Quên mật khẩu?
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
