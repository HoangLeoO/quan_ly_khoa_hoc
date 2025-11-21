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

<%-- ------------------------------------------------------------------------------------------ --%>
<%-- MODAL XÁC NHẬN XÓA NHẬT KÝ --%>
<%-- ------------------------------------------------------------------------------------------ --%>
<div class="modal fade" id="confirmDeleteLogModal" tabindex="-1" aria-labelledby="confirmDeleteLogModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title" id="confirmDeleteLogModalLabel"><i class="bi bi-exclamation-triangle-fill me-2"></i>Xác nhận Xóa Nhật Ký</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc chắn muốn xóa nhật ký học sinh ${studentName} không?</p>

                <%-- Form ẩn dùng để SUBMIT yêu cầu DELETE --%>
                <form id="deleteLogForm" method="POST" action="${pageContext.request.contextPath}/student-log">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="logId" id="modalLogIdInput" value="">
                    <input type="hidden" name="studentId" value="${studentId}">
                </form>

                <p class="text-danger small">Hành động này không thể hoàn tác.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy bỏ</button>
                <button type="button" class="btn btn-danger" id="confirmDeleteButton">
                    <i class="bi bi-trash me-1"></i> Đồng ý Xóa
                </button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<%-- SCRIPT XỬ LÝ MODAL XÁC NHẬN XÓA --%>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const deleteLogModal = document.getElementById('confirmDeleteLogModal');
        const confirmDeleteButton = document.getElementById('confirmDeleteButton');
        const deleteLogForm = document.getElementById('deleteLogForm');
        const modalLogIdInput = document.getElementById('modalLogIdInput');

        if (deleteLogModal) {
            // Lắng nghe sự kiện modal sắp hiển thị
            deleteLogModal.addEventListener('show.bs.modal', function (event) {
                // Lấy logId từ nút kích hoạt modal (Nút 'Xóa')
                const button = event.relatedTarget;
                const logId = button.getAttribute('data-log-id');

                // Cập nhật giá trị logId vào input ẩn trong form
                modalLogIdInput.value = logId;
            });

            // Lắng nghe sự kiện click cho nút "Đồng ý Xóa" trong modal
            confirmDeleteButton.addEventListener('click', function() {
                // Submit form
                deleteLogForm.submit();
            });
        }
    });
</script>
</body>
</html>