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
        <c:import url="../teacher/navbar-teacher.jsp"/>
    </div>
    <section class="py-5 mt-5">
        <div class="container" style="margin-top: 50px">
            <div class="row justify-content-center">
                <div class="col-md-10">
                    <div class="card border-0 shadow">
                        <div class="card-body p-4 p-md-5">
                            <div class="text-center mb-4">
                                <i class="bi bi-book text-black" style="font-size: 4rem"></i>
                                <h3 class="mt-3">Quản lý lớp học</h3>
                            </div>
                            <c:import url="../teacher/table-teacher.jsp"/>
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

        document.getElementById(elementId).innerText = dayName + " " + formattedDate;
    }

    showTodayDateWithDay("today");
</script>
</html>
