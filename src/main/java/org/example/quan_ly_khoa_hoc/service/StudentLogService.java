package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.dto.StudentLogDTO;
import org.example.quan_ly_khoa_hoc.entity.StudentLog;
import org.example.quan_ly_khoa_hoc.repository.StudentLogRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IStudentLogRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IStudentLogService;

import java.util.List;

public class StudentLogService implements IStudentLogService {

    private final IStudentLogRepository studentLogRepository;

    public StudentLogService() {
        // Dependency Injection (Khởi tạo thủ công)
        this.studentLogRepository = new StudentLogRepository();
    }

    // ----------------------------------------------------
    // 1. CREATE (SAVE)
    // ----------------------------------------------------
    @Override
    public int save(StudentLog studentLog) {
        // Business logic: Kiểm tra dữ liệu hợp lệ trước khi lưu
        if (studentLog.getStudentId() <= 0) {
            throw new IllegalArgumentException("ID học sinh không hợp lệ.");
        }
        if (studentLog.getAuthorStaffId() <= 0) {
            throw new IllegalArgumentException("ID tác giả (Staff) không hợp lệ.");
        }
        if (studentLog.getContent() == null || studentLog.getContent().trim().length() < 10) {
            throw new IllegalArgumentException("Nội dung nhật ký quá ngắn (tối thiểu 10 ký tự).");
        }
        return studentLogRepository.save(studentLog);
    }

    // ----------------------------------------------------
    // 2. READ (FIND BY ID)
    // ----------------------------------------------------
    @Override
    public StudentLogDTO findById(int logId) {
        if (logId <= 0) {
            throw new IllegalArgumentException("ID nhật ký không hợp lệ.");
        }
        return studentLogRepository.findById(logId);
    }

    // ----------------------------------------------------
    // 3. READ (FIND BY STUDENT ID)
    // ----------------------------------------------------
    @Override
    public List<StudentLogDTO> findByStudentId(int studentId) {
        if (studentId <= 0) {
            throw new IllegalArgumentException("ID học sinh không hợp lệ.");
        }
        return studentLogRepository.findByStudentId(studentId);
    }

    // ----------------------------------------------------
    // 4. READ (FIND BY AUTHOR STAFF ID)
    // ----------------------------------------------------
    @Override
    public List<StudentLogDTO> findByAuthorStaffId(int authorStaffId) {
        if (authorStaffId <= 0) {
            throw new IllegalArgumentException("ID Staff không hợp lệ.");
        }
        return studentLogRepository.findByAuthorStaffId(authorStaffId);
    }

    // ----------------------------------------------------
    // 5. UPDATE
    // ----------------------------------------------------
    @Override
    public boolean update(StudentLog studentLog) {
        // Business logic: Kiểm tra nội dung cập nhật hợp lệ
        if (studentLog.getLogId() <= 0) {
            throw new IllegalArgumentException("ID nhật ký cần cập nhật không hợp lệ.");
        }
        if (studentLog.getContent() == null || studentLog.getContent().trim().length() < 10) {
            throw new IllegalArgumentException("Nội dung nhật ký cập nhật quá ngắn (tối thiểu 10 ký tự).");
        }
        return studentLogRepository.update(studentLog);
    }

    // ----------------------------------------------------
    // 6. DELETE
    // ----------------------------------------------------
    @Override
    public boolean delete(int logId) {
        if (logId <= 0) {
            throw new IllegalArgumentException("ID nhật ký không hợp lệ để xóa.");
        }
        return studentLogRepository.delete(logId);
    }

    @Override
    public String findFullNameById(int studentId) {
        return studentLogRepository.findFullNameById(studentId);
    }
}