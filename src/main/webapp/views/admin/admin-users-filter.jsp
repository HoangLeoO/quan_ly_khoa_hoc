<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
    <!-- Filter Form -->
    <form action="/admin/users" method="get" class="d-flex flex-wrap gap-3 align-items-center">
        <input type="hidden" name="action" value="search">

        <div class="input-group">
            <span class="input-group-text"><i class="bi bi-search"></i></span>
            <input type="text" name="keyword" id="searchInput" class="form-control"
                   placeholder="Tìm kiếm theo tên..." value="<c:out value="${keyword}"/>">
        </div>

        <div class="input-group">
            <span class="input-group-text"><i class="bi bi-person-fill-gear"></i></span>
            <select id="roleFilter" name="roleId" class="form-select">
                <option value="">Tất cả vai trò</option>
                <c:forEach items="${roleList}" var="role">
                    <option value="${role.getRoleId()}" ${role.getRoleId() == roleId ? 'selected' : ''}>
                            ${role.getRoleName()}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div>
            <button type="submit" class="btn btn-primary">
                <i class="bi bi-search"></i> Tìm kiếm
            </button>
            <a href="/admin/users" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-clockwise"></i> Đặt lại
            </a>
        </div>
    </form>

    <!-- Add User Button -->
    <div class="ms-md-auto">
        <button id="createUserBtn" type="button" class="btn btn-primary"
                data-bs-toggle="modal" data-bs-target="#userFormModal">
            <i class="bi bi-plus-circle me-2"></i>Thêm người dùng
        </button>
    </div>
</div>
