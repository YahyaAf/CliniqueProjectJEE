package org.example.clinique.mapper;

import org.example.clinique.dto.DoctorRegisterRequestDTO;
import org.example.clinique.dto.DoctorResponseDTO;
import org.example.clinique.model.Doctor;
import org.example.clinique.model.Specialite;
import org.example.clinique.model.User;
import org.example.clinique.model.enums.Role;

public class DoctorMapper {

    public static User toUserEntity(DoctorRegisterRequestDTO dto, String hashedPassword) {
        User user = new User();
        user.setFullName(dto.getFullName());
        user.setEmail(dto.getEmail());
        user.setPassword(hashedPassword);
        user.setRole(Role.DOCTOR);
        user.setActive(true);
        return user;
    }

    public static Doctor toDoctorEntity(DoctorRegisterRequestDTO dto, User user, Specialite specialite) {
        Doctor doctor = new Doctor();
        doctor.setMatricule(dto.getMatricule());
        doctor.setUser(user);
        doctor.setSpecialite(specialite);
        return doctor;
    }

    public static DoctorResponseDTO toResponseDTO(Doctor doctor){
        String specialiteName = null;
        String departmentName = null;

        Specialite specialite = doctor.getSpecialite();
        if(specialite != null){
            specialiteName = specialite.getName();
            if(specialite.getDepartment() != null){
                departmentName = specialite.getDepartment().getName();
            }
        }

        return new DoctorResponseDTO(
                doctor.getId(),
                doctor.getUser().getFullName(),
                doctor.getUser().getEmail(),
                doctor.getUser().isActive(),
                doctor.getMatricule(),
                specialiteName,
                departmentName
        );
    }
}
