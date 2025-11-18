package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.quan_ly_khoa_hoc.service.StudentService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IStudentService;

import java.io.IOException;

@WebServlet(name = "StudentController",value = "/students")
public class StudentController extends HttpServlet {
    private IStudentService studentService = new StudentService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        showHome(req,resp);
    }

    private void showHome(HttpServletRequest req, HttpServletResponse resp){
        req.setAttribute("classInfo",studentService.getStudentClassesInfoById(1));
        try {
            req.getRequestDispatcher("/views/student/home-student.jsp").forward(req,resp);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }



}
