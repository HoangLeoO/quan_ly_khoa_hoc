package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.ClassDTO;
import org.example.quan_ly_khoa_hoc.dto.StudentDetailDTO;
import org.example.quan_ly_khoa_hoc.dto.TeacherClassDTO;

import java.util.List;

public interface IClassRepository {
    List<TeacherClassDTO> findClassesByTeacherStaffId(int teacherStaffId);
    List<StudentDetailDTO> findStudentsByClassId(int classId);
    TeacherClassDTO findClassById(int classId);
    List<ClassDTO> findAll();
    ClassDTO findByClassID(int classId);

}
