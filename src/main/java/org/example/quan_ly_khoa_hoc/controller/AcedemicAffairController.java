package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.quan_ly_khoa_hoc.dto.ClassDTO;
import org.example.quan_ly_khoa_hoc.entity.Class;
import org.example.quan_ly_khoa_hoc.service.ClassService;
import org.example.quan_ly_khoa_hoc.service.CourseService;
import org.example.quan_ly_khoa_hoc.service.StaffService;
import org.example.quan_ly_khoa_hoc.service.StudentService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IClassService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ICourseService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IStaffService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IStudentService;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet(name = "AcedemicAffairController", value = "/acedemic-affairs")
public class AcedemicAffairController extends HttpServlet {

    private IClassService classService = new ClassService();
    private IStudentService studentService = new StudentService();
    private ICourseService courseService = new CourseService();
    private IStaffService staffService = new StaffService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "detail":
                showClassDetail(req, resp);
                break;
            case "edit":
                loadEditForm(req, resp); // Mới: trả về form HTML cho modal
                break;
            case "delete":
                int id = Integer.parseInt(req.getParameter("id"));
                boolean success = classService.deleteById(id);
                resp.setContentType("application/json");
                resp.setContentType("application/json;charset=UTF-8");
                resp.getWriter().write("{\"success\":" + success + "}");
                return;
            default:
                showList(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "";

        boolean success = false;

        switch (action) {
            case "add":
                success = addClass(req);
                break;
            case "update":
                success = updateClass(req);
                break;
            case "delete":
                int classId = Integer.parseInt(req.getParameter("id"));
                success = classService.deleteById(classId);
                resp.setContentType("application/json");
                resp.setContentType("application/json;charset=UTF-8");
                resp.getWriter().write("{\"success\":" + success + "}");
                return;
        }

        // AJAX response: trả về JSON thông báo
        resp.setContentType("application/json");
        resp.getWriter().write("{\"success\":" + success + "}");
    }

    private boolean addClass(HttpServletRequest req) {
        try {
            Class cls = new Class();
            cls.setClassName(req.getParameter("className"));
            cls.setCourseId(Integer.parseInt(req.getParameter("courseId")));
            String teacherIdStr = req.getParameter("teacherId");
            cls.setTeacherId(teacherIdStr == null || teacherIdStr.isEmpty() ? null : Integer.parseInt(teacherIdStr));
            cls.setStartDate(LocalDate.parse(req.getParameter("startDate")));
            cls.setEndDate(LocalDate.parse(req.getParameter("endDate")));
            cls.setStatus(req.getParameter("status"));
            return classService.add(cls);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean updateClass(HttpServletRequest req) {
        try {
            int classId = Integer.parseInt(req.getParameter("classId"));
            Class cls = new Class();
            cls.setClassName(req.getParameter("className"));
            cls.setCourseId(Integer.parseInt(req.getParameter("courseId")));
            String teacherIdStr = req.getParameter("teacherId");
            cls.setTeacherId(teacherIdStr == null || teacherIdStr.isEmpty() ? null : Integer.parseInt(teacherIdStr));
            cls.setStartDate(LocalDate.parse(req.getParameter("startDate")));
            cls.setEndDate(LocalDate.parse(req.getParameter("endDate")));
            cls.setStatus(req.getParameter("status"));
            return classService.updateById(classId, cls);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private void showClassDetail(HttpServletRequest req, HttpServletResponse resp) {
        int classId = Integer.parseInt(req.getParameter("id"));
        req.setAttribute("_class", classService.findByClassID(classId));
        req.setAttribute("student", studentService.findByClassId(classId));
        try {
            req.getRequestDispatcher("/views/acedemic-affairs/detail/detail-classes.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void showList(HttpServletRequest req, HttpServletResponse resp) {
        // Params
        String keyword = req.getParameter("keyword");
        Integer teacherId = (req.getParameter("teacherId") != null && !req.getParameter("teacherId").isEmpty())
                ? Integer.parseInt(req.getParameter("teacherId")) : null;
        Integer courseId = (req.getParameter("courseId") != null && !req.getParameter("courseId").isEmpty())
                ? Integer.parseInt(req.getParameter("courseId")) : null;
        String status = req.getParameter("status");

        // Load dropdown
        req.setAttribute("courseList", courseService.findAll());
        req.setAttribute("teacherList", staffService.findAllTeachers());

        // Lọc danh sách
        req.setAttribute("classList", classService.search(keyword, teacherId, courseId, status));

        try {
            req.getRequestDispatcher("/views/acedemic-affairs/home/home-acedemic-affairs.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void loadEditForm(HttpServletRequest req, HttpServletResponse resp) {
        int classId = Integer.parseInt(req.getParameter("id"));
        ClassDTO cls = classService.findByClassID(classId);
        req.setAttribute("classObj", cls);
        req.setAttribute("courseList", courseService.findAll());
        req.setAttribute("teacherList", staffService.findAllTeachers());
        try {
            req.getRequestDispatcher("/views/acedemic-affairs/home/form-edit-class.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

