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
    <title>Đổi Mật Khẩu</title>
    <c:import url="../common/header.jsp"/>
</head>
<body>
<c:import url="../common/navbar.jsp"/>

<section>
    <div class="container" style="margin-top: 50px">
        <div class="row justify-content-center">
            <div class="col-md-6"> <div class="card border-0 shadow">
                <div class="card-body p-4 p-md-5">
                    <div class="text-center mb-5">
                        <i
                                class="bi bi-key-fill text-codegym"
                                style="font-size: 4rem"></i>
                        <h3 class="mt-3">Đổi Mật Khẩu</h3>
                        <p class="text-muted">
                            Hãy đảm bảo mật khẩu mới mạnh mẽ và an toàn
                        </p>
                        <c:if test="${not empty requestScope.message}">
                            <div class="alert alert-info mt-3" role="alert">
                                    ${requestScope.message}
                            </div>
                        </c:if>
                    </div>

                    <form method="POST" action="students?action=change-password">
                        <div class="mb-4">
                            <label for="currentPassword" class="form-label fw-bold">Mật khẩu hiện tại</label>
                            <input
                                    type="password"
                                    class="form-control form-control-lg"
                                    id="currentPassword"
                                    name="currentPassword"
                                    required
                                    placeholder="Nhập mật khẩu hiện tại"
                            />
                            <c:if test="${not empty requestScope.errorCurrentPassword}">
                                <div class="text-danger small mt-1">${requestScope.errorCurrentPassword}</div>
                            </c:if>
                        </div>

                        <div class="mb-4">
                            <label for="newPassword" class="form-label fw-bold">Mật khẩu mới</label>
                            <input
                                    type="password"
                                    class="form-control form-control-lg"
                                    id="newPassword"
                                    name="newPassword"
                                    required
                                    placeholder="Nhập mật khẩu mới"
                            />
                            <c:if test="${not empty requestScope.errorNewPassword}">
                                <div class="text-danger small mt-1">${requestScope.errorNewPassword}</div>
                            </c:if>
                        </div>

                        <div class="mb-5">
                            <label for="confirmNewPassword" class="form-label fw-bold">Xác nhận mật khẩu mới</label>
                            <input
                                    type="password"
                                    class="form-control form-control-lg"
                                    id="confirmNewPassword"
                                    name="confirmNewPassword"
                                    required
                                    placeholder="Xác nhận lại mật khẩu mới"
                            />
                            <c:if test="${not empty requestScope.errorConfirmPassword}">
                                <div class="text-danger small mt-1">${requestScope.errorConfirmPassword}</div>
                            </c:if>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-center">
                            <button type="submit" class="btn btn-lg btn-primary shadow-sm">
                                <i class="bi bi-check-lg me-2"></i>Lưu thay đổi
                            </button>
                            <a href="students?action=profile" class="btn btn-lg btn-outline-secondary shadow-sm">
                                <i class="bi bi-x-lg me-2"></i>Hủy và Quay lại
                            </a>
                        </div>
                    </form>
                </div>
            </div>
            </div>
        </div>
    </div>
</section>


<c:import url="../common/footer.jsp"/>
</body>
</html>