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
                <p>${schedule.getTimeStart()}</p>
                <p class="mb-0"><strong>Bài học:</strong> ${currentSchedule.lessonName}</p>
            </div>
            <c:if test="${not empty studentList}">
                <form action="/attendance" method="post">
                    <input type="hidden" name="action" value="saveAttendance">
                    <input type="hidden" name="scheduleId" value="${scheduleId}">
                    <div class="table-responsive">
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