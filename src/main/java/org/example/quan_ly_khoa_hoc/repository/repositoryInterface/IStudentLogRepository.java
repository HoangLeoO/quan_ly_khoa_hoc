package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.StudentLogDTO;
import org.example.quan_ly_khoa_hoc.entity.StudentLog;

import java.util.List;

public interface IStudentLogRepository {
    int save(StudentLog studentLog);

    StudentLogDTO findById(int logId);

    List<StudentLogDTO> findByStudentId(int studentId);

    List<StudentLogDTO> findByAuthorStaffId(int authorStaffId); // Thêm phương thức tìm theo Staff

    boolean update(StudentLog studentLog);

    boolean delete(int logId);

    String findFullNameById(int studentId);

}
