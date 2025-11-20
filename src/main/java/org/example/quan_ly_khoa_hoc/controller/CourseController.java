package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.quan_ly_khoa_hoc.dto.CourseDTO;
import org.example.quan_ly_khoa_hoc.service.CourseService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ICourseService;

import java.io.IOException;

@WebServlet(name = "CourseController", value = "/admin/courses")
public class CourseController extends HttpServlet {

    private final ICourseService courseService = new CourseService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        getAllCourse(req, resp);
        req.getRequestDispatcher("/views/admin/admin-course.jsp").forward(req, resp);
    }


    public void getAllCourse(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setAttribute("courseList", courseService.getAllCourse());
    }

    public void addCourse(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CourseDTO courseDTO = new CourseDTO();
        String courseName = req.getParameter("courseName");
        String description = req.getParameter("description");
        courseDTO.setCourseName(courseName);
        courseDTO.setDescription(description);
        courseService.addCourse(courseDTO);
        req.setAttribute("courseId", courseDTO.getCourseId());
        System.out.println(courseDTO.getCourseId());
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

                break;
            case "add":
                addCourse(req, resp);
                break;
            default:
                resp.sendRedirect("/admins");
                break;
        }
    }
}
