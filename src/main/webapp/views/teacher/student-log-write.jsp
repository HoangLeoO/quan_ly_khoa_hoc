<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Viết Nhật ký Mới - Học sinh #${studentId}</title>
  <c:import url="../common/header.jsp"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

  <style>
    body {
      background-color: #f4f7f9;
    }
    .container {
      max-width: 900px;
      margin-top: 50px;
      padding: 30px;
      background: #ffffff;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }
    h1 {
      border-bottom: 2px solid #17a2b8; /* Đồng bộ màu */
      padding-bottom: 10px;
      margin-bottom: 30px;
      color: #17a2b8;
      font-size: 2rem;
    }
    .form-label {
      font-weight: 600;
      color: #495057;
    }
    .form-control {
      border-radius: 8px;
      padding: 10px;
    }
  </style>
</head>
<body>

<div class="container">
  <h1 class="text-info"><i class="bi bi-pen me-2"></i> Viết Nhật ký</h1>
  <h4 class="text-muted mb-4">Học sinh: ${studentName}</h4>

  <%-- Hiển thị thông báo lỗi (Đồng bộ) --%>
  <c:if test="${not empty sessionScope.errorMessage}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
      <i class="bi bi-exclamation-triangle me-2"></i>${sessionScope.errorMessage}
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <c:remove var="errorMessage" scope="session"/>
  </c:if>

  <form action="${pageContext.request.contextPath}/student-log?action=create" method="POST">
    <%-- HIDDEN FIELDS BẮT BUỘC --%>
    <input type="hidden" name="studentId" value="${requestScope.studentId}">
    <input type="hidden" name="authorStaffId" value="${requestScope.authorStaffId}">

    <div class="mb-4">
      <label for="content" class="form-label fs-5">
        <i class="bi bi-chat-left-text me-1"></i> Nội dung Nhật ký:
      </label>
      <textarea class="form-control" id="content" name="content" rows="15" placeholder="Nhập chi tiết về hành vi, tiến độ, hoặc nhận xét về học sinh..." required></textarea>
      <div class="form-text">Nội dung này sẽ được lưu với Staff ID của bạn.</div>
    </div>

    <div class="d-flex justify-content-between pt-3">
      <%-- Nút Quay lại --%>
      <a href="${pageContext.request.contextPath}/student-log?studentId=${requestScope.studentId}" class="btn btn-secondary">
        <i class="bi bi-x-circle me-1"></i> Hủy và Quay lại
      </a>

      <%-- Nút Gửi (Lưu) --%>
      <button type="submit" class="btn btn-primary btn-lg">
        <i class="bi bi-save me-2"></i> Lưu Nhật ký
      </button>
    </div>
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>