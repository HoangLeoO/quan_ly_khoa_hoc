package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.dto.ModuleDTO;
import org.example.quan_ly_khoa_hoc.repository.ModuleRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IModuleRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IModuleService;

import java.util.List;

public class ModuleService implements IModuleService {
    private IModuleRepository moduleRepository=new ModuleRepository();
    @Override
    public List<ModuleDTO> findModulesByCourseId(int courseId) {
        return moduleRepository.findModulesByCourseId(courseId);
    }

    @Override
    public List<ModuleDTO> findModulesDTOByStudentId(int studentId, int course_id) {
        return moduleRepository.findModulesDTOByStudentId(studentId,course_id);
    }

    @Override
    public ModuleDTO findById(int moduleId) {
        return moduleRepository.findById(moduleId);
    }

    @Override
    public ModuleDTO findByNameAndCourseId(String moduleName, int courseId) {
        return moduleRepository.findByNameAndCourseId(moduleName, courseId);
    }

    @Override
    public void save(ModuleDTO moduleDTO) {
        moduleRepository.save(moduleDTO);
    }

    @Override
    public void update(ModuleDTO moduleDTO) {
        moduleRepository.update(moduleDTO);
    }

    @Override
    public void delete(int moduleId) {
        moduleRepository.delete(moduleId);
    }
}
