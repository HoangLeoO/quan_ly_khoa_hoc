package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.entity.Enrolment;
import org.example.quan_ly_khoa_hoc.repository.EnrolmentRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IEnrolmentRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IEnrolmentService;

public class EnrolmentService implements IEnrolmentService {
    private IEnrolmentRepository enrolmentRepository = new EnrolmentRepository();
    @Override
    public boolean add(Enrolment enrolment) {
        return enrolmentRepository.add(enrolment);
    }

    @Override
    public boolean delete(int classId, int studentId) {
        return enrolmentRepository.delete(classId, studentId);
    }
}
