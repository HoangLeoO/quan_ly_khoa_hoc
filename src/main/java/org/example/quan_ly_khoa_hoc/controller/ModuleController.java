package org.example.quan_ly_khoa_hoc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.quan_ly_khoa_hoc.dto.ModuleDTO;
import org.example.quan_ly_khoa_hoc.service.ModuleService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IModuleService;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "ModuleController", value = "/admin/modules")
public class ModuleController extends HttpServlet {
    private final IModuleService moduleService = new ModuleService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "add":
                addModule(req, resp);
                break;
            case "update":
                updateModule(req, resp);
                break;
            case "delete":
                deleteModule(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/admin/courses");
                break;
        }
    }

    private void addModule(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String moduleName = req.getParameter("moduleName");
        String sortOrderStr = req.getParameter("sortOrder");
        int courseId = Integer.parseInt(req.getParameter("courseId"));
        int sortOrder;

        if (moduleName == null || moduleName.trim().isEmpty() || sortOrderStr == null || sortOrderStr.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/courses?action=view&id=" + courseId + "&message=add_module_failed");
            return;
        }

        try {
            sortOrder = Integer.parseInt(sortOrderStr);
            if (sortOrder < 0) {
                resp.sendRedirect(req.getContextPath() + "/admin/courses?action=view&id=" + courseId + "&message=negative_sort_order");
                return;
            }
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/courses?action=view&id=" + courseId + "&message=invalid_sort_order");
            return;
        }

        if (moduleService.findByNameAndCourseId(moduleName, courseId) != null) {
            resp.sendRedirect(req.getContextPath() + "/admin/courses?action=view&id=" + courseId + "&message=duplicate_module");
            return;
        }

        ModuleDTO moduleDTO = new ModuleDTO();
        moduleDTO.setModuleName(moduleName);
        moduleDTO.setCourseId(courseId);
        moduleDTO.setSortOrder(sortOrder);
        moduleService.save(moduleDTO);

        resp.sendRedirect(req.getContextPath() + "/admin/courses?action=view&id=" + courseId + "&message=add_module_success");
    }

    private void updateModule(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int moduleId = Integer.parseInt(req.getParameter("moduleId"));
        String moduleName = req.getParameter("moduleName");
        String sortOrderStr = req.getParameter("sortOrder");
        int courseId = Integer.parseInt(req.getParameter("courseId"));
        int sortOrder;

        String redirectUrl = req.getContextPath() + "/admin/courses?action=showModuleUpdateForm&id=" + courseId + "&moduleId=" + moduleId;

        if (moduleName == null || moduleName.trim().isEmpty() || sortOrderStr == null || sortOrderStr.trim().isEmpty()) {
            resp.sendRedirect(redirectUrl + "&message=update_module_failed");
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

        ModuleDTO existingModule = moduleService.findByNameAndCourseId(moduleName, courseId);
        if (existingModule != null && !existingModule.getModuleId().equals(moduleId)) {
            resp.sendRedirect(redirectUrl + "&message=duplicate_module");
            return;
        }

        ModuleDTO moduleDTO = new ModuleDTO();
        moduleDTO.setModuleId(moduleId);
        moduleDTO.setModuleName(moduleName);
        moduleDTO.setSortOrder(sortOrder);
        moduleService.update(moduleDTO);

        resp.sendRedirect(req.getContextPath() + "/admin/courses?action=view&id=" + courseId + "&message=update_module_success");
    }

    private void deleteModule(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int moduleId = Integer.parseInt(req.getParameter("moduleId"));
        int courseId = Integer.parseInt(req.getParameter("courseId"));
        moduleService.delete(moduleId);
        resp.sendRedirect(req.getContextPath() + "/admin/courses?action=view&id=" + courseId + "&message=delete_module_success");
    }
}
