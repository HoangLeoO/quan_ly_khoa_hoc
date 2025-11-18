package org.example.quan_ly_khoa_hoc.service.serviceInterface;

import org.example.quan_ly_khoa_hoc.dto.UserDTO;
import org.example.quan_ly_khoa_hoc.entity.User;

import java.util.List;

public interface IUserService {
    List<UserDTO> getAllUser();
    User createUserWithProfile(UserDTO userDTO);
    User add(User user);
}
