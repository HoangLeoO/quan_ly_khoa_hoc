<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 21/11/2025
  Time: 01:00 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Xem Điểm Khóa Học</title>
    <c:import url="../common/header.jsp"/>
    <style>
        /* Tùy chỉnh màu sắc và shadow cho tiêu đề */
        .grade-header-icon {
            font-size: 4rem !important;
        }

        /* Tùy chỉnh bảng */
        .table-responsive-custom {
            border-radius: 8px;
            overflow: hidden; /* Đảm bảo góc bo tròn của table */
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }
    </style>
</head>
<body>
<c:import url="../common/navbar.jsp"/>

<section class="py-5">
    <div class="container" style="margin-top: 50px">
        <div class="row justify-content-center">
            <div class="col-lg-12">
                <div class="card border-0 shadow-lg p-3">
                    <div class="card-body p-4 p-md-5">

                        <%-- KHU VỰC TIÊU ĐỀ --%>
                        <div class="text-center mb-5 border-bottom pb-4">
                            <i class="bi bi-bar-chart-line-fill text-primary grade-header-icon"></i>
                            <h3 class="mt-3 fw-bold text-dark">Bảng Điểm Chi Tiết Khóa Học</h3>

                            <%-- Hiển thị Tên Khóa học và Tên Học viên (Lấy từ phần tử đầu tiên của list) --%>
                            <c:if test="${not empty gradeDetails}">
                                <p class="text-muted fs-6 mb-0">
                                    <span class="fw-semibold text-dark">${gradeDetails[0].fullName}</span> -
                                    Khóa học: <span class="fw-semibold text-info">${gradeDetails[0].courseName}</span>
                                </p>
                            </c:if>
                        </div>
                        <%-- KẾT THÚC KHU VỰC TIÊU ĐỀ --%>

                        <%-- BẢNG HIỂN THỊ ĐIỂM --%>
                        <c:if test="${not empty gradeDetails}">
                            <div class="table-responsive table-responsive-custom">
                                <table class="table table-hover table-striped mb-0">
                                    <thead class="table-primary">
                                    <tr>
                                        <th scope="col" class="text-center">#</th>
                                        <th scope="col">Tên Module</th>
                                        <th scope="col" class="text-center">Điểm Lý Thuyết</th>
                                        <th scope="col" class="text-center">Điểm Thực Hành</th>
                                        <th scope="col" class="text-center">Điểm Trung Bình</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${gradeDetails}" var="grade" varStatus="stt">
                                        <tr>
                                            <th scope="row" class="text-center">${stt.count}</th>
                                            <td>
                                                <i class="bi bi-book me-2 text-muted"></i>
                                                    ${grade.moduleName}
                                            </td>
                                            <td class="text-center fw-semibold text-primary">
                                                <fmt:formatNumber value="${grade.theoryScore}" pattern="#.##"/>
                                            </td>
                                            <td class="text-center fw-semibold text-success">
                                                <fmt:formatNumber value="${grade.practiceScore}" pattern="#.##"/>
                                            </td>
                                            <td class="text-center fw-bolder">
                                                <fmt:formatNumber value="${grade.averageScore}" pattern="#.##"/>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>

                        <%-- Xử lý trường hợp không có dữ liệu --%>
                        <c:if test="${empty gradeDetails}">
                            <div class="alert alert-warning text-center py-4 mt-4 border-0 shadow-sm">
                                <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                                Hiện tại chưa có điểm số nào được ghi nhận cho khóa học này.
                            </div>
                        </c:if>

                        <div class="mt-5 text-center">
                            <a href="students?action=dashboard" class="btn btn-lg btn-outline-secondary">
                                <i class="bi bi-arrow-left me-2"></i> Quay lại Trang chủ
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