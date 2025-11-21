<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Nội dung Bài học - ${lesson.lessonName}</title>
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
        }
    </style>
</head>
<body>
<!-- Navigation -->
<c:import url="../common/navbar.jsp"/>

<!-- Main Content -->
<section class="py-5 mt-5">
    <div class="container-fluid">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card shadow">
                    <div class="card-body p-4 p-md-5">

                        <!-- Back Button -->
                        <div class="mb-4">
                            <a href="/admin/lessons?action=viewContent&lessonId=${lesson.lessonId}&moduleId=${moduleId}" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-2"></i>Quay lại danh sách nội dung
                            </a>
                        </div>

                        <!-- Lesson Info -->
                        <div class="text-center mb-4">
                            <h2 class="card-title">${lesson.lessonName}</h2>
                            <h4 class="text-muted">
                                <c:choose>
                                    <c:when test="${singleContent.contentType eq 'video'}">Video</c:when>
                                    <c:when test="${singleContent.contentType eq 'text'}">Bài đọc</c:when>
                                    <c:when test="${singleContent.contentType eq 'quiz'}">Quiz</c:when>
                                    <c:otherwise>Nội dung</c:otherwise>
                                </c:choose>
                            </h4>
                        </div>

                        <c:choose>
                            <c:when test="${not empty singleContent}">
                                <!-- Video Player -->
                                <c:if test="${singleContent.contentType eq 'video' and not empty singleContent.contentData}">
                                    <div class="video-container mb-4 rounded">
                                        <iframe src="https://www.youtube.com/embed/${singleContent.contentData}"
                                                title="YouTube video player" frameborder="0"
                                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                                allowfullscreen></iframe>
                                    </div>
                                </c:if>

                                <!-- Content Text -->
                                <c:if test="${singleContent.contentType eq 'text' and not empty singleContent.contentData}">
                                    <div class="mt-4">
                                        <h4 class="mb-3">Nội dung chi tiết</h4>
                                        <div style="line-height: 1.8; white-space: pre-wrap;">
                                            ${singleContent.contentData}
                                        </div>
                                    </div>
                                </c:if>

                                <!-- Quiz (Placeholder) -->
                                <c:if test="${singleContent.contentType eq 'quiz'}">
                                    <div class="alert alert-info text-center mt-4" role="alert">
                                        Nội dung bài học là một bài Quiz với ID: <strong>${singleContent.contentData}</strong> (Chức năng Quiz chưa được triển khai)
                                    </div>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-warning text-center" role="alert">
                                    Không tìm thấy nội dung chi tiết.
                                </div>
                            </c:otherwise>
                        </c:choose>

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
