<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Quản trị viên - CODEGYM</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css"/>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-4Gqr6jhmNs4sKfyRatL2w+g3UqE8vh4h8S9f4kG2jxRUX9N1nf8e3B4tFy4eB5W"
            crossorigin="anonymous"/>
    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg bg-white fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#">
            <i class="bi bi-mortarboard-fill me-2"></i>CODEGYM Admin
        </a>
        <button
                class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarNav"
                aria-controls="navbarNav"
                aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="admin.html"
                    >Quản lý người dùng</a
                    >
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="course-management.html"
                    >Quản lý khóa học</a
                    >
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="module-management.html"
                    >Quản lý Module</a
                    >
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="lesson-management.html"
                    >Quản lý Bài học</a
                    >
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="class-management.html"
                    >Quản lý Lớp học</a
                    >
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="login.html">Đăng xuất</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Admin Section -->
<section class="py-5 mt-5">
    <div class="container" style="margin-top: 50px">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card border-0 shadow">
                    <div class="card-body p-4 p-md-5">
                        <div class="text-center mb-4">
                            <i
                                    class="bi bi-person-gear text-black"
                                    style="font-size: 4rem"></i>
                            <h3 class="mt-3">Quản lý người dùng</h3>
                            <p class="text-muted">
                                Tạo tài khoản mới cho người dùng với các vai trò khác nhau
                            </p>
                        </div>

                        <!-- User List Table -->
                        <div class="mb-5">
                            <h4 class="mb-3">Danh sách người dùng</h4>
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead class="table-light">
                                    <tr>
                                        <th>STT</th>
                                        <th>Họ và tên</th>
                                        <th>Email</th>
                                        <th>Ngày sinh</th>
                                        <th>Vị trí</th>
                                        <th>Vai trò</th>
                                        <th>Ngày tạo</th>
                                        <th>Thao tác</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="user" items="${userList}" varStatus="index">
                                        <tr>
                                            <td>${index.count}</td>
                                            <td>${user.getFullName()}</td>
                                            <td>${user.getEmail()}</td>
                                            <td>${user.getDob()}</td>
                                            <td>${user.getPosition()}</td>
                                            <c:if test="${empty user.getRoleId()}">
                                                <td><span class="badge bg-success" style="width: 60px">Not Assigned</span></td>
                                            </c:if>
                                            <c:if test="${user.getRoleId() == 1}">
                                                <td><span class="badge bg-danger"style="width: 60px">Admin</span></td>
                                            </c:if>
                                            <c:if test="${user.getRoleId() == 2}">
                                                <td><span class="badge bg-success"style="width: 60px">Teacher</span></td>
                                            </c:if>
                                            <c:if test="${user.getRoleId() == 3}">
                                                <td><span class="badge bg-info"style="width: 60px">Student</span></td>
                                            </c:if>
                                            <c:if test="${user.getRoleId() == 4}">
                                                <td><span class="badge bg-warning"style="width: 60px">AO</span></td>
                                            </c:if>
                                            <td>${user.getDob()}</td>
                                            <td class="d-flex border-0">
                                                <button class="btn btn-sm btn-outline-primary me-1">
                                                    <i class="bi bi-pencil"></i>
                                                </button>
                                                <button class="btn btn-sm btn-outline-danger">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Create User Form -->
                        <div class="border-top pt-4">
                            <h4 class="mb-3">Tạo tài khoản mới</h4>
                            <form action="admins?action=add" method="post">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="fullName" class="form-label"
                                        >Họ và tên</label
                                        >
                                        <div class="input-group">
                          <span class="input-group-text">
                            <i class="bi bi-person"></i>
                          </span>
                                            <input
                                                    name="fullName"
                                                    type="text"
                                                    class="form-control"
                                                    id="fullName"
                                                    placeholder="Nhập họ và tên"
                                                    required/>
                                        </div>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label for="email" class="form-label">Email</label>
                                        <div class="input-group">
                          <span class="input-group-text">
                            <i class="bi bi-envelope"></i>
                          </span>
                                            <input
                                                    name="email"
                                                    type="email"
                                                    class="form-control"
                                                    id="email"
                                                    placeholder="Nhập email"
                                                    required/>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="password" class="form-label"
                                        >Mật khẩu</label
                                        >
                                        <div class="input-group">
                          <span class="input-group-text">
                            <i class="bi bi-lock"></i>
                          </span>
                                            <input
                                                    name="password"
                                                    type="password"
                                                    class="form-control"
                                                    id="password"
                                                    placeholder="Nhập mật khẩu"
                                                    required/>
                                        </div>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label for="confirmPassword" class="form-label"
                                        >Xác nhận mật khẩu</label
                                        >
                                        <div class="input-group">
                          <span class="input-group-text">
                            <i class="bi bi-lock-fill"></i>
                          </span>
                                            <input
                                                    name="confirmPassword"
                                                    type="password"
                                                    class="form-control"
                                                    id="confirmPassword"
                                                    placeholder="Xác nhận mật khẩu"
                                                    required/>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="role" class="form-label">Vai trò</label>
                                        <div class="input-group">
                          <span class="input-group-text">
                            <i class="bi bi-shield-check"></i>
                          </span>
                                            <select name="roleId" class="form-select" id="role" required>
                                                <option value="" selected disabled>
                                                    Chọn vai trò
                                                </option>
                                                <option value="3">Student (Học viên)</option>
                                                <option value="2">
                                                    Teacher (Giảng viên)
                                                </option> <option value="4">
                                                    AO (Giáo vụ)
                                                </option>
                                                <option value="1">Admin (Quản trị viên)</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label for="phone" class="form-label"
                                        >Số điện thoại</label
                                        >
                                        <div class="input-group">
                          <span class="input-group-text">
                            <i class="bi bi-telephone"></i>
                          </span>
                                            <input
                                                    name="phone"
                                                    type="tel"
                                                    class="form-control"
                                                    id="phone"
                                                    placeholder="Nhập số điện thoại"/>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="dateOfBirth" class="form-label"
                                        >Ngày sinh</label
                                        >
                                        <div class="input-group">
                          <span class="input-group-text">
                            <i class="bi bi-calendar-date"></i>
                          </span>
                                            <input
                                                    name="dob"
                                                    type="date"
                                                    class="form-control"
                                                    id="dateOfBirth"
                                                    required/>
                                        </div>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label for="position" class="form-label">Vị trí</label>
                                        <div class="input-group">
                          <span class="input-group-text">
                            <i class="bi bi-briefcase"></i>
                          </span>
                                            <input
                                                    name="position"
                                                    type="text"
                                                    class="form-control"
                                                    id="position"
                                                    placeholder="Nhập vị trí công việc"/>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="address" class="form-label">Địa chỉ</label>
                                        <div class="input-group">
                          <span class="input-group-text">
                            <i class="bi bi-geo-alt"></i>
                          </span>
                                            <input
                                                    name="address"
                                                    type="text"
                                                    class="form-control"
                                                    id="address"
                                                    placeholder="Nhập địa chỉ"/>
                                        </div>
                                    </div>
                                </div>

                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                    <button type="reset" class="btn btn-outline-secondary">
                                        <i class="bi bi-arrow-clockwise me-2"></i>Làm mới
                                    </button>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-person-plus me-2"></i>Tạo tài khoản
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="bg-dark text-white py-4" style="margin-top: 99.5px">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <p>&copy; 2023 EduLearn. Tất cả quyền được bảo lưu.</p>
            </div>
            <div class="col-md-6 text-md-end">
                <a href="#" class="text-white text-decoration-none me-3"
                >Chính sách bảo mật</a
                >
                <a href="#" class="text-white text-decoration-none"
                >Điều khoản sử dụng</a
                >
            </div>
        </div>
    </div>
