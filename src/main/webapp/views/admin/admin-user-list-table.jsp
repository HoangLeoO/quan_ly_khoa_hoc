<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="mb-5">
    <h4 class="mb-3">Danh sách người dùng</h4>
    <div class="table-responsive">
        <table class="table table-bordered table-hover">
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
                    <td>${user.getFullName()}</td>
                    <td>${user.getEmail()}</td>
                    <td>${user.getDob()}</td>
                    <td>${user.getPosition()}</td>
                    <c:if test="${empty user.getRoleId()}">
                        <td><span class="badge bg-success" style="width: 60px">Not Assigned</span></td>
                    </c:if>
                    <c:if test="${user.getRoleId() == 1}">
                        <td><span class="badge bg-danger"style="width: 60px">Admin</span></td>
                    </c:if>
                    <c:if test="${user.getRoleId() == 2}">
                        <td><span class="badge bg-success"style="width: 60px">Teacher</span></td>
                    </c:if>
                    <c:if test="${user.getRoleId() == 3}">
                        <td><span class="badge bg-info"style="width: 60px">Student</span></td>
                    </c:if>
                    <c:if test="${user.getRoleId() == 4}">
                        <td><span class="badge bg-warning"style="width: 60px">AO</span></td>
                    </c:if>
                    <td>${user.getDob()}</td>
                    <td class="d-flex border-0">
                        <a href="/admins?action=update&id=${user.getUserId()}"
                           class="btn btn-sm btn-outline-primary">
                            <i class="bi bi-pencil"></i>
                        </a>
                        <a href="/admins?action=delete&id=${user.getUserId()}"
                           class="btn btn-sm btn-outline-danger">
                            <i class="bi bi-trash"></i>
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>