<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Quản trị viên - CODEGYM</title>
    <c:import url="../common/header.jsp"></c:import>
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
<c:import url="admin-toast-container.jsp"></c:import>

<!-- Admin Section -->
<section class="">
    <div class="container" >
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card shadow">
                    <div class="card-body p-4 p-md-5">
                        <div class="text-center mb-4">
                            <i
                                    class="bi bi-person-gear text-black"
                                    style="font-size: 4rem"></i>
                            <h3 class="mt-1">Quản lý người dùng</h3>

                        </div>


                        <div class="row mb-3">

                        </div>
                        <!-- Search and Filter Form -->
                        <div class="row mb-3">
                            <c:import url="admin-users-filter.jsp"></c:import>
                        </div>

                        <!-- User List Table -->
                        <div class="row mb-3">
                            <c:import url="admin-user-list-table.jsp"/>
                        </div>


                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Create/Update User Modal -->
<div class="modal fade" id="userFormModal" tabindex="-1" aria-labelledby="userFormModalLabel" aria-hidden="true">
    <c:import url="admin-create-user-form.jsp"/>
</div>

<!-- Confirm Delete Modal -->
<c:import url="admin-confirm-delete.jsp"/>

<!-- Footer -->
<script>
    // Function to check if password and confirm password match
    function checkPasswordMatch() {
        var password = document.getElementById("password");
        var confirmPassword = document.getElementById("confirmPassword");

        if (password.value !== confirmPassword.value) {
            confirmPassword.setCustomValidity("Mật khẩu xác nhận không khớp!");
            confirmPassword.classList.add("is-invalid");
        } else {
            confirmPassword.setCustomValidity('');
            confirmPassword.classList.remove("is-invalid");
            confirmPassword.classList.add("is-valid");
        }
    }

    // Attach password check listeners
    var passInput = document.getElementById("password");
    var confirmInput = document.getElementById("confirmPassword");
    if (passInput && confirmInput) {
        passInput.onchange = checkPasswordMatch;
        confirmInput.onkeyup = checkPasswordMatch;
    }

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

            // Reset toast classes before applying new ones
            toastLiveExample.classList.remove('bg-success', 'bg-danger', 'text-white');
            closeButton.classList.remove('btn-close-white');

            switch (message) {
                case 'add_success':
                    toastMessage = 'Đã thêm người dùng mới thành công!';
                    isSuccess = true;
                    break;
                case 'update_success':
                    toastMessage = 'Đã cập nhật thông tin người dùng thành công!';
                    isSuccess = true;
                    break;
                case 'delete_success':
                    toastMessage = 'Đã xóa người dùng thành công.';
                    isSuccess = true; // Or you can have a different color for deletion
                    break;
                case 'user_not_found':
                case 'invalid_id':
                    toastMessage = 'Lỗi: ID người dùng không hợp lệ hoặc không tìm thấy.';
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
                // Clean the URL to remove the message parameter after showing the toast
                window.history.replaceState({}, document.title, window.location.pathname);
            }
        }

        // Confirm Delete Modal Logic
        var confirmDeleteModal = document.getElementById('confirmDeleteModal');
        if (confirmDeleteModal) {
            confirmDeleteModal.addEventListener('show.bs.modal', function (event) {
                var button = event.relatedTarget;
                var deleteUrl = button.getAttribute('data-delete-url');
                var userName = button.getAttribute('data-user-name');
                var confirmDeleteButton = document.getElementById('confirmDeleteButton');
                var itemNameToDelete = document.getElementById('itemNameToDelete');

                confirmDeleteButton.setAttribute('href', deleteUrl);
                if (itemNameToDelete) {
                    itemNameToDelete.textContent = userName;
                }
            });
        }

        // User Form Modal Logic
        var userFormModalElement = document.getElementById('userFormModal');
        if (!userFormModalElement) return;

        var userFormModal = new bootstrap.Modal(userFormModalElement);
        var form = userFormModalElement.querySelector('form');
        var modalTitle = userFormModalElement.querySelector('.modal-title');
        var submitButton = userFormModalElement.querySelector('button[type="submit"]');
        var cancelResetButton = userFormModalElement.querySelector('#cancel-reset-btn');
        var passwordFieldsRow = userFormModalElement.querySelector('#password-fields-row');
        var passwordField = document.getElementById('password');
        var confirmPasswordField = document.getElementById('confirmPassword');

        // Resets the form to its "create" state
        function switchToCreateMode() {
            modalTitle.textContent = 'Tạo tài khoản mới';
            form.action = '/admin/users?action=add';
            form.reset();
            form.classList.remove('was-validated');
            form.querySelectorAll('.is-invalid, .is-valid').forEach(el => el.classList.remove('is-invalid', 'is-valid'));
            var hiddenUserId = form.querySelector('input[name="userId"]');
            if (hiddenUserId) hiddenUserId.remove();
            if (passwordFieldsRow) passwordFieldsRow.style.display = 'flex';
            if (passwordField) passwordField.required = true;
            if (confirmPasswordField) confirmPasswordField.required = true;
            if (cancelResetButton) cancelResetButton.innerHTML = '<i class="bi bi-arrow-clockwise me-2"></i> Làm mới';
            if (submitButton) submitButton.innerHTML = '<i class="bi bi-person-plus me-2"></i> Tạo tài khoản';
        }

        // Show modal automatically if the page was loaded in "update" mode
        <c:if test="${not empty mode and mode eq 'update'}">
        userFormModal.show();
        </c:if>

        // Event listener for when the modal is about to be shown
        // This is primarily for the "Create User" button
        userFormModalElement.addEventListener('show.bs.modal', function (event) {
            var button = event.relatedTarget;
            if (button && button.id === 'createUserBtn') {
                switchToCreateMode();
            }
        });

        // Event listener for edit buttons. This triggers a full page reload
        // to get the user data from the server.
        document.addEventListener('click', function (event) {
            var editButton = event.target.closest('a[href*="action=update"]');
            if (editButton) {
                event.preventDefault(); // Prevent default link behavior
                // Redirect to the edit URL to reload the page with user data
                window.location.href = editButton.href;
            }
        });

        // --- Logic for handling the Cancel button and closing the modal ---
        var shouldRedirectAfterClose = false;

        // Event listener for the Cancel/Reset button
        if (cancelResetButton) {
            cancelResetButton.addEventListener('click', function (event) {
                // If the button says "Hủy", it means we are in update mode
                if (this.textContent.trim().includes('Hủy')) {
                    event.preventDefault();
                    shouldRedirectAfterClose = true; // Set flag to redirect after modal closes
                    userFormModal.hide();
                } else {
                    // Otherwise, it's a "Làm mới" button in create mode, so we just reset the form
                    form.classList.remove('was-validated');
                }
            });
        }

        // Event listener to redirect back to the user list after closing an "update" modal
        userFormModalElement.addEventListener('hidden.bs.modal', function (event) {
            const url = new URL(window.location);
            // Only redirect if the flag is set (meaning "Cancel" was clicked in update mode)
            if (url.searchParams.get('action') === 'update' && shouldRedirectAfterClose) {
                window.location.href = '/admin/users';
            }
            // Reset flag for next time
            shouldRedirectAfterClose = false;
        });
    });
</script>
<c:import url="../common/footer.jsp"/>
</body>
</html>
