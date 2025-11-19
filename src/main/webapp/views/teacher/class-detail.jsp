<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 11/18/2025
  Time: 8:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Title</title>
    <c:import url="../common/header.jsp"/>
</head>
<body>
<div>
    <div>
        <c:import url="../common/navbar.jsp"/>
    </div>

    <section class="py-5 mt-5">
        <div class="container" style="margin-top: 50px">
            <div class="row justify-content-center">
                <div class="col-md-10">
                    <div class="card border-0 shadow">
                        <div class="card-body p-4 p-md-5">
                            <div class="text-center mb-4">
                                <i class="bi bi-book text-black" style="font-size: 4rem"></i>
                            </div>
                            <div class="mb-5">
                                <div class="row">
                                    <div class="col-6">
                                        <h4 class="mb-3">Danh sách sinh viên của lớp ${className}</h4>
                                    </div>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover">
                                        <thead class="table-light">
                                        <tr>
                                            <th>STT</th>
                                            <th>Họ và Tên</th>
                                            <th>Tổng số buổi</th>
                                            <th>Đi học</th>
                                            <th>Đi muộn</th>
                                            <th>Vắng</th>
                                            <th>Có phép</th>
                                            <th>Thao tác</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="student" items="${studentList}" varStatus="status">
                                            <tr>
                                                <td>${status.count}</td>
                                                <td>${student.getFullName()}</td>
                                                <td>${student.getTotalSessions()}</td>
                                                <td>${student.getPresentCount()}</td>
                                                <td>${student.getLateCount()}</td>
                                                <td>${student.getAbsentCount()}</td>
                                                <td>${student.getExcusedCount()}</td>
                                                <td><a href="/attendance?action=view-form&classId=${classId}&courseId=${courseId}" class="btn btn-primary">
                                                    <i class="bi bi-calendar-check"></i>Chi tiết
                                                </a></td>
                                            </tr>


                                        </c:forEach>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <div class="row">
        <c:import url="../teacher/footer-teacher.jsp"/>
    </div>
</div>
</body>
</html>
