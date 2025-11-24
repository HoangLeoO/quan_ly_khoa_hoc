<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<form id="formEditClass">
    <input type="hidden" name="classId" value="${classObj.classId}" />

    <div class="mb-3">
        <label for="className" class="form-label">Tên lớp</label>
        <input type="text" class="form-control" id="className" name="className" value="${classObj.className}" required>
    </div>

    <div class="mb-3">
        <label for="courseId" class="form-label">Khóa học</label>
        <select class="form-select" id="courseId" name="courseId" required>
            <c:forEach var="course" items="${courseList}">
                <option value="${course.courseId}" <c:if test="${course.courseId eq classObj.courseId}">selected</c:if>>
                        ${course.courseName}
                </option>
            </c:forEach>
        </select>
    </div>

    <div class="mb-3">
        <label for="teacherId" class="form-label">Giáo viên</label>
        <select class="form-select" id="teacherId" name="teacherId">
            <option value="">-- Chọn giáo viên --</option>
            <c:forEach var="teacher" items="${teacherList}">
                <option value="${teacher.staffId}" <c:if test="${teacher.staffId eq classObj.teacherId}">selected</c:if>>
                        ${teacher.fullName}
                </option>
            </c:forEach>
        </select>
    </div>

    <div class="mb-3">
        <label for="startDate" class="form-label">Ngày bắt đầu</label>
        <input type="date" class="form-control" id="startDate" name="startDate" value="${classObj.startDate}" required>
    </div>

    <div class="mb-3">
        <label for="endDate" class="form-label">Ngày kết thúc</label>
        <input type="date" class="form-control" id="endDate" name="endDate" value="${classObj.endDate}" required>
    </div>

    <div class="mb-3">
        <label for="status" class="form-label">Trạng thái</label>
        <select class="form-select" id="status" name="status" required>
            <option value="studying" <c:if test="${classObj.status eq 'studying'}">selected</c:if>>Studying</option>
            <option value="completed" <c:if test="${classObj.status eq 'completed'}">selected</c:if>>Completed</option>
            <option value="dropped" <c:if test="${classObj.status eq 'dropped'}">selected</c:if>>Dropped</option>
        </select>
    </div>

    <div class="text-end">
        <button type="submit" class="btn btn-success">Cập nhật</button>
    </div>
</form>
