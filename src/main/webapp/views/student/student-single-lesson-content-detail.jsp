<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <%-- Sử dụng lesson.lessonName --%>
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
            border-radius: 8px; /* Thêm bo góc cho video */
            box-shadow: 0 4px 8px rgba(0,0,0,0.1); /* Thêm đổ bóng */
        }
        .video-container iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border: none;
        }
        .content-text-box {
            line-height: 1.8;
            font-size: 1.1rem;
            padding: 20px;
            background-color: #f8f9fa;
            border-left: 5px solid #007bff;
            border-radius: 4px;
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
                            <%-- Đường dẫn quay lại sử dụng lessonId và moduleId từ request attributes --%>
                            <a href="${pageContext.request.contextPath}/students?action=lesson-content-list&lessonId=${lessonId}&moduleId=${moduleId}" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-2"></i>Quay lại Mục lục Bài học
                            </a>
                        </div>

                        <div class="text-center mb-5 border-bottom pb-3">
                            <h4 class="text-secondary mt-3">
                                <c:choose>
                                    <c:when test="${singleContent.contentType eq 'video'}"><i class="bi bi-play-circle me-2 text-danger"></i>Video Bài giảng</c:when>
                                    <c:when test="${singleContent.contentType eq 'text'}"><i class="bi bi-file-text me-2 text-primary"></i>Bài đọc chi tiết</c:when>
                                    <c:when test="${singleContent.contentType eq 'quiz'}"><i class="bi bi-question-circle me-2 text-success"></i>Bài Kiểm tra (Quiz)</c:when>
                                    <c:otherwise><i class="bi bi-info-circle me-2"></i>Nội dung</c:otherwise>
                                </c:choose>
                                : <span class="fw-bold">${singleContent.contentName}</span>
                            </h4>
                        </div>

                        <c:choose>
                            <c:when test="${not empty singleContent}">

                                <%-- Video Player --%>
                                <c:if test="${singleContent.contentType eq 'video' and not empty singleContent.contentData}">
                                    <h5 class="mb-3 text-danger"><i class="bi bi-camera-video-fill me-2"></i>Nội dung Video</h5>
                                    <div class="video-container mb-4 shadow-lg">
                                            <%-- ${singleContent.contentData} phải là ID video YouTube (ví dụ: dQw4w9WgXcQ) --%>
                                        <iframe src="https://www.youtube.com/embed/${singleContent.contentData}"
                                                title="YouTube video player"
                                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                                allowfullscreen></iframe>
                                    </div>
                                </c:if>

                                <%-- Content Text --%>
                                <c:if test="${singleContent.contentType eq 'text' and not empty singleContent.contentData}">
                                    <div class="mt-4">
                                        <h5 class="mb-3 text-primary"><i class="bi bi-book-half me-2"></i>Nội dung Bài đọc</h5>
                                        <div class="content-text-box shadow-sm">
                                                <%-- Sử dụng c:out với escapeXml="false" nếu contentData có thể chứa HTML (từ rich text editor) --%>
                                            <c:out value="${singleContent.contentData}" escapeXml="false"/>
                                        </div>
                                    </div>
                                </c:if>

                                <%-- Quiz (Placeholder) --%>
                                <c:if test="${singleContent.contentType eq 'quiz'}">
                                    <div class="alert alert-success text-center mt-4 p-4 shadow-sm" role="alert">
                                        <h5 class="alert-heading"><i class="bi bi-patch-question-fill me-2"></i>Bài Kiểm Tra</h5>
                                        <p>Bài học này là một bài Quiz. Nhấn nút dưới đây để bắt đầu (ID Quiz: **${singleContent.contentData}**).</p>
                                        <hr>
                                            <%-- Thay thế đường dẫn bằng action bắt đầu Quiz thực tế của bạn --%>
                                        <a href="${pageContext.request.contextPath}/students?action=startQuiz&quizId=${singleContent.contentData}" class="btn btn-success fw-bold">
                                            <i class="bi bi-box-arrow-in-right me-2"></i> Bắt đầu Quiz
                                        </a>
                                    </div>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-warning text-center" role="alert">
                                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                    Không tìm thấy nội dung chi tiết cho mục này.
                                </div>
                            </c:otherwise>
                        </c:choose>

                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<c:import url="../common/footer.jsp"/>
</body>
</html>