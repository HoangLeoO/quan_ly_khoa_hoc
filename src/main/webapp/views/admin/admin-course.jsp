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
            <i class="bi bi-check-circle-fill me-2"></i>
            <strong class="me-auto">Thông báo</strong>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body">
            <!-- Message will be inserted here -->
        </div>
    </div>
</div>

<!-- Admin Section -->
<section class="py-5 mt-5">
    <div class="container" style="margin-top: 50px">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card shadow">
                    <div class="card-body p-4 p-md-5">
                        <div class="text-center mb-4">
                            <i class="bi bi-book text-black" style="font-size: 4rem"></i>
                            <h3 class="mt-3">Quản lý Khóa học</h3>
                            <p class="text-muted">
                                Thêm mới và quản lý các khóa học trong hệ thống
                            </p>
                        </div>

                        <div class="d-flex justify-content-end mb-3">
                            <button id="createCourseBtn" type="button" class="btn btn-primary" data-bs-toggle="modal"
                                    data-bs-target="#courseFormModal">
                                <i class="bi bi-plus-circle me-2"></i>Tạo khóa học mới
                            </button>
                        </div>

                        <!-- Course List Table -->
                        <c:import url="admin-course-list-table.jsp"/>

                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Create/Update Course Modal -->
<div class="modal fade" id="courseFormModal" tabindex="-1" aria-labelledby="courseFormModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="courseFormModalLabel">Tạo khóa học mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="courseForm" action="/admin/courses?action=add" method="post" class="needs-validation" novalidate>
                    <input type="hidden" id="courseId" name="courseId"/>
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label for="courseName" class="form-label">Tên khóa học</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-book"></i></span>
                                <input type="text" class="form-control" id="courseName" name="courseName"
                                       placeholder="Nhập tên khóa học (ví dụ: Fullstack Java)" required/>
                                <div class="invalid-feedback">Vui lòng nhập tên khóa học.</div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label for="description" class="form-label">Mô tả</label>
                            <div class="input-group">
                                <span class="input-group-text align-items-start"><i
                                        class="bi bi-text-paragraph"></i></span>
                                <textarea class="form-control" id="description" rows="5" name="description"
                                          placeholder="Nhập mô tả chi tiết về khóa học" required></textarea>
                                <div class="invalid-feedback">Vui lòng nhập mô tả cho khóa học.</div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="submit" form="courseForm" class="btn btn-primary">
                    <i class="bi bi-plus-circle me-2"></i>Tạo khóa học
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Confirm Delete Modal -->
<div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmDeleteModalLabel">Xác nhận xóa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Bạn có chắc chắn muốn xóa khóa học này không? Hành động này không thể hoàn tác.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button id="confirmDeleteButton" type="button" class="btn btn-danger">Xóa</button>
            </div>
        </div>
    </div>
</div>


<!-- Footer -->

<c:import url="../common/footer.jsp"/>


<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Toast logic to show messages from URL parameters
        const urlParams = new URLSearchParams(window.location.search);
        const message = urlParams.get('message');
        if (message) {
            const toastLiveExample = document.getElementById('liveToast');
            const toastBody = toastLiveExample.querySelector('.toast-body');
            const toastHeaderIcon = toastLiveExample.querySelector('.toast-header i');
            let toastMessage = '';
            let toastIconClass = 'bi-check-circle-fill text-success'; // Default success

            switch (message) {
                case 'add_success':
                    toastMessage = 'Đã thêm khóa học  mới thành công!';
                    break;
                case 'update_success':
                    toastMessage = 'Đã cập nhật thông tin người dùng thành công!';
                    break;
                case 'delete_success':
                    toastMessage = 'Đã xóa người dùng thành công.';
                    toastIconClass = 'bi-trash-fill text-danger';
                    break;
                case 'user_not_found':
                    toastMessage = 'Lỗi: Không tìm thấy người dùng.';
                    toastIconClass = 'bi-exclamation-triangle-fill text-danger';
                    break;
                case 'invalid_id':
                    toastMessage = 'Lỗi: ID người dùng không hợp lệ.';
                    toastIconClass = 'bi-exclamation-triangle-fill text-danger';
                    break;
            }

            if (toastMessage) {
                toastBody.textContent = toastMessage;
                toastHeaderIcon.className = 'me-2 ' + toastIconClass;
                const toast = new bootstrap.Toast(toastLiveExample);
                toast.show();
                // Clean the URL to remove the message parameter
                window.history.replaceState({}, document.title, window.location.pathname);
            }
        }
    });
</script>
</body>
</html>
