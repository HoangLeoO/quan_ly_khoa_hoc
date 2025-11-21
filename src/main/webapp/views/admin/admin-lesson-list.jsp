<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Danh sách Bài học - ${module.moduleName}</title>
    <c:import url="../common/header.jsp"/>
    <style>
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
                            <a href="/admin/courses?action=view&id=${module.courseId}" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-2"></i>Quay lại chi tiết khóa học
                            </a>
                        </div>

                        <!-- Module Info -->
                        <div class="text-center mb-5">
                            <h2 class="card-title">Module: ${module.moduleName}</h2>
                            <p class="text-muted">Danh sách các bài học</p>
                        </div>

                        <!-- Lesson List -->
                        <div class="list-group">
                            <c:choose>
                                <c:when test="${not empty lessonList}">
                                    <c:forEach var="lesson" items="${lessonList}" varStatus="index">
                                        <div class="list-group-item d-flex justify-content-between align-items-center">
                                            <div>
                                                <span class="badge bg-secondary me-2">${lesson.sortOrder}</span>
                                                <span class="fw-bold">${lesson.lessonName}</span>
                                                <c:if test="${not empty lesson.contentType}">
                                                    <span class="badge bg-info ms-2">
                                                        <c:choose>
                                                            <c:when test="${lesson.contentType eq 'video'}">Video</c:when>
                                                            <c:when test="${lesson.contentType eq 'text'}">Bài đọc</c:when>
                                                            <c:when test="${lesson.contentType eq 'quiz'}">Quiz</c:when>
                                                            <c:otherwise>Khác</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </c:if>
                                            </div>
                                            <div>
                                                <a href="/admin/lessons?action=viewContent&lessonId=${lesson.lessonId}&moduleId=${module.moduleId}" class="btn btn-sm btn-info text-white">
                                                    <i class="bi bi-eye"></i> Xem nội dung
                                                </a>
                                                <a href="/admin/lessons?action=showUpdateForm&lessonId=${lesson.lessonId}&moduleId=${module.moduleId}" class="btn btn-sm btn-outline-primary">
                                                    <i class="bi bi-pencil"></i>
                                                </a>
                                                <button type="button" class="btn btn-sm btn-outline-danger delete-lesson-btn"
                                                        data-bs-toggle="modal" data-bs-target="#confirmDeleteLessonModal"
                                                        data-lesson-id="${lesson.lessonId}"
                                                        data-lesson-name="${lesson.lessonName}">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="list-group-item text-center text-muted">
                                        Chưa có bài học nào trong module này.
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Add Lesson Button -->
                        <div class="text-center mt-4">
                            <button id="addLessonBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#lessonFormModal">
                                <i class="bi bi-plus-circle me-2"></i>Thêm Bài học mới
                            </button>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Modals -->
<c:import url="admin-lesson-form.jsp"/>
<c:import url="admin-lesson-confirm-delete.jsp"/>

<!-- Hidden data for lesson to edit -->
<c:if test="${not empty mode and mode eq 'update'}">
    <div id="lesson-data-to-edit"
         data-lesson-id="<c:out value='${lessonToEdit.lessonId}'/>"
         data-lesson-name="<c:out value='${lessonToEdit.lessonName}'/>"
         data-sort-order="<c:out value='${lessonToEdit.sortOrder}'/>"
         data-content-type="<c:out value='${lessonToEdit.contentType}'/>"
         data-content-data="<c:out value='${lessonContentToEdit.contentData}'/>">
    </div>
