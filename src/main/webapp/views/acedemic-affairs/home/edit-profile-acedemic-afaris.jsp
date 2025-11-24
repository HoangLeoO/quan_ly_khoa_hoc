<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 18/11/2025
  Time: 10:16 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Chỉnh Sửa Hồ Sơ</title>
    <c:import url="../../common/header.jsp"/>
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
<c:import url="../../common/navbar.jsp"/>

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
                            <h3 class="mt-3">Chỉnh Sửa Hồ Sơ Giáo vụ</h3>
                            <p class="text-muted">
                                Cập nhật các thông tin cá nhân của bạn
                            </p>
                        </div>

                        <%-- THÊM class="needs-validation" và novalidate --%>
                        <form action="acedemic-affairs" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="action" value="update-profile">

                            <div class="mb-5">
                                <h4 class="mb-4 border-bottom pb-2">Thông tin cá nhân</h4>

                                <div class="row form-group-row align-items-center">
                                    <label for="fullName" class="col-sm-4 col-form-label fw-bold">
                                        Họ và tên: <span class="text-danger">*</span>
                                    </label>
                                    <div class="col-sm-8">
                                        <input type="text"
                                               class="form-control"
                                               id="fullName"
                                               name="fullName"
                                               value="${teacher.getFullName()}"
                                               required
                                               minlength="3"
                                               maxlength="100">
                                        <div class="invalid-feedback">
                                            Vui lòng nhập Họ và tên (3-100 ký tự).
                                        </div>
                                    </div>
                                </div>

                                <div class="row form-group-row align-items-center">
                                    <label class="col-sm-4 col-form-label fw-bold">
                                        Email: <span class="text-danger">*</span>
                                    </label>
                                    <div class="col-sm-8">
                                        <p class="form-control-static text-muted">${teacher.getEmail()}</p>
                                        <input type="hidden" name="email" value="${teacher.getEmail()}">
                                    </div>
                                </div>

                                <div class="row form-group-row align-items-center">
                                    <label for="phone" class="col-sm-4 col-form-label fw-bold">Số điện thoại: <span class="text-danger">*</span></label>
                                    <div class="col-sm-8">
                                        <input type="tel"
                                               class="form-control"
                                               id="phone"
                                               name="phone"
                                               value="${teacher.getPhone()}"
                                               pattern="[0-9]{10,11}"
                                               title="Số điện thoại phải có 10 hoặc 11 chữ số.">
                                        <div class="invalid-feedback">
                                            Vui lòng nhập đúng định dạng Số điện thoại (10 hoặc 11 chữ số).
                                        </div>
                                    </div>
                                </div>

                                <div class="row form-group-row align-items-center">
                                    <label for="dob" class="col-sm-4 col-form-label fw-bold">Ngày sinh:</label>
                                    <div class="col-sm-8">
                                        <input type="date"
                                               class="form-control"
                                               id="dob"
                                               name="dob"
                                               value="${teacher.getDob()}">
                                        <div class="invalid-feedback">
                                            Ngày sinh không được là ngày trong tương lai.
                                        </div>

                                        <%-- Có thể bỏ thẻ small này nếu đã set max date bằng JS --%>
                                        <%-- <small class="text-muted mt-1 d-block">
                                            Ngày hiện tại:
                                            <fmt:formatDate value="${teacher.getDob()}" pattern="dd/MM/yyyy" />
                                        </small> --%>
                                    </div>
                                </div>

                                <div class="row form-group-row align-items-center">
                                    <label for="address" class="col-sm-4 col-form-label fw-bold">Địa chỉ:</label>
                                    <div class="col-sm-8">
                                        <input type="text"
                                               class="form-control"
                                               id="address"
                                               name="address"
                                               value="${teacher.getAddress()}">
                                    </div>
                                </div>
                            </div>

                            <div class="d-flex justify-content-center mt-5">
                                <button type="submit" class="btn btn-lg btn-primary shadow-sm me-3">
                                    <i class="bi bi-save me-2"></i>Lưu thay đổi
                                </button>
                                <a href="/acedemic-affairs?action=profile" class="btn btn-lg btn-outline-secondary shadow-sm">
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


<c:import url="../../common/footer.jsp"/>

<script>
    // JavaScript để thiết lập ngày tối đa cho trường Ngày sinh là ngày hiện tại
    document.addEventListener('DOMContentLoaded', function () {
        const dobInput = document.getElementById('dob');
        if (dobInput) {
            const today = new Date().toISOString().split('T')[0];
            dobInput.setAttribute('max', today);
        }

        // Kích hoạt Bootstrap validation
        'use strict'
        const forms = document.querySelectorAll('.needs-validation')
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }

                form.classList.add('was-validated')
            }, false)
        })
    });
</script>

</body>
</html>