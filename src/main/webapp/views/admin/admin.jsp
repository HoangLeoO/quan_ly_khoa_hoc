<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Quản trị viên - CODEGYM</title>
    <c:import url="../common/header.jsp"/>
</head>
<body>
<!-- Navigation -->
<c:import url="../common/navbar.jsp"/>

<!-- Admin Section -->
<section class="py-5 mt-5">
    <div class="container" style="margin-top: 50px">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card border-0 shadow">
                    <div class="card-body p-4 p-md-5">
                        <div class="text-center mb-4">
                            <i
                                    class="bi bi-person-gear text-black"
                                    style="font-size: 4rem"></i>
                            <h3 class="mt-3">Quản lý người dùng</h3>
                            <p class="text-muted">
                                Tạo tài khoản mới cho người dùng với các vai trò khác nhau
                            </p>
                        </div>

                        <!-- User List Table -->
                        <c:import url="admin-user-list-table.jsp"/>

                        <!-- Create User Form -->
                        <c:import url="admin-create-user-form.jsp"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<c:import url="../common/footer.jsp"/>
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</body>
</html>
