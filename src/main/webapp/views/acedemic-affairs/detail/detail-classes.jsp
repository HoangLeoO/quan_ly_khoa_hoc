
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thông tin lớp học</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <c:import url="../../common/header.jsp"/>
</head>
<body>
<div>


    <!-- Navigation -->
    <div>
        <c:import url="../../common/navbar.jsp"/>
    </div>

    <section class="py-5 mt-4">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="card shadow-sm">

                        <div class="card-header text-center bg-primary text-dark">
                            <h3>Thông tin lớp học</h3>
                        </div>
                        <div class="card-body">
                            <div class="row mb-2">
                                <div class="col-sm-4 fw-bold">Lớp:</div>
                                <div class="col-sm-8">${_class.className}</div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-sm-4 fw-bold">Khóa học:</div>
                                <div class="col-sm-8">${_class.courseName}</div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-sm-4 fw-bold">Giáo viên:</div>
                                <div class="col-sm-8">${_class.teacherName}</div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-sm-4 fw-bold">Số học viên:</div>
                                <div class="col-sm-8">${_class.countStudent}</div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-sm-4 fw-bold">Ngày bắt đầu:</div>
                                <div class="col-sm-8">${_class.startDate}</div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-sm-4 fw-bold">Ngày kết thúc:</div>
                                <div class="col-sm-8">${_class.endDate}</div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-sm-4 fw-bold">Trạng thái:</div>
                                <div class="col-sm-8">${_class.status}</div>
                            </div>

                            <a class="btn btn-sm btn-outline-primary me-1"
                               href="/schedule?classId=${_class.classId}">
                                Thời khóa biểu
                            </a>
                            <!-- Bảng danh sách học viên -->
                            <c:import url="table-list-student.jsp"/>

                        </div>
                        <div class="mb-3">
                            <a class="btn btn-sm btn-primary text-truncate" style="min-width: 120px;" href="/acedemic-affairs">
                                Quay lại
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Modal Thêm học viên vào lớp -->
    <c:import url="../modal/modal-add-student.jsp"/>

    <!-- Modal Xác nhận xóa học sinh -->
    <c:import url="../modal/modal-delete-student.jsp"/>



</div>


<!-- Script JS để gán dữ liệu cho modal xóa -->
<script>
    const deleteButtons = document.querySelectorAll('.btn-delete-student');
    const deleteModal = new bootstrap.Modal(document.getElementById('deleteStudentModal'));
    const deleteStudentId = document.getElementById('deleteStudentId');
    const deleteStudentName = document.getElementById('deleteStudentName');

    deleteButtons.forEach(btn => {
        btn.addEventListener('click', () => {
            deleteStudentId.value = btn.dataset.id;
            deleteStudentName.textContent = btn.dataset.name;
            deleteModal.show();
        });
    });
</script>

<c:import url="../../common/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
