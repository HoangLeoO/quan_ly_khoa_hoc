package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.quan_ly_khoa_hoc.dto.ClassDTO;
import org.example.quan_ly_khoa_hoc.dto.TeacherInfoDTO;
import org.example.quan_ly_khoa_hoc.entity.Class;
import org.example.quan_ly_khoa_hoc.entity.Staff;
import org.example.quan_ly_khoa_hoc.entity.User;
import org.example.quan_ly_khoa_hoc.service.*;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.*;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet(name = "AcedemicAffairController", value = "/acedemic-affairs")
public class AcedemicAffairController extends HttpServlet {

    private IClassService classService = new ClassService();
    private IStudentService studentService = new StudentService();
    private ICourseService courseService = new CourseService();
    private IStaffService staffService = new StaffService();
    private IEnrolmentService enrolmentService = new EnrolmentService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "profile":
                showProfile(req, resp);
                break;
            case "update-profile":
                showUpDateProfile(req, resp);
                break;
            case "detail":
                showClassDetail(req, resp);
                break;
            case "edit":
                loadEditForm(req, resp); // Mới: trả về form HTML cho modal
                break;
            case "delete":
                int id = Integer.parseInt(req.getParameter("id"));
                boolean success = classService.deleteById(id);

                resp.setContentType("application/json;charset=UTF-8");
                resp.getWriter().write("{\"success\":" + success + "}");
                return;
            default:
                showList(req, resp);
        }
    }

    private void showUpDateProfile(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession(false);
        if (session != null) {
            User u = (User) session.getAttribute("currentUser");
            String email = u.getEmail();
            req.setAttribute("teacher", staffService.findStaffByEmail(email));
        }
        try {
            req.getRequestDispatcher("views/acedemic-affairs/home/edit-profile-acedemic-afaris.jsp").forward(req, resp);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void showProfile(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession(false);
        if (session != null) {
            User u = (User) session.getAttribute("currentUser");
            String email = u.getEmail();
            TeacherInfoDTO dto = staffService.findStaffByEmail(email);
            DateTimeFormatter formatterVN = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            String formattedDateVN = dto.getDob().format(formatterVN);
            req.setAttribute("dob", formattedDateVN);
            req.setAttribute("teacher", dto);
        }
        try {
            req.getRequestDispatcher("views/acedemic-affairs/home/profile-acedemic-affairs.jsp").forward(req, resp);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
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
            case "update-profile":
                updateProfile(req, resp);
                break;
            case "delete":
                int classId = Integer.parseInt(req.getParameter("id"));
                success = classService.deleteById(classId);
                resp.setContentType("application/json;charset=UTF-8");
                resp.getWriter().write("{\"success\":" + success + "}");
                return;
            default:
                resp.sendRedirect(req.getContextPath() + "/teacher");
                break;
        }

        // AJAX response: trả về JSON thông báo
        resp.setContentType("application/json");
        resp.getWriter().write("{\"success\":" + success + "}");
    }

    private void updateProfile(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            try {
                resp.sendRedirect(req.getContextPath() + "/login?msg=session_expired");
            } catch (IOException e) {
                e.printStackTrace();
            }
            return;
        }
        User currentUser = (User) session.getAttribute("currentUser");
        String userEmail = currentUser.getEmail();

        try {
            TeacherInfoDTO dto = staffService.findStaffByEmail(userEmail);
            if (dto == null) {
                resp.sendRedirect(req.getContextPath() + "/acedemic-affairs?action=profile&msg=update_error_user_not_found");
                return;
            }
            Staff teacher = new Staff();
            teacher.setStaffId(dto.getStaffId());
            String dobStr = req.getParameter("dob");
            teacher.setFullName(req.getParameter("fullName"));
            teacher.setPhone(req.getParameter("phone"));
            teacher.setAddress(req.getParameter("address"));
            if (dobStr != null && !dobStr.trim().isEmpty()) {
                teacher.setDob(LocalDate.parse(dobStr.trim()));
            } else {
                teacher.setDob(null);
            }
            boolean success = staffService.updateStaffProfile(teacher);
            String mess = success ? "update_success" : "update_failed";
            resp.sendRedirect(req.getContextPath() + "/acedemic-affairs?action=profile&msg=" + mess);

        } catch (Exception e) {
            e.printStackTrace();
            try {
                resp.sendRedirect(req.getContextPath() + "/acedemic-affairs?action=profile&msg=update_error");
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }

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
        req.setAttribute("studentList", studentService.findByClassId(classId));
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

        List<ClassDTO> list;

        if (status == null || status.equals("default")) {
            // Lọc ĐANG HỌC + SẮP MỞ
            list = classService.findAll();
        } else if (status.isEmpty()) {
            // Lọc tất cả
            list = classService.search(keyword, teacherId, courseId, null);
        } else {
            // Lọc 1 trạng thái cụ thể
            list = classService.search(keyword, teacherId, courseId, status);
        }

        req.setAttribute("classList", list);
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

