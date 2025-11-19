<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
  <title>Lịch Học Hôm Nay - Điểm Danh</title>
  <c:import url="../common/header.jsp"/>
</head>
<body>
<div id="wrapper">
  <div>
    <c:import url="../teacher/navbar-teacher.jsp"/>
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

              <div class="table-responsive">
                <table class="table table-bordered table-hover">
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

                      <td class="text-nowrap">
                        <a class="btn btn-sm btn-success me-1"
                           href="${pageContext.request.contextPath}/teacher/take-attendance?action=takeNew&scheduleId=${schedule.getScheduleId()}">
                          <i class="bi bi-pencil-square"></i> Điểm danh mới
                        </a>
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
    <c:import url="../teacher/footer-teacher.jsp"/>
  </div>
</div>
</body>
</html>