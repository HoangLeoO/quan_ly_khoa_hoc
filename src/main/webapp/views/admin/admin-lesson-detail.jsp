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
    <div class="container-fluid">
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

                        <h4 class="mb-3">Danh sách Nội dung</h4>
                        <div class="list-group mb-4">
                            <c:choose>
                                <c:when test="${not empty lessonContents}">
                                    <c:forEach var="content" items="${lessonContents}" varStatus="status">
                                        <div class="list-group-item d-flex justify-content-between align-items-center">
                                            <div>
                                                <span class="badge bg-secondary me-2">${status.count}</span>
                                                <span class="fw-bold">
                                                    <c:choose>
                                                        <c:when test="${content.contentType eq 'video'}"><i class="bi bi-play-circle me-1 text-danger"></i>Video</c:when>
                                                        <c:when test="${content.contentType eq 'text'}"><i class="bi bi-file-text me-1 text-primary"></i>Bài đọc</c:when>
                                                        <c:when test="${content.contentType eq 'quiz'}"><i class="bi bi-question-circle me-1 text-success"></i>Quiz</c:when>
                                                        <c:otherwise><i class="bi bi-info-circle me-1"></i>Nội dung</c:otherwise>
                                                    </c:choose>
                                                </span>
                                                <small class="text-muted ms-2">
                                                    <c:choose>
                                                        <c:when test="${content.contentType eq 'video'}">${content.contentData}</c:when>
                                                        <c:when test="${content.contentType eq 'text'}">${content.contentData.length() > 50 ? content.contentData.substring(0, 50).concat('...') : content.contentData}</c:when>
                                                        <c:when test="${content.contentType eq 'quiz'}">${content.contentData}</c:when>
                                                    </c:choose>
                                                </small>
                                            </div>
                                            <div>
                                                <a href="/admin/lessons?action=viewSingleContent&contentId=${content.contentId}&lessonId=${lesson.lessonId}&moduleId=${moduleId}" class="btn btn-sm btn-outline-primary">
                                                    <i class="bi bi-eye"></i> Xem
                                                </a>
                                                <button class="btn btn-sm btn-outline-primary edit-content-btn"
                                                        data-bs-toggle="modal" data-bs-target="#lessonContentFormModal"
                                                        data-content-id="${content.contentId}"
                                                        data-lesson-id="${lesson.lessonId}"
                                                        data-module-id="${moduleId}"
                                                        data-content-type="${content.contentType}"
                                                        data-content-data="${content.contentData}">
                                                    <i class="bi bi-pencil"></i> Sửa
                                                </button>
                                                <button class="btn btn-sm btn-outline-danger delete-content-btn"
                                                        data-bs-toggle="modal" data-bs-target="#confirmDeleteContentModal"
                                                        data-content-id="${content.contentId}"
                                                        data-content-type="${content.contentType}"
                                                        data-content-data="${content.contentData}"
                                                        data-lesson-id="${lesson.lessonId}"
                                                        data-module-id="${moduleId}">
                                                    <i class="bi bi-trash"></i> Xóa
                                                </button>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-warning text-center" role="alert">
                                        Chưa có nội dung nào cho bài học này.
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Add Content Button -->
                        <div class="text-center mt-4">
                            <button id="addLessonContentBtn" class="btn btn-primary"
                                    data-bs-toggle="modal" data-bs-target="#lessonContentFormModal"
                                    data-lesson-id="${lesson.lessonId}"
                                    data-module-id="${moduleId}">
                                <i class="bi bi-plus-circle me-2"></i>Thêm Nội dung mới
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
<c:import url="admin-lesson-content-confirm-delete.jsp"/>

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
        const modalTitle = document.getElementById('lessonContentFormModalLabel');
        const submitButton = lessonContentFormModalEl.querySelector('button[type="submit"]');
        const contentTypeSelect = document.getElementById('contentTypeContent');
        const contentDataField = document.getElementById('contentDataFieldContent');
        const lessonIdContentInput = document.getElementById('lessonIdContent');
        const moduleIdContentInput = document.getElementById('moduleIdContent');
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

        // --- Handle Add/Edit Content Modal ---
        lessonContentFormModalEl.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget; // Button that triggered the modal
            const lessonId = button.dataset.lessonId;
            const moduleId = button.dataset.moduleId;
            
            lessonIdContentInput.value = lessonId;
            moduleIdContentInput.value = moduleId;

            if (button.id === 'addLessonContentBtn') {
                form.action = '/admin/lessons?action=addContent'; // New action for adding content
                form.reset();
                form.classList.remove('was-validated');
                modalTitle.textContent = 'Thêm Nội dung mới';
                submitButton.innerHTML = '<i class="bi bi-plus-circle me-2"></i>Thêm Nội dung';
                contentTypeSelect.value = '';
                updateContentDataField('');
            } else if (button.classList.contains('edit-content-btn')) {
                form.action = '/admin/lessons?action=updateContent';
                form.classList.remove('was-validated');
                modalTitle.textContent = 'Cập nhật Nội dung';
                submitButton.innerHTML = '<i class="bi bi-check-circle me-2"></i>Cập nhật Nội dung';
                
                const contentId = button.dataset.contentId;
                const contentType = button.dataset.contentType;
                const contentData = button.dataset.contentData;

                // Set hidden contentId for update
                let hiddenContentIdInput = document.getElementById('contentId');
                if (!hiddenContentIdInput) {
                    hiddenContentIdInput = document.createElement('input');
                    hiddenContentIdInput.type = 'hidden';
                    hiddenContentIdInput.name = 'contentId';
                    hiddenContentIdInput.id = 'contentId';
                    form.appendChild(hiddenContentIdInput);
                }
                hiddenContentIdInput.value = contentId;

                contentTypeSelect.value = contentType;
                updateContentDataField(contentType, contentData);
            }
        });

        // --- Handle Delete Content Modal ---
        const confirmDeleteContentModalEl = document.getElementById('confirmDeleteContentModal');
        if (confirmDeleteContentModalEl) {
            const deleteContentIdInput = document.getElementById('deleteContentId');
            const contentDataToDelete = document.getElementById('contentDataToDelete');
            const deleteContentLessonIdInput = document.getElementById('deleteContentLessonId');
            const deleteContentModuleIdInput = document.getElementById('deleteContentModuleId');

            document.querySelectorAll('.delete-content-btn').forEach(button => {
                button.addEventListener('click', function () {
                    deleteContentIdInput.value = this.dataset.contentId;
                    contentDataToDelete.textContent = this.dataset.contentData.length > 50 ? this.dataset.contentData.substring(0, 50).concat('...') : this.dataset.contentData;
                    deleteContentLessonIdInput.value = this.dataset.lessonId;
                    deleteContentModuleIdInput.value = this.dataset.moduleId;
                });
            });
        }

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
                case 'add_content_success': toastMessage = 'Đã thêm nội dung bài học thành công!'; isSuccess = true; break;
                case 'add_content_failed': toastMessage = 'Thêm nội dung bài học thất bại. Vui lòng điền đầy đủ thông tin.'; isError = true; break;
                case 'delete_content_success': toastMessage = 'Đã xóa nội dung bài học thành công!'; isSuccess = true; break;
                case 'delete_content_failed': toastMessage = 'Xóa nội dung bài học thất bại.'; isError = true; break;
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
