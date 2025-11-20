<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="modal-dialog modal-lg">
<div class="modal-content">
<div class="modal-header">
    <h5 class="modal-title">${mode eq 'update' ? 'Cập nhật thông tin' : 'Tạo tài khoản mới'}</h5>
    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
</div>
<div class="modal-body">

<form action="${mode eq 'update' ? '/admin/users?action=update':'/admin/users?action=add'}" method="post" class="needs-validation" novalidate>

    <input type="hidden" name="userId" value="${user.userId}"/>

    <div class="row">
        <div class="col-md-6 mb-3">
            <label for="fullName" class="form-label d-flex align-items-center"
            ><i class="bi bi-asterisk text-danger" style="font-size: 10px"></i> Họ và tên</label
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
                        value="${mode eq 'update' ? user.fullName : ''}"
                        required
                        pattern="^[a-zA-ZÀ-ỹ\s]+$"
                        title="Họ tên không được để trống hoặc chỉ chứa khoảng trắng"/>
                <div class="invalid-feedback">
                    Họ tên không hợp lệ (không được chứa số hoặc ký tự đặc biệt).
                </div>

            </div>
        </div>

        <div class="col-md-6 mb-3">
            <label for="email" class="form-label"><i class="bi bi-asterisk text-danger" style="font-size: 10px"></i>
                Email</label>
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
                        value="${mode eq 'update' ? user.email : ''}"
                        required
                        pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"/>
                <div class="invalid-feedback">
                    Email không hợp lệ.
                </div>
            </div>
        </div>
    </div>

    <%-- Password fields are now always in the DOM, but hidden in update mode --%>
    <div class="row" id="password-fields-row" <c:if test="${mode eq 'update'}">style="display: none;"</c:if>>
        <div class="col-md-6 mb-3">
            <label for="password" class="form-label"
            ><i class="bi bi-asterisk text-danger" style="font-size: 10px"></i> Mật khẩu</label
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
                        <c:if test="${mode ne 'update'}">required</c:if>/>
                <div class="invalid-feedback">
                    Mật khẩu không được để trống.
                </div>
            </div>
        </div>

        <div class="col-md-6 mb-3">
            <label for="confirmPassword" class="form-label"
            ><i class="bi bi-asterisk text-danger" style="font-size: 10px"></i>Xác nhận mật khẩu</label
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
                        <c:if test="${mode ne 'update'}">required</c:if>/>
                <div class="invalid-feedback">
                    Mật khẩu không khớp.
                </div>
            </div>
        </div>
    </div>


    <div class="row">
        <div class="col-md-6 mb-3">
            <label for="role" class="form-label"><i class="bi bi-asterisk text-danger" style="font-size: 10px"></i> Vai
                trò</label>
            <div class="input-group">
    <span class="input-group-text">
    <i class="bi bi-shield-check"></i>
    </span>
                <select name="roleId" class="form-select" id="role" required>
                    <option value="" ${mode eq 'update' && user.roleId == 1 ? 'selected' : ''} disabled>Chọn vai trò
                    </option>
                    <option value="3" ${mode eq 'update' && user.roleId == 3 ? 'selected' : ''}>Student (Học viên)
                    </option>
                    <option value="2" ${mode eq 'update' && user.roleId == 2 ? 'selected' : ''}>Teacher (Giảng viên)
                    </option>
                    <option value="4" ${mode eq 'update' && user.roleId == 4 ? 'selected' : ''}>AO (Giáo vụ)</option>
                </select>
            </div>
        </div>
        <div class="col-md-6 mb-3">
            <label for="phone" class="form-label"
            ><i class="bi bi-asterisk text-danger" style="font-size: 10px"></i>Số điện thoại</label
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
                        value="${mode eq 'update' ? user.phone : ''}"
                        required
                        pattern="0[3|5|7|8|9][0-9]{8}"/>
                <div class="invalid-feedback">
                    Số điện thoại không hợp lệ (phải có 10 số và đúng đầu số VN).
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6 mb-3">
            <label for="dateOfBirth" class="form-label"
            ><i class="bi bi-asterisk text-danger" style="font-size: 10px"></i>Ngày sinh</label
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
                <div class="invalid-feedback">
                    Ngày sinh không được để trống.
                </div>
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
                        value="${mode eq 'update' ? user.position : ''}"
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
                        value="${mode eq 'update' ? user.address : ''}"
                        placeholder="Nhập địa chỉ"/>
            </div>
        </div>
    </div>

    <div class="modal-footer">
        <button type="reset" id="cancel-reset-btn" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-clockwise me-2"></i>${mode eq 'update' ? 'Hủy' : 'Làm mới'}
        </button>
        <button type="submit" class="btn btn-primary">
            <i class="bi bi-person-plus me-2"></i>${mode eq 'update' ? 'Cập nhật' : 'Tạo tài khoản'}
        </button>
    </div>
    </form>
    </div>
    </div>
</div>

