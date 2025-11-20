package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.dto.ClassLogDTO; // Import DTO
import org.example.quan_ly_khoa_hoc.entity.ClassLog;
import org.example.quan_ly_khoa_hoc.repository.ClassLogRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IClassLogRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IClassLogService;

import java.util.List;

// Triển khai Service Layer, xử lý business logic và ủy nhiệm cho Repository
public class ClassLogService implements IClassLogService {

    // Dependency Injection (Khởi tạo thủ công)
    private final IClassLogRepository classLogRepository;

    public ClassLogService() {
        // Khởi tạo ClassLogRepository
        this.classLogRepository = new ClassLogRepository();
    }

    // ----------------------------------------------------
    // 1. CREATE
    // ----------------------------------------------------
    @Override
    public int save(ClassLog classLog) {
        // Business logic: Kiểm tra dữ liệu hợp lệ trước khi lưu
        if (classLog.getClassId() <= 0 || classLog.getAuthorStaffId() <= 0 || classLog.getContent() == null || classLog.getContent().trim().length() < 10) {
            throw new IllegalArgumentException("Dữ liệu nhật ký không hợp lệ: Thiếu Class ID, Author ID hoặc nội dung quá ngắn.");
        }
        return classLogRepository.save(classLog);
    }

    // ----------------------------------------------------
    // 2. READ (FIND BY ID) - Trả về ClassLogDTO
    // ----------------------------------------------------
    @Override
    public ClassLogDTO findById(int logId) {
        if (logId <= 0) {
            throw new IllegalArgumentException("ID nhật ký không hợp lệ.");
        }
        return classLogRepository.findById(logId);
    }

    // ----------------------------------------------------
    // 3. READ (FIND ALL) - Trả về List<ClassLogDTO>
    // ----------------------------------------------------
    @Override
    public List<ClassLogDTO> findAll() {
        return classLogRepository.findAll();
    }

    // ----------------------------------------------------
    // 4. READ (FIND BY CLASS ID) - Trả về List<ClassLogDTO>
    // ----------------------------------------------------
    @Override
    public List<ClassLogDTO> findByClassId(int classId) {
        if (classId <= 0) {
            throw new IllegalArgumentException("ID lớp học không hợp lệ.");
        }
        return classLogRepository.findByClassId(classId);
    }

    // ----------------------------------------------------
    // 5. UPDATE
    // ----------------------------------------------------
    @Override
    public boolean update(ClassLog classLog) {
        // Business logic: Kiểm tra nội dung cập nhật hợp lệ
        if (classLog.getLogId() <= 0 || classLog.getContent() == null || classLog.getContent().trim().length() < 10) {
            throw new IllegalArgumentException("Dữ liệu cập nhật nhật ký không hợp lệ.");
        }
        return classLogRepository.update(classLog);
    }

    // ----------------------------------------------------
    // 6. DELETE
    // ----------------------------------------------------
    @Override
    public boolean delete(int logId) {
        if (logId <= 0) {
            throw new IllegalArgumentException("ID nhật ký không hợp lệ để xóa.");
        }
        return classLogRepository.delete(logId);
    }
}