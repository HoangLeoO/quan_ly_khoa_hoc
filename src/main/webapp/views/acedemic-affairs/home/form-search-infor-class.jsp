<%--
  Created by IntelliJ IDEA.
  User: Hi
  Date: 19/11/2025
  Time: 11:47 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<form action="#" method="get" class="row g-3">

    <!-- Tên lớp -->
    <div class="col-md-3">
        <label>Tên lớp:</label>
        <input name="keyword" class="form-control" placeholder="Nhập tên lớp...">
    </div>

    <!-- Giáo viên -->
    <div class="col-md-3">
        <label>Giáo viên:</label>
        <select name="teacherId" class="form-control">
            <option value="">-- Tất cả --</option>
            <c:forEach var="t" items="${teacherList}">
                <option value="${t.id}">${t.name}</option>
            </c:forEach>
        </select>
    </div>

    <!-- Khóa học -->
    <div class="col-md-3">
        <label>Khóa học:</label>
        <select name="courseId" class="form-control">
            <option value="">-- Tất cả --</option>
            <c:forEach var="c" items="${courseList}">
                <option value="${c.id}">${c.name}</option>
            </c:forEach>
        </select>
    </div>

    <!-- Trạng thái -->
    <div class="col-md-3">
        <label>Trạng thái:</label>
        <select name="status" class="form-control">
            <option value="">-- Tất cả --</option>
            <option value="ACTIVE">Đang học</option>
            <option value="UPCOMING">Sắp mở</option>
            <option value="FINISHED">Đã kết thúc</option>
        </select>
    </div>

    <!-- Nút tìm -->
    <div class="col-md-12">
        <button class="btn btn-primary mt-2">Tìm kiếm</button>
    </div>
</form>
