<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Hi
  Date: 18/11/2025
  Time: 2:50 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div>
    <c:import url="../common/header.jsp"/>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg bg-white fixed-top">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="bi bi-mortarboard-fill me-2"></i>CODEGYM Academic Affairs Staff
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
                        <a class="nav-link" href="view.jsp">Danh sách lớp học</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../auth/login.jsp">Đăng xuất</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Admin Section -->
    <section class="py-5 mt-5">
        <div class="container" style="margin-top: 50px">
            <div class="row justify-content-center">
                <div class="col-md-10">
                    <div class="card border-0 shadow">
                        <div class="card-body p-4 p-md-5">


                            <!-- Class List Table -->
                            <div class="mb-5">
                                <h4 class="mb-3">Danh sách Lớp học</h4>
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover align-middle">
                                        <thead class="table-light">
                                        <tr class="align-middle">
                                            <th>ID</th>
                                            <th>Tên lớp</th>
                                            <th>Khóa học</th>
                                            <th>Giáo viên</th>
                                            <th>Số lượng học viên</th>
                                            <th>Ngày bắt đầu</th>
                                            <th>Ngày kết thúc</th>

                                            <th>Thao tác</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr class="align-content-lg-center">
                                            <td>1</td>
                                            <td>C072025</td>
                                            <td>Fullstack Java</td>
                                            <td>Nguyễn Văn A</td>
                                            <td>4</td>
                                            <td>01/01/2024</td>
                                            <td>30/06/2024</td>

                                            <td>
                                                <button
                                                        class="btn btn-sm btn-outline-primary me-1"
                                                >
                                                    Thời khóa biểu
                                                </button>
                                                <button
                                                        class="btn btn-sm btn-outline-primary me-1"
                                                >
                                                    Chuyên cần
                                                </button>
                                                <button
                                                        class="btn btn-sm btn-outline-primary me-1"
                                                >
                                                    Nhật ký
                                                </button>
                                            </td>
                                        </tr>
                                        <tr class="align-content-lg-center">
                                            <td>2</td>
                                            <td>C082025</td>
                                            <td>Python for Data Science</td>
                                            <td>Trần Thị B</td>
                                            <td>7</td>
                                            <td>15/01/2024</td>
                                            <td>31/07/2024</td>

                                            <td>
                                                <button
                                                        class="btn btn-sm btn-outline-primary me-1"
                                                >
                                                    Thời khóa biểu
                                                </button>
                                                <button
                                                        class="btn btn-sm btn-outline-primary me-1"
                                                >
                                                    Chuyên cần
                                                </button>
                                                <button
                                                        class="btn btn-sm btn-outline-primary me-1"
                                                >
                                                    Nhật ký
                                                </button>
                                            </td>
                                        </tr>
                                        <tr class="align-content-lg-center">
                                            <td>3</td>
                                            <td>C092025</td>
                                            <td>Web Development with React</td>
                                            <td>Lê Văn C</td>
                                            <td>9</td>
                                            <td>01/02/2024</td>
                                            <td>31/08/2024</td>

                                            <td>
                                                <button
                                                        class="btn btn-sm btn-outline-primary me-1"
                                                >
                                                    Thời khóa biểu
                                                </button>
                                                <button
                                                        class="btn btn-sm btn-outline-primary me-1"
                                                >
                                                    Chuyên cần
                                                </button>
                                                <button
                                                        class="btn btn-sm btn-outline-primary me-1"
                                                >
                                                    Nhật ký
                                                </button>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
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
