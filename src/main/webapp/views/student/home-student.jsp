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
                            <h3 class="mt-3">Trang chủ học viên</h3>
                            <p class="text-muted">
                                Chào mừng học viên đến với khóa học codegym
                            </p>
                        </div>

                        <!-- User List Table -->
                        <div class="mb-5">
                            <h4 class="mb-3">Danh sách khóa học hiện tại</h4>
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead class="table-light">
                                    <tr>
                                        <th>STT</th>
                                        <th>Tên lớp học</th>
                                        <th>Tên khóa học</th>
                                        <th>Trạng thái lớp học</th>
                                        <th>Thao tác</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${classInfo}" var="c" varStatus="stt">
                                        <tr>
                                            <td>${stt.count}</td>
                                            <td>${c.getClassName()}</td>
                                            <td>${c.getCourseName()}</td>
                                            <td>${c.getStatus()}</td>
                                            <td><a href="#">
                                                <button class="btn btn-sm btn-outline-primary me-1">
                                                    Chi tiết
                                                </button>
                                            </a></td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <%-- pagination--%>
                        <div class="d-flex justify-content-center">
                            <ul class="pagination">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#">&laquo;</a>
                                </li>
                                <li class="page-item active">
                                    <a class="page-link" href="#">1</a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="#">2</a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="#">3</a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="#">4</a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="#">5</a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="#">&raquo;</a>
                                </li>
                            </ul>
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
