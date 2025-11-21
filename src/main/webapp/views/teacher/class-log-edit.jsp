<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa Nhật ký #${classLog.logId}</title>

    <c:set var="classLog" value="${requestScope.classLog}"/>
    <c:set var="className" value="${requestScope.className}"/>
    <%-- c:set var="currentStaffId" value="${requestScope.currentStaffId}"/ --%>
    <c:set var="errorMessage" value="${requestScope.errorMessage}"/> <%-- Lỗi nếu có --%>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7f9;
            color: #333;
            line-height: 1.6;
            padding: 20px;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #ffc107;
            border-bottom: 2px solid #ffc107;
            padding-bottom: 10px;
            margin-bottom: 20px;
            font-size: 1.8rem;
        }
        .detail-group {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

<div class="container mt-5">

    <c:if test="${empty classLog}">
        <%-- Xử lý trường hợp không tìm thấy dữ liệu (mặc dù Controller đã xử lý lỗi này) --%>
        <div class="alert alert-danger" role="alert">
            Không thể tải dữ liệu nhật ký để chỉnh sửa.
            <a href="${pageContext.request.contextPath}/class-log?action=history&classId=${param.classId}">Quay lại lịch sử</a>
        </div>
    </c:if>

    <c:if test="${not empty classLog}">
        <h1>
            <i class="bi bi-pencil-square me-2"></i> Chỉnh sửa Nhật ký
            <small class="text-muted">Lớp: ${className} </small>
        </h1>

        <%-- Hiển thị thông báo lỗi (nếu có lỗi khi submit lại form) --%>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i> ${errorMessage}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/class-log" method="POST">

                <%-- HIDDEN FIELDS BẮT BUỘC cho việc Cập nhật --%>
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="logId" value="${classLog.logId}">
            <input type="hidden" name="classId" value="${classLog.classId}">

            <div class="row">
                <div class="col-md-6 detail-group">
                    <label class="form-label text-primary"><i class="bi bi-person me-1"></i> Người Viết:</label>
                        <%-- Giả định DTO có hàm getAuthorStaffName() --%>
                    <p class="form-control-plaintext"><strong>${classLog.authorStaffName}</strong></p>
                </div>
                <div class="col-md-6 detail-group">
                    <label class="form-label text-primary"><i class="bi bi-calendar-check me-1"></i> Thời gian Ghi nhận:</label>
                    <p class="form-control-plaintext">
                        <fmt:formatDate value="${classLog.createdAt}" pattern="dd/MM/yyyy HH:mm:ss"/>
                    </p>
                </div>
            </div>

            <hr>

                <%-- TRƯỜNG CÓ THỂ CHỈNH SỬA: Nội dung Nhật ký --%>
            <div class="mb-4">
                <label for="content" class="form-label fw-bold"><i class="bi bi-book me-1"></i> Nội dung Nhật ký:</label>
                    <%-- Hiển thị nội dung hiện tại trong textarea để chỉnh sửa --%>
                <textarea class="form-control" id="content" name="content" rows="10" required>${classLog.content}</textarea>
                <div class="form-text">Hãy điền nội dung cần chỉnh sửa vào đây.</div>
            </div>

                <%-- Nhóm nút hành động --%>
            <div class="d-flex justify-content-end">
                <a href="${pageContext.request.contextPath}/class-log?action=history&classId=${classLog.classId}&teacherId=${classLog.authorStaffId}" class="btn btn-secondary me-2">
                    <i class="bi bi-x-circle me-1"></i> Hủy
                </a>
                <button type="submit" class="btn btn-warning">
                    <i class="bi bi-save me-1"></i> Lưu Chỉnh Sửa
                </button>
            </div>

        </form>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>