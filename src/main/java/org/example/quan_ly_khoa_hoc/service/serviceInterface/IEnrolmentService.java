package org.example.quan_ly_khoa_hoc.service.serviceInterface;

import org.example.quan_ly_khoa_hoc.entity.Enrolment;

public interface IEnrolmentService {
    boolean add(Enrolment enrolment);
    boolean delete(int classId, int studentId);
}
