package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.quan_ly_khoa_hoc.dto.TeacherInfoDTO;
import org.example.quan_ly_khoa_hoc.entity.User;
import org.example.quan_ly_khoa_hoc.service.ClassService;
import org.example.quan_ly_khoa_hoc.service.TeacherService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IClassService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ITeacherService;

import java.io.IOException;

// KHÔNG CẦN CÁC IMPORT LIÊN QUAN ĐẾN StudentDetailDTO VÀ List NỮA

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
            default:
                showList(req, resp);
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
        System.out.println(teacherInfoDTO.getStaffId());
        if(teacherInfoDTO!=null){
            req.setAttribute("classList", classService.findClassesByTeacherStaffId(teacherInfoDTO.getStaffId()));
            req.setAttribute("nameTeacher",teacherInfoDTO.getFullName());
        }
        try {
            req.getRequestDispatcher("/views/teacher/home-teacher.jsp").forward(req,resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}