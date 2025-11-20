<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Điểm danh: ${currentSchedule.lessonName} (${currentClass.className})</title>
    <c:import url="../common/header.jsp"/>
    <style>
        /* Tùy chỉnh màu sắc khi nút trạng thái điểm danh được chọn */
        .btn-check:checked + .btn-outline-secondary,
        .btn-check:checked + .btn-outline-secondary:hover,
        .btn-check:checked + .btn-outline-secondary:focus {
            color: #ffffff !important;
            background-color: #3d985f !important;
            border-color: #3d985f !important;
        }

        /* CUSTOM CSS THÊM: Đảm bảo các nút nhỏ và gọn hơn */
        .attendance-btn-group label.btn {
            padding: 0.25rem 0.5rem; /* Giảm padding cho nút */
            font-size: 0.8rem;      /* Thu nhỏ font */
            line-height: 1.5;
            border-radius: 0.2rem; /* Giữ bo góc nhỏ */
        }

        /* Màu mặc định: Có mặt (Present - Màu Xanh lá) */
        .btn-check[value="present"]:checked + .btn-outline-secondary {
            background-color: #198754 !important; /* success */
            color: white !important;
            border-color: #198754 !important;
        }

        /* Muộn (Late - Màu Vàng) */
        .btn-check[value="late"]:checked + .btn-outline-secondary {
            background-color: #ffc107 !important; /* warning */
            color: #212529 !important;
            border-color: #ffc107 !important;
        }

        /* Vắng (Absent - Màu Đỏ) */
        .btn-check[value="absent"]:checked + .btn-outline-secondary {
            background-color: #dc3545 !important; /* danger */
            color: white !important;
            border-color: #dc3545 !important;
        }

        /* Phép (Excused - Màu Xanh dương nhạt) */
        .btn-check[value="excused"]:checked + .btn-outline-secondary {
            background-color: #0dcaf0 !important; /* info */
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
                ĐIỂM DANH: ${currentSchedule.lessonName} (${currentClass.className})
            </h4>

            <div class="alert alert-light p-2 mb-3 small">
                <p class="mb-0">
                    <strong>Bài học:</strong> ${currentSchedule.lessonName}
                    (Phòng: ${currentSchedule.room})
                </p>
            </div>

            <c:if test="${not empty studentList}">
                <%-- THÊM ID VÀO FORM --%>
                <form id="attendanceForm" action="${pageContext.request.contextPath}/attendance" method="post">
                    <input type="hidden" name="action" value="saveAttendance">
                    <input type="hidden" name="scheduleId" value="${scheduleId}">
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

                                <%-- Lấy dữ liệu cũ từ DB --%>
                                <c:set var="oldAtt" value="${oldAttendanceMap[st.studentId]}" />
                                <c:set var="status" value="${not empty oldAtt ? oldAtt.status : 'present'}" />
                                <c:set var="noteValue" value="${not empty oldAtt ? oldAtt.note : ''}" />

                                <tr>
                                    <td class="text-center">${loop.count}</td>
                                    <td class="fw-bold small">${st.fullName}</td>

                                    <input type="hidden" name="studentId" value="${st.studentId}">

                                    <td>
                                        <div class="d-flex justify-content-center gap-1 attendance-btn-group">

                                                <%-- Có mặt (present) --%>
                                            <input type="radio" class="btn-check" name="status_${st.studentId}" id="p_${st.studentId}" value="present"
                                                   <c:if test="${status eq 'present'}">checked</c:if>>
                                            <label class="btn btn-outline-secondary" for="p_${st.studentId}">Có mặt</label>

                                                <%-- Muộn (late) --%>
                                            <input type="radio" class="btn-check" name="status_${st.studentId}" id="l_${st.studentId}" value="late"
                                                   <c:if test="${status eq 'late'}">checked</c:if>>
                                            <label class="btn btn-outline-secondary" for="l_${st.studentId}">Muộn</label>

                                                <%-- Vắng (absent) --%>
                                            <input type="radio" class="btn-check" name="status_${st.studentId}" id="a_${st.studentId}" value="absent"
                                                   <c:if test="${status eq 'absent'}">checked</c:if>>
                                            <label class="btn btn-outline-secondary" for="a_${st.studentId}">Vắng</label>

                                                <%-- Phép (excused) --%>
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
                            <%-- THAY NÚT SUBMIT BẰNG NÚT MỞ MODAL --%>
                        <button type="button"
                                class="btn btn-primary px-5"
                                data-bs-toggle="modal"
                                data-bs-target="#confirmSaveModal">
                            LƯU ĐIỂM DANH
                        </button>
                    </div>
                </form>
            </c:if>
            <c:if test="${empty studentList}">
                <div class="alert alert-info text-center mt-4">
                    Không tìm thấy học viên trong lớp ${currentClass.className}.
                </div>
            </c:if>
        </div>
    </div>
</div>

<%-- ------------------------------------------------------------------------------------------ --%>
<%-- MODAL XÁC NHẬN LƯU DỮ LIỆU --%>
<%-- ------------------------------------------------------------------------------------------ --%>
<div class="modal fade" id="confirmSaveModal" tabindex="-1" aria-labelledby="confirmSaveModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmSaveModalLabel">Xác nhận Lưu Điểm danh</h5>
                <%-- SỬ DỤNG CLASS CỦA BOOTSTRAP 5 --%>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc chắn muốn lưu dữ liệu điểm danh này không?</p>
                <p class="text-danger small">Lưu ý: Dữ liệu cũ (nếu có) sẽ bị ghi đè hoàn toàn.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy bỏ</button>

                <%-- NÚT GỬI DỮ LIỆU THỰC SỰ: Dùng JavaScript để submit form có ID 'attendanceForm' --%>
                <button type="button"
                        class="btn btn-primary"
                        onclick="document.getElementById('attendanceForm').submit();">
                    Đồng ý LƯU
                </button>
            </div>
        </div>
    </div>
</div>

</body>
</html>