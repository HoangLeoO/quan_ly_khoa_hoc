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
            case "add":
                success = addEnrolment(req);
                break;
            case "delete":
                success = deleteEnrolment(req);
                break;
        }

        // Trả về JSON
        resp.setContentType("application/json");
        resp.getWriter().write("{\"success\":" + success + "}");
    }

    private boolean addEnrolment(HttpServletRequest req) {
        try {
            int classId = Integer.parseInt(req.getParameter("classId"));
            int studentId = Integer.parseInt(req.getParameter("studentId"));
            String status = req.getParameter("status");

            Enrolment enrol = new Enrolment();
            enrol.setClassId(classId);
            enrol.setStudentId(studentId);
            enrol.setEnrolDate(Timestamp.valueOf(LocalDateTime.now()));
            enrol.setStatus(status);

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
