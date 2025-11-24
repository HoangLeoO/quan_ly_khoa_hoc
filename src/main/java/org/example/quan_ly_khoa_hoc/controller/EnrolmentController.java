package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.quan_ly_khoa_hoc.entity.Enrolment;
import org.example.quan_ly_khoa_hoc.service.EnrolmentService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IEnrolmentService;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

@WebServlet(name = "EnrolmentController", value = "/enrolment")
public class EnrolmentController extends HttpServlet {
    private IEnrolmentService enrolmentService = new EnrolmentService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if(action == null) action = "";

        boolean success = false;

        switch (action) {
            case "addStudent":
                success = addEnrolment(req);
                // Redirect về chi tiết lớp kèm message
                resp.sendRedirect(req.getContextPath() + "/acedemic-affairs?action=detail&id="
                        + req.getParameter("classId") + "&msg=" + (success ? "add_success" : "add_failed"));
                return;
            case "deleteStudent":
                success = deleteEnrolment(req);
                resp.sendRedirect(req.getContextPath() + "/acedemic-affairs?action=detail&id="
                        + req.getParameter("classId") + "&msg=" + (success ? "delete_success" : "delete_failed"));
                return;
        }

        // Redirect về trang chi tiết lớp để cập nhật danh sách
        int classId = Integer.parseInt(req.getParameter("classId"));
        resp.sendRedirect(req.getContextPath() + "/acedemic-affairs?action=detail&id=" + classId);
    }

    private boolean addEnrolment(HttpServletRequest req) {
        try {
            int classId = Integer.parseInt(req.getParameter("classId"));
            int studentId = Integer.parseInt(req.getParameter("studentId"));


            Enrolment enrol = new Enrolment();
            enrol.setClassId(classId);
            enrol.setStudentId(studentId);

            return enrolmentService.add(enrol);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean deleteEnrolment(HttpServletRequest req) {
        try {
            int classId = Integer.parseInt(req.getParameter("classId"));
            int studentId = Integer.parseInt(req.getParameter("studentId"));
            return enrolmentService.delete(classId, studentId);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
