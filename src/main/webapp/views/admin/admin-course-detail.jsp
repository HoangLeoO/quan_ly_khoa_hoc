<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Chi tiết Khóa học - ${course.courseName}</title>
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

                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <a href="/admin/courses" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-2"></i>Quay lại
                            </a>
                            <button id="addModuleBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#moduleFormModal">
                                <i class="bi bi-plus-circle me-2"></i>Thêm Module mới
                            </button>
                        </div>

                        <div class="text-center mb-5">
                            <h2 class="card-title">${course.courseName}</h2>
                            <p class="text-muted">${course.description}</p>
                        </div>

                        <h4 class="mb-3">Danh sách Module</h4>
                        <div class="list-group">
                            <c:choose>
                                <c:when test="${not empty moduleList}">
                                    <c:forEach var="module" items="${moduleList}" varStatus="index">
                                        <div class="list-group-item d-flex justify-content-between align-items-center">
                                            <div>
                                                <span class="badge bg-secondary me-2">${module.sortOrder}</span>
                                                <span class="fw-bold">${module.moduleName}</span>
                                                <small class="text-muted ms-2">(${module.total_lessons} bài học)</small>
                                            </div>
                                            <div>
                                                <a href="/admin/lessons?action=listByModule&moduleId=${module.moduleId}" class="btn btn-smbtn-outline-primary">
                                                    <i class="bi bi-eye"></i> Chi tiết
                                                </a>
                                                <a href="/admin/courses?action=showModuleUpdateForm&id=${course.courseId}&moduleId=${module.moduleId}" class="btn btn-sm btn-outline-primary">
                                                    <i class="bi bi-pencil"></i>
                                                </a>
                                                <button class="btn btn-sm btn-outline-danger delete-module-btn"
                                                        data-bs-toggle="modal" data-bs-target="#confirmDeleteModuleModal"
                                                        data-module-id="${module.moduleId}"
                                                        data-module-name="${module.moduleName}">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="list-group-item text-center text-muted">
                                        Chưa có module nào trong khóa học này.
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

<!-- Modals -->
<c:import url="admin-module-form.jsp"/>
<c:import url="admin-module-confirm-delete.jsp"/>

