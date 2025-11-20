<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 18/11/2025
  Time: 10:16 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Danh sách Module</title>
    <c:import url="../common/header.jsp"/>
</head>
<body>
<c:import url="../common/navbar.jsp"/>

<section>
    <div class="container" style="margin-top: 50px">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card border-0 shadow rounded-3">
                    <div class="card-body p-4 p-md-5">
                        <div class="text-center mb-4">
                            <i
                                    class="bi bi-journal-bookmark text-primary"
                                    style="font-size: 4rem"></i>
                            <h3 class="mt-3">Các Module trong Khóa học</h3>
                            <p class="text-muted">
                                Danh sách các module bạn cần hoàn thành trong chương trình Codegym
                            </p>
                        </div>

                        <div class="mb-5">
                            <h4 class="mb-4">Danh sách Module hiện tại</h4>

                            <%--
                                SỬA Ở ĐÂY: Thêm lớp 'justify-content-center' nếu độ dài của moduleList bằng 1
                                Lưu ý: Bạn phải thêm taglib prefix="fn" ở trên
                            --%>
                            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 <c:if test="${fn:length(moduleList) == 1}">justify-content-center</c:if>">

                                <c:forEach items="${moduleList}" var="m" varStatus="stt">
                                    <%-- Lấy giá trị tiến độ, mặc định là 0 nếu NULL --%>
                                    <c:set var="progress" value="${empty m.progressPercentage ? 0 : m.progressPercentage}"/>

                                    <div class="col">
                                        <div class="card h-100 shadow-sm border-0">
                                            <div class="card-body d-flex flex-column">

                                                    <%-- Tên Module --%>
                                                <h5 class="card-title text-truncate text-primary">${m.moduleName}</h5>

                                                    <%-- Thanh Tiến độ --%>
                                                <div class="mt-2 mb-3">
                                                    <span class="text-muted small">Tiến độ:</span>
                                                    <div class="progress mt-1" style="height: 25px;">
                                                        <div class="progress-bar progress-bar-striped
                                    <c:if test="${progress == 100}">bg-success</c:if>
                                    <c:if test="${progress < 100 && progress > 0}">bg-info</c:if>
                                    <c:if test="${progress == 0}">bg-secondary</c:if>"
                                                             role="progressbar"
                                                             style="width: ${progress}%;"
                                                             aria-valuenow="${progress}"
                                                             aria-valuemin="0"
                                                             aria-valuemax="100">
                                                            <span class="fw-bold">${progress}%</span>
                                                        </div>
                                                    </div>
                                                </div>

                                                    <%-- Nút Thao tác (Đẩy xuống dưới cùng) --%>
                                                <div class="mt-auto">
                                                    <a href="${pageContext.request.contextPath}/students?action=detail-module&module-id=${m.moduleId}">
                                                        <button class="btn btn-sm btn-outline-primary w-100 rounded-pill">
                                                            <i class="bi bi-eye me-1"></i> Xem chi tiết module
                                                        </button>
                                                    </a>
                                                </div>

                                            </div>

                                                <%-- Card Footer (Hiển thị STT) --%>
                                            <div class="card-footer bg-light border-top-0 py-1 text-center">
                                                <small class="text-muted">${stt.count}</small>
                                            </div>

                                        </div>
                                    </div>
                                </c:forEach>

                            </div>

                            <%-- Placeholder cho trường hợp không có module nào --%>
                            <c:if test="${empty moduleList}">
                                <div class="alert alert-info text-center py-4">
                                    <i class="bi bi-info-circle me-2"></i> Hiện chưa có module nào được gán cho bạn.
                                </div>
                            </c:if>
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