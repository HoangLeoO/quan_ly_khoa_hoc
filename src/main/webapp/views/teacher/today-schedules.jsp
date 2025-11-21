<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
  <title>Lịch Học Hôm Nay - Điểm Danh</title>
  <c:import url="../common/header.jsp"/>
</head>
<body>
<div id="wrapper">
  <div>
    <c:import url="../common/navbar.jsp"/>
  </div>
  <section class="py-5 mt-5">
    <div class="container" style="margin-top: 50px">
      <div class="row justify-content-center">
        <div class="col-md-11">
          <div class="card border-0 shadow">
            <div class="card-body p-4 p-md-5">
              <div class="text-center mb-4">
                <i class="bi bi-calendar-check text-success" style="font-size: 4rem"></i>
              </div>

              <h4 class="mb-3 text-center">Danh sách lịch học hôm nay</h4>
              <p class="text-muted text-center">Chọn buổi học để bắt đầu điểm danh.</p>

              <div>
                <table id="tableStudent" class="table table-bordered table-hover">
                  <thead class="table-light">
                  <tr>
                    <th>STT</th>
                    <th>Lớp Học</th>
                    <th>Bài Học</th>
                    <th>Thời Gian Bắt Đầu</th>
                    <th>Phòng Học</th>
                    <th>Thao tác</th>
                  </tr>
                  </thead>
                  <tbody>

                  <c:forEach var="schedule" items="${todaySchedules}" varStatus="status">
                    <tr>
                      <td>${status.count}</td>
                      <td>${schedule.getClassName()}</td>
                      <td>${schedule.getLessonName()}</td>
                      <td>${schedule.getTimeStart()}</td>
                      <td>${schedule.getRoom()}</td>

                      <td>
                          <%-- Sử dụng c:choose để kiểm tra trạng thái --%>
                        <c:choose>
                          <%-- TRƯỜNG HỢP 1: Đã điểm danh => Hiển thị nút Chỉnh sửa --%>
                          <c:when test="${schedule.attendanceTaken}">
                            <a class="btn btn-sm btn-primary"
                               href="${pageContext.request.contextPath}/attendance?action=edit&scheduleId=${schedule.scheduleId}">
                              <i class="bi bi-pencil-square"></i> Chỉnh sửa
                            </a>
                          </c:when>

                          <%-- TRƯỜNG HỢP 2: Chưa điểm danh => Hiển thị nút Điểm danh mới --%>
                          <c:otherwise>
                            <a class="btn btn-sm btn-success"
                               href="${pageContext.request.contextPath}/attendance?action=takeNew&scheduleId=${schedule.scheduleId}">
                              <i class="bi bi-check-circle"></i> Điểm danh mới
                            </a>
                          </c:otherwise>
                        </c:choose>
                      </td>
                    </tr>
                  </c:forEach>

                  <c:if test="${empty todaySchedules}">
                    <tr>
                      <td colspan="6" class="text-center text-muted">Hôm nay không có lịch học nào cần điểm danh.</td>
                    </tr>
                  </c:if>

                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <div class="row">
    <c:import url="../common/footer.jsp"/>
  </div>
</div>

<%-- ------------------------------------------------------------------------------------------ --%>
<%-- TOAST CONTAINER VÀ MÃ TOAST --%>
<%-- ------------------------------------------------------------------------------------------ --%>

<div aria-live="polite" aria-atomic="true" class="bg-body-tertiary position-relative">
  <div class="toast-container position-fixed top-0 end-0 p-3">

    <div id="statusToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
      <div class="toast-header">
        <strong class="me-auto" id="toastTitle">Thông báo hệ thống</strong>
        <small id="toastTime">Vừa xong</small>
        <button type="button" class="btn-close ms-2 mb-1" data-bs-dismiss="toast" aria-label="Close"></button>
      </div>
      <div class="toast-body" id="toastMessage">
      </div>
    </div>

  </div>
</div>

<%-- ------------------------------------------------------------------------------------------ --%>
<%-- SCRIPT HIỂN THỊ TOAST --%>
<%-- ------------------------------------------------------------------------------------------ --%>
<script>
  document.addEventListener('DOMContentLoaded', function() {
    const urlParams = new URLSearchParams(window.location.search);
    const msg = urlParams.get('msg');

    if (msg) {
      const toastElement = document.getElementById('statusToast');
      const toastTitle = document.getElementById('toastTitle');
      const toastMessage = document.getElementById('toastMessage');

      let titleText = "Thông báo";
      let messageText = "";
      let bgColor = "bg-primary";

      // Xử lý thông báo dựa trên tham số msg
      switch (msg) {
        case 'saved':
          titleText = 'Thành công! 🎉';
          messageText = 'Dữ liệu điểm danh đã được lưu và cập nhật.';
          bgColor = "bg-success text-white";
          break;
        case 'error':
          titleText = 'Lỗi! 😕';
          messageText = 'Đã có lỗi xảy ra trong quá trình lưu điểm danh.';
          bgColor = "bg-danger text-white";
          break;
        case 'system_error':
          titleText = 'Lỗi Hệ thống!';
          messageText = 'Không thể xử lý yêu cầu.';
          bgColor = "bg-warning";
          break;
        default:
          return;
      }

      // Cập nhật nội dung và style
      toastTitle.textContent = titleText;
      toastMessage.textContent = messageText;

      // Thêm class màu vào toast-body
      // (Thêm và xóa class cũ nếu cần, để đảm bảo màu sắc chính xác)
      toastMessage.classList.remove('bg-primary', 'bg-success', 'bg-danger', 'bg-warning', 'text-white');
      if(bgColor.includes('text-white')) {
        toastMessage.classList.add('text-white');
      }
      toastMessage.classList.add(bgColor.split(' ')[0]);


      // Khởi tạo và hiển thị Toast
      const toast = new bootstrap.Toast(toastElement, {
        autohide: true,
        delay: 5000 // Tự động ẩn sau 5 giây
      });
      toast.show();

      // Xóa tham số msg khỏi URL sau khi hiển thị
      const newUrl = new URL(window.location.href);
      newUrl.searchParams.delete('msg');
      window.history.replaceState({}, document.title, newUrl.toString());
    }
  });
</script>

</body>
</html>