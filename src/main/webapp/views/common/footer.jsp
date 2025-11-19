<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 17/11/2025
  Time: 10:02 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<script>
    // ĐẶT GIỚI HẠN SỐ LƯỢNG NÚT SỐ HIỂN THỊ
    // Số 1 sẽ chỉ hiển thị 1 nút số (trang hiện tại) xung quanh
    $.fn.dataTable.ext.pager.numbers_length = 5;

    $(document).ready(function() {
        $('#tableStudent').dataTable({
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