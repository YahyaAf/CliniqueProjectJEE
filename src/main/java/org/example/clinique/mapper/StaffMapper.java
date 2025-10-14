package org.example.clinique.mapper;

import org.example.clinique.dto.StaffRegisterRequestDTO;
import org.example.clinique.dto.StaffResponseDTO;
import org.example.clinique.model.Staff;
import org.example.clinique.model.User;
import org.example.clinique.model.enums.Role;

public class StaffMapper {

    public static User toUserEntity(StaffRegisterRequestDTO dto, String hashedPassword) {
        User user = new User();
        user.setFullName(dto.getFullName());
        user.setEmail(dto.getEmail());
        user.setPassword(hashedPassword);
        user.setRole(Role.STAFF);
        user.setActive(true);
        return user;
    }

    public static Staff toStaffEntity(StaffRegisterRequestDTO dto, User user) {
        Staff staff = new Staff();
        staff.setPosition(dto.getPosition());
        staff.setUser(user);
        return staff;
    }

    public static StaffResponseDTO toResponseDTO(Staff staff){
        return new StaffResponseDTO(
                staff.getId(),
                staff.getUser().getFullName(),
                staff.getUser().getEmail(),
                staff.getUser().isActive(),
                staff.getPosition()
        );
    }
}
