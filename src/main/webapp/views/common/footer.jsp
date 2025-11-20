<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 17/11/2025
  Time: 10:02 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    // ĐẶT GIỚI HẠN SỐ LƯỢNG NÚT SỐ HIỂN THỊ
    // Số 1 sẽ chỉ hiển thị 1 nút số (trang hiện tại) xung quanh
    $.fn.dataTable.ext.pager.numbers_length = 5;

    $(document).ready(function() {
        $('#tableClassInfo').dataTable({
            // SỬ DỤNG KIỂU PHÂN TRANG NÂNG CAO
            "pagingType": "full_numbers",

            "dom": 'lrt<"row"<"col-sm-12 col-md-5"l><"col-sm-12 col-md-7 d-flex justify-content-end"p>>',
            "lengthChange": false,
            "pageLength": 5,

            // VIỆT HÓA VÀ ĐỔI TÊN NÚT PHÂN TRANG
            "language": {
                // Ghi đè các nhãn cho nút phân trang
                "paginate": {
                    "previous": "TRƯỚC",
                    "next": "SAU",
                    "first": "",
                    "last": ""
                }
            }
        });
    });
</script>