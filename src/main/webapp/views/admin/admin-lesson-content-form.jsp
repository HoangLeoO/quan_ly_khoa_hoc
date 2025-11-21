<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="lessonContentFormModal" tabindex="-1" aria-labelledby="lessonContentFormModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="lessonContentFormModalLabel">Chỉnh sửa Nội dung Bài học</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="lessonContentForm" action="/admin/lessons?action=updateContent" method="post" class="needs-validation" novalidate>
                    <input type="hidden" id="lessonIdContent" name="lessonId" value="${lesson.lessonId}"/>
                    <input type="hidden" id="moduleIdContent" name="moduleId" value="${moduleId}"/>
                    
                    <div class="mb-3">
                        <label for="contentTypeContent" class="form-label d-flex align-items-center">Loại nội dung<span
                                class="text-danger">*</span></label>
                        <select class="form-select" id="contentTypeContent" name="contentType" required>
                            <option value="">Chọn loại nội dung</option>
                            <option value="text">Bài đọc</option>
                            <option value="video">Video</option>
                            <option value="quiz">Quiz</option>
                        </select>
                        <div class="invalid-feedback">Vui lòng chọn loại nội dung.</div>
                    </div>
                    <div id="contentDataFieldContent" class="mb-3">
                        <!-- Dynamic content input will be loaded here -->
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="submit" form="lessonContentForm" class="btn btn-primary">
                    <i class="bi bi-check-circle me-2"></i>Cập nhật Nội dung
                </button>
            </div>
        </div>
    </div>
</div>
