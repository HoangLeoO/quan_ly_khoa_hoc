<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="border-top pt-4">
    <h4 class="mb-3">${mode eq 'update' ? 'Cập nhật thông tin' : 'Tạo tài khoản mới'}</h4>
    <form action="${mode eq 'update' ? '/admins?action=update':'/admins?action=add'}" method="post">
        <c:if test="${mode eq 'update'}">
            <input type="hidden" name="userId" value="${user.getUserId()}"/>
        </c:if>
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
                            value="${user.getFullName()}"
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
                            value="${user.getEmail()}"
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
                        <option value="" ${user.getRoleId() == 1 ? 'selected' : ''} disabled>Chọn vai trò</option>
                        <option value="3" ${user.getRoleId() == 3 ? 'selected' : ''}>Student (Học viên)</option>
                        <option value="2" ${user.getRoleId() == 2 ? 'selected' : ''}>Teacher (Giảng viên)</option>
                        <option value="4" ${user.getRoleId() == 4 ? 'selected' : ''}>AO (Giáo vụ)</option>
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
                            placeholder="Nhập số điện thoại"
                            value="${user.getPhone()}"
                            required/>
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
                            value="${user.getDob()}"
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
                            value="${user.getPosition()}"
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
                            value="${user.getAddress()}"
                            placeholder="Nhập địa chỉ"/>
                </div>
            </div>
        </div>

        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
            <button type="reset" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-clockwise me-2"></i>${mode eq 'update' ? 'Hủy' : 'Làm mới'}
            </button>
            <button type="submit" class="btn btn-primary">
                <i class="bi bi-person-plus me-2"></i>${mode eq 'update' ? 'Cập nhật' : 'Tạo tài khoản'}
            </button>
        </div>
    </form>
</div>