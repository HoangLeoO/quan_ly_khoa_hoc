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
    <title>Danh sách Module</title>
    <c:import url="../common/header.jsp"/>
    <style>
        /* ... (Các CSS cũ đã giữ nguyên) ... */
        /* Tùy chỉnh CSS cho giao diện Module */
        .card-module-modern {
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08) !important;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .card-module-modern:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.12) !important;
        }

        /* Tùy chỉnh tiêu đề chính */
        .main-header-icon {
            font-size: 4.5rem !important;
            color: #0d6efd;
        }

        /* Định nghĩa lại kích thước thanh tiến độ */
        .progress-module-height {
            height: 20px !important;
        }

        /* CSS MỚI: Định dạng khung thông tin khóa học */
        .course-info-box {
            background-color: #f8f9fa; /* Màu nền nhẹ */
            border-left: 5px solid #0d6efd; /* Đường viền nổi bật */
            padding: 15px;
            border-radius: 8px;
        }

    </style>
</head>
<body>
<c:import url="../common/navbar.jsp"/>

<section class="py-5">
    <div class="container" style="margin-top: 50px">
        <div class="row justify-content-center">
            <div class="col-lg-10 col-xl-9">
                <div class="card border-0 shadow-lg p-3 rounded-3">
                    <div class="card-body p-4 p-md-5">

                        <%-- KHU VỰC TIÊU ĐỀ ĐÃ CHỈNH SỬA --%>
                        <div class="mb-5">
                            <div class="text-center mb-4">
                                <i class="bi bi-journal-bookmark main-header-icon"></i>
                                <h3 class="mt-3 fw-bold text-dark">CÁC MODULE TRONG KHÓA HỌC</h3>
                                <p class="text-muted fs-6">
                                    Danh sách các module bạn cần hoàn thành trong chương trình CodeGym
                                </p>
                            </div>

                            <%-- THÊM KHUNG THÔNG TIN KHÓA HỌC VÀ TIẾN ĐỘ TỔNG THỂ --%>
                            <c:set var="overallProgress" value="${empty overallModuleProgress ? 65 : overallModuleProgress}"/> <%-- Giá trị giả định: 65% --%>

                            <%-- Thiết lập biến để dùng cho nút quay lại --%>
                            <c:set var="currentCourseName" value="${empty courseName ? 'Java Web Fullstack' : courseName}"/>
                            <c:set var="currentClassName" value="${empty className ? 'C1125G1' : className}"/>

                            <div class="row gx-4">
                                <div class="col-md-7">
                                    <div class="course-info-box h-100">
                                        <h5 class="fw-bold text-primary mb-3">Thông tin Khóa học của bạn</h5>
                                        <p class="mb-1">
                                            <i class="bi bi-book-fill me-2 text-info"></i>
                                            <span class="fw-semibold">Khóa học:</span> ${currentCourseName}
                                        </p>
                                        <p class="mb-1">
                                            <i class="bi bi-diagram-3-fill me-2 text-info"></i>
                                            <span class="fw-semibold">Lớp học:</span> ${currentClassName}
                                        </p>
                                        <p class="mb-0">
                                            <i class="bi bi-person-circle me-2 text-info"></i>
                                            <span class="fw-semibold">Giảng viên:</span> ${empty instructorName ? 'Thầy Nguyễn Văn A' : instructorName}
                                        </p>
                                    </div>
                                </div>
                                <div class="col-md-5">
                                    <div class="d-flex flex-column justify-content-center align-items-center bg-light p-3 rounded-3 h-100">
                                        <h6 class="fw-bold text-dark mb-2">Tiến độ Module Tổng thể</h6>
                                        <div class="progress w-100 progress-module-height" role="progressbar" aria-label="Overall Progress">
                                            <div class="progress-bar bg-primary"
                                                 style="width: ${overallProgress}%;"
                                                 aria-valuenow="${overallProgress}"
                                                 aria-valuemin="0"
                                                 aria-valuemax="100">
                                                <span class="fw-bold small">${overallProgress}%</span>
                                            </div>
                                        </div>
                                        <small class="text-muted mt-2">(${fn:length(moduleList)} Module)</small>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%-- KẾT THÚC KHU VỰC TIÊU ĐỀ ĐÃ CHỈNH SỬA --%>

                        <%-- KHU VỰC DANH SÁCH MODULE --%>
                        <div class="mb-5">
                            <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
                                <h4 class="mb-0 fw-semibold text-dark">DANH SÁCH MODULE HIỆN TẠI</h4>

                                <%-- THAY THẾ NÚT QUAY LẠI: Trỏ về Trang Chủ Học Viên --%>
                                <a href="${pageContext.request.contextPath}/students?action=home"
                                   class="btn btn-outline-secondary btn-sm rounded-pill">
                                    <i class="bi bi-arrow-left me-1"></i> Quay lại
                                </a>

                            </div>

                            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 <c:if test="${fn:length(moduleList) == 1}">justify-content-center</c:if>">

                                <c:forEach items="${moduleList}" var="m" varStatus="stt">
                                    <c:set var="progress" value="${empty m.progressPercentage ? 0 : m.progressPercentage}"/>

                                    <div class="col">
                                        <div class="card h-100 card-module-modern">
                                            <div class="card-body d-flex flex-column p-3">

                                                <h5 class="card-title text-truncate text-dark fw-bold">${m.moduleName}</h5>

                                                <div class="mt-2 mb-4">
                                                    <span class="text-muted small fw-semibold">Tiến độ:</span>
                                                    <div class="progress mt-1 rounded-pill progress-module-height">
                                                        <div class="progress-bar progress-bar-striped
                                                            <c:choose>
                                                                <c:when test="${progress == 100}">bg-success</c:when>
                                                                <c:when test="${progress > 0}">bg-info</c:when>
                                                                <c:otherwise>bg-secondary</c:otherwise>
                                                            </c:choose>"
                                                             role="progressbar"
                                                             style="width: ${progress}%;"
                                                             aria-valuenow="${progress}"
                                                             aria-valuemin="0"
                                                             aria-valuemax="100">
                                                            <span class="small fw-bold">${progress}%</span>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="mt-auto">
                                                    <a href="${pageContext.request.contextPath}/students?action=detail-module&module-id=${m.moduleId}&course-name=${currentCourseName}&module-name=${m.moduleName}&progress=${progress}&class-name=${currentClassName}">
                                                        <button class="btn btn-sm btn-primary w-100 fw-semibold">
                                                            <i class="bi bi-eye me-1"></i> Xem chi tiết module
                                                        </button>
                                                    </a>
                                                </div>

                                            </div>

                                            <div class="card-footer bg-light border-0 py-2 text-center">
                                                <small class="text-muted fw-bold">#${stt.count}</small>
                                            </div>

                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <c:if test="${empty moduleList}">
                                <div class="alert alert-info text-center py-4 mt-4 border-0 shadow-sm">
                                    <i class="bi bi-info-circle me-2 fs-5"></i> Hiện chưa có module nào được gán cho bạn.
                                </div>
                            </c:if>
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