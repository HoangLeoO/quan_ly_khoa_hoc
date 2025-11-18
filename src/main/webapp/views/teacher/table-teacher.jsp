<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 11/18/2025
  Time: 11:42 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Course List Table -->
<div class="mb-5">
    <h4 class="mb-3">Danh sách Lớp học</h4>
    <div class="table-responsive">
        <table class="table table-bordered table-hover">
            <thead class="table-light">
            <tr>
                <th>STT</th>
                <th>Tên Lớp Học</th>
                <th>Tên Khóa Học</th>
                <th>Ngày bắt đầu</th>
                <th>Ngày kết thúc</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>1</td>
                <td>C0525G1-JV101</td>
                <td>
                    Khóa học lập trình Java
                </td>
                <td>
                    02/03/2012
                </td>
                <td>
                    02/03/2012
                </td>
                <td class="d-flex border-0 text-nowrap">
                    <button
                            class="btn btn-sm btn-outline-primary me-1"
                            onclick="editCourse(3)">Chi tiết
                    </button>
                </td>
            </tr>
            <tr>
                <td>2</td>
                <td>C0525G1-JV101</td>
                <td>
                    Khóa học phân tích dữ liệu với Python
                </td>
                <td>
                    02/03/2012
                </td>
                <td>
                    02/03/2012
                </td>
                <td class="d-flex border-0 text-nowrap">
                    <button
                            class="btn btn-sm btn-outline-primary me-1"
                            onclick="editCourse(3)">Chi tiết
                    </button>
                </td>
            </tr>
            <tr>
                <td>3</td>
                <td>C0525G1-JV101</td>
                <td>
                    Khóa học phát triển web
                </td>
                <td>
                    02/03/2012
                </td>
                <td>
                    02/03/2012
                </td>
                <td class="d-flex border-0 text-nowrap">
                    <button
                            class="btn btn-sm btn-outline-primary me-1"
                            onclick="editCourse(3)">Chi tiết
                    </button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
