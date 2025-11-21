<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="modal fade" id="confirmDeleteContentModal" tabindex="-1" aria-labelledby="confirmDeleteContentModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmDeleteContentModalLabel">Xác nhận xóa Nội dung</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Bạn có chắc chắn muốn xóa nội dung <strong id="contentNameToDelete"></strong>? <strong class="text-danger">Hành động này không thể hoàn tác.</strong>
            </div>
            <div class="modal-footer">
                <form id="deleteContentForm" method="post" action="/admin/lessons?action=deleteContent">
                    <input type="hidden" id="deleteContentId" name="contentId"/>
                    <input type="hidden" id="deleteContentLessonId" name="lessonId" value="${lesson.lessonId}"/>
                    <input type="hidden" id="deleteContentModuleId" name="moduleId" value="${moduleId}"/>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-danger">Xóa</button>
                </form>
            </div>
            </div>
        </div>
    </div>
</div>
