package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.ClassDTO;
import org.example.quan_ly_khoa_hoc.dto.StudentDetailDTO;
import org.example.quan_ly_khoa_hoc.dto.TeacherClassDTO;
import org.example.quan_ly_khoa_hoc.entity.Class;

import java.util.List;

public interface IClassRepository {
    List<TeacherClassDTO> findClassesByTeacherStaffId(int teacherStaffId);

    List<StudentDetailDTO> findStudentsByClassId(int classId);

    TeacherClassDTO findClassById(int classId);

    List<ClassDTO> findAll();

    ClassDTO findByClassID(int classId);

    List<ClassDTO> search(String keyword, Integer teacherId, Integer courseId, String status);

    boolean add(Class classObj);

    boolean updateById(int classId, Class classObj);

    boolean deleteById(int classId);
}
