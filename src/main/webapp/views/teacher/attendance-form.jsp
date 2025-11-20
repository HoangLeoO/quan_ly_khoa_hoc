<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>
        <c:choose>
            <c:when test="${requestScope.isNewForm}">Tạo mới và Điểm danh: Lớp ${currentClass.className}</c:when>
            <c:otherwise>Chỉnh sửa Điểm danh: ${currentSchedule.lessonName} (${currentClass.className})</c:otherwise>
        </c:choose>
    </title>
    <c:import url="../common/header.jsp"/>
    <style>
        /* Tùy chỉnh CSS giữ nguyên... */
        .btn-check:checked + .btn-outline-secondary,
        .btn-check:checked + .btn-outline-secondary:hover,
        .btn-check:checked + .btn-outline-secondary:focus {
            color: #ffffff !important;
            background-color: #3d985f !important;
            border-color: #3d985f !important;
        }

        .attendance-btn-group label.btn {
            padding: 0.25rem 0.5rem;
            font-size: 0.8rem;
            line-height: 1.5;
            border-radius: 0.2rem;
        }

        .btn-check[value="present"]:checked + .btn-outline-secondary {
            background-color: #198754 !important;
            color: white !important;
            border-color: #198754 !important;
        }

        .btn-check[value="late"]:checked + .btn-outline-secondary {
            background-color: #ffc107 !important;
            color: #212529 !important;
            border-color: #ffc107 !important;
        }

        .btn-check[value="absent"]:checked + .btn-outline-secondary {
            background-color: #dc3545 !important;
            color: white !important;
            border-color: #dc3545 !important;
        }

        .btn-check[value="excused"]:checked + .btn-outline-secondary {
            background-color: #0dcaf0 !important;
            color: #212529 !important;
            border-color: #0dcaf0 !important;
        }
    </style>
</head>
<body>
<c:import url="../common/navbar.jsp"/>

