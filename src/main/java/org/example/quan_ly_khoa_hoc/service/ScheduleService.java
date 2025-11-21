package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.dto.ScheduleDTO;
import org.example.quan_ly_khoa_hoc.entity.Schedule;
import org.example.quan_ly_khoa_hoc.repository.ScheduleRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IScheduleRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IScheduleService;

import java.util.List;

public class ScheduleService implements IScheduleService {
    private final IScheduleRepository scheduleRepository = new ScheduleRepository();
    @Override
    public List<ScheduleDTO> findAll() {
        return scheduleRepository.findAll();
    }

    @Override
    public boolean add(Schedule schedule) {
        return scheduleRepository.add(schedule);
    }

    @Override
    public boolean editById(int scheduleId, Schedule schedule) {
        return scheduleRepository.editById(scheduleId,schedule);
    }

    @Override
    public boolean deleteById(int scheduleId) {
        return scheduleRepository.deleteById(scheduleId);
    }

    @Override
    public List<ScheduleDTO> findScheduleDTOByClassId(int classId) {
        return scheduleRepository.findScheduleDTOByClassId(classId);
    }

    @Override
    public Schedule findScheduleById(int scheduleId) {
        return scheduleRepository.findScheduleById(scheduleId);
    }


}