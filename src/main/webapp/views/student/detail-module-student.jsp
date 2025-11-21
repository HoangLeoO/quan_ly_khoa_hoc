<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 18/11/2025
  Time: 10:16 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Danh sách Bài học</title>
    <c:import url="../common/header.jsp"/>
    <style>
        /* CSS tùy chỉnh để làm nổi bật trạng thái hoàn thành */
        .lesson-list-item {
            transition: all 0.3s ease;
            border-left: 5px solid transparent;
            border-radius: 8px; /* Bo góc nhẹ cho mỗi item */
        }

        .lesson-list-item:hover {
            background-color: #f8f9fa;
        }

        .lesson-completed {
            background-color: #d1e7dd; /* Màu nền success-subtle của Bootstrap */
            border-left-color: #198754; /* Màu viền xanh lá (Success) */
        }

        .lesson-completed:hover {
            background-color: #c0ddd3;
        }

        /* Định dạng icon và tiêu đề đồng nhất với các trang khác */
        .main-header-icon {
            font-size: 4.5rem !important;
            color: #0d6efd;
        }

        /* CSS ĐÃ THÊM: Định dạng khung thông tin module */
        .module-info-box {
            background-color: #f8f9fa; /* Màu nền nhẹ */
            border-left: 5px solid #0d6efd; /* Đường viền nổi bật (Primary) */
            padding: 15px;
            border-radius: 8px;
        }

        /* CSS ĐÃ THÊM: Chiều cao thanh tiến độ */
        .progress-lesson-height {
            height: 20px !important;
        }
    </style>
</head>
<body>
<c:import url="../common/navbar.jsp"/>

