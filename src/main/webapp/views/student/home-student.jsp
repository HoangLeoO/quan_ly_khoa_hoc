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
    <title>Trang chủ Học viên</title>
    <c:import url="../common/header.jsp"/>
</head>
<body>
<c:import url="../common/navbar.jsp"/>


<section >
    <div class="container" style="margin-top: 50px">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card border-0 shadow">
                    <div class="card-body p-4 p-md-5">
                        <div class="text-center mb-4">
                            <i
                                    class="bi bi-person-gear text-black"
                                    style="font-size: 4rem"></i>
                            <h3 class="mt-3">Trang chủ học viên</h3>
                            <p class="text-muted">
                                Chào mừng học viên đến với khóa học codegym
                            </p>
                        </div>

                        <div class="mb-5">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h4 class="mb-0">Danh sách lớp học hiện tại</h4>

                                <div class="">
                                    <a href="students?action=view-classes" class="btn btn-outline-secondary btn-sm">
                                        <i class="bi bi-archive-fill me-1"></i> Xem các khóa học đã hoàn thành
                                    </a>
                                </div>
                            </div>

                            <%--
                                Bắt đầu hiển thị Cards
                                row-cols-1: 1 cột trên màn hình nhỏ
                                row-cols-md-2: 2 cột trên màn hình trung bình
                                row-cols-lg-3: 3 cột trên màn hình lớn
                            --%>
                            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 <c:if test="${fn:length(classInfo) == 1}">justify-content-center</c:if>">
                                <c:forEach items="${classInfo}" var="c" varStatus="stt">
                                    <%-- Bắt đầu Card cho mỗi lớp học --%>
                                    <div class="col">
                                        <div class="card h-100 shadow-sm border-0">
                                            <div class="card-body d-flex flex-column">

                                                    <%-- 1. Tên Khóa học & Lớp học (Đã sửa từ h3 thành h5) --%>
                                                <h5 class="card-title text-primary">${c.getClassName()}</h5>
                                                <h6 class="card-subtitle mb-2 text-muted">
                                                    Khóa học: **${c.getCourseName()}**
                                                </h6>

                                                    <%-- 2. Trạng thái lớp học (Badge) - Đã Việt hóa và sửa màu --%>
                                                <div class="mb-3">
                                                    <span class="text-uppercase small fw-bold me-2">Trạng thái:</span>
                                                    <c:choose>
                                                        <c:when test="${c.getStatus() == 'studying'}">
                                                            <span class="badge bg-success">Đang học</span>
                                                        </c:when>
                                                        <c:when test="${c.getStatus() == 'completed'}">
                                                            <span class="badge bg-secondary">Đã hoàn thành</span>
                                                        </c:when>
                                                        <c:when test="${c.getStatus() == 'dropped'}">
                                                            <span class="badge bg-danger">Đã hủy</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-info text-dark">Không rõ</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>

                                                    <%-- 3. Nút Thao tác (Đẩy xuống dưới cùng của card) --%>
                                                <div class="mt-auto">
                                                    <a href="students?action=detail-class&course-id=${c.getCourse_id()}" class="btn btn-sm btn-primary w-100">
                                                        <i class="bi bi-info-circle-fill me-1"></i> Xem Chi tiết
                                                    </a>
                                                </div>
                                            </div>
                                                <%-- Footer (Đã thêm nhãn STT) --%>
                                            <div class="card-footer bg-light border-top-0 py-1 text-center">
                                                <small class="text-muted">${stt.count}</small>
                                            </div>
                                        </div>
                                    </div>
                                    <%-- Kết thúc Card --%>
                                </c:forEach>
                            </div>

                            <%-- Xử lý trường hợp không có dữ liệu --%>
                            <c:if test="${empty classInfo}">
                                <div class="alert alert-info text-center py-4">
                                    <i class="bi bi-emoji-frown me-2"></i> Hiện tại bạn chưa đăng ký lớp học nào.
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