<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Điểm danh: ${currentSchedule.lessonName} (${currentClass.className})</title>
    <c:import url="../common/header.jsp"/>
</head>
<body>
<c:import url="../teacher/navbar-teacher.jsp"/>

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-body p-4">
            <h3 class="mb-4 text-center text-primary">
                ĐIỂM DANH: ${currentSchedule.lessonName} (${currentClass.className})
            </h3>

            <div class="alert alert-info p-3 mb-4">
                <%-- SỬA LỖI HIỂN THỊ THỜI GIAN VÀ BỔ SUNG THÔNG TIN PHÒNG HỌC --%>
                <p class="mb-1"><strong>Ngày:</strong>
                    <%-- Dùng currentSchedule và giả định getTimeStartAsDate đã được thêm vào ScheduleDTO --%>
                    <p value="${currentSchedule.getTimeStart()}"></p>
                </p>
                <p class="mb-0"><strong>Giờ:</strong>
                    <p value="${currentSchedule.getTimeStart()}"></p>
                </p>
                <p class="mb-0"><strong>Bài học:</strong> ${currentSchedule.lessonName}</p>
            </div>

            <c:if test="${not empty studentList}">
                <form action="${pageContext.request.contextPath}/attendance" method="post">
                    <input type="hidden" name="action" value="saveAttendance">
                    <input type="hidden" name="scheduleId" value="${scheduleId}">

                        <%-- THÊM BẢNG ĐIỂM DANH --%>
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

                                        <%-- TRƯỜNG ẨN: Truyền studentId cho Controller dễ dàng xử lý mảng --%>
                                    <input type="hidden" name="studentId" value="${st.studentId}">

                                    <td>
                                        <div class="d-flex justify-content-center gap-2">
                                                <%-- Có mặt (Mặc định chọn) --%>
                                            <input type="radio" class="btn-check" name="status_${st.studentId}" id="p_${st.studentId}" value="present" checked>
                                            <label class="btn btn-outline-success btn-sm" for="p_${st.studentId}">Có mặt</label>

                                                <%-- Muộn --%>
                                            <input type="radio" class="btn-check" name="status_${st.studentId}" id="l_${st.studentId}" value="late">
                                            <label class="btn btn-outline-warning btn-sm" for="l_${st.studentId}">Muộn</label>

                                                <%-- Vắng --%>
                                            <input type="radio" class="btn-check" name="status_${st.studentId}" id="a_${st.studentId}" value="absent">
                                            <label class="btn btn-outline-danger btn-sm" for="a_${st.studentId}">Vắng</label>

                                                <%-- Phép --%>
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
                        <a href="${pageContext.request.contextPath}/attendance" class="btn btn-secondary me-2">Quay lại danh sách</a>
                        <button type="submit" class="btn btn-primary px-5">LƯU ĐIỂM DANH</button>
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

</body>
</html>