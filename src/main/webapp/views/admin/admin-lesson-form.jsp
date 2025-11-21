<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="lessonFormModal" tabindex="-1" aria-labelledby="lessonFormModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="lessonFormModalLabel">Thêm Bài học mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="lessonForm" action="/admin/lessons?action=add" method="post" class="needs-validation" novalidate>
                    <input type="hidden" id="lessonId" name="lessonId"/>
                    <input type="hidden" id="moduleId" name="moduleId" value="${module.moduleId}"/>
                    <div class="row">
                        <div class="col-md-8 mb-3">
                            <label for="lessonName" class="form-label">Tên Bài học</label>
                            <input type="text" class="form-control" id="lessonName" name="lessonName" placeholder="Nhập tên bài học" required/>
                            <div class="invalid-feedback">Vui lòng nhập tên bài học.</div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="sortOrder" class="form-label">Thứ tự</label>
                            <input type="number" class="form-control" id="sortOrder" name="sortOrder" value="0" min="0" required/>
                            <div class="invalid-feedback">Vui lòng nhập thứ tự sắp xếp (số không âm).</div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="contentType" class="form-label">Loại nội dung</label>
                        <select class="form-select" id="contentType" name="contentType" required>
                            <option value="">Chọn loại nội dung</option>
                            <option value="text">Bài đọc</option>
                            <option value="video">Video</option>
                            <option value="quiz">Quiz</option>
                        </select>
                        <div class="invalid-feedback">Vui lòng chọn loại nội dung.</div>
                    </div>
                    <div id="contentDataField" class="mb-3">
                        <!-- Dynamic content input will be loaded here -->
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" id="cancel-reset-btn" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="submit" form="lessonForm" class="btn btn-primary">
                    <i class="bi bi-plus-circle me-2"></i>Thêm Bài học
                </button>
            </div>
        </div>
    </div>
</div>
