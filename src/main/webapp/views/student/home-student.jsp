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
    <%-- Đảm bảo bạn đã import Bootstrap CSS ở đây (trong header.jsp) --%>
    <c:import url="../common/header.jsp"/>
    <style>
        /* Tùy chỉnh CSS để làm cho giao diện đẹp và hiện đại hơn */
        .card-class-list {
            /* Giới hạn chiều rộng cho phần danh sách lớp học */
            max-width: 100%;
            /* Bật cuộn ngang nếu nội dung vượt quá (cho trường hợp số lượng card nhiều) */
            overflow-x: auto;
            /* Đảm bảo không cuộn dọc không cần thiết */
            overflow-y: hidden;
            /* Tùy chọn: Thêm khoảng cách ở đáy để thanh cuộn không quá sát */
            padding-bottom: 10px;
        }

        /* Định nghĩa bố cục cho các card bên trong để chúng nằm trên một hàng và có thể cuộn */
        .card-row-scrollable {
            display: flex;
            /* Ngăn các card xuống dòng */
            flex-wrap: nowrap;
            /* Khoảng cách giữa các card */
            gap: 1.5rem; /* Tương đương với g-4 trong Bootstrap */
            padding-bottom: 5px; /* Giảm khoảng cách giữa nội dung và thanh cuộn */
        }

        /* Định nghĩa kích thước cố định cho mỗi cột/card để kích hoạt cuộn */
        .card-col-fixed {
            /* flex-shrink: 0; đảm bảo cột không bị co lại */
            flex: 0 0 auto;
            /* Đặt chiều rộng cố định (ví dụ: 300px) hoặc dùng % */
            width: 300px;
        }

        /* Tùy chỉnh màu sắc và shadow cho Card */
        .card-modern {
            border-radius: 12px;
            /* Shadow đẹp hơn, nhẹ hơn */
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08) !important;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .card-modern:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.12) !important;
        }

        /* Tùy chỉnh tiêu đề chính */
        .main-header-icon {
            font-size: 4.5rem !important; /* Biểu tượng to hơn */
            color: #0d6efd; /* Màu primary */
        }

        /* Ẩn thanh cuộn ngang mặc định của trình duyệt cho các trình duyệt hỗ trợ */
        .card-class-list::-webkit-scrollbar {
            height: 8px; /* Chiều cao của thanh cuộn ngang */
        }

        .card-class-list::-webkit-scrollbar-thumb {
            background-color: #ced4da; /* Màu của "cục nắm" cuộn */
            border-radius: 4px;
        }

        .card-class-list::-webkit-scrollbar-track {
            background: #f8f9fa; /* Màu nền của thanh cuộn */
            border-radius: 4px;
        }

        /* CSS mới để xử lý tiêu đề lớp học trên một dòng */
        .card-title-single-line {
            white-space: nowrap;      /* Ngăn văn bản xuống dòng */
            overflow: hidden;         /* Ẩn phần văn bản tràn */
            text-overflow: ellipsis;  /* Thêm dấu ba chấm nếu tràn */
        }

    </style>
</head>
<body>
<c:import url="../common/navbar.jsp"/>


