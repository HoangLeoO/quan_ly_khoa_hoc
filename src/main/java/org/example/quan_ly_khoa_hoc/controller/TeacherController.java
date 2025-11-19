package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.quan_ly_khoa_hoc.dto.StudentDetailDTO;
import org.example.quan_ly_khoa_hoc.dto.TeacherInfoDTO;
import org.example.quan_ly_khoa_hoc.entity.User;
import org.example.quan_ly_khoa_hoc.service.ClassService;
import org.example.quan_ly_khoa_hoc.service.TeacherService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IClassService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ITeacherService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "TeacherController",value = "/teacher")
public class TeacherController extends HttpServlet {
    private IClassService classService = new ClassService();
    private ITeacherService teacherService = new TeacherService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "detail":
                showClassDetail(req, resp);
                break;
            default:
                showList(req, resp);
        }
    }

    private void showClassDetail(HttpServletRequest req, HttpServletResponse resp) {
        try {
            int classId = Integer.parseInt(req.getParameter("classId"));
            int courseId = Integer.parseInt(req.getParameter("courseId"));
            String className = req.getParameter("className");
            List<StudentDetailDTO> studentList = classService.findStudentsByClassId(classId);
            req.setAttribute("classId", classId);
            req.setAttribute("courseId", courseId);
            req.setAttribute("className", className);
            req.setAttribute("studentList", studentList);
            req.getRequestDispatcher("/views/teacher/class-detail.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void showList(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");

        String userEmail = null;
        if (user != null) {
            userEmail = user.getEmail();
        }
        TeacherInfoDTO teacherInfoDTO =teacherService.findStaffByEmail(userEmail);
        if(teacherInfoDTO!=null){
            req.setAttribute("classList", classService.findClassesByTeacherStaffId(teacherInfoDTO.getStaffId()));
            req.setAttribute("nameTeacher",teacherInfoDTO.getFullName());
        }
        req.setAttribute("classList", classService.findClassesByTeacherStaffId(1));
        try {
            req.getRequestDispatcher("/views/teacher/home-teacher.jsp").forward(req,resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
