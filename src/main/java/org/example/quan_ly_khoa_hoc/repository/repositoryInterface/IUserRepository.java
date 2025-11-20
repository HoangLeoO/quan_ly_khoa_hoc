package org.example.quan_ly_khoa_hoc.repository.repositoryInterface;

import org.example.quan_ly_khoa_hoc.dto.UserDTO;
import org.example.quan_ly_khoa_hoc.entity.User;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public interface IUserRepository {

    //Lấy tất cả người dùng
    List<UserDTO> getAllUser();
    User  addUserInTransaction(Connection connection, User user) throws SQLException;

    List<UserDTO> search(String keyword, Integer roleId);

    boolean deleteUser (Integer userId);

    UserDTO getUserById(Integer userId);

    UserDTO updateUserInTransaction(Connection connection, UserDTO userDTO) throws SQLException;

    // Tìm user theo email
    User findByEmail(String email);


}