<section class="py-5">
    <div class="container" style="margin-top: 50px">
        <div class="row justify-content-center">
            <div class="col-lg-10 col-xl-9">
                <div class="card border-0 shadow-lg rounded-3 p-3">
                    <div class="card-body p-4 p-md-5">

                        <%-- KHU VỰC TIÊU ĐỀ ĐÃ ĐƯỢC CHỈNH SỬA --%>
                        <div class="mb-5">
                            <div class="text-center mb-4">
                                <i class="bi bi-journal-bookmark main-header-icon"></i>
                                <h3 class="mt-3 fw-bold text-dark">Các Bài Học trong Module Này</h3>
                                <p class="text-muted fs-6">
                                    Danh sách các bài học bạn cần hoàn thành trong chương trình CodeGym
                                </p>
                            </div>

                            <%-- THÊM KHUNG THÔNG TIN MODULE VÀ TIẾN ĐỘ TỔNG THỂ --%>
                            <c:set var="overallProgress" value="${empty overallLessonProgress ? 30 : overallLessonProgress}"/>

                            <%-- Thiết lập biến cho nút Quay lại --%>
                            <c:set var="currentModuleName" value="${empty moduleName ? 'Module 3: Frontend Basics' : moduleName}"/>
                            <c:set var="currentCourseName" value="${empty courseName ? 'Java Web Fullstack' : courseName}"/>


                            <div class="row gx-4">
                                <div class="col-md-7 mb-3 mb-md-0">
                                    <div class="module-info-box h-100">
                                        <h5 class="fw-bold text-primary mb-3">Thông tin Module</h5>
                                        <p class="mb-1">
                                            <i class="bi bi-folder-fill me-2 text-info"></i>
                                            <span class="fw-semibold">Module:</span> ${currentModuleName}
                                        </p>
                                        <p class="mb-0">
                                            <i class="bi bi-book me-2 text-info"></i>
                                            <span class="fw-semibold">Khóa học:</span> ${currentCourseName}
                                        </p>
                                    </div>
                                </div>
                                <div class="col-md-5">
                                    <div class="d-flex flex-column justify-content-center align-items-center bg-light p-3 rounded-3 h-100">
                                        <%-- TIẾN ĐỘ BÀI HỌC TỔNG THỂ --%>
                                        <div class="progress w-100 rounded-pill progress-lesson-height" role="progressbar" aria-label="Lesson Progress">
                                            <div class="progress-bar bg-info"
                                                 style="width: ${overallProgress}%;"
                                                 aria-valuenow="${overallProgress}"
                                                 aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <span class="fw-bold small">${overallProgress}%</span>
                                            </div>
                                        </div>
                                        <small class="text-muted mt-2">(${fn:length(lessons)} Bài học trong Module)</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%-- KẾT THÚC KHU VỰC TIÊU ĐỀ ĐÃ ĐƯỢC CHỈNH SỬA --%>

                        <div class="mb-5">

                            <%-- NÚT QUAY LẠI ĐÃ ĐƯỢC CHỈNH SỬA --%>
                            <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
                                <h4 class="mb-0 fw-semibold text-dark">Danh sách Bài học hiện tại</h4>

                                <%-- NÚT QUAY LẠI MỚI: Trỏ về trang Danh sách Module --%>
                                <%-- Yêu cầu biến moduleId, courseName và moduleName, progress phải được truyền vào trang này --%>
                                <a href="${pageContext.request.contextPath}/students?action=detail-module&module-id=${moduleId}&course-name=${currentCourseName}&module-name=${currentModuleName}&progress=${overallProgress}&class-name=${className}"
                                   class="btn btn-outline-secondary btn-sm rounded-pill">
                                    <i class="bi bi-arrow-left me-1"></i> Quay lại
                                </a>

                            </div>

                            <div class="list-group">
                                <c:forEach items="${lessons}" var="lesson" varStatus="loop">
                                    <form action="students" method="post" class="mb-2">

                                            <%-- ITEM BÀI HỌC --%>
                                        <div class="d-flex align-items-center p-3 border shadow-sm lesson-list-item
                                            ${lesson.isCompleted() ? 'lesson-completed' : ''}">

                                            <div style="width: 40px;" class="text-center fw-bold me-3">
                                                    <%-- STT --%>
                                                <span class="badge rounded-pill bg-dark">${loop.count}</span>
                                            </div>

                                                <%-- TÊN BÀI HỌC VÀ LINK --%>
                                            <div class="flex-grow-1">
                                                <a href="students?action=lesson-content&module-id=${moduleId}&lesson-id=${lesson.getLessonId()}&module-name=${currentModuleName}"
                                                   class="fw-bold text-decoration-none
                                                          ${lesson.isCompleted() ? 'text-success' : 'text-dark'}">
                                                        ${lesson.getLessonName()}
                                                </a>
                                            </div>

                                                <%-- TRẠNG THÁI (CHECKBOX) --%>
                                            <div class="text-end">

                                                <input type="hidden" name="action" value="update-lesson-status">
                                                <input type="hidden" name="lessonId" value="${lesson.getLessonId()}">

                                                <label class="form-check-label me-3 small fw-semibold
                                                              ${lesson.isCompleted() ? 'text-success' : 'text-muted'}"
                                                       for="status-check-${lesson.getLessonId()}">
                                                        ${lesson.isCompleted() ? 'Đã hoàn thành' : 'Chưa hoàn thành'}
                                                </label>

                                                <input type="checkbox"
                                                       name="status"
                                                       id="status-check-${lesson.getLessonId()}"
                                                       class="form-check-input"
                                                       style="cursor:pointer; width:1.5em; height:1.5em;"
                                                       value="true"
                                                       <c:if test="${lesson.isCompleted()}">checked</c:if>
                                                       onchange="this.form.submit()">
                                            </div>

                                        </div>
                                    </form>
                                </c:forEach>

                                <c:if test="${empty lessons}">
                                    <div class="alert alert-info text-center py-3 mt-4 border-0 shadow-sm">
                                        <i class="bi bi-info-circle me-2 fs-5"></i> Module này hiện chưa có bài học nào được gán.
                                    </div>
                                </c:if>

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