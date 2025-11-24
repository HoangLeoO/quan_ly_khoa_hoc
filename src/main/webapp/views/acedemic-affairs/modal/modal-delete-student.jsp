    <%--
      Created by IntelliJ IDEA.
      User: Hi
      Date: 21/11/2025
      Time: 1:39 CH
      To change this template use File | Settings | File Templates.
    --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <div class="modal fade" id="deleteStudentModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <form action="/enrolment?action=deleteStudent" method="post" class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Xác nhận xóa học sinh</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc chắn muốn xóa học sinh <strong id="deleteStudentName"></strong> khỏi lớp này?</p>
                <input type="hidden" name="studentId" id="deleteStudentId" />
                <input type="hidden" name="classId" value="${_class.classId}" />
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-danger">Xóa</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
            </div>
        </form>
    </div>
    </div>
