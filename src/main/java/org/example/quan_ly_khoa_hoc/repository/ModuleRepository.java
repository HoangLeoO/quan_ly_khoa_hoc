package org.example.quan_ly_khoa_hoc.repository;

import org.example.quan_ly_khoa_hoc.entity.Module;
import org.example.quan_ly_khoa_hoc.repository.repositoryInterface.IModuleRepository;
import org.example.quan_ly_khoa_hoc.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ModuleRepository implements IModuleRepository {
    @Override
    public List<Module> findModulesByCourseId(int courseId) {
        List<Module> list = new ArrayList<>();
        String sql = "SELECT module_id, module_name FROM modules WHERE course_id = ?";
        try (Connection conn = DatabaseUtil.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Module(rs.getInt("module_id"), rs.getString("module_name")));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}
