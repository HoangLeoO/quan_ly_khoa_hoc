<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="moduleFormModal" tabindex="-1" aria-labelledby="moduleFormModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="moduleFormModalLabel">Thêm Module mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="moduleForm" method="post" class="needs-validation" novalidate>
                    <input type="hidden" id="moduleId" name="moduleId"/>
                    <input type="hidden" id="courseId" name="courseId" value="${course.courseId}"/>
                    <div class="mb-3">
                        <label for="moduleName" class="form-label d-flex align-items-center">Tên Module<span
                                class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="moduleName" name="moduleName" required/>
                        <div class="invalid-feedback">Vui lòng nhập tên module.</div>
                    </div>
                    <div class="mb-3">
                        <label for="sortOrder" class="form-label d-flex align-items-centerl">Thứ tự<span
                                class="text-danger">*</span></label>
                        <input type="number" class="form-control" id="sortOrder" name="sortOrder" value="0" min="0" required/>
                        <div class="invalid-feedback">Vui lòng nhập thứ tự sắp xếp (số không âm).</div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" id="cancel-reset-btn" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="submit" form="moduleForm" class="btn btn-primary">Lưu</button>
            </div>
        </div>
    </div>
</div>
