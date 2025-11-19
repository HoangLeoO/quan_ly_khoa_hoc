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
    <h4 class="mb-3">Danh sách Lớp học</h4>
    <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle">
            <thead class="table-light">
            <tr class="align-middle">
                <th>STT</th>
                <th>Tên lớp</th>
                <th>Khóa học</th>
                <th>Giáo viên</th>
                <th>Số lượng học viên</th>
                <th>Ngày bắt đầu</th>
                <th>Ngày kết thúc</th>
                <th>Trạng thái</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>

            <c:forEach var="classes" items="${classList}" varStatus="status">

                <tr>
                    <td>${status.count}</td>
                    <td>${classes.getClassName()}</td>
                    <td>${classes.getCourseName()}</td>
                    <td>${classes.getTeacherName()}</td>
                    <td>${classes.getCountStudent()}</td>
                    <td>${classes.getStartDate()}</td>
                    <td>${classes.getEndDate()}</td>
                    <td>${classes.getStatus()}</td>
                    <td class="d-flex border-0 text-nowrap">
                        <a class="btn btn-sm btn-outline-primary me-1"
                           href="#">
                            Thời khóa biểu
                        </a>
                        <a class="btn btn-sm btn-outline-primary me-1"
                           href="#">
                            Chuyên cần
                        </a>
                        <a class="btn btn-sm btn-outline-primary me-1"
                           href="#">
                            Nhật ký
                        </a>
                    </td>
                </tr>

            </c:forEach>


            </tbody>
        </table>
    </div>
</div>