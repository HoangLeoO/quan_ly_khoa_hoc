<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: Hi
  Date: 19/11/2025
  Time: 8:51 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="mb-5">
    <h4 class="mb-3">Danh sách học viên</h4>
    <div class="table-responsive">
        <table id="tableClassInfo"
               class="table table-bordered table-hover table-striped align-middle text-center w-100">
            <thead class="table-light">
            <tr>
                <th style="width: 3%;">STT</th>
                <th style="width: 15%;">Họ và tên</th>
                <th style="width: 12%;">Số điện thoại</th>
                <th style="width: 10%;">Ngày sinh</th>
                <th style="width: 20%;">Địa chỉ</th>
                <th style="width: 15%;">Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="student" items="${student}" varStatus="status">
                <tr>
                    <td>${status.count}</td>
                    <td class="text-start">${student.getFullName()}</td>
                    <td class="text-start">${student.getPhone()}</td>
                    <td class="text-center">${student.getDob()}</td>
                    <td class="text-start">${student.getAddress()}</td>

                    <td>
                        <a class="btn btn-sm btn-success text-truncate" style="min-width: 120px;"
                           href="/acedemic-affairs?action=detail&id=${_class.classId}">
                            Tình trạng học tập
                        </a>
                        <a class="btn btn-sm btn-success text-truncate" style="min-width: 120px;"
                           href="/acedemic-affairs?action=detail&id=${_class.classId}">
                            Thông tin chi tiết
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

    </div>
</div>


