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
    <title>${schedule == null ? "Thêm buổi học" : "Cập nhật buổi học"}</title>
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
                                <h3 class="mb-3">${schedule == null ? "Thêm buổi học" : "Cập nhật buổi học"}</h3>
                            </div>
                            <a href="schedule?action=add&classId=${classId}" class="btn btn-primary mb-3">Thêm buổi học</a>
                            <!-- Class List Table -->
                            <form method="post" action="schedule">
                                <input type="hidden" name="action" value="${schedule == null ? 'add' : 'edit'}">
                                <input type="hidden" name="schedule_id" value="${schedule != null ? schedule.scheduleId : ''}">
                                <input type="hidden" name="classId" value="${param.classId}">

                                <div class="mb-3">
                                    <label class="form-label">Bài học</label>
                                    <select name="lessonId" class="form-select" required>
                                        <c:forEach items="${lessonList}" var="l">
                                            <option value="${l.lessonId}"
                                                    <c:if test="${schedule != null && schedule.lessonId == l.lessonId}">selected</c:if>>
                                                    ${l.lessonName} - ${l.moduleName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Giờ bắt đầu</label>
                                    <input type="datetime-local" name="timeStart" class="form-control"
                                           value="<c:out value='${schedule != null ? schedule.timeStart.toString().replace(" ", "T") : ""}'/>"
                                           required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Giờ kết thúc</label>
                                    <input type="datetime-local" name="timeEnd" class="form-control"
                                           value="<c:out value='${schedule != null ? schedule.timeEnd.toString().replace(" ", "T") : ""}'/>"
                                           required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Phòng học</label>
                                    <input type="text" name="room" class="form-control"
                                           value="<c:out value='${schedule != null ? schedule.room : ""}'/>" required>
                                </div>

                                <button class="btn btn-success">Lưu</button>
                                <a class="btn btn-secondary" href="schedule?classId=${param.classId}">Hủy</a>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
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

    <c:import url="../common/footer.jsp"/>

</body>
</html>
