<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="confirmDeleteModuleModal" tabindex="-1" aria-labelledby="confirmDeleteModuleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmDeleteModuleModalLabel">Xác nhận xóa Module</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Bạn có chắc chắn muốn xóa module <strong id="moduleNameToDelete"></strong>? <strong class="text-danger">Hành động này không thể hoàn tác.</strong>
            </div>
            <div class="modal-footer">
                <form id="deleteModuleForm" method="post" action="/admin/modules?action=delete">
                    <input type="hidden" id="deleteModuleId" name="moduleId"/>
                    <input type="hidden" name="courseId" value="${course.courseId}"/>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-danger">Xóa</button>
                </form>
            </div>
        </div>
    </div>
</div>
