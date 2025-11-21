<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="studentLog" value="${requestScope.studentLog}"/>
<c:set var="studentId" value="${requestScope.studentId}"/>
<c:set var="currentStaffId" value="${requestScope.currentStaffId}"/>
<c:set var="studentName" value="${requestScope.studentName != null ? requestScope.studentName : 'Học sinh #'}" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Nhật ký Học sinh ${studentName}</title>
    <c:import url="../common/header.jsp"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        .container {
            max-width: 850px;
        }
        .content-box {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border-left: 5px solid #17a2b8; /* Đồng bộ màu */
            white-space: pre-wrap;
            font-size: 1rem;
        }
        .detail-group {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="container py-5 mt-5">
    <c:choose>
        <c:when test="${empty studentLog}">
            <div class="alert alert-danger">
                Không tìm thấy Nhật ký Học sinh.
            </div>
        </c:when>
        <c:otherwise>
            <h1 class="text-info mb-4">
                <i class="bi bi-journal-text me-2"></i> Chi tiết Nhật ký ${studentName}
                <small class="text-muted fs-5">(${studentName}${studentId})</small>
            </h1>

            <div class="row">
                <div class="col-md-6 detail-group">
                    <label class="form-label text-primary fw-bold">Học sinh:</label>
                    <p class="form-control-plaintext">${studentName}${studentLog.studentId}</p>
                </div>
                <div class="col-md-6 detail-group">
                    <label class="form-label text-primary fw-bold">Người Viết (Staff):</label>
                    <p class="form-control-plaintext">${studentLog.authorStaffName} (ID: ${studentLog.authorStaffId})</p>
                </div>
            </div>

            <div class="detail-group">
                <label class="form-label text-primary fw-bold">Thời gian Ghi nhận:</label>
                <p class="form-control-plaintext">
                    <fmt:formatDate value="${studentLog.createdAt}" pattern="dd/MM/yyyy HH:mm:ss"/>
                </p>
            </div>

            <div class="detail-group">
                <label class="form-label text-primary fw-bold"><i class="bi bi-book me-1"></i> Nội dung:</label>
                <div class="content-box">
                        ${studentLog.content}
                </div>
            </div>

            <div class="mt-4 d-flex justify-content-between">
                    <%-- Nút Quay lại --%>
                <a href="${pageContext.request.contextPath}/student-log?studentId=${studentId}" class="btn btn-secondary">
                    <i class="bi bi-arrow-left-circle me-1"></i> Quay lại Danh sách Nhật ký
                </a>

                    <%-- Nút Hành động (Sửa/Xóa) --%>
                <c:if test="${studentLog.authorStaffId == currentStaffId}">
                    <div>
                        <a href="${pageContext.request.contextPath}/student-log?action=edit&logId=${studentLog.logId}&studentId=${studentId}" class="btn btn-warning text-dark me-2">
                            <i class="bi bi-pencil-square"></i> Chỉnh Sửa
                        </a>
                        <button type="button" class="btn btn-danger"
                                data-bs-toggle="modal"
                                data-bs-target="#confirmDeleteLogModal"
                                data-log-id="${studentLog.logId}">
                            <i class="bi bi-trash"></i> Xóa
                        </button>
                    </div>
                </c:if>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<%-- Cần thêm MODAL XÁC NHẬN XÓA vào đây (giống list view) --%>
</body>
</html>