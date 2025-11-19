package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.quan_ly_khoa_hoc.entity.Module;
import org.example.quan_ly_khoa_hoc.entity.User;
import org.example.quan_ly_khoa_hoc.service.CourseService;
import org.example.quan_ly_khoa_hoc.service.StudentService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ICourseService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IStudentService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "StudentController",value = "/students")
public class StudentController extends HttpServlet {


    private IStudentService studentService = new StudentService();
    private ICourseService courseService = new CourseService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "home";  // mặc định vào trang home

        switch (action) {
            case "home":
                showHome(req, resp);
                break;

            case "profile":
                showProfile(req, resp);
                break;

            case "detail-class":
                showDetailClass(req, resp);
                break;



            default:
                showHome(req, resp); // fallback
                break;
        }
    }

    private void showDetailClass(HttpServletRequest req, HttpServletResponse resp) {
        int courseId = Integer.parseInt(req.getParameter("course-id"));
        List<Module> module = courseService.findModulesByCourseId(courseId);
        req.setAttribute("moduleList",module);
        try {
            req.getRequestDispatcher("/views/student/detail-class-student.jsp").forward(req,resp);
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
            System.out.println("Email hiện tại: " + email);
            req.setAttribute("student",studentService.getStudentProfileByEmail(email));
        }
        try {
            req.getRequestDispatcher("/views/student/profile-student.jsp").forward(req,resp);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void showHome(HttpServletRequest req, HttpServletResponse resp){
        HttpSession session = req.getSession(false);
        if (session != null) {
            User u = (User) session.getAttribute("currentUser");
            String email = u.getEmail();
            System.out.println("Email hiện tại: " + email);
            req.setAttribute("classInfo",studentService.getStudentClassesInfoById(studentService.getStudentIdByEmail(email)));
        }
        try {
            req.getRequestDispatcher("/views/student/home-student.jsp").forward(req,resp);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

}
