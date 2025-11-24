<%--
  Created by IntelliJ IDEA.
  User: Hi
  Date: 21/11/2025
  Time: 4:16 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="modal fade" id="deleteClassModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title">Xác nhận xóa</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/acedemic-affairs" method="post">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="id" id="deleteClassId">
                <div class="modal-body">
                    Bạn có chắc muốn xóa lớp: <b id="deleteClassName"></b> ?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-danger">Xóa</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Khi click nút xóa trên bảng
    document.querySelectorAll('.btn-delete').forEach(function(btn) {
        btn.addEventListener('click', function() {
            const id = this.getAttribute('data-id');
            const name = this.getAttribute('data-name');

            document.getElementById('deleteClassId').value = id;
            document.getElementById('deleteClassName').textContent = name;

            new bootstrap.Modal(document.getElementById('deleteClassModal')).show();
        });
    });
</script>
