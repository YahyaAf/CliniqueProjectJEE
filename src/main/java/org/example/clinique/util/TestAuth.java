package org.example.clinique.util;

import org.example.clinique.model.Patient;
import org.example.clinique.model.User;
import org.example.clinique.model.enums.BloodType;
import org.example.clinique.model.enums.Gender;
import org.example.clinique.repository.implementation.DoctorRepositoryImpl;
import org.example.clinique.repository.implementation.PatientRepositoryImpl;
import org.example.clinique.repository.implementation.StaffRepositoryImpl;
import org.example.clinique.repository.implementation.UserRepositoryImpl;
import org.example.clinique.service.AuthService;

public class TestAuth {
    public static void main(String[] args) {
        AuthService authService = new AuthService(
                new UserRepositoryImpl(),
                new PatientRepositoryImpl(),
                new DoctorRepositoryImpl(),
                new StaffRepositoryImpl()
        );

        User user = new User();
        user.setFullName("ahmed hos");
        user.setEmail("ahmed@gmail.com");
        user.setPassword("ahmed123");

        Patient patient = new Patient();
        patient.setCin("EE123456");
        patient.setGender(Gender.MALE);
        patient.setDateOfBirth(java.time.LocalDate.of(1995, 5, 10));
        patient.setBloodType(BloodType.A_NEGATIVE);
        patient.setInsuranceNumber("wafa assurance");
        authService.registerPatient(user, patient);
    }

}
