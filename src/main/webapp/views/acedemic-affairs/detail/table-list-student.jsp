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
    <div id="tableClassContainer">
        <div class="table-responsive">
            <table id="tableClassInfo" class="table table-bordered table-hover table-striped align-middle text-center">
                <thead class="table-light">
                <tr>
                    <th style="width: 3%;">STT</th>
                    <th style="width: 20%;">Họ và tên</th>
                    <th style="width: 15%;">Số điện thoại</th>
                    <th style="width: 12%;">Ngày sinh</th>
                    <th style="width: 25%;">Địa chỉ</th>
                    <th style="width: 25%;">Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="student" items="${studentList}" varStatus="status">
                    <tr>
                        <td>${status.count}</td>
                        <td class="text-start">${student.fullName}</td>
                        <td class="text-start">${student.phone}</td>
                        <td class="text-start">${student.dobFormatted}</td>
                        <td class="text-start">${student.address}</td>
                        <td>
                            <div class="d-flex justify-content-center gap-1">
                                <a class="btn btn-sm btn-success" title="Tình trạng học tập"
                                   href="/acedemic-affairs?action=status&id=${student.studentId}">
                                    <i class="bi bi-graph-up"></i>
                                </a>

                                <a class="btn btn-sm btn-primary" title="Thông tin chi tiết"
                                   href="/acedemic-affairs?action=detail&id=${student.studentId}">
                                    <i class="bi bi-info-circle"></i>
                                </a>

                                <button class="btn btn-sm btn-danger btn-delete-student"
                                        data-id="${student.studentId}" data-name="${student.fullName}"
                                        title="Xóa học sinh">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>



