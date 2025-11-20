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
    <title>Chỉnh Sửa Hồ Sơ</title>
    <c:import url="../common/header.jsp"/>
    <style>
        /* CSS để tạo khoảng cách cho các trường nhập liệu */
        .form-group-row {
            margin-bottom: 1.5rem;
        }
        .form-control-static {
            padding-top: calc(0.375rem + 1px);
            padding-bottom: calc(0.375rem + 1px);
        }
    </style>
</head>
<body>
<c:import url="../common/navbar.jsp"/>

<section>
    <div class="container" style="margin-top: 50px">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card border-0 shadow">
                    <div class="card-body p-4 p-md-5">
                        <div class="text-center mb-5">
                            <i
                                    class="bi bi-person-lines-fill text-primary"
                                    style="font-size: 4rem"></i>
                            <h3 class="mt-3">Chỉnh Sửa Hồ Sơ Học Viên</h3>
                            <p class="text-muted">
                                Cập nhật các thông tin cá nhân của bạn
                            </p>
                        </div>

                        <form action="students" method="post">
                            <input type="hidden" name="action" value="update-profile">

                            <div class="mb-5">
                                <h4 class="mb-4 border-bottom pb-2">Thông tin cá nhân</h4>

                                <div class="row form-group-row align-items-center">
                                    <label for="fullName" class="col-sm-4 col-form-label fw-bold">Họ và tên:</label>
                                    <div class="col-sm-8">
                                        <input type="text"
                                               class="form-control"
                                               id="fullName"
                                               name="fullName"
                                               value="${student.getFullName()}"
                                               required>
                                    </div>
                                </div>

                                <div class="row form-group-row align-items-center">
                                    <label class="col-sm-4 col-form-label fw-bold">Email:</label>
                                    <div class="col-sm-8">
                                        <p class="form-control-static text-muted">${student.getEmail()}</p>
                                        <input type="hidden" name="email" value="${student.getEmail()}">
                                    </div>
                                </div>

                                <div class="row form-group-row align-items-center">
                                    <label for="phone" class="col-sm-4 col-form-label fw-bold">Số điện thoại:</label>
                                    <div class="col-sm-8">
                                        <input type="tel"
                                               class="form-control"
                                               id="phone"
                                               name="phone"
                                               value="${student.getPhone()}">
                                    </div>
                                </div>

                                <div class="row form-group-row align-items-center">
                                    <label for="dob" class="col-sm-4 col-form-label fw-bold">Ngày sinh:</label>
                                    <div class="col-sm-8">
                                        <input type="date"
                                               class="form-control"
                                               id="dob"
                                               name="dob"
                                               value="${student.getDob()}">
                                    </div>
                                </div>

                                <div class="row form-group-row align-items-center">
                                    <label for="address" class="col-sm-4 col-form-label fw-bold">Địa chỉ:</label>
                                    <div class="col-sm-8">
                                        <input type="text"
                                               class="form-control"
                                               id="address"
                                               name="address"
                                               value="${student.getAddress()}">
                                    </div>
                                </div>
                            </div>

                            <div class="d-flex justify-content-center mt-5">
                                <button type="submit" class="btn btn-lg btn-primary shadow-sm me-3">
                                    <i class="bi bi-save me-2"></i>Lưu thay đổi
                                </button>
                                <a href="students?action=view-profile" class="btn btn-lg btn-outline-secondary shadow-sm">
                                    <i class="bi bi-x-circle me-2"></i>Hủy bỏ
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

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>