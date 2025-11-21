package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.quan_ly_khoa_hoc.dto.LessonContentDTO;
import org.example.quan_ly_khoa_hoc.dto.LessonDTO;
import org.example.quan_ly_khoa_hoc.dto.ModuleDTO;
import org.example.quan_ly_khoa_hoc.service.LessonContentService;
import org.example.quan_ly_khoa_hoc.service.LessonService;
import org.example.quan_ly_khoa_hoc.service.ModuleService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ILessonContentService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.ILessonService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IModuleService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "LessonController", value = "/admin/lessons")
public class LessonController extends HttpServlet {
    private final ILessonService lessonService = new LessonService();
    private final IModuleService moduleService = new ModuleService();
    private final ILessonContentService lessonContentService = new LessonContentService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "listByModule":
                listLessonsByModule(req, resp);
                break;
            case "viewContent":
                viewLessonContent(req, resp);
                break;
            case "viewSingleContent":
                viewSingleContent(req, resp);
                break;
            case "showUpdateForm":
                showUpdateForm(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/admin/courses");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "add":
                addLesson(req, resp);
                break;
            case "update":
                updateLesson(req, resp);
                break;
            case "delete":
                deleteLesson(req, resp);
                break;
            case "addContent":
                addLessonContent(req, resp);
                break;
            case "updateContent":
                updateLessonContent(req, resp);
                break;
            case "deleteContent":
                deleteLessonContent(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/admin/courses");
                break;
        }
    }

    private void listLessonsByModule(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int moduleId = Integer.parseInt(req.getParameter("moduleId"));
        ModuleDTO module = moduleService.findById(moduleId);
        List<LessonDTO> lessonList = lessonService.findLessonsByModuleId(moduleId);

        req.setAttribute("module", module);
        req.setAttribute("lessonList", lessonList);
        req.getRequestDispatcher("/views/admin/admin-lesson-list.jsp").forward(req, resp);
    }

    private void viewLessonContent(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int lessonId = Integer.parseInt(req.getParameter("lessonId"));
        int moduleId = Integer.parseInt(req.getParameter("moduleId"));

        LessonDTO lesson = lessonService.findById(lessonId);
        List<LessonContentDTO> lessonContents = lessonContentService.findByLessonId(lessonId);

        req.setAttribute("lesson", lesson);
        req.setAttribute("lessonContents", lessonContents);
        req.setAttribute("moduleId", moduleId);

        req.getRequestDispatcher("/views/admin/admin-lesson-detail.jsp").forward(req, resp);
    }

    private void viewSingleContent(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int contentId = Integer.parseInt(req.getParameter("contentId"));
        int lessonId = Integer.parseInt(req.getParameter("lessonId"));
        int moduleId = Integer.parseInt(req.getParameter("moduleId"));

        LessonDTO lesson = lessonService.findById(lessonId);
        LessonContentDTO singleContent = lessonContentService.findById(contentId);

        req.setAttribute("lesson", lesson);
        req.setAttribute("singleContent", singleContent);
        req.setAttribute("moduleId", moduleId);
        req.setAttribute("lessonId", lessonId);

        req.getRequestDispatcher("/views/admin/admin-single-lesson-content-detail.jsp").forward(req, resp);
    }

    private void showUpdateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int lessonId = Integer.parseInt(req.getParameter("lessonId"));
        int moduleId = Integer.parseInt(req.getParameter("moduleId"));

        LessonDTO lessonToEdit = lessonService.findById(lessonId);
        List<LessonContentDTO> lessonContentsToEdit = lessonContentService.findByLessonId(lessonId);
        LessonContentDTO lessonContentToEdit = null;
        if (lessonContentsToEdit != null && !lessonContentsToEdit.isEmpty()) {
            lessonContentToEdit = lessonContentsToEdit.get(0);
        }
        
        ModuleDTO module = moduleService.findById(moduleId);

        List<LessonDTO> lessonList = lessonService.findLessonsByModuleId(moduleId);

        req.setAttribute("module", module);
        req.setAttribute("lessonList", lessonList);
        req.setAttribute("lessonToEdit", lessonToEdit);
        req.setAttribute("lessonContentToEdit", lessonContentToEdit);
        req.setAttribute("mode", "update");

