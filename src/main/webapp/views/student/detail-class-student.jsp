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
<section class="py-5 mt-5">
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
                            <h3 class="mt-3">Các Module trong Khóa học</h3>
                            <p class="text-muted">
                                Danh sách các module bạn cần hoàn thành trong chương trình Codegym
                            </p>
                        </div>

                        <!-- Module List Table -->
                        <div class="mb-5">
                            <h4 class="mb-3">Danh sách Module hiện tại</h4>
                            <div class="table-responsive">
                                <table id="tableStudent" class="table table-bordered table-hover align-middle">
                                    <thead class="table-light">
                                    <tr>
                                        <th class="text-center" style="width: 10%">STT</th>
                                        <th style="width: 70%">Tên Module</th>
                                        <th class="text-center" style="width: 20%">Thao tác</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%-- Giả định biến ${moduleList} chứa danh sách các module --%>
                                    <c:forEach items="${moduleList}" var="m" varStatus="stt">
                                        <tr>
                                            <td class="text-center">${stt.count}</td>
                                            <td>${m.getModuleName()}</td>
                                            <td class="text-center">
                                                <a href="${pageContext.request.contextPath}/students?action=details">
                                                    <button class="btn btn-sm btn-outline-primary me-1 rounded-pill">
                                                        Xem chi tiết module
                                                    </button>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <%-- Placeholder cho trường hợp không có module nào --%>
                                    <c:if test="${empty moduleList}">
                                        <tr>
                                            <td colspan="3" class="text-center text-muted py-4">
                                                Hiện chưa có module nào được gán cho bạn.
                                            </td>
                                        </tr>
                                    </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <%-- pagination - Giữ nguyên cấu trúc phân trang --%>
                        <div class="d-flex justify-content-center">
                            <ul class="pagination shadow-sm rounded-pill">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#" aria-label="Previous">&laquo;</a>
                                </li>
                                <li class="page-item active">
                                    <a class="page-link" href="#">1</a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="#">2</a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="#">3</a>
                                </li>
                                <li class="page-item disabled">
                                    <a class="page-link" href="#" aria-label="Next">&raquo;</a>
                                </li>
                            </ul>
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
