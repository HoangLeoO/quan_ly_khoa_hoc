<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Lịch Sử Nhật Ký Học Sinh</title>
  <%-- Import các file dùng chung --%>
  <c:import url="../common/header.jsp"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <style>
    .log-card {
      border-left: 5px solid #17a2b8; /* Thanh màu xanh ngọc đồng bộ */
      border-radius: .3rem;
      transition: transform 0.2s, box-shadow 0.2s;
    }
    .log-card:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .log-header {
      background-color: #f8f9fa;
      padding: 10px 15px;
      border-bottom: 1px solid #e9ecef;
    }
    .log-content-preview {
      max-height: 100px; /* Giới hạn chiều cao */
      overflow: hidden;
      text-overflow: ellipsis;
    }
  </style>
</head>
<body>
<div>
  <c:import url="../common/navbar.jsp"/>
</div>
<div class="container py-5 mt-5">

  <%-- Giả định studentName và currentStaffId đã được đặt trong Request Scope --%>
  <c:set var="studentName" value="${requestScope.studentName != null ? requestScope.studentName : 'Học sinh #'}" />
  <c:set var="currentStaffId" value="${requestScope.currentStaffId}" />

  <h1 class="mb-4 text-info">
    <i class="bi bi-person-lines-fill me-2"></i> Lịch Sử Nhật Ký của ${studentName}
    <span class="badge bg-info ms-2">${studentLogs.size()} bản ghi</span>
  </h1>

  <%-- Hiển thị thông báo (thành công/lỗi) từ Session (Đồng bộ) --%>
  <c:if test="${not empty sessionScope.message}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
      <i class="bi bi-check-circle me-2"></i>${sessionScope.message}
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <c:remove var="message" scope="session"/>
  </c:if>
  <c:if test="${not empty sessionScope.errorMessage}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
      <i class="bi bi-exclamation-triangle me-2"></i>${sessionScope.errorMessage}
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <c:remove var="errorMessage" scope="session"/>
  </c:if>

  <%-- Nút quay lại và nút Thêm Nhật Ký --%>
  <div class="mb-4 d-flex justify-content-between">
    <%-- Quay lại trang chi tiết học sinh (Giả định URL) --%>
    <a href="${pageContext.request.contextPath}/class?action=detail&classId=3&courseId=3l&studentId=${studentId}" class="btn btn-secondary">
      <i class="bi bi-arrow-left-circle me-1"></i> Quay lại chi tiết Học sinh
    </a>

    <%-- Nút Viết nhật ký mới --%>
    <a href="${pageContext.request.contextPath}/student-log?action=write&studentId=${studentId}" class="btn btn-success">
      <i class="bi bi-plus-circle me-1"></i> Viết nhật ký mới
    </a>
  </div>

  <c:choose>
    <c:when test="${not empty studentLogs}">
      <%-- Lặp qua danh sách nhật ký --%>
      <c:forEach var="log" items="${studentLogs}">
        <div class="card shadow-sm mb-4 log-card">
          <div class="log-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0 text-info">
              <i class="bi bi-journal-text me-2"></i> Nhật ký
            </h5>
            <div class="log-actions">
                <%-- Nút Chi tiết --%>
<%--              <a href="${pageContext.request.contextPath}/student-log?action=detail&logId=${log.logId}&studentId=${studentId}" class="btn btn-sm btn-outline-info me-1">--%>
<%--                <i class="bi bi-eye"></i> Chi tiết--%>
<%--              </a>--%>

                <%-- Nút Chỉnh sửa (Chỉ Staff là tác giả mới được sửa) --%>
              <c:if test="${log.authorStaffId == currentStaffId}">
                <a href="${pageContext.request.contextPath}/student-log?action=edit&logId=${log.logId}&studentId=${studentId}" class="btn btn-sm btn-warning text-dark me-1">
                  <i class="bi bi-pencil"></i> Sửa
                </a>

                <%-- Nút Xóa: Sử dụng data attributes để truyền logId và kích hoạt modal --%>
                <button type="button" class="btn btn-sm btn-danger"
                        data-bs-toggle="modal"
                        data-bs-target="#confirmDeleteLogModal"
                        data-log-id="${log.logId}">
                  <i class="bi bi-trash"></i> Xóa
                </button>
              </c:if>
            </div>
          </div>
          <div class="card-body">
            <div class="log-content-preview text-muted mb-2">
              <p>${log.content}</p>
            </div>
            <p class="card-subtitle small mt-3">
              <i class="bi bi-person me-1"></i> Tác giả: <strong>${log.authorStaffName}</strong>
              <span class="text-muted ms-3">| <i class="bi bi-clock me-1"></i> ${log.createdAt}</span>
            </p>
          </div>
        </div>
        <%-- Form Xóa riêng biệt cho mỗi log (ẩn đi) --%>
        <form id="deleteForm-${log.logId}"
              action="${pageContext.request.contextPath}/student-log?action=delete"
              method="POST"
              style="display:none;">
          <input type="hidden" name="logId" value="${log.logId}">
          <input type="hidden" name="studentId" value="${studentId}">
        </form>
      </c:forEach>
    </c:when>
    <c:otherwise>
      <div class="alert alert-info py-4" role="alert">
        <h4 class="alert-heading"><i class="bi bi-info-circle me-2"></i>Thông báo!</h4>
        <p>Hiện tại chưa có bất kỳ nhật ký nào được ghi cho học sinh này.</p>
        <hr>
        <a href="${pageContext.request.contextPath}/student-log?action=write&studentId=${studentId}" class="btn btn-info text-white">
          <i class="bi bi-pen me-1"></i> Bắt đầu ghi nhật ký ngay!
        </a>
      </div>
    </c:otherwise>
  </c:choose>

</div>

<%-- ------------------------------------------------------------------------------------------ --%>
<%-- MODAL XÁC NHẬN XÓA NHẬT KÝ (Đồng bộ) --%>
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
<%-- SCRIPT XỬ LÝ MODAL XÁC NHẬN XÓA (Đồng bộ) --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<%-- SCRIPT XỬ LÝ MODAL XÁC NHẬN XÓA (Đồng bộ) --%>
<script>
  document.addEventListener('DOMContentLoaded', function () {
    const deleteLogModal = document.getElementById('confirmDeleteLogModal');

    deleteLogModal.addEventListener('show.bs.modal', function (event) {
      const button = event.relatedTarget;
      const logId = button.getAttribute('data-log-id');

      // ⭐ ĐÃ XÓA 3 dòng code lỗi:
      // const logIdPlaceholder = deleteLogModal.querySelector('#logIdPlaceholder');
      // logIdPlaceholder.textContent = logId;

      const confirmDeleteButton = deleteLogModal.querySelector('#confirmDeleteButton');
      // Xóa sự kiện onclick cũ để tránh submit nhiều lần
      confirmDeleteButton.onclick = null;

      // Thiết lập sự kiện mới: tìm form tương ứng và submit nó
      confirmDeleteButton.onclick = function() {
        // Form cần submit có ID là 'deleteForm-' + logId
        const formToSubmit = document.getElementById('deleteForm-' + logId);
        if (formToSubmit) {
          formToSubmit.submit();
        }
      };
    });
  });
</script>
</body>
</html>