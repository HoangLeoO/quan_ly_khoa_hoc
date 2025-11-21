package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.ScheduleDTO;
import org.example.quan_ly_khoa_hoc.entity.Schedule;

import java.util.List;

public interface IScheduleRepository {
    List<ScheduleDTO> findAll();

    boolean add(Schedule schedule);

    boolean editById(int scheduleId, Schedule schedule);

    boolean deleteById(int scheduleId);

    List<ScheduleDTO> findScheduleDTOByClassId(int classId);

    Schedule findScheduleById(int scheduleId);
}