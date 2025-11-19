<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Điểm danh lớp ${currentClass.className}</title>
    <c:import url="../common/header.jsp"/>
</head>
<body>
<c:import url="../teacher/navbar-teacher.jsp"/>

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-body p-4">
            <h3 class="mb-4 text-center text-primary">ĐIỂM DANH: ${currentClass.className}</h3>

            <form action="/attendance" method="get" class="mb-4 p-3 bg-light rounded border">
                <input type="hidden" name="action" value="view-form">
                <input type="hidden" name="classId" value="${currentClass.classId}">

                <div class="row align-items-end">
                    <div class="col-md-4">
                        <label class="fw-bold">1. Chọn Module:</label>
                        <select name="moduleId" class="form-select">
                            <option value="">--- Chọn Module ---</option>
                            <c:forEach items="${moduleList}" var="m">
                                <option value="${m.moduleId}" ${String.valueOf(m.moduleId) == selectedModuleId ? 'selected' : ''}>
                                        ${m.moduleName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-1">
                        <button type="submit" class="btn btn-secondary w-100">
                            <i class="bi bi-arrow-repeat"></i>
                        </button>
                    </div>

                    <div class="col-md-4">
                        <label class="fw-bold">2. Chọn Bài học:</label>
                        <select name="lessonId" class="form-select" ${empty lessonList ? 'disabled' : ''}>
                            <option value="">--- Chọn Bài học ---</option>
                            <c:forEach items="${lessonList}" var="l">
                                <option value="${l.lessonId}" ${String.valueOf(l.lessonId) == selectedLessonId ? 'selected' : ''}>
                                        ${l.lessonName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-3">
                        <button type="submit" class="btn btn-primary w-100" ${empty lessonList ? 'disabled' : ''}>
                            Hiển thị danh sách
                        </button>
                    </div>
                </div>
                <div class="form-text text-muted mt-2">
                    * Hướng dẫn: Chọn Module rồi nhấn nút mũi tên để tải danh sách bài học. Sau đó chọn bài và nhấn "Hiển thị".
                </div>
            </form>

            <c:if test="${not empty studentList}">
                <form action="/attendance" method="post">
                    <input type="hidden" name="action" value="save-attendance">
                    <input type="hidden" name="classId" value="${currentClass.classId}">

                    <input type="hidden" name="lessonId" value="${selectedLessonId}">

                    <div class="mb-3 row">
                        <label class="col-sm-2 col-form-label fw-bold">Ngày điểm danh:</label>
                        <div class="col-sm-4">
                            <input type="date" name="attendanceDate" class="form-control"
                                   value="<%= java.time.LocalDate.now() %>" required>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-bordered table-hover align-middle">
                            <thead class="table-primary text-center">
                            <tr>
                                <th>STT</th>
                                <th>Họ và Tên</th>
                                <th>Trạng thái</th>
                                <th>Ghi chú</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="st" items="${studentList}" varStatus="loop">
                                <tr>
                                    <td class="text-center">${loop.count}</td>
                                    <td class="fw-bold">${st.fullName}</td>
                                    <td>
                                        <div class="d-flex justify-content-center gap-2">
                                            <input type="radio" class="btn-check" name="status_${st.studentId}" id="p_${st.studentId}" value="present" checked>
                                            <label class="btn btn-outline-success btn-sm" for="p_${st.studentId}">Có mặt</label>

                                            <input type="radio" class="btn-check" name="status_${st.studentId}" id="l_${st.studentId}" value="late">
                                            <label class="btn btn-outline-warning btn-sm" for="l_${st.studentId}">Muộn</label>

                                            <input type="radio" class="btn-check" name="status_${st.studentId}" id="a_${st.studentId}" value="absent">
                                            <label class="btn btn-outline-danger btn-sm" for="a_${st.studentId}">Vắng</label>

                                            <input type="radio" class="btn-check" name="status_${st.studentId}" id="e_${st.studentId}" value="excused">
                                            <label class="btn btn-outline-primary btn-sm" for="e_${st.studentId}">Phép</label>
                                        </div>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control form-control-sm" name="note_${st.studentId}">
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="text-end mt-3">
                        <a href="/classes?action=detail&id=${currentClass.classId}" class="btn btn-secondary me-2">Quay lại</a>
                        <button type="submit" class="btn btn-primary px-5">LƯU ĐIỂM DANH</button>
                    </div>
                </form>
            </c:if>

            <c:if test="${empty studentList}">
                <div class="alert alert-info text-center mt-4">
                    Vui lòng chọn Module và Bài học ở trên để bắt đầu điểm danh.
                </div>
            </c:if>
        </div>
    </div>
</div>

</body>
</html>