        req.getRequestDispatcher("/views/admin/admin-lesson-list.jsp").forward(req, resp);
    }

    private void addLesson(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String lessonName = req.getParameter("lessonName");
        String sortOrderStr = req.getParameter("sortOrder");
        int moduleId = Integer.parseInt(req.getParameter("moduleId"));
        int sortOrder;

        String redirectUrl = req.getContextPath() + "/admin/lessons?action=listByModule&moduleId=" + moduleId;

        if (lessonName == null || lessonName.trim().isEmpty() || sortOrderStr == null || sortOrderStr.trim().isEmpty()) {
            resp.sendRedirect(redirectUrl + "&message=add_lesson_failed");
            return;
        }

        try {
            sortOrder = Integer.parseInt(sortOrderStr);
            if (sortOrder < 0) {
                resp.sendRedirect(redirectUrl + "&message=negative_sort_order");
                return;
            }
        } catch (NumberFormatException e) {
            resp.sendRedirect(redirectUrl + "&message=invalid_sort_order");
            return;
        }

        if (lessonService.findByNameAndModuleId(lessonName, moduleId) != null) {
            resp.sendRedirect(redirectUrl + "&message=duplicate_lesson");
            return;
        }

        LessonDTO lessonDTO = new LessonDTO();
        lessonDTO.setLessonName(lessonName);
        lessonDTO.setModuleId(moduleId);
        lessonDTO.setSortOrder(sortOrder);

        lessonService.save(lessonDTO);

        resp.sendRedirect(redirectUrl + "&message=add_lesson_success");
    }

    private void updateLesson(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int lessonId = Integer.parseInt(req.getParameter("lessonId"));
        String lessonName = req.getParameter("lessonName");
        String sortOrderStr = req.getParameter("sortOrder");
        int moduleId = Integer.parseInt(req.getParameter("moduleId"));
        int sortOrder;

        String redirectUrl = req.getContextPath() + "/admin/lessons?action=showUpdateForm&moduleId=" + moduleId + "&lessonId=" + lessonId;

        if (lessonName == null || lessonName.trim().isEmpty() || sortOrderStr == null || sortOrderStr.trim().isEmpty()) {
            resp.sendRedirect(redirectUrl + "&message=update_lesson_failed");
            return;
        }

        try {
            sortOrder = Integer.parseInt(sortOrderStr);
            if (sortOrder < 0) {
                resp.sendRedirect(redirectUrl + "&message=negative_sort_order");
                return;
            }
        } catch (NumberFormatException e) {
            resp.sendRedirect(redirectUrl + "&message=invalid_sort_order");
            return;
        }

        LessonDTO existingLesson = lessonService.findByNameAndModuleId(lessonName, moduleId);
        if (existingLesson != null && !existingLesson.getLessonId().equals(lessonId)) {
            resp.sendRedirect(redirectUrl + "&message=duplicate_lesson");
            return;
        }

        LessonDTO lessonDTO = new LessonDTO();
        lessonDTO.setLessonId(lessonId);
        lessonDTO.setLessonName(lessonName);
        lessonDTO.setModuleId(moduleId);
        lessonDTO.setSortOrder(sortOrder);

        lessonService.update(lessonDTO);

        resp.sendRedirect(req.getContextPath() + "/admin/lessons?action=listByModule&moduleId=" + moduleId + "&message=update_lesson_success");
    }

    private void addLessonContent(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int lessonId = Integer.parseInt(req.getParameter("lessonId"));
        int moduleId = Integer.parseInt(req.getParameter("moduleId"));
        String contentType = req.getParameter("contentType");
        String contentName = req.getParameter("contentName"); // Get contentName
        String contentData = req.getParameter("contentData");

        String redirectUrl = req.getContextPath() + "/admin/lessons?action=viewContent&lessonId=" + lessonId + "&moduleId=" + moduleId;

        if (contentType == null || contentType.trim().isEmpty() || contentName == null || contentName.trim().isEmpty() || contentData == null || contentData.trim().isEmpty()) {
            resp.sendRedirect(redirectUrl + "&message=add_content_failed");
            return;
        }

        LessonContentDTO lessonContentDTO = new LessonContentDTO();
        lessonContentDTO.setLessonId(lessonId);
        lessonContentDTO.setContentType(contentType);
        lessonContentDTO.setContentName(contentName); // Set contentName
        lessonContentDTO.setContentData(contentData);

        lessonContentService.save(lessonContentDTO);

        resp.sendRedirect(redirectUrl + "&message=add_content_success");
    }

    private void updateLessonContent(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int contentId = Integer.parseInt(req.getParameter("contentId"));
        int lessonId = Integer.parseInt(req.getParameter("lessonId"));
        int moduleId = Integer.parseInt(req.getParameter("moduleId"));
        String contentType = req.getParameter("contentType");
        String contentName = req.getParameter("contentName"); // Get contentName
        String contentData = req.getParameter("contentData");

        String redirectUrl = req.getContextPath() + "/admin/lessons?action=viewContent&lessonId=" + lessonId + "&moduleId=" + moduleId;

        if (contentType == null || contentType.trim().isEmpty() || contentName == null || contentName.trim().isEmpty() || contentData == null || contentData.trim().isEmpty()) {
            resp.sendRedirect(redirectUrl + "&message=update_content_failed");
            return;
        }

        LessonContentDTO lessonContentDTO = new LessonContentDTO();
        lessonContentDTO.setContentId(contentId);
        lessonContentDTO.setLessonId(lessonId);
        lessonContentDTO.setContentType(contentType);
        lessonContentDTO.setContentName(contentName); // Set contentName
        lessonContentDTO.setContentData(contentData);

        lessonContentService.update(lessonContentDTO);

        resp.sendRedirect(redirectUrl + "&message=update_content_success");
    }

    private void deleteLessonContent(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int contentId = Integer.parseInt(req.getParameter("contentId"));
        int lessonId = Integer.parseInt(req.getParameter("lessonId"));
        int moduleId = Integer.parseInt(req.getParameter("moduleId"));

        lessonContentService.delete(contentId);

        resp.sendRedirect(req.getContextPath() + "/admin/lessons?action=viewContent&lessonId=" + lessonId + "&moduleId=" + moduleId + "&message=delete_content_success");
    }

    private void deleteLesson(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int lessonId = Integer.parseInt(req.getParameter("lessonId"));
        int moduleId = Integer.parseInt(req.getParameter("moduleId"));

        lessonService.delete(lessonId);
        resp.sendRedirect(req.getContextPath() + "/admin/lessons?action=listByModule&moduleId=" + moduleId + "&message=delete_lesson_success");
    }
}
