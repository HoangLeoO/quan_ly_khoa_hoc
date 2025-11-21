package org.example.quan_ly_khoa_hoc.service.serviceInterface;

import org.example.quan_ly_khoa_hoc.dto.UserDTO;
import org.example.quan_ly_khoa_hoc.entity.User;

import java.util.List;

public interface IUserService {
    List<UserDTO> getAllUser();
    User createUserWithProfile(UserDTO userDTO);

    User updateUserWithProfile(UserDTO userDTO);

    List<UserDTO> search(String keyword, Integer roleId);

    boolean deleteUser(Integer userId);
    User add(User user);

    User findByEmail(String email); // Changed return type to User


    UserDTO getUserById(Integer userId);
}
