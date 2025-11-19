<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 11/18/2025
  Time: 9:33 AM
  To change this template use File | Settings | File Templates.
--%>
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
        <div class="container">
            <div class="row">
                <div class="col-2">Xin chào</div>
                <div class="col-8"></div>
                <div class="col-2" id="today"></div>
            </div>
        </div>
        <div class="container" style="margin-top: 50px">
            <div class="row justify-content-center">
                <div class="col-md-10">
                    <div class="card border-0 shadow">
                        <div class="card-body p-4 p-md-5">
                            <div class="text-center mb-4">
                                <i class="bi bi-book text-black" style="font-size: 4rem"></i>
                            </div>
                            <div class="mb-5">
                                <h4 class="mb-3">Danh sách Lớp học</h4>
                                <div class="table-responsive">
                                    <table id="tableStudent" class="table table-bordered table-hover">
                                        <thead class="table-light">
                                        <tr>
                                            <th>STT</th>
                                            <th>Tên Lớp Học</th>
                                            <th>Tên Khóa Học</th>
                                            <th>Ngày bắt đầu</th>
                                            <th>Ngày kết thúc</th>
                                            <th>Thao tác</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="classes" items="${classList}" varStatus="status">
                                            <tr>
                                                <td>${status.count}</td>
                                                <td>${classes.getClassName()}</td>
                                                <td>${classes.getCourseName()}</td>
                                                <td>${classes.getStartDate()}</td>
                                                <td>${classes.getEndDate()}</td>
                                                <td class="d-flex border-0 text-nowrap">
                                                    <a class="btn btn-sm btn-outline-primary me-1"
                                                       href="/teacher?action=detail&classId=${classes.getClassId()}&courseId=${classes.getCourseId()}&className=${classes.getClassName()}">
                                                        Chi tiết
                                                    </a>
                                                </td>
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
        <c:import url="../common/footer.jsp"/>
    </div>
</div>
</body>
<script>

    function showTodayDateWithDay(elementId) {
        const today = new Date();

        const days = [
            "Chủ Nhật",
            "Thứ Hai",
            "Thứ Ba",
            "Thứ Tư",
            "Thứ Năm",
            "Thứ Sáu",
            "Thứ Bảy"
        ];

        const dayName = days[today.getDay()];
        const options = {day: '2-digit', month: '2-digit', year: 'numeric'};
        const formattedDate = today.toLocaleDateString('vi-VN', options);

        document.getElementById(elementId).innerText = dayName + " ngày " + formattedDate;
    }

    showTodayDateWithDay("today");
</script>
</html>
