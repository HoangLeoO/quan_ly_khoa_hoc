package org.example.quan_ly_khoa_hoc.service.serviceInterface;

import org.example.quan_ly_khoa_hoc.dto.ModuleDTO;

import java.util.List;

public interface IModuleService {
    List<ModuleDTO> findModulesByCourseId(int courseId);
    List<ModuleDTO> findModulesDTOByStudentId(int studentId);
    ModuleDTO findById(int moduleId);
    ModuleDTO findByNameAndCourseId(String moduleName, int courseId);
    void save(ModuleDTO moduleDTO);
    void update(ModuleDTO moduleDTO);
    void delete(int moduleId);
}
