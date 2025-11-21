<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <%-- SỬA: Lấy tên bài học từ phần tử đầu tiên của danh sách --%>
    <title><c:if test="${not empty lesson}">${lesson.get(0).getLessonName()}</c:if></title>
    <c:import url="../common/header.jsp"/>
    <style>
        .content-item-title {
            color: #212529; /* Màu chữ tiêu đề bình thường */
        }
        .content-item:hover {
            background-color: #e9ecef; /* Hiệu ứng hover sáng hơn */
            cursor: pointer;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        }
        .lesson-info-box {
            background-color: #f8f9fa; /* Màu nền nhẹ cho khu vực tiêu đề */
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #dee2e6;
        }
        .item-icon {
            font-size: 1.2rem;
            color: #17a2b8; /* Màu info */
        }
        .badge-type {
            background-color: #0d6efd !important; /* Màu primary */
        }
    </style>
</head>
<body>
<c:import url="../common/navbar.jsp"/>

<section class="py-5 mt-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card shadow border-0">
                    <div class="card-body p-4 p-md-5">

                        <%-- HEADER VÀ NÚT QUAY LẠI --%>
                        <div class="mb-4 d-flex justify-content-between align-items-center border-bottom pb-3">
                            <div>
                                <%-- Dùng moduleId (đã được đặt trong Controller) --%>
                                <a href="${pageContext.request.contextPath}/students?action=detail-module&module-id=${moduleId}" class="btn btn-outline-secondary">
                                    <i class="bi bi-arrow-left me-2"></i>Quay lại danh sách Bài học
                                </a>
                            </div>
                            <%-- SỬA LỖI: Dùng moduleName đã được đổi tên (giả định) --%>
                            <h4 class="text-primary mb-0">${module-name}</h4>
                        </div>

                        <%-- THÔNG TIN BÀI HỌC (SỬ DỤNG PHẦN TỬ ĐẦU TIÊN) --%>
                        <c:if test="${not empty lesson}">
                            <div class="text-center mb-5 lesson-info-box">
                                <h2 class="card-title fw-bold text-dark">
                                    Bài học: ${lesson.get(0).getLessonName()}
                                </h2>
                                <p class="text-muted fs-6 mb-0">
                                    Mục lục chi tiết và nội dung của bài học này.
                                </p>
                            </div>
                        </c:if>

                        <h4 class="mb-3 fw-semibold text-dark border-bottom pb-2">
                            <i class="bi bi-list-nested me-2"></i> Mục lục Nội dung
                        </h4>

                        <%-- DANH SÁCH MỤC LỤC --%>
                        <div class="list-group">
                            <c:choose>
                                <c:when test="${not empty lesson}">
                                    <c:forEach var="content" items="${lesson}" varStatus="index">

                                        <%-- Mỗi mục lục là một link để xem chi tiết nội dung --%>
                                        <a href="${pageContext.request.contextPath}/students?action=view-lesson-content-detail&contentId=${content.getContentId()}&lessonId=${content.getLessonId()}&module-id=${moduleId}"
                                           class="list-group-item list-group-item-action d-flex justify-content-between align-items-center content-item py-3">

                                            <div class="d-flex align-items-center">
                                                    <%-- Số thứ tự --%>
                                                <span class="badge bg-secondary me-3">${index.count}</span>

                                                    <%-- Tiêu đề Nội dung --%>
                                                <div class="fw-bold content-item-title me-3">
                                                        ${content.getContentName()}
                                                </div>

                                            </div>

                                            <div>
                                                    <%-- Icon xem chi tiết --%>
                                                <i class="bi bi-arrow-right-circle-fill text-primary item-icon"></i>
                                            </div>
                                        </a>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="list-group-item text-center text-muted py-4">
                                        <i class="bi bi-info-circle-fill me-2"></i>
                                        Bài học này hiện chưa có mục lục nội dung chi tiết.
                                    </div>
                                </c:otherwise>
                            </c:choose>
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