<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="mb-5">
    <h4 class="mb-3">Danh sách người dùng</h4>
    <div class="table-responsive">
        <table id="tableStudent" class="table table-bordered table-hover">
            <thead class="table-light">
            <tr>
                <th>STT</th>
                <th>Họ và tên</th>
                <th>Email</th>
                <th>Ngày sinh</th>
                <th>Vị trí</th>
                <th>Vai trò</th>
                <th>Ngày tạo</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="user" items="${userList}" varStatus="index">
                <tr>
                    <td>${index.count}</td>
                    <td>${user.fullName}</td>
                    <td>${user.email}</td>
                    <td>
                            ${user.getDobString()}
                    </td>
                    <td>${user.position}</td>
                    <td>
                        <c:choose>
                            <c:when test="${user.roleId == 1}">
                                <span class="badge bg-danger" style="width: 60px">Admin</span>
                            </c:when>
                            <c:when test="${user.roleId == 2}">
                                <span class="badge bg-success" style="width: 60px">Teacher</span>
                            </c:when>
                            <c:when test="${user.roleId == 3}">
                                <span class="badge bg-info" style="width: 60px">Student</span>
                            </c:when>
                            <c:when test="${user.roleId == 4}">
                                <span class="badge bg-warning" style="width: 60px">AO</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary" style="width: 60px">Not Assigned</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${not empty user.createdAt}">
                            ${user.getCreatedAtString()}
                        </c:if>
                    </td>
                    <td class="d-flex border-0">
                        <a href="/admin/users?action=update&id=${user.userId}"
                           class="btn btn-sm btn-outline-primary">
                            <i class="bi bi-pencil"></i>
                        </a>
                        <button type="button" class="btn btn-sm btn-outline-danger"
                                data-bs-toggle="modal" data-bs-target="#confirmDeleteModal"
                                data-delete-url="/admin/users?action=delete&id=${user.userId}">
                            <i class="bi bi-trash"></i>
                        </button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
