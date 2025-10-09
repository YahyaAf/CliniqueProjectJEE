package org.example.clinique.mapper;

import org.example.clinique.dto.StaffDTO;
import org.example.clinique.model.Staff;
import org.example.clinique.model.User;
import org.example.clinique.model.enums.Role;

public class StaffMapper {

    public static User toUserEntity(StaffDTO dto, String hashedPassword) {
        User user = new User();
        user.setFullName(dto.getFullName());
        user.setEmail(dto.getEmail());
        user.setPassword(hashedPassword);
        user.setRole(Role.STAFF);
        user.setActive(true);
        return user;
    }

    public static Staff toStaffEntity(StaffDTO dto, User user) {
        Staff staff = new Staff();
        staff.setPosition(dto.getPosition());
        staff.setUser(user);
        return staff;
    }
}
