package org.example.clinique.mapper;

import org.example.clinique.dto.PatientDTO;
import org.example.clinique.model.Patient;
import org.example.clinique.model.User;
import org.example.clinique.model.enums.Role;

public class PatientMapper {

    public static User toUserEntity(PatientDTO dto, String hashedPassword) {
        User user = new User();
        user.setFullName(dto.getFullName());
        user.setEmail(dto.getEmail());
        user.setPassword(hashedPassword);
        user.setRole(Role.PATIENT);
        return user;
    }

    public static Patient toPatientEntity(PatientDTO dto, User user) {
        Patient patient = new Patient();
        patient.setCin(dto.getCin());
        patient.setDateOfBirth(dto.getDateOfBirth());
        patient.setGender(dto.getGender());
        patient.setBloodType(dto.getBloodType());
        patient.setInsuranceNumber(dto.getInsuranceNumber());
        patient.setUser(user);
        return patient;
    }
}
