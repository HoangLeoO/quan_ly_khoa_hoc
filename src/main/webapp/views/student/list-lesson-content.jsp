<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <%-- Sử dụng lesson.getLessonName() --%>
    <title></title>
    <c:import url="../common/header.jsp"/>
    <style>
        .list-group-item:hover {
            background-color: #f8f9fa;
        }
        .content-item-link {
            text-decoration: none;
            color: inherit;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
    </style>
</head>
<body>
<c:import url="../common/navbar.jsp"/>

<section class="py-5 mt-5">
    <div class="container-fluid">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card shadow border-0">
                    <div class="card-body p-4 p-md-5">

                        <div class="mb-4">
                            <%-- Giả định quay lại danh sách các bài học của Module --%>
                            <a href="${pageContext.request.contextPath}/students?action=listLessonsByModule&moduleId=${moduleId}" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-2"></i>Quay lại danh sách Bài học
                            </a>
                        </div>

                        <div class="text-center mb-5">
                            <%-- Sử dụng lesson.getLessonName() --%>
<%--                            <h2 class="card-title fw-bold text-primary">${lesson.getLessonName()}</h2>--%>
                            <p class="text-muted mt-2">Danh sách nội dung bài học</p>
                        </div>

                        <h4 class="mb-3"><i class="bi bi-list-ol me-2"></i>Mục lục Nội dung</h4>

                        <%-- Danh sách Nội dung (Sử dụng lessonContents) --%>
                        <div class="list-group mb-4">
                            <c:choose>
                                <%-- Giả định list nội dung là lessonContents (từ Controller) --%>
                                <c:when test="${not empty lessonContents}">
                                    <c:forEach var="content" items="${lessonContents}" varStatus="status">

                                        <%-- Link đến trang chi tiết nội dung (viewSingleContent) --%>
                                        <a href="${pageContext.request.contextPath}/students?action=viewSingleContent&contentId=${content.getContentId()}&lessonId=${lesson.getLessonId()}&moduleId=${moduleId}"
                                           class="list-group-item list-group-item-action">

                                            <div class="content-item-link">
                                                <div>
                                                        <%-- Số thứ tự --%>
                                                    <span class="badge bg-secondary me-2">${status.count}</span>

                                                        <%-- Hiển thị loại nội dung --%>
                                                    <span class="badge ms-2
                                                        <c:choose>
                                                            <c:when test="${content.getContentType() eq 'video'}">bg-danger</c:when>
                                                            <c:when test="${content.getContentType() eq 'text'}">bg-primary</c:when>
                                                            <c:when test="${content.getContentType() eq 'quiz'}">bg-success</c:when>
                                                            <c:otherwise>bg-info</c:otherwise>
                                                        </c:choose>" style="width: 80px">
                                                        <c:choose>
                                                            <c:when test="${content.getContentType() eq 'video'}"><i class="bi bi-play-circle me-1"></i>Video</c:when>
                                                            <c:when test="${content.getContentType() eq 'text'}"><i class="bi bi-file-text me-1"></i>Bài đọc</c:when>
                                                            <c:when test="${content.getContentType() eq 'quiz'}"><i class="bi bi-question-circle me-1"></i>Quiz</c:when>
                                                            <c:otherwise>Nội dung</c:otherwise>
                                                        </c:choose>
                                                    </span>

                                                        <%-- Tên nội dung --%>
                                                    <span class="fw-bold ms-2">${content.getContentName()}</span>
                                                </div>

                                                    <%-- Icon xem chi tiết --%>
                                                <i class="bi bi-chevron-right text-primary"></i>
                                            </div>
                                        </a>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-warning text-center" role="alert">
                                        Chưa có nội dung nào được thêm vào bài học này.
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <%-- Loại bỏ nút Thêm Nội dung mới --%>

                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<c:import url="../common/footer.jsp"/>

<%-- Loại bỏ toàn bộ phần JS liên quan đến Admin (Toast, Modal, Form Validation) --%>
</body>
</html>