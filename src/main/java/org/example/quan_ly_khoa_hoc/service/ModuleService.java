package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.entity.Module;
import org.example.quan_ly_khoa_hoc.repository.ModuleRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IModuleRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IModuleService;

import java.util.List;

public class ModuleService implements IModuleService {
    private IModuleRepository moduleRepository=new ModuleRepository();
    @Override
    public List<Module> findModulesByCourseId(int courseId) {
        return moduleRepository.findModulesByCourseId(courseId);
    }
}
