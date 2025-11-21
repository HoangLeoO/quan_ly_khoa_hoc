<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form action="/admin/courses" method="get" class="d-flex flex-wrap gap-3 align-items-center">
    <input type="hidden" name="action" value="search">
    <div class="input-group">
        <span class="input-group-text"><i class="bi bi-search"></i></span>
        <input type="text" name="keyword" class="form-control" placeholder="Tìm kiếm khóa học..." value="<c:out value='${keyword}'/>">
    </div>
    <div>
        <button type="submit" class="btn btn-primary">
            <i class="bi bi-search"></i> Tìm kiếm
        </button>
        <a href="/admin/courses" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-clockwise"></i> Đặt lại
        </a>
    </div>
</form>
