package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.ClassLogDTO;
import org.example.quan_ly_khoa_hoc.entity.ClassLog;

import java.util.List;

public interface IClassLogRepository {
    // Phương thức GHI (CREATE/UPDATE) vẫn sử dụng Entity
    int save(ClassLog classLog);
    boolean update(ClassLog classLog);
    boolean delete(int logId);

    // Phương thức ĐỌC (READ) sử dụng DTO để trả về dữ liệu tổng hợp
    ClassLogDTO findById(int logId);
    List<ClassLogDTO> findAll();
    List<ClassLogDTO> findByClassId(int classId);
}
