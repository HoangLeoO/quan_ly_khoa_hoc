package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.ModuleDTO;
import org.example.quan_ly_khoa_hoc.entity.Module;

import java.util.List;

public interface IModuleRepository {
    List<Module> findModulesByCourseId(int courseId);

    List<ModuleDTO> findModulesDTOByStudentId(int studentId);
}
