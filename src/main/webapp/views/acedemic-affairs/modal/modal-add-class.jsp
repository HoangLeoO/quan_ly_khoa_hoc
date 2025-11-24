<%--
  Created by IntelliJ IDEA.
  User: Hi
  Date: 21/11/2025
  Time: 4:04 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="modal fade" id="addClassModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title">Thêm lớp học mới</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/acedemic-affairs" method="post">
                    <input type="hidden" name="action" value="add">
                    <div class="mb-3">
                        <label class="form-label">Tên lớp</label>
                        <input type="text" name="className" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Khóa học</label>
                        <select name="courseId" class="form-control">
                            <c:forEach var="c" items="${courseList}">
                                <option value="${c.courseId}">${c.courseName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Giáo viên</label>
                        <select name="teacherId" class="form-control">
                            <option value="">-- Chưa phân công --</option>
                            <c:forEach var="t" items="${teacherList}">
                                <option value="${t.staffId}">${t.fullName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Ngày bắt đầu</label>
                        <input type="date" name="startDate" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Ngày kết thúc</label>
                        <input type="date" name="endDate" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Trạng thái</label>
                        <select name="status" class="form-control">
                            <option value="studying">Studying</option>
                            <option value="completed">Completed</option>
                            <option value="dropped">Dropped</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-success w-100">Thêm lớp</button>
                </form>
            </div>
        </div>
    </div>
</div>
