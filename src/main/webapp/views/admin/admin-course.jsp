<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
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
                            <button id="createCourseBtn" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#courseFormModal">
                                <i class="bi bi-plus-circle me-2"></i>Tạo khóa học mới
                            </button>
                        </div>

                        <!-- Course List Table -->
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Tên khóa học</th>
                                    <th>Mô tả</th>
                                    <th>Ngày tạo</th>
                                    <th>Thao tác</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <%-- Course rows will be rendered by JavaScript --%>
                                </tbody>
                            </table>
                        </div>
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
                <form id="courseForm" class="needs-validation" novalidate>
                    <input type="hidden" id="courseId" value="" />
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label for="courseName" class="form-label">Tên khóa học</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-book"></i></span>
                                <input type="text" class="form-control" id="courseName" placeholder="Nhập tên khóa học (ví dụ: Fullstack Java)" required />
                                <div class="invalid-feedback">Vui lòng nhập tên khóa học.</div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label for="description" class="form-label">Mô tả</label>
                            <div class="input-group">
                                <span class="input-group-text align-items-start"><i class="bi bi-text-paragraph"></i></span>
                                <textarea class="form-control" id="description" rows="5" placeholder="Nhập mô tả chi tiết về khóa học" required></textarea>
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
<div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
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
        // Initial data
        let courses = [
            { id: 1, name: "Fullstack Java", description: "Khóa học lập trình Java từ cơ bản đến nâng cao, bao gồm cả frontend và backend", createdDate: "01/01/2023" },
            { id: 2, name: "Python for Data Science", description: "Khóa học phân tích dữ liệu với Python và các thư viện phổ biến", createdDate: "05/01/2023" },
            { id: 3, name: "Web Development with React", description: "Khóa học phát triển web frontend với React.js và các công nghệ liên quan", createdDate: "10/01/2023" },
        ];
        let nextId = 4;

        // DOM Elements
        const courseFormModal = new bootstrap.Modal(document.getElementById('courseFormModal'));
        const courseForm = document.getElementById('courseForm');
        const modalTitle = document.getElementById('courseFormModalLabel');
        const modalSubmitButton = courseFormModal._element.querySelector('button[type="submit"]');
        const confirmDeleteModal = new bootstrap.Modal(document.getElementById('confirmDeleteModal'));
        const confirmDeleteButton = document.getElementById('confirmDeleteButton');
        const toastLiveExample = document.getElementById('liveToast');
        const toast = new bootstrap.Toast(toastLiveExample);
        let courseIdToDelete = null;

        // Toast function
        function showToast(message, type = 'success') {
            const toastBody = toastLiveExample.querySelector('.toast-body');
            const toastHeaderIcon = toastLiveExample.querySelector('.toast-header i');
            toastBody.textContent = message;
            if (type === 'success') {
                toastHeaderIcon.className = 'me-2 bi bi-check-circle-fill text-success';
            } else if (type === 'danger') {
                toastHeaderIcon.className = 'me-2 bi bi-trash-fill text-danger';
            }
            toast.show();
        }

        // Render table
        function renderCourseTable() {
            const tableBody = document.querySelector("tbody");
            tableBody.innerHTML = "";
            courses.forEach(course => {
                const row = `
                    <tr>
                        <td>${course.id}</td>
                        <td>${course.name}</td>
                        <td>${course.description}</td>
                        <td>${course.createdDate}</td>
                        <td class="d-flex border-0">
                            <button class="btn btn-sm btn-outline-primary me-1 edit-btn" data-course-id="${course.id}">
                                <i class="bi bi-pencil"></i>
                            </button>
                            <button class="btn btn-sm btn-outline-danger delete-btn" data-course-id="${course.id}">
                                <i class="bi bi-trash"></i>
                            </button>
                        </td>
                    </tr>`;
                tableBody.insertAdjacentHTML('beforeend', row);
            });
        }

        // Switch to create mode
        function switchToCreateMode() {
            courseForm.reset();
            courseForm.classList.remove('was-validated');
            document.getElementById('courseId').value = '';
            modalTitle.textContent = 'Tạo khóa học mới';
            modalSubmitButton.innerHTML = '<i class="bi bi-plus-circle me-2"></i>Tạo khóa học';
        }

        // Switch to edit mode
        function switchToEditMode(course) {
            courseForm.reset();
            courseForm.classList.remove('was-validated');
            document.getElementById('courseId').value = course.id;
            document.getElementById('courseName').value = course.name;
            document.getElementById('description').value = course.description;
            modalTitle.textContent = 'Cập nhật khóa học';
            modalSubmitButton.innerHTML = '<i class="bi bi-check-circle me-2"></i>Cập nhật khóa học';
            courseFormModal.show();
        }

        // Handle form submission
        courseForm.addEventListener('submit', function (event) {
            event.preventDefault();
            event.stopPropagation();

            if (courseForm.checkValidity()) {
                const courseId = document.getElementById('courseId').value;
                const courseName = document.getElementById('courseName').value;
                const description = document.getElementById('description').value;

                if (courseId) { // Update
                    const courseIndex = courses.findIndex(c => c.id == courseId);
                    if (courseIndex !== -1) {
                        courses[courseIndex].name = courseName;
                        courses[courseIndex].description = description;
                        showToast('Cập nhật khóa học thành công!');
                    }
                } else { // Create
                    const today = new Date();
                    const formattedDate = `${String(today.getDate()).padStart(2, '0')}/${String(today.getMonth() + 1).padStart(2, '0')}/${today.getFullYear()}`;
                    courses.push({ id: nextId++, name: courseName, description: description, createdDate: formattedDate });
                    showToast('Thêm khóa học mới thành công!');
                }
                renderCourseTable();
                courseFormModal.hide();
            }

            courseForm.classList.add('was-validated');
        });

        // Event delegation for edit and delete buttons
        document.querySelector('tbody').addEventListener('click', function(event) {
            const editBtn = event.target.closest('.edit-btn');
            const deleteBtn = event.target.closest('.delete-btn');

            if (editBtn) {
                const courseId = editBtn.dataset.courseId;
                const course = courses.find(c => c.id == courseId);
                if (course) {
                    switchToEditMode(course);
                }
            }

            if (deleteBtn) {
                courseIdToDelete = deleteBtn.dataset.courseId;
                confirmDeleteModal.show();
            }
        });

        // Handle delete confirmation
        confirmDeleteButton.addEventListener('click', function() {
            if (courseIdToDelete) {
                courses = courses.filter(c => c.id != courseIdToDelete);
                renderCourseTable();
                confirmDeleteModal.hide();
                showToast('Đã xóa khóa học thành công.', 'danger');
                courseIdToDelete = null;
            }
        });

        // Handle modal show for create
        document.getElementById('createCourseBtn').addEventListener('click', switchToCreateMode);

        // Initial render
        renderCourseTable();
    });
</script>

</body>
</html>
