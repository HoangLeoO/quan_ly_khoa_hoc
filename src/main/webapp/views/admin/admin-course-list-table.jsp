<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="mb-5">
    <h4 class="mb-4">Danh sách khóa học</h4>
    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
        <c:forEach var="course" items="${courseList}" varStatus="index">
            <div class="col">
                <div class="card h-100 shadow-sm">
                    <div class="card-body d-flex flex-column">
                        <h4 class="card-title mb-3">${course.getCourseName()}</h4>
                        <p class="card-text text-muted flex-grow-1">${course.getDescription()}</p>
                        <div class="mt-auto">
                            <hr class="my-3">
                            <p class="card-text"><small class="text-muted">Số lượng module: ${course.getCountModule()} </small></p>
                            <div class="d-flex justify-content-between align-items-center">
                                <a href="/admin/courses?action=view&id=${course.getCourseId()}" class="btn btn-sm btn-primary">
                                    <i class="bi bi-eye me-1"></i> Xem chi tiết
                                </a>
                                <a href="/admin/courses?action=update&id=${course.courseId}" class="btn btn-sm btn-outline-secondary">
                                    <i class="bi bi-pencil me-1"></i> Sửa
                                </a>
                                <button type="button" class="btn btn-sm btn-outline-danger"
                                        data-bs-toggle="modal" data-bs-target="#confirmDeleteModal"
                                        data-delete-url="/admin/courses?action=delete&id=${course.courseId}"
                                        data-course-name="${course.getCourseName()}">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
