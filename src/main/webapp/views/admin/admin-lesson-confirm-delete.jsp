<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="modal fade" id="confirmDeleteLessonModal" tabindex="-1" aria-labelledby="confirmDeleteLessonModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmDeleteLessonModalLabel">Xác nhận xóa Bài học</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Bạn có chắc chắn muốn xóa bài học <strong id="lessonNameToDelete"></strong>? <strong class="text-danger">Hành động này không thể hoàn tác.</strong>
            </div>
            <div class="modal-footer">
                <form id="deleteLessonForm" method="post" action="/admin/lessons?action=delete">
                    <input type="hidden" id="deleteLessonId" name="lessonId"/>
                    <input type="hidden" id="deleteLessonModuleId" name="moduleId" value="${module.moduleId}"/>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-danger">Xóa</button>
                </form>
            </div>
        </div>
    </div>
</div>
