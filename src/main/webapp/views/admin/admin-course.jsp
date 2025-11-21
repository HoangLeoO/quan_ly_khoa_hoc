<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Quản lý Khóa học - EduLearn</title>
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
        <div class="toast-body">
            <!-- Message will be inserted here -->
        </div>
    </div>
</div>

<!-- Admin Section -->
<section class="">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card shadow">
                    <div class="card-body p-4 p-md-5">
                        <div class="text-center mb-4">
                            <i class="bi bi-book text-black" style="font-size: 4rem"></i>
                            <h3 class="mt-1">Quản lý Khóa học</h3>

                        </div>

                        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3 mb-4">
                            <!-- Search Form -->
                            <c:import url="admin-courses-filter.jsp"></c:import>

                            <!-- Add Course Button -->
                            <div class="ms-md-auto">
                                <button id="createCourseBtn" type="button" class="btn btn-primary" data-bs-toggle="modal"
                                        data-bs-target="#courseFormModal">
                                    <i class="bi bi-plus-circle me-2"></i>Tạo khóa học mới
                                </button>
                            </div>
                        </div>

                        <!-- Course List -->
                        <c:import url="admin-course-list-table.jsp"/>

                        <!-- Pagination -->
                        <c:import url="../common/pagination.jsp"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Create/Update Course Modal -->
<c:import url="admin-create-course-form.jsp"></c:import>
<!-- Confirm Delete Modal -->
<c:import url="admin-course-confirm-delete.jsp"></c:import>

<!-- Hidden data for course to edit -->
<c:if test="${not empty mode and mode eq 'update'}">
    <div id="course-data-to-edit"
         data-course-id="<c:out value='${courseToEdit.courseId}'/>"
         data-course-name="<c:out value='${courseToEdit.courseName}'/>"
         data-description="<c:out value='${courseToEdit.description}'/>">
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
        const courseFormModalElement = document.getElementById('courseFormModal');
        const courseFormModal = new bootstrap.Modal(courseFormModalElement);
        const form = document.getElementById('courseForm');
        const modalTitle = document.getElementById('courseFormModalLabel');
        const submitButton = courseFormModalElement.querySelector('button[type="submit"]');
        const cancelResetButton = document.getElementById('cancel-reset-btn');

        // Function to switch modal to "Create" mode
        function switchToCreateMode() {
            form.action = '/admin/courses?action=add';
            form.reset();
            form.classList.remove('was-validated');
            modalTitle.textContent = 'Tạo khóa học mới';
            submitButton.innerHTML = '<i class="bi bi-plus-circle me-2"></i>Tạo khóa học';
            cancelResetButton.textContent = 'Làm mới';
            document.getElementById('courseId').value = '';
        }

        // Function to switch modal to "Update" mode
        function switchToUpdateMode(course) {
            form.action = `/admin/courses?action=update`;
            form.classList.remove('was-validated');
            modalTitle.textContent = 'Cập nhật khóa học';
            submitButton.innerHTML = '<i class="bi bi-check-circle me-2"></i>Cập nhật';
            cancelResetButton.textContent = 'Hủy';
            document.getElementById('courseId').value = course.courseId;
            document.getElementById('courseName').value = course.courseName;
            document.getElementById('description').value = course.description;
        }

        // Event listener for modal show
        courseFormModalElement.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
            if (button && button.id === 'createCourseBtn') {
                switchToCreateMode();
            }
        });

        // Check if page is in "update" mode and show modal
        const courseDataElement = document.getElementById('course-data-to-edit');
        if (courseDataElement) {
            const courseToEdit = {
                courseId: courseDataElement.dataset.courseId,
                courseName: courseDataElement.dataset.courseName,
                description: courseDataElement.dataset.description
            };
            switchToUpdateMode(courseToEdit);
            courseFormModal.show();
        }

        // --- Logic for handling the Cancel button and closing the modal ---
        let shouldRedirectAfterClose = false;

        if (cancelResetButton) {
            cancelResetButton.addEventListener('click', function (event) {
                if (this.textContent.trim() === 'Hủy') {
                    event.preventDefault();
                    shouldRedirectAfterClose = true;
                    courseFormModal.hide();
                } else {
                    form.reset();
                    form.classList.remove('was-validated');
                }
            });
        }

        courseFormModalElement.addEventListener('hidden.bs.modal', function () {
            const url = new URL(window.location);
            if (url.searchParams.get('action') === 'update' && shouldRedirectAfterClose) {
                window.location.href = '/admin/courses';
            }
            shouldRedirectAfterClose = false;
        });


        // Toast logic
        const urlParams = new URLSearchParams(window.location.search);
        const message = urlParams.get('message');
        if (message) {
            const toastLiveExample = document.getElementById('liveToast');
            const toastBody = toastLiveExample.querySelector('.toast-body');
            const toastHeaderIcon = toastLiveExample.querySelector('.toast-header i');
            const closeButton = toastLiveExample.querySelector('.btn-close');

            let toastMessage = '';
            let isSuccess = false;
            let isError = false;

            toastLiveExample.classList.remove('bg-success', 'bg-danger', 'text-white');
            closeButton.classList.remove('btn-close-white');

            switch (message) {
                case 'add_success':
                    toastMessage = 'Đã thêm khóa học mới thành công!';
                    isSuccess = true;
                    break;
                case 'update_success':
                    toastMessage = 'Đã cập nhật thông tin khóa học thành công!';
                    isSuccess = true;
                    break;
                case 'delete_success':
                    toastMessage = 'Đã xóa khóa học thành công.';
                    isSuccess = true;
                    break;
                case 'add_failed':
                    toastMessage = 'Thêm khóa học thất bại. Vui lòng điền đầy đủ thông tin.';
                    isError = true;
                    break;
                case 'update_failed':
                    toastMessage = 'Cập nhật thất bại. Vui lòng điền đầy đủ thông tin.';
                    isError = true;
                    break;
                case 'duplicate_course':
                    toastMessage = 'Tên khóa học đã tồn tại. Vui lòng chọn tên khác.';
                    isError = true;
                    break;
                case 'user_not_found':
                case 'invalid_id':
                    toastMessage = 'Lỗi: ID khóa học không hợp lệ hoặc không tìm thấy.';
                    isError = true;
                    break;
            }

            if (toastMessage) {
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
                window.history.replaceState({}, document.title, window.location.pathname);
            }
        }

        // Confirm Delete Modal
        var confirmDeleteModal = document.getElementById('confirmDeleteModal');
        if (confirmDeleteModal) {
            confirmDeleteModal.addEventListener('show.bs.modal', function (event) {
                var button = event.relatedTarget;
                var deleteUrl = button.getAttribute('data-delete-url');
                var courseName = button.getAttribute('data-course-name');
                var confirmDeleteButton = document.getElementById('confirmDeleteButton');
                var itemNameToDelete = document.getElementById('itemNameToDelete');

                confirmDeleteButton.setAttribute('href', deleteUrl);
                if(itemNameToDelete) {
                    itemNameToDelete.textContent = courseName;
                }
            });
        }
    });
</script>
</body>
</html>