</c:if>

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
        const lessonFormModalEl = document.getElementById('lessonFormModal');
        if (!lessonFormModalEl) return;

        const lessonFormModal = new bootstrap.Modal(lessonFormModalEl);
        const form = document.getElementById('lessonForm');
        const modalTitle = document.getElementById('lessonFormModalLabel');
        const submitButton = lessonFormModalEl.querySelector('button[type="submit"]');
        const cancelResetButton = document.getElementById('cancel-reset-btn');
        const contentTypeSelect = document.getElementById('contentType');
        const contentDataField = document.getElementById('contentDataField');
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

        function switchToCreateMode() {
            form.action = '/admin/lessons?action=add';
            form.reset();
            form.classList.remove('was-validated');
            modalTitle.textContent = 'Thêm Bài học mới';
            submitButton.innerHTML = '<i class="bi bi-plus-circle me-2"></i>Thêm Bài học';
            cancelResetButton.textContent = 'Làm mới';
            document.getElementById('lessonId').value = '';
            document.getElementById('sortOrder').value = 0;
            contentTypeSelect.value = '';
            updateContentDataField('');
        }

        function switchToUpdateMode(lesson, lessonContent) {
            form.action = '/admin/lessons?action=update';
            form.classList.remove('was-validated');
            modalTitle.textContent = 'Cập nhật Bài học';
            submitButton.innerHTML = '<i class="bi bi-check-circle me-2"></i>Cập nhật';
            cancelResetButton.textContent = 'Hủy';
            document.getElementById('lessonId').value = lesson.lessonId;
            document.getElementById('lessonName').value = lesson.lessonName;
            document.getElementById('sortOrder').value = lesson.sortOrder;
            contentTypeSelect.value = lesson.contentType;
            updateContentDataField(lesson.contentType, lessonContent.contentData);
        }

        // --- Handle Add Lesson Modal ---
        lessonFormModalEl.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
            if (button && button.id === 'addLessonBtn') {
                switchToCreateMode();
            }
        });

        // --- Check for update mode on page load ---
        const lessonDataElement = document.getElementById('lesson-data-to-edit');
        if (lessonDataElement) {
            const lessonToEdit = {
                lessonId: lessonDataElement.dataset.lessonId,
                lessonName: lessonDataElement.dataset.lessonName,
                sortOrder: lessonDataElement.dataset.sortOrder,
                contentType: lessonDataElement.dataset.contentType
            };
            const lessonContentToEdit = {
                contentData: lessonDataElement.dataset.contentData
            };
            switchToUpdateMode(lessonToEdit, lessonContentToEdit);
            lessonFormModal.show();
        }

        // --- Logic for the Cancel/Reset button ---
        let shouldRedirectAfterClose = false;
        if (cancelResetButton) {
            cancelResetButton.addEventListener('click', function (event) {
                if (this.textContent.trim() === 'Hủy') {
                    event.preventDefault();
                    shouldRedirectAfterClose = true;
                    lessonFormModal.hide();
                } else { // "Làm mới"
                    form.reset();
                    form.classList.remove('was-validated');
                    document.getElementById('sortOrder').value = 0;
                    contentTypeSelect.value = '';
                    updateContentDataField('');
                }
            });
        }

        // --- Logic for redirecting after modal closes ---
        lessonFormModalEl.addEventListener('hidden.bs.modal', function () {
            const currentUrl = new URL(window.location);
            const action = currentUrl.searchParams.get('action');
            if ((action === 'showUpdateForm') && shouldRedirectAfterClose) {
                window.location.href = '/admin/lessons?action=listByModule&moduleId=${module.moduleId}';
            }
            shouldRedirectAfterClose = false;
        });

        // --- Handle Delete Modal ---
        const confirmDeleteLessonModalEl = document.getElementById('confirmDeleteLessonModal');
        if (confirmDeleteLessonModalEl) {
            const deleteLessonIdInput = document.getElementById('deleteLessonId');
            const lessonNameToDelete = document.getElementById('lessonNameToDelete');
            const deleteLessonModuleIdInput = document.getElementById('deleteLessonModuleId');

            document.querySelectorAll('.delete-lesson-btn').forEach(button => {
                button.addEventListener('click', function () {
                    deleteLessonIdInput.value = this.dataset.lessonId;
                    lessonNameToDelete.textContent = this.dataset.lessonName;
                    deleteLessonModuleIdInput.value = '${module.moduleId}';
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
                case 'add_lesson_success': toastMessage = 'Đã thêm bài học mới thành công!'; isSuccess = true; break;
                case 'update_lesson_success': toastMessage = 'Đã cập nhật bài học thành công!'; isSuccess = true; break;
                case 'delete_lesson_success': toastMessage = 'Đã xóa bài học thành công.'; isSuccess = true; break;
                case 'add_lesson_failed': toastMessage = 'Thêm bài học thất bại. Vui lòng điền đầy đủ thông tin.'; isError = true; break;
                case 'update_lesson_failed': toastMessage = 'Cập nhật bài học thất bại. Vui lòng điền đầy đủ thông tin.'; isError = true; break;
                case 'duplicate_lesson': toastMessage = 'Tên bài học đã tồn tại trong module này.'; isError = true; break;
                case 'invalid_sort_order': toastMessage = 'Thứ tự sắp xếp phải là một số hợp lệ.'; isError = true; break;
                case 'negative_sort_order': toastMessage = 'Thứ tự sắp xếp không được là số âm.'; isError = true; break;
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
                cleanUrl.searchParams.delete('mode');
                cleanUrl.searchParams.delete('lessonId');
                cleanUrl.searchParams.delete('moduleId');
                window.history.replaceState({}, '', cleanUrl.pathname + cleanUrl.search);
            }
        }
    });
</script>
</body>
</html>
