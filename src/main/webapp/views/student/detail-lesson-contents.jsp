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
        /* CSS tùy chỉnh */
        .content-section {
            padding: 20px;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            margin-bottom: 20px;
            background-color: #fff;
        }

        .content-section-video {
            /* Tỷ lệ 16:9 cho video nhúng */
            position: relative;
            width: 100%;
            padding-bottom: 56.25%; /* 16:9 */
            height: 0;
            overflow: hidden;
            border-radius: 8px;
        }

        .content-section-video iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border: 0;
        }

        /* Định dạng icon */
        .content-type-icon {
            font-size: 1.25rem;
            width: 30px;
            text-align: center;
        }

        /* Active link trong mục lục */
        .list-group-item.active-content-link {
            background-color: #0d6efd;
            border-color: #0d6efd;
            color: #fff;
            font-weight: bold;
        }
    </style>
</head>
<body>
<c:import url="../common/navbar.jsp"/>

<section class="py-5">
    <div class="container-fluid" style="margin-top: 50px">
        <div class="row justify-content-center">
            <div class="col-lg-12 col-xl-11">
                <div class="card border-0 shadow-lg rounded-3 p-3">
                    <div class="card-body p-4 p-md-5">

                        <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                            <div>
                                <h3 class="fw-bold text-dark mb-1">
                                    <i class="bi bi-play-circle-fill me-2 text-primary"></i>
                                    [PLACEHOLDER: Tên Bài học]
                                </h3>
                                <p class="text-muted small mb-0">
                                    <span class="fw-semibold">[PLACEHOLDER: Tên Khóa học]</span> /
                                    <span class="fw-semibold text-info">[PLACEHOLDER: Tên Module]</span>
                                </p>
                            </div>

                            <a href="[PLACEHOLDER: Link đến Danh sách Bài học]"
                               class="btn btn-outline-secondary btn-sm rounded-pill">
                                <i class="bi bi-arrow-left me-1"></i> Danh sách Bài học
                            </a>
                        </div>


                        <div class="row gx-4">
                            <div class="col-lg-4 mb-4 mb-lg-0">
                                <div class="card shadow-sm">
                                    <div class="card-header bg-primary text-white fw-bold">
                                        <i class="bi bi-list-task me-2"></i> Mục lục Bài học
                                    </div>
                                    <div class="list-group list-group-flush">

                                        <a href="#section-text"
                                           class="list-group-item list-group-item-action active-content-link">
                                            <i class="content-type-icon bi bi-file-earmark-text me-2"></i>
                                            Nội dung Lý thuyết
                                        </a>

                                        <a href="#section-video"
                                           class="list-group-item list-group-item-action">
                                            <i class="content-type-icon bi bi-camera-video me-2"></i>
                                            Video Bài giảng
                                        </a>

                                        <a href="#section-quiz"
                                           class="list-group-item list-group-item-action">
                                            <i class="content-type-icon bi bi-patch-question me-2"></i>
                                            Kiểm tra nhanh (Quiz)
                                        </a>

                                    </div>
                                </div>

                            </div>


                            <div class="col-lg-8">

                                <div id="section-text" class="content-section shadow-sm">
                                    <h4 class="mb-3 fw-bold text-primary">
                                        <i class="bi bi-file-earmark-text me-2"></i> Nội dung Lý thuyết
                                    </h4>

                                    <hr>

                                    <div class="lesson-text-content">
                                        <h3>Phần 1: Giới thiệu về HTML</h3>
                                        <p>HTML (HyperText Markup Language) là ngôn ngữ đánh dấu tiêu chuẩn được sử dụng để tạo các trang web. Nó mô tả cấu trúc của một trang web theo ngữ nghĩa và ban đầu bao gồm các tín hiệu về hình thức cho tài liệu.</p>

                                        <h4>Cấu trúc cơ bản của một tài liệu HTML:</h4>
                                        <pre>&lt;!DOCTYPE html&gt;
&lt;html lang="vi"&gt;
&lt;head&gt;
    &lt;title&gt;Tiêu đề trang&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
    &lt;h1&gt;Đây là một tiêu đề lớn&lt;/h1&gt;
    &lt;p&gt;Đây là một đoạn văn bản.&lt;/p&gt;
&lt;/body&gt;
&lt;/html&gt;</pre>
                                        <p class="mt-3">Hãy click vào mục lục bên trái để xem các phần nội dung khác của bài học.</p>
                                    </div>
                                </div>

                                <div id="section-video" class="content-section shadow-sm" style="display: none;">
                                    <h4 class="mb-3 fw-bold text-primary">
                                        <i class="bi bi-camera-video me-2"></i> Video Bài giảng
                                    </h4>
                                    <hr>
                                    <div class="content-section-video">
                                        <iframe src="https://www.youtube.com/embed/dQw4w9WgXcQ"
                                                title="Video Bài học"
                                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                                                allowfullscreen></iframe>
                                    </div>
                                </div>

                                <div id="section-quiz" class="content-section shadow-sm" style="display: none;">
                                    <h4 class="mb-3 fw-bold text-primary">
                                        <i class="bi bi-patch-question me-2"></i> Kiểm tra nhanh
                                    </h4>
                                    <hr>
                                    <div class="alert alert-warning border-0">
                                        <i class="bi bi-lightbulb me-2"></i>
                                        Bạn cần hoàn thành bài kiểm tra này để chuyển sang bài học tiếp theo.
                                        <p class="mt-2 mb-0">
                                            <a href="[PLACEHOLDER: Link đến Bài Quiz]" target="_blank" class="btn btn-warning btn-sm fw-semibold">
                                                <i class="bi bi-box-arrow-up-right me-1"></i> Bắt đầu Bài kiểm tra
                                            </a>
                                        </p>
                                    </div>
                                </div>

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