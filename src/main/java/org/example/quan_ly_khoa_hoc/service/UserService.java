package org.example.quan_ly_khoa_hoc.service;

import org.example.quan_ly_khoa_hoc.dto.UserDTO;
import org.example.quan_ly_khoa_hoc.entity.Staff;
import org.example.quan_ly_khoa_hoc.entity.Student;
import org.example.quan_ly_khoa_hoc.entity.User;
import org.example.quan_ly_khoa_hoc.repository.UserRepository;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IUserRepository;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IStaffService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IStudentService;
import org.example.quan_ly_khoa_hoc.service.serviceInterface.IUserService;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class UserService implements IUserService {
    private static IUserRepository userRepository = new UserRepository();

    private static IStudentService studentService = new StudentService();
    private static IStaffService staffService = new StaffService();

    @Override
    public List<UserDTO> getAllUser() {
        return userRepository.getAllUser();
    }

    public User createUserWithProfile(UserDTO userDTO) {
        try (Connection connection = DatabaseUtil.getConnectDB()) {
            connection.setAutoCommit(false);
            User user = new User();
            user.setEmail(userDTO.getEmail());
            user.setPasswordHash(userDTO.getPasswordHash());
            user.setRoleId(userDTO.getRoleId());
            user = userRepository.addUserInTransaction(connection, user);
            if (user.getRoleId() == 3) {
                Student student = new Student();
                student.setUserId(user.getUserId());
                student.setFullName(userDTO.getFullName());
                student.setPhone(userDTO.getPhone());
                student.setDob(userDTO.getDob());
                student.setAddress(userDTO.getAddress());
                studentService.addStudentInTransaction(connection, student);
            }
            if (user.getRoleId() == 2 || user.getRoleId() == 4) {
                Staff staff = new Staff();
                staff.setUserId(user.getUserId());
                staff.setFullName(userDTO.getFullName());
                staff.setPosition(userDTO.getPosition());
                staff.setPhone(userDTO.getPhone());
                staff.setDob(userDTO.getDob());
                staff.setAddress(userDTO.getAddress());
                staffService.addStaffInTransaction(connection, staff);
            }
            connection.commit();
            return user;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public User updateUserWithProfile(UserDTO userDTO) {
        try (Connection connection = DatabaseUtil.getConnectDB()) {
            connection.setAutoCommit(false);
            userRepository.updateUserInTransaction(connection, userDTO);
            if (userDTO.getRoleId() == 3) {
                studentService.updateStudentInTransaction(connection, userDTO);
            }
            if (userDTO.getRoleId() == 2 || userDTO.getRoleId() == 4) {
                staffService.updateStaffInTransaction(connection, userDTO);
            }
            connection.commit();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public boolean deleteUser(Integer userId) {
        return userRepository.deleteUser(userId);
    }

    @Override
    public User add(User user) {
        return null;
    }

    @Override
    public UserDTO getUserById(Integer userId) {
        return userRepository.getUserById(userId);
    }

    @Override
    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }
}
