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

<div class="mb-5">
    <div class="d-flex align-items-center mb-3">
        <h3 class="mb-0">Danh sách lớp học</h3>
        <button class="btn btn-success ms-auto" data-bs-toggle="modal" data-bs-target="#addClassModal">
            Thêm lớp mới
        </button>
    </div>
    <div class="table-responsive">
        <table id = "tableClassInfo" class="table table-bordered table-hover table-striped align-middle text-center w-100">
            <thead class="table-light text-center align-middle">
            <tr>
                <th>STT</th>
                <th>Tên lớp</th>
                <th>Khóa học</th>
                <th>Giáo viên</th>
                <th>Trạng thái</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="classes" items="${classList}" varStatus="status">
                <tr>
                    <td>${status.count}</td>
                    <td class="text-start">${classes.className}</td>
                    <td class="text-start">${classes.courseName}</td>
                    <td class="text-start">${classes.teacherName}</td>
                    <td>
                        <c:choose>
                            <c:when test="${classes.status=='studying'}">
                                <span class="badge bg-success">Studying</span>
                            </c:when>
                            <c:when test="${classes.status=='completed'}">
                                <span class="badge bg-warning text-dark">Completed</span>
                            </c:when>
                            <c:when test="${classes.status=='dropped'}">
                                <span class="badge bg-danger">Dropped</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary">${classes.status}</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <div class="d-flex justify-content-center flex-wrap gap-1">
                            <a class="btn btn-sm btn-outline-primary flex-grow-1 text-truncate"
                               style="min-width:100px"
                               href="/acedemic-affairs?action=detail&id=${classes.classId}">Chi tiết</a>
                            <button class="btn btn-warning btn-sm btn-edit" data-id="${classes.classId}">Sửa</button>
                            <button class="btn btn-danger btn-sm btn-delete" data-id="${classes.classId}">Xóa</button>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>