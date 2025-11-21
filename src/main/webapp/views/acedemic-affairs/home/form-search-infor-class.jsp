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
<form action="/acedemic-affairs" method="get" class="row g-3">

    <div class="col-md-3">
        <label>Tên lớp:</label>
        <input name="keyword" value="${param.keyword}" class="form-control" placeholder="Nhập tên lớp...">
    </div>

    <div class="col-md-3">
        <label>Giáo viên:</label>
        <select name="teacherId" class="form-control">
            <option value="">-- Tất cả --</option>
            <c:forEach var="t" items="${teacherList}">
                <option value="${t.staffId}"
                    ${param.teacherId == t.staffId ? "selected" : ""}>
                        ${t.fullName}
                </option>
            </c:forEach>
        </select>
    </div>

    <div class="col-md-3">
        <label>Khóa học:</label>
        <select name="courseId" class="form-control">
            <option value="">-- Tất cả --</option>
            <c:forEach var="c" items="${courseList}">
                <option value="${c.courseId}"
                    ${param.courseId == c.courseId ? "selected" : ""}>
                        ${c.courseName}
                </option>
            </c:forEach>
        </select>
    </div>

    <div class="col-md-3">
        <label>Trạng thái:</label>
        <select name="status" class="form-control">
            <option value="">-- Tất cả --</option>
            <option value="studying"   ${param.status == 'studying' ? "selected" : ""}>Đang học</option>
            <option value="completed"  ${param.status == 'completed' ? "selected" : ""}>Đã hoàn thành</option>
            <option value="dropped"    ${param.status == 'dropped' ? "selected" : ""}>Đã hủy</option>
        </select>
    </div>

    <div class="col-md-12 mt-2">
        <button class="btn btn-primary">Tìm kiếm</button>
        <a href="/acedemic-affairs" class="btn btn-secondary">Đặt lại</a>
    </div>
</form>
