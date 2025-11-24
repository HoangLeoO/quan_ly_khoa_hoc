<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Quản lý lớp học</title>
    <c:import url="../../common/header.jsp"/>
</head>
<body>
<c:import url="../../common/navbar.jsp"/>

<section>
    <div class="container" style="margin-top:50px">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card border-0 shadow">
                    <div class="card-body p-4 p-md-5">
                        <div class="text-center mb-4">
                            <i class="bi bi-person-gear text-black" style="font-size:4rem"></i>
                            <h3 class="mt-3">Quản lý lớp học</h3>
                        </div>

                        <!-- Search Form -->
                        <c:import url="form-search-infor-class.jsp"/>

                        <!-- Table danh sách lớp -->
                        <div id="tableContainer">
                            <c:import url="table-list-class.jsp"/>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Modal Add -->
<c:import url="../modal/modal-add-class.jsp"/>

<!-- Modal Edit -->
<c:import url="../modal/modal-edit-class.jsp"/>

<!-- Modal Delete -->
<c:import url="../modal/modal-delete-class.jsp"/>

<!-- Toast -->
<div class="position-fixed top-0 end-0 p-3" style="z-index:1080">
    <div id="toastMsg" class="toast align-items-center text-white bg-success border-0" role="alert">
        <div class="d-flex">
            <div class="toast-body" id="toastBody">Thao tác thành công!</div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        const toastEl = document.getElementById('toastMsg');
        const toast = new bootstrap.Toast(toastEl);

        function showToast(message, isSuccess = true) {
            $(toastEl).removeClass("bg-success bg-danger");
            $(toastEl).addClass(isSuccess ? "bg-success" : "bg-danger");
            $("#toastBody").text(message);
            toast.show();
        }

        // Hiển thị toast dựa trên URL ?msg=
        const urlParams = new URLSearchParams(window.location.search);
        const msg = urlParams.get('msg');
        if (msg) {
            switch (msg) {
                case "add_success":
                    showToast("Thêm lớp mới thành công!");
                    break;
                case "success":
                    showToast("Cập nhật lớp thành công!");
                    break;
                case "delete_success":
                    showToast("Xóa lớp thành công!");
                    break;
                case "error":
                    showToast("Thao tác thất bại!", false);
                    break;
            }

        }

        // ---------- Edit Class ----------
        $(document).on("click", ".btn-edit", function () {
            const id = $(this).data("id");
            $.get("/acedemic-affairs?action=edit&id=" + id, function (html) {
                $("#editModalBody").html(html); // load form pre-filled
                const editModal = new bootstrap.Modal(document.getElementById('editClassModal'));
                editModal.show();
            });
        });

        // submit form Edit bằng AJAX
        $(document).on("submit", "#formEditClass", function (e) {
            e.preventDefault();
            const editModalEl = $("#editClassModal");

            $.post("/acedemic-affairs?action=update", $(this).serialize(), function (res) {
                editModalEl.modal('hide');

                if (res.success) {
                    window.location.href = "/acedemic-affairs?msg=success";
                } else {
                    showToast("Cập nhật thất bại!", false);
                }
            }, "json");
        });

    });
</script>

<c:import url="../../common/footer.jsp"/>
</body>
</html>
