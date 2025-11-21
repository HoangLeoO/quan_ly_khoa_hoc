<%--
  Created by IntelliJ IDEA.
  User: Hi
  Date: 21/11/2025
  Time: 1:39 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="addStudentModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <form action="/enrolment?action=addStudent" method="post" class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Thêm học viên vào lớp</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" name="classId" value="${_class.classId}" />
                <div class="mb-3">
                    <label>Chọn học viên:</label>
                    <select name="studentId" class="form-control" required>
                        <option value="">-- Chọn học viên --</option>
                        <c:forEach var="s" items="${allStudents}">
                            <option value="${s.studentId}">${s.fullName} - ${s.phone}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-success">Thêm</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
            </div>
        </form>
    </div>
</div>