<section class="py-5">
    <div class="container" style="margin-top: 50px">
        <div class="row justify-content-center">
            <div class="col-lg-10 col-xl-9">
                <div class="card border-0 shadow-lg p-3">
                    <div class="card-body p-4 p-md-5">

                        <%-- KHU VỰC TIÊU ĐỀ ĐÃ ĐƯỢC CHỈNH SỬA --%>
                        <div class="mb-5">
                            <div class="text-center mb-5">
                                <i class="bi bi-person-gear main-header-icon"></i>
                                <h3 class="mt-3 fw-bold text-dark">TRANG CHỦ HỌC VIÊN 👋</h3>
                                <p class="text-muted fs-6">
                                    Chào mừng bạn đến với khóa học CodeGym. Hãy kiểm tra các lớp học hiện tại của bạn.
                                </p>
                            </div>

                            <%-- Bắt đầu phần thống kê mới để lấp đầy khoảng trống --%>
                            <div class="row text-center">
                                <%-- Giả định biến học viên và số liệu --%>
                                <c:set var="studentName" value="${empty studentName ? 'Học viên CodeGym' : studentName}"/>
                                <c:set var="studyingClassCount" value="${empty studyingClassCount ? fn:length(classInfo) : studyingClassCount}"/>

                                <div class="col-md-6 mb-3 mb-md-0">
                                    <div class="p-3 bg-light rounded-3 h-100 border border-primary-subtle">
                                        <h5 class="fw-bold text-primary mb-2">Chào mừng, ${studentName}!</h5>
                                        <p class="mb-0 text-muted small">
                                            <i class="bi bi-calendar-check me-1"></i> Luôn sẵn sàng cho buổi học tiếp theo!
                                        </p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="p-3 bg-light rounded-3 h-100 border border-info-subtle">
                                        <h5 class="fw-bold text-dark mb-2">${studyingClassCount} Lớp đang học</h5>
                                    </div>
                                </div>
                            </div>
                            <%-- Kết thúc phần thống kê mới --%>
                        </div>
                        <%-- KẾT THÚC KHU VỰC TIÊU ĐỀ ĐÃ ĐƯỢC CHỈNH SỬA --%>

                        <div class="mb-5" id="class-list-section">
                            <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
                                <h4 class="mb-0 fw-semibold text-dark">Danh sách lớp học hiện tại</h4>
                                <a href="students?action=view-classes" class="btn btn-outline-secondary btn-sm rounded-pill">
                                    <i class="bi bi-archive-fill me-1"></i> Xem các khóa học đã hoàn thành
                                </a>
                            </div>

                            <%-- KHU VỰC CHỨA DANH SÁCH CLASS CARD VÀ HỖ TRỢ SCROLL NGANG --%>
                            <div class="card-class-list">
                                <%-- Dùng flexbox để tạo hàng ngang, nowrap để không xuống dòng --%>
                                <div class="card-row-scrollable">
                                    <c:forEach items="${classInfo}" var="c" varStatus="stt">
                                        <%-- Bắt đầu Card cho mỗi lớp học --%>
                                        <div class="card-col-fixed">
                                            <div class="card h-100 card-modern">
                                                <div class="card-body d-flex flex-column p-3">

                                                        <%-- 1. Tên Khóa học & Lớp học --%>
                                                        <%-- ĐÃ THÊM class card-title-single-line VÀO ĐÂY --%>
                                                    <h5 class="card-title text-dark fw-bold card-title-single-line">${c.getClassName()}</h5>
                                                    <h6 class="card-subtitle mb-3 text-muted small">
                                                        Khóa học: <span class="fw-semibold">${c.getCourseName()}</span>
                                                    </h6>

                                                        <%-- 2. Trạng thái lớp học (Badge) --%>
                                                    <div class="mb-3">
                                                        <span class="text-uppercase small fw-bold me-2 text-dark">Trạng thái:</span>
                                                        <c:choose>
                                                            <c:when test="${c.getStatus() == 'studying'}">
                                                                <span class="badge rounded-pill bg-success-subtle text-success">Đang học</span>
                                                            </c:when>
                                                            <c:when test="${c.getStatus() == 'completed'}">
                                                                <span class="badge rounded-pill bg-secondary-subtle text-secondary">Đã hoàn thành</span>
                                                            </c:when>
                                                            <c:when test="${c.getStatus() == 'dropped'}">
                                                                <span class="badge rounded-pill bg-danger-subtle text-danger">Đã hủy</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge rounded-pill bg-info-subtle text-info">Không rõ</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>

                                                        <%-- 3. Nút Thao tác (Đẩy xuống dưới cùng của card) --%>
                                                    <div class="mt-auto pt-2">
                                                        <a href="students?action=detail-class&course-id=${c.getCourse_id()}&class-id=${c.getClassId()}" class="btn btn-sm btn-primary w-100 fw-semibold">
                                                            <i class="bi bi-info-circle-fill me-1"></i> Xem Chi tiết
                                                        </a>
                                                    </div>
                                                </div>
                                                    <%-- Footer (Thêm nhãn STT) --%>
                                                <div class="card-footer bg-light border-0 py-2 text-center">
                                                    <small class="text-muted fw-bold">#${stt.count}</small>
                                                </div>
                                            </div>
                                        </div>
                                        <%-- Kết thúc Card --%>
                                    </c:forEach>
                                </div>
                            </div>
                            <%-- KẾT THÚC KHU VỰC SCROLL NGANG --%>


                            <%-- Xử lý trường hợp không có dữ liệu --%>
                            <c:if test="${empty classInfo}">
                                <div class="alert alert-info text-center py-4 mt-4 border-0 shadow-sm">
                                    <i class="bi bi-emoji-frown me-2 fs-5"></i> Hiện tại bạn chưa đăng ký lớp học nào đang diễn ra.
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