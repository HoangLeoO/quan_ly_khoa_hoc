package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.quan_ly_khoa_hoc.dto.*;
import org.example.quan_ly_khoa_hoc.entity.Lesson;
import org.example.quan_ly_khoa_hoc.entity.Module;
import org.example.quan_ly_khoa_hoc.entity.Student;
import org.example.quan_ly_khoa_hoc.entity.User;
import org.example.quan_ly_khoa_hoc.service.*;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.*;
import org.example.quan_ly_khoa_hoc.util.PasswordUtil;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "StudentController", value = "/students")
public class StudentController extends HttpServlet {


    private IStudentService studentService = new StudentService();
    private ICourseService courseService = new CourseService();
    private IModuleService moduleService = new ModuleService();
    private ILessonService lessonService = new LessonService();
    private ILessonProgressService lessonProgressService = new LessonProgressService();
    private IClassService classService = new ClassService();
    private ILessonContentService lessonContentService = new LessonContentService();
    private IGradeService gradeService = new GradeService();

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

            case "detail-module":
                showDetailModule(req, resp);
                break;
            case "lesson-content":
                req.getRequestDispatcher("/views/student/detail-lesson-contents.jsp").forward(req, resp);
                break;
            case "update-profile":
                showUpdate(req, resp);
                break;
            case "change-password":
                showChangePasswordForm(req, resp);
                break;
            case "grade-view":
                showViewGrade(req, resp);
                break;
            default:
                showHome(req, resp); // fallback
                break;
        }
    }

    private void showUpdate(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession(false);
        if (session != null) {
            User u = (User) session.getAttribute("currentUser");
            String email = u.getEmail();
            req.setAttribute("student", studentService.getStudentProfileByEmail(email));
        }
        try {
            req.getRequestDispatcher("/views/student/edit-profile-student.jsp").forward(req, resp);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String action = req.getParameter("action");
        if (action == null) action = "home";  // mặc định vào trang home
        switch (action) {
            case "update-lesson-status":
                int id = Integer.parseInt(req.getParameter("lessonId"));

                boolean status = req.getParameter("status") != null;
                HttpSession session = req.getSession(false);
                if (session != null) {
                    User u = (User) session.getAttribute("currentUser");
                    String email = u.getEmail();
                    lessonProgressService.updateIsComplete(status, studentService.getStudentIdByEmail(email), id);
                }
                resp.sendRedirect(req.getHeader("Referer"));
                break;
            case "update-profile":
                saveUpdateProfile(req, resp);
                break;
            case "change-password":
                try {
                    handleChangePassword(req, resp);
                } catch (ServletException e) {
                    throw new RuntimeException(e);
                }
                break;
        }
    }

    private void showDetailModule(HttpServletRequest req, HttpServletResponse resp) {
        String moduleIdStr = req.getParameter("module-id");
        String progressStr = req.getParameter("progress");
        String moduleName = req.getParameter("module-name");
        String courseName = req.getParameter("course-name");

        int moduleId = -1;
        Float progress = 0f;

        if (moduleIdStr != null && !moduleIdStr.isEmpty()) {
            try {
                moduleId = Integer.parseInt(moduleIdStr);
            } catch (NumberFormatException e) {
                System.err.println("Lỗi NumberFormatException cho module-id: " + moduleIdStr);
            }
        }
        if (progressStr != null && !progressStr.isEmpty()) {
            try {
                progress = Float.parseFloat(progressStr);
            } catch (NumberFormatException e) {
                System.err.println("Lỗi NumberFormatException cho progress: " + progressStr);
            }
        }
        if (moduleId == -1) {
            try {
                resp.sendRedirect(req.getContextPath() + "/students?action=home");
                return;
            } catch (IOException e) {
                throw new RuntimeException("Lỗi chuyển hướng về trang chủ", e);
            }
        }


        HttpSession session = req.getSession(false);
        if (session != null) {
            User u = (User) session.getAttribute("currentUser");
            if (u != null) {
                String email = u.getEmail();

                // Chỉ gọi service khi moduleId hợp lệ
                List<LessonDTO> Lesson = lessonService.getAllByModuleIdAndStudentId(
                        moduleId,
                        studentService.getStudentIdByEmail(email)
                );
                req.setAttribute("lessons", Lesson);
            }

            req.setAttribute("moduleName", moduleName);
            req.setAttribute("courseName", courseName);
            req.setAttribute("overallLessonProgress", progress); // Sử dụng giá trị đã kiểm tra

        }

        // Chuyển tiếp tới JSP
        try {
            req.getRequestDispatcher("/views/student/detail-module-student.jsp").forward(req, resp);
        } catch (ServletException | IOException e) {
            throw new RuntimeException("Lỗi chuyển tiếp trang JSP", e);
        }
    }

    private void showDetailClass(HttpServletRequest req, HttpServletResponse resp) {
        int course_id = Integer.parseInt(req.getParameter("course-id"));
        HttpSession session = req.getSession(false);
        ClassDTO classDTO = classService.findByClassID(Integer.parseInt(req.getParameter("class-id")));
        if (session != null) {
            User u = (User) session.getAttribute("currentUser");
            String email = u.getEmail();
            List<ModuleDTO> module = moduleService.findModulesDTOByStudentId(studentService.getStudentIdByEmail(email), course_id);
            req.setAttribute("moduleList", module);
            req.setAttribute("courseName", classDTO.getCourseName());
            req.setAttribute("className", classDTO.getClassName());
            req.setAttribute("instructorName", classDTO.getTeacherName());
        }
        try {
            req.getRequestDispatcher("/views/student/detail-class-student.jsp").forward(req, resp);
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
            StudentProfileDTO student = studentService.getStudentProfileByEmail(email);
            DateTimeFormatter formatterVN = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            String formattedDateVN = student.getDob().format(formatterVN);
            req.setAttribute("student", studentService.getStudentProfileByEmail(email));
            req.setAttribute("formattedDateVN", formattedDateVN);
        }
        try {
            req.getRequestDispatcher("/views/student/profile-student.jsp").forward(req, resp);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void showHome(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession(false);
        if (session != null) {
            User u = (User) session.getAttribute("currentUser");
            String email = u.getEmail();
            List<ClassInfoDTO> classInfoDTOS = studentService.getStudentClassesInfoById(studentService.getStudentIdByEmail(email));
            StudentProfileDTO studentProfileDTO = studentService.getStudentProfileByEmail(email);
            System.out.println(classInfoDTOS.size());
            req.setAttribute("studentName", studentProfileDTO.getFullName());
            req.setAttribute("classInfo", classInfoDTOS);

        }
        try {
            req.getRequestDispatcher("/views/student/home-student.jsp").forward(req, resp);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void showChangePasswordForm(HttpServletRequest req, HttpServletResponse resp) {
        try {
            req.getRequestDispatcher("/views/student/update-password-student.jsp").forward(req, resp);
        } catch (ServletException e) {
            throw new RuntimeException("Lỗi Servlet khi hiển thị trang đổi mật khẩu", e);
        } catch (IOException e) {
            throw new RuntimeException("Lỗi IO khi hiển thị trang đổi mật khẩu", e);
        }
    }

    private void saveUpdateProfile(HttpServletRequest req, HttpServletResponse resp) {
        Student student = new Student();
        student.setStudentId(studentService.getStudentIdByEmail(req.getParameter("email")));
        student.setFullName(req.getParameter("fullName"));
        student.setDob(LocalDate.parse(req.getParameter("dob")));
        student.setAddress(req.getParameter("address"));
        student.setPhone(req.getParameter("phone"));
        studentService.updateProfileStudent(student);
        try {
            resp.sendRedirect("students?action=profile");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void handleChangePassword(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            resp.sendRedirect("login");
            return;
        }
        User currentUser = (User) session.getAttribute("currentUser");
        String userEmail = currentUser.getEmail();

        String currentPassword = req.getParameter("currentPassword");
        String newPassword = req.getParameter("newPassword");
        String confirmNewPassword = req.getParameter("confirmNewPassword");

        boolean hasError = false;

        String currentHashedPassword = studentService.getHashedPasswordByEmail(userEmail);


        if (!PasswordUtil.checkPassword(currentPassword, currentHashedPassword)) {
            req.setAttribute("errorCurrentPassword", "Mật khẩu hiện tại không đúng.");
            hasError = true;
        }

        if (newPassword == null || newPassword.isEmpty() || !newPassword.equals(confirmNewPassword)) {
            req.setAttribute("errorConfirmPassword", "Mật khẩu mới và xác nhận mật khẩu không khớp.");
            hasError = true;
        }

        if (newPassword != null && newPassword.length() < 6) {
            req.setAttribute("errorNewPassword", "Mật khẩu phải có ít nhất 6 ký tự.");
            hasError = true;
        }

        if (currentPassword.equals(newPassword)) {
            req.setAttribute("errorNewPassword", "Mật khẩu mới không được trùng với mật khẩu hiện tại.");
            hasError = true;
        }


        if (hasError) {
            req.getRequestDispatcher("/views/student/update-password-student.jsp").forward(req, resp);
            return;
        }

        try {
            String newHashedPassword = PasswordUtil.hashPassword(newPassword);

            studentService.updatePassword(userEmail, newHashedPassword);

            req.getSession().setAttribute("message", "Đổi mật khẩu thành công!");
            resp.sendRedirect("students?action=change-password");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("message", "Đã xảy ra lỗi trong quá trình đổi mật khẩu.");
            req.getRequestDispatcher("/views/student/update-password-student.jsp").forward(req, resp);
        }
    }

    private void showViewGrade(HttpServletRequest req, HttpServletResponse resp){
        HttpSession session = req.getSession(false);
        if (session != null) {
            User u = (User) session.getAttribute("currentUser");
            String email = u.getEmail();
            int studentId = studentService.getStudentIdByEmail(email);
            List<GradeDetailDTO> gradeDetailDTOS = gradeService.findStudentGradesByCourseAndStudentId(studentId,Integer.parseInt(req.getParameter("course-id")));
            req.setAttribute("gradeDetails",gradeDetailDTOS);
        }
        try {
            req.getRequestDispatcher("views/grade/grade-view-student.jsp").forward(req, resp);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

}