</footer>

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>

<script>
    // Form validation
    document
        .querySelector("form")
        .addEventListener("submit", function (event) {
            event.preventDefault();

            const password = document.getElementById("password").value;
            const confirmPassword =
                document.getElementById("confirmPassword").value;

            if (password !== confirmPassword) {
                alert("Mật khẩu và xác nhận mật khẩu không khớp!");
                return;
            }

            // Get form values
            const fullName = document.getElementById("fullName").value;
            const email = document.getElementById("email").value;
            const role = document.getElementById("role").value;
            const phone = document.getElementById("phone").value;
            const address = document.getElementById("address").value;
            const dateOfBirth = document.getElementById("dateOfBirth").value;
            const position = document.getElementById("position").value;

            // Create new row for the table
            const tableBody = document.querySelector("tbody");
            const newRow = document.createElement("tr");

            // Get next ID
            const rows = tableBody.querySelectorAll("tr");
            const nextId = rows.length + 1;

            // Set role badge color
            let roleBadge = "";
            if (role === "admin") {
                roleBadge = '<span class="badge bg-primary">Admin</span>';
            } else if (role === "teacher") {
                roleBadge = '<span class="badge bg-success">Teacher</span>';
            } else if (role === "student") {
                roleBadge = '<span class="badge bg-info">Student</span>';
            }

            // Format date of birth
            const birthDate = new Date(dateOfBirth);
            const formattedBirthDate = `${birthDate
            .getDate()
            .toString()
            .padStart(2, "0")}/${(birthDate.getMonth() + 1)
            .toString()
            .padStart(2, "0")}/${birthDate.getFullYear()}`;

            // Get current date
            const today = new Date();
            const formattedDate = `${today
            .getDate()
            .toString()
            .padStart(2, "0")}/${(today.getMonth() + 1)
            .toString()
            .padStart(2, "0")}/${today.getFullYear()}`;

            // Set row HTML
            newRow.innerHTML = `
          <td>${nextId}</td>
          <td>${fullName}</td>
          <td>${email}</td>
          <td>${formattedBirthDate}</td>
          <td>${position || "Chưa có"}</td>
          <td>${roleBadge}</td>
          <td>${formattedDate}</td>
          <td>
            <button class="btn btn-sm btn-outline-primary me-1">
              <i class="bi bi-pencil"></i>
            </button>
            <button class="btn btn-sm btn-outline-danger" onclick="deleteRow(this)">
              <i class="bi bi-trash"></i>
            </button>
          </td>
        `;

            // Add row to table
            tableBody.appendChild(newRow);

            // Reset form
            this.reset();

            // Show success message
            alert("Tạo tài khoản thành công!");
        });

    // Delete row function
    function deleteRow(btn) {
        if (confirm("Bạn có chắc chắn muốn xóa người dùng này?")) {
            const row = btn.closest("tr");
            row.remove();

            // Update IDs
            const rows = document.querySelectorAll("tbody tr");
            rows.forEach((row, index) => {
                row.cells[0].textContent = index + 1;
            });
        }
    }
</script>
</body>
</html>
