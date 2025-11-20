package org.example.quan_ly_khoa_hoc.service.serviceInterface;

import org.example.quan_ly_khoa_hoc.entity.ClassLog;
import org.example.quan_ly_khoa_hoc.dto.ClassLogDTO; // Import DTO

import java.util.List;

public interface IClassLogService {
    // Thao tác CREATE
    int save(ClassLog classLog);

    // Thao tác READ: Đã thay đổi return type sang DTO để bao gồm tên tác giả
    ClassLogDTO findById(int logId);
    List<ClassLogDTO> findAll();
    List<ClassLogDTO> findByClassId(int classId); // Rất quan trọng cho việc đọc nhật ký lớp học

    // Thao tác UPDATE
    boolean update(ClassLog classLog);

    // Thao tác DELETE
    boolean delete(int logId);
}