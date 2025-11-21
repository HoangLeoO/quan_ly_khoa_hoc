<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Hi
  Date: 18/11/2025
  Time: 2:50 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thời khóa biểu</title>
    <c:import url="../common/header.jsp"/>
</head>
<body>
<div>


    <!-- Navigation -->
    <div>
        <c:import url="../common/navbar.jsp"/>
    </div>



    <section>
        <div class="container" style="margin-top: 50px">
            <div class="row justify-content-center">
                <div class="col-md-10">
                    <div class="card border-0 shadow">
                        <div class="card-body p-4 p-md-5">
                            <div class="text-center mb-4">
                                <i
                                        class="bi bi-person-gear text-black"
                                        style="font-size: 4rem"></i>
                                <h3 class="mt-3">Thời khóa biểu</h3>
                            </div>
                            <a href="schedule?action=add&classId=${classId}" class="btn btn-primary mb-3">Thêm buổi học</a>
                            <!-- Class List Table -->
                            <table id="tableStudent" class="table table-bordered table-hover align-middle">
                                <thead class="table-light text-center">
                                <tr>
                                    <th>Ngày</th>
                                    <th>Giờ học</th>
                                    <th>Bài học</th>
                                    <th>Phòng</th>
                                    <th>Thao tác</th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:forEach var="s" items="${list}">
                                    <tr>
                                        <td>${s.studyDate}</td>
                                        <td>${s.timeBegin} - ${s.timeEnd}</td>
                                        <td>${s.lessonName} (${s.moduleName})</td>
                                        <td>${s.room}</td>
                                        <td>
                                            <a class="btn btn-sm btn-outline-primary"
                                               href="schedule?action=edit&schedule_id=${s.scheduleId}&classId=${classId}">
                                                Sửa
                                            </a>
                                            <a class="btn btn-sm btn-outline-danger"
                                               href="schedule?action=delete&schedule_id=${s.scheduleId}&classId=${classId}"
                                               onclick="return confirm('Xóa buổi học?')">
                                                Xóa
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <c:import url="../common/footer.jsp"/>
    <!-- Modal xác nhận xóa -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Xác nhận xóa</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    Bạn có chắc muốn xóa buổi học này?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <a href="#" id="confirmDeleteBtn" class="btn btn-danger">Xóa</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Toast thông báo -->
    <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
        <div id="toastMsg" class="toast align-items-center text-bg-success border-0" role="alert">
            <div class="d-flex">
                <div class="toast-body" id="toastBody">Thao tác thành công!</div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Truyền id vào modal
        var deleteModal = document.getElementById('deleteModal')
        deleteModal.addEventListener('show.bs.modal', function (event) {
            var button = event.relatedTarget
            var scheduleId = button.getAttribute('data-id')
            var confirmBtn = document.getElementById('confirmDeleteBtn')
            confirmBtn.href = "schedule?action=delete&schedule_id=" + scheduleId + "&classId=${param.classId}"
        })

        // Hiển thị Toast từ server
        <c:if test="${not empty successMsg}">
        var toastEl = document.getElementById('toastMsg')
        toastEl.classList.remove('text-bg-danger')
        toastEl.classList.add('text-bg-success')
        document.getElementById('toastBody').innerText = "${successMsg}"
        var toast = new bootstrap.Toast(toastEl)
        toast.show()
        </c:if>

        <c:if test="${not empty errorMsg}">
        var toastEl = document.getElementById('toastMsg')
        toastEl.classList.remove('text-bg-success')
        toastEl.classList.add('text-bg-danger')
        document.getElementById('toastBody').innerText = "${errorMsg}"
        var toast = new bootstrap.Toast(toastEl)
        toast.show()
        </c:if>
    </script>


</body>
</html>