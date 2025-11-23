<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                        <c:import url="table-list-class.jsp"/>

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
    $(document).ready(function() {
        // ---------- Toast ----------
        const toastEl = document.getElementById('toastMsg');
        // tạo toast instance 1 lần (dùng lại)
        const toast = new bootstrap.Toast(toastEl);

        function showToast(message, isSuccess = true) {
            $(toastEl).removeClass("bg-success bg-danger");
            $(toastEl).addClass(isSuccess ? "bg-success" : "bg-danger");
            $("#toastBody").text(message);
            toast.show();
        }

        // ---------- Add Class ----------
        $(document).on("submit", "#formAddClass", function(e){
            e.preventDefault();
            const addModalEl = $("#addClassModal");

            $.post("/acedemic-affairs?action=add", $(this).serialize(), function(res){
                // gán handler trước khi ẩn modal
                addModalEl.one('hidden.bs.modal', function(){
                    showToast(res.success ? "Thêm lớp thành công!" : "Thêm lớp thất bại!", res.success);
                    if(res.success) location.reload();
                });
                // rồi mới ẩn modal (khi ẩn xong, handler sẽ chạy)
                addModalEl.modal('hide');
            }, "json");
        });

        // ---------- Edit Class ----------
        $(document).on("click", ".btn-edit", function(){
            const id = $(this).data("id");
            $.get("/acedemic-affairs?action=edit&id=" + id, function(html){
                $("#editModalBody").html(html);
                const editModalEl = $("#editClassModal");
                // show modal
                const editModal = new bootstrap.Modal(document.getElementById('editClassModal'));
                editModal.show();
            });
        });

        $(document).on("submit", "#formEditClass", function(e){
            e.preventDefault();
            const editModalEl = $("#editClassModal");
            $.post("/acedemic-affairs?action=update", $(this).serialize(), function(res){
                // bind once then hide
                editModalEl.one('hidden.bs.modal', function(){
                    showToast(res.success ? "Cập nhật lớp thành công!" : "Cập nhật thất bại!", res.success);
                    if(res.success) location.reload();
                });
                editModalEl.modal('hide');
            }, "json");
        });

        // ---------- Delete Class ----------
        let deleteId = 0;
        $(document).on("click", ".btn-delete", function(){
            deleteId = $(this).data("id");
            const deleteModal = new bootstrap.Modal(document.getElementById('deleteClassModal'));
            deleteModal.show();
        });

        $(document).on("click", "#confirmDeleteBtn", function(){
            const deleteModalEl = $("#deleteClassModal");
            $.post("/acedemic-affairs?action=delete", {id: deleteId}, function(res){
                // bind once then hide
                deleteModalEl.one('hidden.bs.modal', function(){
                    showToast(res.success ? "Xóa lớp thành công!" : "Xóa lớp thất bại!", res.success);
                    if(res.success) location.reload();
                });
                deleteModalEl.modal('hide');
            }, "json");
        });
    });

</script>

<c:import url="../../common/footer.jsp"/>
</body>
</html>
