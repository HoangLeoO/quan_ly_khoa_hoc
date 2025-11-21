<%--
  Created by IntelliJ IDEA.
  User: nguyenkimquockhanh
  Date: 20/11/25
  Time: 15:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="modal fade" id="courseFormModal" tabindex="-1" aria-labelledby="courseFormModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="courseFormModalLabel">Tạo khóa học mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="courseForm" action="/admin/courses?action=add" method="post" class="needs-validation"
                      novalidate>
                    <input type="hidden" id="courseId" name="courseId"/>
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label for="courseName" class="form-label">Tên khóa học</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-book"></i></span>
                                <input type="text" class="form-control" id="courseName" name="courseName"
                                       placeholder="Nhập tên khóa học (ví dụ: Fullstack Java)" required/>
                                <div class="invalid-feedback">Vui lòng nhập tên khóa học.</div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label for="description" class="form-label">Mô tả</label>
                            <div class="input-group">
                                <span class="input-group-text align-items-start"><i
                                        class="bi bi-text-paragraph"></i></span>
                                <textarea class="form-control" id="description" rows="5" name="description"
                                          placeholder="Nhập mô tả chi tiết về khóa học" required></textarea>
                                <div class="invalid-feedback">Vui lòng nhập mô tả cho khóa học.</div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" id="cancel-reset-btn" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="submit" form="courseForm" class="btn btn-primary">
                    <i class="bi bi-plus-circle me-2"></i>Tạo khóa học
                </button>
            </div>
        </div>
    </div>
</div>
