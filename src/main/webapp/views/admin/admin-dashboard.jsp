<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Admin Dashboard - EduLearn</title>
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
                <div class="card shadow">
                    <div class="card-body p-4 p-md-5">
                        <div class="text-center mb-4">
                            <i class="bi bi-speedometer2 text-black" style="font-size: 4rem"></i>
                            <h3 class="mt-3">Admin Dashboard</h3>
                            <p class="text-muted">
                                Tổng quan và thống kê hệ thống
                            </p>
                        </div>

                        <div class="row text-center mb-5">
                            <div class="col-md-4">
                                <div class="card bg-primary text-white mb-3">
                                    <div class="card-body">
                                        <h5 class="card-title">Tổng số Nhân viên</h5>
                                        <p class="card-text display-4">${totalStaff}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card bg-success text-white mb-3">
                                    <div class="card-body">
                                        <h5 class="card-title">Tổng số Khóa học</h5>
                                        <p class="card-text display-4">${totalCourses}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card bg-info text-white mb-3">
                                    <div class="card-body">
                                        <h5 class="card-title">Tổng số Học viên</h5>
                                        <p class="card-text display-4">
                                            <c:set var="totalStudents" value="0"/>
                                            <c:forEach var="stats" items="${monthlyEnrollments}">
                                                <c:set var="totalStudents" value="${totalStudents + stats.count}"/>
                                            </c:forEach>
                                            ${totalStudents}
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <h4 class="mb-3">Thống kê Học viên đăng ký theo tháng</h4>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead class="table-light">
                                <tr>
                                    <th>Tháng</th>
                                    <th>Năm</th>
                                    <th>Số lượng Học viên</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty monthlyEnrollments}">
                                        <c:forEach var="stats" items="${monthlyEnrollments}">
                                            <tr>
                                                <td>${stats.month}</td>
                                                <td>${stats.year}</td>
                                                <td>${stats.count}</td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="3" class="text-center text-muted">Không có dữ liệu thống kê học viên.</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<c:import url="../common/footer.jsp"/>
</body>
</html>