<div class="container mt-4">
    <div class="card shadow-sm">
        <div class="card-body p-3">
            <h4 class="mb-3 text-center text-primary">
                <c:choose>
                    <c:when test="${requestScope.isNewForm}">
                        <i class="bi bi-calendar-plus me-2"></i> TẠO BUỔI HỌC VÀ ĐIỂM DANH: Lớp ${currentClass.className}
                    </c:when>
                    <c:otherwise>
                        <i class="bi bi-pencil-square me-2"></i> CHỈNH SỬA ĐIỂM DANH: ${currentSchedule.lessonName} (${currentClass.className})
                    </c:otherwise>
                </c:choose>
            </h4>

            <form id="attendanceForm" action="${pageContext.request.contextPath}/attendance" method="post">
                <c:choose>
                    <c:when test="${requestScope.isNewForm}">
                        <%-- LUỒNG TẠO MỚI --%>
                        <input type="datetime-local" name="timeStart" value="${scheduleTimeStart}" />
                        <input type="datetime-local" name="timeEnd" value="${scheduleTimeEnd}" />

                        <input type="hidden" name="action" value="saveTodayAttendance" />
                        <input type="hidden" name="classId" value="${currentClass.classId}" />
                        <!-- scheduleId có thể null, nhưng hiện tại ta không dùng ở server nữa -->
                        <c:if test="${not empty scheduleId}">
                            <input type="hidden" name="scheduleId" value="${scheduleId}" />
                        </c:if>

                        <div class="alert alert-warning p-3 mb-4">
                            <h6 class="text-danger"><i class="bi bi-info-circle me-1"></i> Thông tin Buổi học Mới</h6>
                            <div class="row">
                                <div class="col-md-6 mb-2">
                                    <label for="timeStart" class="form-label small fw-bold">Bắt đầu:</label>
                                    <input type="datetime-local" class="form-control form-control-sm" id="timeStart" name="timeStart" required
                                           value="${currentDateTimeStart}"> <%-- Dùng biến mới --%>
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label for="timeEnd" class="form-label small fw-bold">Kết thúc:</label>
                                    <input type="datetime-local" class="form-control form-control-sm" id="timeEnd" name="timeEnd" required
                                           value="${currentDateTimeEnd}"> <%-- Dùng biến mới và có giá trị mặc định --%>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-2">
                                    <label for="room" class="form-label small fw-bold">Phòng học:</label>
                                    <input type="text" class="form-control form-control-sm" id="room" name="room" required placeholder="Ví dụ: A201">
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label for="lessonId" class="form-label small fw-bold">Bài học (ID):</label>
                                    <input type="number" class="form-control form-control-sm" id="lessonId" name="lessonId" placeholder="ID Bài học (Nếu có)">
                                </div>
                            </div>
                        </div>

                    </c:when>
                    <c:otherwise>
                        <%-- LUỒNG CHỈNH SỬA --%>
                        <input type="hidden" name="action" value="saveAttendance">
                        <input type="hidden" name="scheduleId" value="${scheduleId}">

                        <div class="alert alert-warning p-3 mb-4">
                            <h6 class="text-danger"><i class="bi bi-info-circle me-1"></i> Thông tin Buổi học</h6>

                            <div class="row">
                                <div class="col-md-6 mb-2">
                                    <label for="timeStart" class="form-label small fw-bold">Bắt đầu:</label>
                                    <input type="datetime-local" class="form-control form-control-sm" id="timeStart" name="timeStart" required
                                           value="${scheduleTimeStart}"> <%-- SỬ DỤNG BIẾN ĐÃ FORMAT --%>
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label for="timeEnd" class="form-label small fw-bold">Kết thúc:</label>
                                    <input type="datetime-local" class="form-control form-control-sm" id="timeEnd" name="timeEnd" required
                                           value="${scheduleTimeEnd}"> <%-- SỬ DỤNG BIẾN ĐÃ FORMAT --%>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-2">
                                    <label for="room" class="form-label small fw-bold">Phòng học:</label>
                                    <input type="text" class="form-control form-control-sm" id="room" name="room" required
                                           value="${currentSchedule.room}" placeholder="Ví dụ: A201">
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label for="lessonId" class="form-label small fw-bold">Bài học (ID):</label>
                                    <input type="number" class="form-control form-control-sm" id="lessonId" name="lessonId"
                                           value="${currentSchedule.lessonId}" placeholder="ID Bài học (Nếu có)">
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>

                <c:if test="${not empty studentList}">
                    <div>
                        <table class="table table-bordered table-hover align-middle table-sm">
                            <thead class="table-light text-center">
                            <tr>
                                <th style="width: 5%;">STT</th>
                                <th style="width: 30%;">Họ và Tên</th>
                                <th style="width: 45%;">Trạng thái</th>
                                <th style="width: 20%;">Ghi chú</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="st" items="${studentList}" varStatus="loop">

                                <%-- Lấy dữ liệu cũ (chỉ có khi isNewForm=false) --%>
                                <c:set var="oldAtt" value="${oldAttendanceMap[st.studentId]}" />
                                <c:set var="status" value="${not empty oldAtt ? oldAtt.status : 'present'}" />
                                <c:set var="noteValue" value="${not empty oldAtt ? oldAtt.note : ''}" />

                                <tr>
                                    <td class="text-center">${loop.count}</td>
                                    <td class="fw-bold small">${st.fullName}</td>

                                    <td>
                                        <div class="d-flex justify-content-center gap-1 attendance-btn-group">

                                            <input type="radio" class="btn-check" name="status_${st.studentId}" id="p_${st.studentId}" value="present"
                                                   <c:if test="${status eq 'present'}">checked</c:if> required>
                                            <label class="btn btn-outline-secondary" for="p_${st.studentId}">Có mặt</label>

                                            <input type="radio" class="btn-check" name="status_${st.studentId}" id="l_${st.studentId}" value="late"
                                                   <c:if test="${status eq 'late'}">checked</c:if>>
                                            <label class="btn btn-outline-secondary" for="l_${st.studentId}">Muộn</label>

                                            <input type="radio" class="btn-check" name="status_${st.studentId}" id="a_${st.studentId}" value="absent"
                                                   <c:if test="${status eq 'absent'}">checked</c:if>>
                                            <label class="btn btn-outline-secondary" for="a_${st.studentId}">Vắng</label>

                                            <input type="radio" class="btn-check" name="status_${st.studentId}" id="e_${st.studentId}" value="excused"
                                                   <c:if test="${status eq 'excused'}">checked</c:if>>
                                            <label class="btn btn-outline-secondary" for="e_${st.studentId}">Phép</label>
                                        </div>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control form-control-sm" name="note_${st.studentId}" value="${noteValue}">
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="text-end mt-3">
                        <a href="${pageContext.request.contextPath}/attendance" class="btn btn-secondary me-2">Quay lại danh sách</a>
                        <button type="button"
                                class="btn btn-primary px-5"
                                data-bs-toggle="modal"
                                data-bs-target="#confirmSaveModal">
                            <c:if test="${requestScope.isNewForm}">TẠO VÀ LƯU ĐIỂM DANH</c:if>
                            <c:if test="${!requestScope.isNewForm}">CẬP NHẬT ĐIỂM DANH</c:if>
                        </button>
                    </div>
                </c:if>
                <c:if test="${empty studentList}">
                    <div class="alert alert-info text-center mt-4">
                        Không tìm thấy học viên trong lớp ${currentClass.className}.
                    </div>
                </c:if>
            </form>
        </div>
    </div>
</div>

<%-- MODAL XÁC NHẬN LƯU DỮ LIỆU --%>
<div class="modal fade" id="confirmSaveModal" tabindex="-1" aria-labelledby="confirmSaveModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmSaveModalLabel">Xác nhận Lưu Điểm danh</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc chắn muốn lưu dữ liệu điểm danh này không?</p>
                <p class="text-danger small">
                    Lưu ý:
                    <c:if test="${!requestScope.isNewForm}">Dữ liệu cũ (nếu có) sẽ bị ghi đè hoàn toàn. </c:if>
                    <c:if test="${requestScope.isNewForm}">Một buổi học mới sẽ được tạo trong thời khóa biểu.</c:if>
                </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy bỏ</button>
                <button type="button"
                        class="btn btn-primary"
                        onclick="document.getElementById('attendanceForm').submit();">
                    Đồng ý LƯU
                </button>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>