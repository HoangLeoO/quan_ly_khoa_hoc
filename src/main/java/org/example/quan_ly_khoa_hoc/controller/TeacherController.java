package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.quan_ly_khoa_hoc.dto.TeacherClassDTO;
import org.example.quan_ly_khoa_hoc.dto.TeacherInfoDTO;
import org.example.quan_ly_khoa_hoc.entity.Staff;
import org.example.quan_ly_khoa_hoc.entity.Student;
import org.example.quan_ly_khoa_hoc.entity.User;
import org.example.quan_ly_khoa_hoc.service.ClassService;
import org.example.quan_ly_khoa_hoc.service.TeacherService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IClassService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ITeacherService;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

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
            case "profile":
                showProfile(req, resp);
                break;
            case "update-profile":
                showUpDateProfile(req,resp);
                break;
            default:
                showList(req, resp);
        }
    }

    private void showUpDateProfile(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession(false);
        if (session != null) {
            User u = (User) session.getAttribute("currentUser");
            String email = u.getEmail();
            req.setAttribute("teacher", teacherService.findStaffByEmail(email));
        }
        try {
            req.getRequestDispatcher("/views/teacher/edit-profile-teacher.jsp").forward(req, resp);
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
            TeacherInfoDTO dto = teacherService.findStaffByEmail(email);
            DateTimeFormatter formatterVN = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            String formattedDateVN = dto.getDob().format(formatterVN);
            req.setAttribute("dob",formattedDateVN);
            req.setAttribute("teacher",dto);
        }
        try {
            req.getRequestDispatcher("/views/teacher/profile-teacher.jsp").forward(req, resp);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }


    private void showList(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");

        String userEmail = null;
        if (user != null) {
            userEmail = user.getEmail();
        }
        TeacherInfoDTO teacherInfoDTO = teacherService.findStaffByEmail(userEmail);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        if(teacherInfoDTO != null){
            List<TeacherClassDTO> classList = classService.findClassesByTeacherStaffId(teacherInfoDTO.getStaffId());
            for (TeacherClassDTO classDto : classList) {
                if (classDto.getStartDate() != null) {
                    classDto.setStartDayFormatted(classDto.getStartDate().format(formatter));
                } else {
                    classDto.setStartDayFormatted("N/A");
                }
                if (classDto.getEndDate() != null) {
                    classDto.setEndDayFormatted(classDto.getEndDate().format(formatter));
                } else {
                    classDto.setEndDayFormatted("N/A");
                }
            }
            req.setAttribute("classList", classList);
            req.setAttribute("nameTeacher", teacherInfoDTO.getFullName());
        }
        try {
            req.getRequestDispatcher("/views/teacher/home-teacher.jsp").forward(req,resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Luôn thiết lập encoding cho yêu cầu POST để xử lý ký tự tiếng Việt
        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");

        // Nếu action bị thiếu, đặt mặc định là một giá trị không hợp lệ
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "update-profile":
                updateProfile(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/teacher");
                break;
        }
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
            TeacherInfoDTO dto = teacherService.findStaffByEmail(userEmail);
            if (dto == null) {
                resp.sendRedirect(req.getContextPath() + "/teacher?action=profile&msg=update_error_user_not_found");
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
            boolean success = teacherService.updateStaffProfile(teacher);
            String mess = success ? "update_success" : "update_failed";
            resp.sendRedirect(req.getContextPath() + "/teacher?action=profile&msg=" + mess);

        } catch (Exception e) {
            e.printStackTrace();
            try {
                resp.sendRedirect(req.getContextPath() + "/teacher?action=profile&msg=update_error");
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }
}