<!-- Hidden data for module to edit -->
<c:if test="${not empty mode and mode eq 'update'}">
    <div id="module-data-to-edit"
         data-module-id="<c:out value='${moduleToEdit.moduleId}'/>"
         data-module-name="<c:out value='${moduleToEdit.moduleName}'/>"
         data-sort-order="<c:out value='${moduleToEdit.sortOrder}'/>">
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
        const moduleFormModalEl = document.getElementById('moduleFormModal');
        if (!moduleFormModalEl) return;

        const moduleFormModal = new bootstrap.Modal(moduleFormModalEl);
        const form = document.getElementById('moduleForm');
        const modalTitle = document.getElementById('moduleFormModalLabel');
        const submitButton = moduleFormModalEl.querySelector('button[type="submit"]');
        const cancelResetButton = document.getElementById('cancel-reset-btn');
        const urlParams = new URLSearchParams(window.location.search);

        // --- Logic for showing the modal ---

        // 1. Handle the "Add New Module" button
        moduleFormModalEl.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
            if (button && button.id === 'addModuleBtn') {
                form.action = '/admin/modules?action=add';
                form.reset();
                form.classList.remove('was-validated');
                modalTitle.textContent = 'Thêm Module mới';
                submitButton.innerHTML = '<i class="bi bi-plus-circle me-2"></i>Thêm';
                cancelResetButton.textContent = 'Làm mới';
                document.getElementById('moduleId').value = '';
                document.getElementById('sortOrder').value = 0;
            }
        });

        // 2. Handle page load in "update" mode (from clicking the edit link)
        const moduleDataElement = document.getElementById('module-data-to-edit');
        if (moduleDataElement) {
            form.action = '/admin/modules?action=update';
            form.classList.remove('was-validated');
            modalTitle.textContent = 'Cập nhật Module';
            submitButton.innerHTML = '<i class="bi bi-check-circle me-2"></i>Cập nhật';
            cancelResetButton.textContent = 'Hủy';

            document.getElementById('moduleId').value = moduleDataElement.dataset.moduleId;
            document.getElementById('moduleName').value = moduleDataElement.dataset.moduleName;
            document.getElementById('sortOrder').value = moduleDataElement.dataset.sortOrder;

            moduleFormModal.show();
        }

        // 3. Handle re-opening the modal after a server-side validation error
        if (urlParams.get('showModuleModal') === 'true') {
            form.action = '/admin/modules?action=update';
            form.classList.remove('was-validated');
            modalTitle.textContent = 'Cập nhật Module';
            submitButton.innerHTML = '<i class="bi bi-check-circle me-2"></i>Cập nhật';
            cancelResetButton.textContent = 'Hủy';

            document.getElementById('moduleId').value = urlParams.get('errorModuleId');
            document.getElementById('moduleName').value = urlParams.get('errorModuleName');
            document.getElementById('sortOrder').value = urlParams.get('errorSortOrder');

            moduleFormModal.show();
        }

        // --- Logic for the Cancel/Reset button ---
        let shouldRedirectAfterClose = false;
        if (cancelResetButton) {
            cancelResetButton.addEventListener('click', function (event) {
                if (this.textContent.trim() === 'Hủy') {
                    event.preventDefault();
                    shouldRedirectAfterClose = true;
                    moduleFormModal.hide();
                } else { // "Làm mới"
                    form.reset();
                    form.classList.remove('was-validated');
                    document.getElementById('sortOrder').value = 0;
                }
            });
        }

        // --- Logic for redirecting after modal closes ---
        moduleFormModalEl.addEventListener('hidden.bs.modal', function () {
            const currentUrl = new URL(window.location);
            const action = currentUrl.searchParams.get('action');
            if ((action === 'showModuleUpdateForm' || urlParams.get('showModuleModal') === 'true') && shouldRedirectAfterClose) {
                window.location.href = '/admin/courses?action=view&id=${course.courseId}';
            }
            shouldRedirectAfterClose = false;
        });

        // --- Other logic (Delete Modal, Toast) ---
        const confirmDeleteModalEl = document.getElementById('confirmDeleteModuleModal');
        if (confirmDeleteModalEl) {
            const deleteModuleIdInput = document.getElementById('deleteModuleId');
            const moduleNameToDelete = document.getElementById('moduleNameToDelete');
            document.querySelectorAll('.delete-module-btn').forEach(button => {
                button.addEventListener('click', function () {
                    deleteModuleIdInput.value = this.dataset.moduleId;
                    moduleNameToDelete.textContent = this.dataset.moduleName;
                });
            });
        }

        const message = urlParams.get('message');
        if (message) {
            const toastLiveExample = document.getElementById('liveToast');
            const toastBody = toastLiveExample.querySelector('.toast-body');
            let toastMessage = '';
            let isSuccess = false;
            let isError = false;

            toastLiveExample.classList.remove('bg-success', 'bg-danger', 'text-white');

            switch (message) {
                case 'add_module_success': toastMessage = 'Đã thêm module mới thành công!'; isSuccess = true; break;
                case 'update_module_success': toastMessage = 'Đã cập nhật module thành công!'; isSuccess = true; break;
                case 'delete_module_success': toastMessage = 'Đã xóa module thành công.'; isSuccess = true; break;
                case 'add_module_failed': toastMessage = 'Thêm module thất bại. Vui lòng điền đầy đủ thông tin.'; isError = true; break;
                case 'update_module_failed': toastMessage = 'Cập nhật module thất bại. Vui lòng điền đầy đủ thông tin.'; isError = true; break;
                case 'duplicate_module': toastMessage = 'Tên module đã tồn tại trong khóa học này.'; isError = true; break;
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
                cleanUrl.searchParams.delete('showModuleModal');
                cleanUrl.searchParams.delete('errorModuleId');
                cleanUrl.searchParams.delete('errorModuleName');
                cleanUrl.searchParams.delete('errorSortOrder');
                cleanUrl.searchParams.delete('mode');
                cleanUrl.searchParams.delete('moduleId');
                window.history.replaceState({}, '', cleanUrl.pathname + cleanUrl.search);
            }
        }
    });
</script>

</body>
</html>
