<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>${lesson.getLessonName()}</title>
    <c:import url="../common/header.jsp"/>
    <style>
        .video-container {
            position: relative;
            padding-bottom: 56.25%; /* 16:9 aspect ratio */
            height: 0;
            overflow: hidden;
            max-width: 100%;
            background: #000;
        }
        .video-container iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border-radius: 8px; /* Thêm bo góc cho video */
        }
        .content-box {
            line-height: 1.8;
            font-size: 1.1rem;
            color: #343a40;
            padding: 20px;
            border-radius: 8px;
            background-color: #f8f9fa; /* Nền nhẹ cho nội dung đọc */
            border-left: 5px solid #007bff; /* Thanh màu xanh nổi bật */
        }
        .lesson-header {
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
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

                        <div class="mb-4">
                            <%-- Giả định quay lại trang danh sách mục lục (cần lessonId và moduleId) --%>
                            <a href="${pageContext.request.contextPath}/students?action=lesson-content&lessonId=${lessonId}&module-id=${moduleId}" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-2"></i>Quay lại Mục lục Bài học
                            </a>
                        </div>

                        <div class="text-center mb-5 lesson-header">
                            <h2 class="card-title fw-bold text-primary">${lesson.getLessonName()}</h2>
                            <%-- Hiển thị loại nội dung --%>
                            <span class="badge bg-info text-uppercase fs-6 mt-2">
                                <c:choose>
                                    <c:when test="${lessonContent.getContentType() eq 'video'}">Video Bài giảng</c:when>
                                    <c:when test="${lessonContent.getContentType() eq 'text'}">Bài Đọc</c:when>
                                    <c:when test="${lessonContent.getContentType() eq 'quiz'}">Kiểm Tra (Quiz)</c:when>
                                    <c:otherwise>Nội dung Khác</c:otherwise>
                                </c:choose>
                            </span>
                        </div>

                        <c:choose>
                            <c:when test="${not empty lessonContent}">

                                <c:if test="${lessonContent.contentType eq 'video' and not empty lessonContent.contentData}">
                                    <h4 class="mb-3"><i class="bi bi-camera-video-fill me-2 text-danger"></i>Video Bài giảng</h4>
                                    <div class="video-container mb-4 rounded shadow-lg">
                                        <iframe src="https://www.youtube.com/embed/${lessonContent.contentData}"
                                                title="YouTube video player" frameborder="0"
                                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                                allowfullscreen></iframe>
                                    </div>
                                </c:if>

                                <c:if test="${lessonContent.contentType eq 'text' and not empty lessonContent.contentData}">
                                    <h4 class="mb-3"><i class="bi bi-book-half me-2 text-success"></i>Nội dung Bài đọc</h4>
                                    <div class="content-box shadow-sm">
                                            <%-- Sử dụng escapeXml="false" nếu contentData chứa HTML an toàn (ví dụ: định dạng từ rich text editor) --%>
                                        <p><c:out value="${lessonContent.contentData}" escapeXml="false"/></p>
                                    </div>
                                </c:if>

                                <c:if test="${lessonContent.contentType eq 'quiz'}">
                                    <h4 class="mb-3"><i class="bi bi-patch-question-fill me-2 text-warning"></i>Bài Kiểm Tra</h4>
                                    <div class="alert alert-warning text-center mt-4 p-4 shadow-sm" role="alert">
                                        <h5 class="alert-heading">Sẵn sàng làm Quiz?</h5>
                                        <p>Bài học này là một bài kiểm tra. Nhấn nút dưới đây để bắt đầu (ID Quiz: ${lessonContent.contentData}).</p>
                                        <hr>
                                        <a href="${pageContext.request.contextPath}/students?action=startQuiz&quizId=${lessonContent.contentData}" class="btn btn-warning fw-bold">
                                            <i class="bi bi-box-arrow-in-right me-2"></i> Bắt đầu Quiz
                                        </a>
                                    </div>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-danger text-center shadow-sm" role="alert">
                                    <i class="bi bi-x-octagon-fill me-2"></i>
                                    Rất tiếc, nội dung chi tiết cho bài học này hiện chưa có sẵn.
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <%-- Loại bỏ nút "Chỉnh sửa nội dung" --%>

                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<c:import url="../common/footer.jsp"/>

<%-- Loại bỏ toàn bộ phần JS liên quan đến Modals, Toast, và Form Validation --%>
</body>
</html>