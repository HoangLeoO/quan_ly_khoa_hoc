package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.quan_ly_khoa_hoc.service.ClassService;
import org.example.quan_ly_khoa_hoc.service.StudentService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IClassService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IStudentService;

import java.io.IOException;

@WebServlet(name = "AcedemicAffairController", value = "/acedemic-affairs")
public class AcedemicAffairController extends HttpServlet {
    private IClassService classService = new ClassService();
    private IStudentService studentService = new StudentService();

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
        int classId = Integer.parseInt(req.getParameter("id"));

        req.setAttribute("_class", classService.findByClassID(classId));
        req.setAttribute("student", studentService.findByClassId(classId));
        try {
            req.getRequestDispatcher("/views/acedemic-affairs/detail/detail-classes.jsp").forward(req,resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    private void showList(HttpServletRequest req, HttpServletResponse resp) {
        req.setAttribute("classList", classService.findAll());
        try {
            req.getRequestDispatcher("/views/acedemic-affairs/home/home-acedemic-affairs.jsp").forward(req,resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
