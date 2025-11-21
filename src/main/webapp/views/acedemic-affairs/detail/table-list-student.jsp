<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: Hi
  Date: 19/11/2025
  Time: 8:51 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<<div class="mb-5">
<div class="d-flex align-items-center mb-3">
    <h3 class="mb-0">Danh sách lớp học</h3>
    <button class="btn btn-success ms-auto" data-bs-toggle="modal" data-bs-target="#addClassModal">
        Thêm lớp mới
    </button>
</div>
<div class="table-responsive">
    <table id="tableClassInfo" class="table table-bordered table-hover table-striped align-middle text-center w-100">
        <thead class="table-light text-center align-middle">
        <tr>
            <th style="width: 3%;">STT</th>
            <th style="width: 15%;">Tên lớp</th>
            <th style="width: 20%;">Khóa học</th>
            <th style="width: 20%;">Giáo viên</th>
            <th style="width: 7%;">Trạng thái</th>
            <th style="width: 15%;">Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="classes" items="${classList}" varStatus="status">
            <tr class="align-middle text-center">
                <td>${status.count}</td>
                <td class="text-start">${classes.getClassName()}</td>
                <td class="text-start">${classes.getCourseName()}</td>
                <td class="text-start">${classes.getTeacherName()}</td>
                <td>
                    <c:choose>
                        <c:when test="${classes.getStatus() == 'studying'}">
                            <span class="badge bg-success">${classes.getStatus()}</span>
                        </c:when>
                        <c:when test="${classes.getStatus() == 'completed'}">
                            <span class="badge bg-warning text-dark">${classes.getStatus()}</span>
                        </c:when>
                        <c:when test="${classes.getStatus() == 'dropped'}">
                            <span class="badge bg-danger">${classes.getStatus()}</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-secondary">${classes.getStatus()}</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <div class="d-flex justify-content-center flex-wrap gap-1">
                        <a class="btn btn-sm btn-outline-primary flex-grow-1 text-truncate"
                           style="min-width: 100px;"
                           href="/acedemic-affairs?action=detail&id=${classes.getClassId()}">Chi tiết</a>
                        <button class="btn btn-warning btn-sm btn-edit" data-id="${classes.getClassId()}">Sửa</button>
                        <button class="btn btn-danger btn-sm btn-delete" data-id="${classes.getClassId()}">Xóa</button>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</div>

