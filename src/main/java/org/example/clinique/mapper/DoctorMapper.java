package org.example.clinique.mapper;

import org.example.clinique.dto.DoctorDTO;
import org.example.clinique.model.Doctor;
import org.example.clinique.model.User;
import org.example.clinique.model.enums.Role;

import java.util.UUID;

public class DoctorMapper {

    public static User toUserEntity(DoctorDTO dto, String hashedPassword) {
        User user = new User();
        user.setFullName(dto.getFullName());
        user.setEmail(dto.getEmail());
        user.setPassword(hashedPassword);
        user.setRole(Role.DOCTOR);
        user.setActive(true);
        return user;
    }

    public static Doctor toDoctorEntity(DoctorDTO dto, User user) {
        Doctor doctor = new Doctor();
        doctor.setMatricule(dto.getMatricule());
        doctor.setUser(user);

        if (dto.getSpecialiteId() != null && !dto.getSpecialiteId().isEmpty()) {
            doctor.setSpecialiteId(UUID.fromString(dto.getSpecialiteId()));
        } else {
            doctor.setSpecialiteId(null);
        }

        return doctor;
    }
}
