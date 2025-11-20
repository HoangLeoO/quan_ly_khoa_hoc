<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 18/11/2025
  Time: 10:16 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <c:import url="../common/header.jsp"/>
</head>
<body>
<c:import url="../common/navbar.jsp"/>

<!-- Section -->
<section>
    <div class="container" style="margin-top: 50px">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card border-0 shadow">
                    <div class="card-body p-4 p-md-5">
                        <div class="text-center mb-5">
                            <!-- Icon cho Profile -->
                            <i
                                    class="bi bi-person-circle text-codegym"
                                    style="font-size: 4rem"></i>
                            <h3 class="mt-3">Hồ Sơ Học Viên</h3>
                            <p class="text-muted">
                                Thông tin cá nhân của bạn
                            </p>
                        </div>

                        <!-- Profile Details -->
                        <div class="mb-5">
                            <h4 class="mb-4 border-bottom pb-2">Thông tin cá nhân</h4>
                            <dl class="row g-3">
                                <!-- Họ và tên -->
                                <dt class="col-sm-4 fw-bold">Họ và tên:</dt>
                                <dd class="col-sm-8">${student.getFullName()}</dd>

                                <!-- Email -->
                                <dt class="col-sm-4 fw-bold">Email:</dt>
                                <dd class="col-sm-8">${student.getEmail()}</dd>

                                <!-- Số điện thoại -->
                                <dt class="col-sm-4 fw-bold">Số điện thoại:</dt>
                                <dd class="col-sm-8">${student.getPhone()}</dd>

                                <!-- Ngày sinh -->
                                <dt class="col-sm-4 fw-bold">Ngày sinh:</dt>
                                <dd class="col-sm-8">${student.getDob()}</dd>

                                <!-- Địa chỉ -->
                                <dt class="col-sm-4 fw-bold">Địa chỉ:</dt>
                                <dd class="col-sm-8">${student.getAddress()}</dd>
                            </dl>
                        </div>

                        <!-- Action Button -->
                        <div class="d-flex justify-content-center">
                            <a href="students?action=update-profile">
                                <button class="btn btn-lg btn-outline-primary shadow-sm me-2">
                                    <i class="bi bi-pencil-square me-2"></i>Chỉnh sửa hồ sơ
                                </button>
                            </a>
                            <a href="students?action=change-password">
                                <button class="btn btn-lg btn-outline-secondary shadow-sm">
                                    <i class="bi bi-key me-2"></i>Đổi mật khẩu
                                </button>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>


<c:import url="../common/footer.jsp"/>
</body>
</html>
