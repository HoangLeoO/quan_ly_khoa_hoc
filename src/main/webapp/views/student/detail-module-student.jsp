<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 18/11/2025
  Time: 10:16 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <c:import url="../common/header.jsp"/>
</head>
<body>
<c:import url="../common/navbar.jsp"/>

<!-- Section -->
<section>
    <div class="container" style="margin-top: 50px">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card border-0 shadow rounded-3">
                    <div class="card-body p-4 p-md-5">
                        <div class="text-center mb-4">
                            <!-- Icon mô tả khóa học/module -->
                            <i
                                    class="bi bi-journal-bookmark text-primary"
                                    style="font-size: 4rem"></i>
                            <h3 class="mt-3">Các bài học trong module này</h3>
                            <p class="text-muted">
                                Danh sách các bài học bạn cần hoàn thành trong chương trình Codegym
                            </p>
                        </div>

                        <!-- Module List Table -->
                        <div class="mb-5">
                            <h4 class="mb-3">Danh sách bài học hiện tại</h4>
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover align-middle">
                                    <thead class="table-light text-center">
                                    <tr>
                                        <th scope="col" style="width: 60px;">STT</th>
                                        <th scope="col">Tên Bài Học</th>
                                        <th scope="col" style="width: 150px;">Trạng Thái</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${lessons}" var="lesson" varStatus="loop">
                                        <form action="students" method="post">
                                            <tr data-lesson-id="${lesson.getLessonId()}"
                                                class="${lesson.getStatus() ? 'table-success' : ''}">

                                                <td class="text-center fw-bold">${loop.count}</td>

                                                <td class="fw-bold">
                                                    <a href="students?action=lesson-content">${lesson.getLessonName()}</a>
                                                </td>

                                                <td class="text-center">

                                                    <input type="hidden" name="action" value="update-lesson-status">
                                                    <input type="hidden" name="lessonId"
                                                           value="${lesson.getLessonId()}">
                                                    <input type="checkbox"
                                                           name="status"
                                                           class="form-check-input"
                                                           style="cursor:pointer; width:1.5em; height:1.5em;"
                                                           value="true"
                                                           <c:if test="${lesson.getStatus()}">checked</c:if>
                                                           onchange="this.form.submit()">

                                                </td>

                                            </tr>
                                        </form>
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


<c:import url="../common/footer.jsp"/>
</body>
</html>
