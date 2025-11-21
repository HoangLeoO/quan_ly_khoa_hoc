package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.quan_ly_khoa_hoc.dto.CourseDTO;
import org.example.quan_ly_khoa_hoc.dto.ModuleDTO;
import org.example.quan_ly_khoa_hoc.service.CourseService;
import org.example.quan_ly_khoa_hoc.service.ModuleService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ICourseService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IModuleService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CourseController", value = "/admin/courses")
public class CourseController extends HttpServlet {

    private final ICourseService courseService = new CourseService();
    private final IModuleService moduleService = new ModuleService();
    private static final int PAGE_SIZE = 6; // Number of courses per page

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "delete":
                deleteCourse(req, resp);
                break;
            case "update":
                showUpdateForm(req, resp);
                break;
            case "search":
                search(req, resp);
                break;
            case "view":
                viewCourseDetails(req, resp);
                break;
            case "showModuleUpdateForm":
                showModuleUpdateForm(req, resp);
                break;
            default:
                getAllCourse(req, resp);
                break;
        }
    }

    private void viewCourseDetails(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int courseId = Integer.parseInt(req.getParameter("id"));
        CourseDTO course = courseService.findById(courseId);
        List<ModuleDTO> moduleList = moduleService.findModulesByCourseId(courseId);

        req.setAttribute("course", course);
        req.setAttribute("moduleList", moduleList);
        req.getRequestDispatcher("/views/admin/admin-course-detail.jsp").forward(req, resp);
    }

    private void showModuleUpdateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int courseId = Integer.parseInt(req.getParameter("id"));
        int moduleId = Integer.parseInt(req.getParameter("moduleId"));

        CourseDTO course = courseService.findById(courseId);
        List<ModuleDTO> moduleList = moduleService.findModulesByCourseId(courseId);
        ModuleDTO moduleToEdit = moduleService.findById(moduleId);

        req.setAttribute("course", course);
        req.setAttribute("moduleList", moduleList);
        req.setAttribute("moduleToEdit", moduleToEdit);
        req.setAttribute("mode", "update"); // Set mode to trigger modal

        req.getRequestDispatcher("/views/admin/admin-course-detail.jsp").forward(req, resp);
    }


    private void showUpdateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        CourseDTO course = courseService.findById(id);
        req.setAttribute("courseToEdit", course);
        req.setAttribute("mode", "update");
        getAllCourse(req, resp);
    }

    public void getAllCourse(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        if (req.getParameter("page") != null) {
            page = Integer.parseInt(req.getParameter("page"));
        }

        List<CourseDTO> courseList = courseService.findPaginated(page, PAGE_SIZE);
        int totalCourses = courseService.getTotalCourseCount();
        int totalPages = (int) Math.ceil((double) totalCourses / PAGE_SIZE);

        req.setAttribute("courseList", courseList);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("paginationUrl", "/admin/courses?");

        req.getRequestDispatcher("/views/admin/admin-course.jsp").forward(req, resp);
    }

    public void addCourse(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String courseName = req.getParameter("courseName");
        String description = req.getParameter("description");

        if (courseName == null || courseName.trim().isEmpty() || description == null || description.trim().isEmpty()) {
            resp.sendRedirect("/admin/courses?message=add_failed");
            return;
        }

        if (courseService.findByName(courseName) != null) {
            resp.sendRedirect("/admin/courses?message=duplicate_course");
            return;
        }

        CourseDTO courseDTO = new CourseDTO();
        courseDTO.setCourseName(courseName);
        courseDTO.setDescription(description);
        courseService.addCourse(courseDTO);
        resp.sendRedirect("/admin/courses?message=add_success");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "update":
                updateCourse(req, resp);
                break;
            case "add":
                addCourse(req, resp);
                break;
            default:
                resp.sendRedirect("/admin/courses");
                break;
        }
    }

    private void updateCourse(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("courseId"));
        String courseName = req.getParameter("courseName");
        String description = req.getParameter("description");

        if (courseName == null || courseName.trim().isEmpty() || description == null || description.trim().isEmpty()) {
            resp.sendRedirect("/admin/courses?action=update&id=" + id + "&message=update_failed");
            return;
        }

        CourseDTO existingCourse = courseService.findByName(courseName);
        if (existingCourse != null && !existingCourse.getCourseId().equals(id)) {
            resp.sendRedirect("/admin/courses?action=update&id=" + id + "&message=duplicate_course");
            return;
        }

        CourseDTO courseDTO = new CourseDTO(id, courseName, description);
        courseService.update(courseDTO);
        resp.sendRedirect("/admin/courses?message=update_success");
    }

    private void deleteCourse(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        courseService.deleteCourse(Integer.parseInt(req.getParameter("id")));
        resp.sendRedirect("/admin/courses?message=delete_success");
    }

    private void search(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        if (keyword == null) keyword = "";
        keyword = keyword.trim();

        List<CourseDTO> courseDTOList = courseService.search(keyword);

        req.setAttribute("courseList", courseDTOList);
        req.setAttribute("keyword", keyword);
        req.setAttribute("totalPages", 1);
        req.setAttribute("currentPage", 1);

        req.getRequestDispatcher("/views/admin/admin-course.jsp").forward(req, resp);
    }
}
