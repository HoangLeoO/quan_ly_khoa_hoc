<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Chi tiết Bài học - ${lesson.lessonName}</title>
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
        .toast-container {
            position: fixed;
            top: 1rem;
            right: 1rem;
            z-index: 1055;
        }
    </style>
</head>
<body>
<!-- Navigation -->
<c:import url="../common/navbar.jsp"/>

<!-- Toast Container -->
<div class="toast-container">
    <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <i class="bi me-2"></i>
            <strong class="me-auto">Thông báo</strong>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body"></div>
    </div>
</div>

<!-- Main Content -->
<section class="py-5 mt-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card shadow">
                    <div class="card-body p-4 p-md-5">

                        <!-- Back Button -->
                        <div class="mb-4">
                            <a href="/admin/lessons?action=listByModule&moduleId=${moduleId}" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-2"></i>Quay lại danh sách bài học
                            </a>
                        </div>

                        <!-- Lesson Info -->
                        <div class="text-center mb-4">
                            <h2 class="card-title">${lesson.lessonName}</h2>
                        </div>

                        <c:choose>
                            <c:when test="${not empty lessonContent}">
                                <!-- Video Player -->
                                <c:if test="${lessonContent.contentType eq 'video' and not empty lessonContent.contentData}">
                                    <div class="video-container mb-4 rounded">
                                        <iframe src="https://www.youtube.com/embed/${lessonContent.contentData}"
                                                title="YouTube video player" frameborder="0"
                                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                                allowfullscreen></iframe>
                                    </div>
                                </c:if>

                                <!-- Content Text -->
                                <c:if test="${lessonContent.contentType eq 'text' and not empty lessonContent.contentData}">
                                    <div class="mt-4">
                                        <h4 class="mb-3">Nội dung bài học</h4>
                                        <div style="line-height: 1.8;">
                                            ${lessonContent.contentData}
                                        </div>
                                    </div>
                                </c:if>

                                <!-- Quiz (Placeholder) -->
                                <c:if test="${lessonContent.contentType eq 'quiz'}">
                                    <div class="alert alert-info text-center mt-4" role="alert">
                                        Nội dung bài học là một bài Quiz. (Chức năng Quiz chưa được triển khai)
                                    </div>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-warning text-center" role="alert">
                                    Chưa có nội dung cho bài học này.
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <!-- Edit Content Button -->
                        <div class="text-center mt-5">
                            <button id="editLessonContentBtn" class="btn btn-primary"
                                    data-bs-toggle="modal" data-bs-target="#lessonContentFormModal"
                                    data-lesson-id="${lesson.lessonId}"
                                    data-module-id="${moduleId}"
                                    data-content-type="${lessonContent.contentType}"
                                    data-content-data="${lessonContent.contentData}">
                                <i class="bi bi-pencil-square me-2"></i>Chỉnh sửa nội dung
                            </button>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Modals -->
<c:import url="admin-lesson-content-form.jsp"/>

<!-- Footer -->
<c:import url="../common/footer.jsp"/>

<script>
    // Bootstrap form validation
    (function () {
        'use strict'
        var forms = document.querySelectorAll('.needs-validation')
        Array.prototype.slice.call(forms)
            .forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }
                    form.classList.add('was-validated')
                }, false)
            })
    })();

    document.addEventListener('DOMContentLoaded', function () {
        const lessonContentFormModalEl = document.getElementById('lessonContentFormModal');
        if (!lessonContentFormModalEl) return;

        const lessonContentFormModal = new bootstrap.Modal(lessonContentFormModalEl);
        const form = document.getElementById('lessonContentForm');
        const contentTypeSelect = document.getElementById('contentTypeContent');
        const contentDataField = document.getElementById('contentDataFieldContent');
        const urlParams = new URLSearchParams(window.location.search);

        function updateContentDataField(selectedType, currentData = '') {
            let html = '';
            if (selectedType === 'text') {
                html = `
                    <label for="contentData" class="form-label">Nội dung Bài đọc</label>
                    <textarea class="form-control" id="contentData" name="contentData" rows="5" required>${currentData}</textarea>
                    <div class="invalid-feedback">Vui lòng nhập nội dung bài đọc.</div>
                `;
            } else if (selectedType === 'video') {
                html = `
                    <label for="contentData" class="form-label">ID Video YouTube</label>
                    <input type="text" class="form-control" id="contentData" name="contentData" placeholder="Ví dụ: dQw4w9WgXcQ" value="${currentData}" required/>
                    <div class="invalid-feedback">Vui lòng nhập ID video YouTube.</div>
                `;
            } else if (selectedType === 'quiz') {
                html = `
                    <label for="contentData" class="form-label">ID Quiz</label>
                    <input type="text" class="form-control" id="contentData" name="contentData" placeholder="Ví dụ: quiz_123" value="${currentData}" required/>
                    <div class="invalid-feedback">Vui lòng nhập ID Quiz.</div>
                `;
            }
            contentDataField.innerHTML = html;
        }

        contentTypeSelect.addEventListener('change', function () {
            updateContentDataField(this.value);
        });

        // --- Handle Edit Lesson Content Modal ---
        lessonContentFormModalEl.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget; // Button that triggered the modal
            if (button && button.id === 'editLessonContentBtn') {
                const lessonId = button.dataset.lessonId;
                const moduleId = button.dataset.moduleId;
                const contentType = button.dataset.contentType;
                const contentData = button.dataset.contentData;

                document.getElementById('lessonIdContent').value = lessonId;
                document.getElementById('moduleIdContent').value = moduleId;
                contentTypeSelect.value = contentType;
                updateContentDataField(contentType, contentData);
            }
        });

        // --- Toast Logic ---
        const message = urlParams.get('message');
        if (message) {
            const toastLiveExample = document.getElementById('liveToast');
            const toastBody = toastLiveExample.querySelector('.toast-body');
            let toastMessage = '';
            let isSuccess = false;
            let isError = false;

            toastLiveExample.classList.remove('bg-success', 'bg-danger', 'text-white');

            switch (message) {
                case 'update_content_success': toastMessage = 'Đã cập nhật nội dung bài học thành công!'; isSuccess = true; break;
                case 'update_content_failed': toastMessage = 'Cập nhật nội dung bài học thất bại. Vui lòng điền đầy đủ thông tin.'; isError = true; break;
            }

            if (toastMessage) {
                const toastHeaderIcon = toastLiveExample.querySelector('.toast-header i');
                const closeButton = toastLiveExample.querySelector('.btn-close');
                toastBody.textContent = toastMessage;
                if (isSuccess) {
                    toastLiveExample.classList.add('bg-success', 'text-white');
                    toastHeaderIcon.className = 'me-2 bi bi-check-circle-fill';
                    closeButton.classList.add('btn-close-white');
                } else if (isError) {
                    toastLiveExample.classList.add('bg-danger', 'text-white');
                    toastHeaderIcon.className = 'me-2 bi bi-exclamation-triangle-fill';
                    closeButton.classList.add('btn-close-white');
                }
                const toast = new bootstrap.Toast(toastLiveExample);
                toast.show();
                
                const cleanUrl = new URL(window.location);
                cleanUrl.searchParams.delete('message');
                window.history.replaceState({}, '', cleanUrl.pathname + cleanUrl.search);
            }
        }
    });
</script>
</body>
</html>
