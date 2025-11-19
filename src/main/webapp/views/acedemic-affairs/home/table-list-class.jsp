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
    <h4 class="mb-3">Danh sách Lớp học</h4>
    <div class="table-responsive">
        <table id ="tableClassInfo" class="table table-bordered table-hover table-striped align-middle text-center w-100">
            <thead class="table-light text-center align-middle">
            <tr>
                <th style="width: 3%;">STT</th>
                <th style="width: 15%;">Tên lớp</th>
                <th style="width: 20%;">Khóa học</th>
                <th style="width: 7%;">Trạng thái</th>
                <th style="width: 15%;">Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="classes" items="${classList}" varStatus="status">
                <tr class="align-middle text-center">
                    <td>${status.count}</td>
                    <td class="text-start">${classes.getClassName()}</td>
                    <td class="text-start">${classes.getCourseName()}</td>
                    <td>
                        <c:choose>
                            <c:when test="${classes.getStatus() == 'Đang học'}">
                                <span class="badge bg-success">${classes.getStatus()}</span>
                            </c:when>
                            <c:when test="${classes.getStatus() == 'Sắp mở'}">
                                <span class="badge bg-warning text-dark">${classes.getStatus()}</span>
                            </c:when>
                            <c:when test="${classes.getStatus() == 'Đã kết thúc'}">
                                <span class="badge bg-danger">${classes.getStatus()}</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary">${classes.getStatus()}</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <div class="d-flex justify-content-center flex-wrap gap-1">
                            <a class="btn btn-sm btn-outline-primary flex-grow-1 text-truncate" style="min-width: 100px;" href="/acedemic-affairs?action=detail&id=${classes.getClassId()}">Chi tiết</a>

                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

    </div>
</div>


<script>
    // ĐẶT GIỚI HẠN SỐ LƯỢNG NÚT SỐ HIỂN THỊ
    // Số 1 sẽ chỉ hiển thị 1 nút số (trang hiện tại) xung quanh
    $.fn.dataTable.ext.pager.numbers_length = 5;

    $(document).ready(function() {
        $('#tableClassInfo').dataTable({
            // SỬ DỤNG KIỂU PHÂN TRANG NÂNG CAO
            "pagingType": "full_numbers",

            "dom": 'lrti<"row"<"col-sm-12 col-md-5"l><"col-sm-12 col-md-7 d-flex justify-content-end"p>>',
            "lengthChange": false,
            "pageLength": 5,

            // VIỆT HÓA VÀ ĐỔI TÊN NÚT PHÂN TRANG
            "language": {
                "url": "//cdn.datatables.net/plug-ins/2.0.8/i18n/vi.json",

                // Ghi đè các nhãn cho nút phân trang
                "paginate": {
                    "previous": "Trước",
                    "next": "Sau",
                    "first": "",
                    "last": ""
                }
            }
        });
    });
</script>