<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="mb-5">
    <div class="d-flex align-items-center mb-3">
        <h3 class="mb-0">Danh sách học viên</h3>
        <button class="btn btn-success ms-auto" data-bs-toggle="modal" data-bs-target="#addStudentModal">
            Thêm học viên vào lớp
        </button>
    </div>
    <div class="table-responsive">
        <table id="tableStudentInfo"
               class="table table-bordered table-hover table-striped align-middle text-center w-100">
            <thead class="table-light">
            <tr>
                <th style="width: 3%;">STT</th>
                <th style="width: 15%;">Họ và tên</th>
                <th style="width: 12%;">Số điện thoại</th>
                <th style="width: 10%;">Ngày sinh</th>
                <th style="width: 20%;">Địa chỉ</th>
                <th style="width: 25%;">Thao tác</th>
            </tr>
            </thead>
            <tbody>

            <c:forEach var="student" items="${studentList}" varStatus="status">
                <tr>
                    <td>${status.count}</td>
                    <td class="text-start">${student.fullName}</td>
                    <td class="text-start">${student.phone}</td>
                    <td class="text-center">${student.dobFormatted}</td>
                    <td class="text-start">${student.address}</td>
                    <td>
                        <div class="d-flex flex-column align-items-center gap-1">
                            <div class="d-flex justify-content-center gap-1 w-100">
                                <!-- Nút Tình trạng học tập -->
                                <a class="btn btn-sm btn-success flex-grow-1 text-truncate"
                                   href="/acedemic-affairs?action=status&id=${student.studentId}">
                                    Tình trạng học tập
                                </a>
                                <!-- Nút Thông tin chi tiết -->
                                <a class="btn btn-sm btn-primary flex-grow-1 text-truncate"
                                   href="/acedemic-affairs?action=detail&id=${student.studentId}">
                                    Thông tin chi tiết
                                </a>
                            </div>
                            <div class="d-flex justify-content-center gap-1 w-100">
                                <!-- Nút Xóa học sinh -->
                                <button class="btn btn-danger btn-sm flex-grow-1 btn-delete-student"
                                        data-id="${student.studentId}" data-name="${student.fullName}">
                                    Xóa học sinh
                                </button>
                            </div>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>



