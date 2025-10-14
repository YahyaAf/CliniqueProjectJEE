package org.example.clinique.util;

import org.example.clinique.dto.DoctorRegisterRequestDTO;
import org.example.clinique.repository.implementation.*;
import org.example.clinique.service.AuthService;

public class TestAuth {
    public static void main(String[] args) {
        AuthService authService = new AuthService(
                new UserRepositoryImpl(),
                new PatientRepositoryImpl(),
                new DoctorRepositoryImpl(),
                new StaffRepositoryImpl(),
                new SpecialiteRepositoryImpl()
        );

//        PatientDTO patientDTO = new PatientDTO();
//        patientDTO.setFullName("mourad mousstawi");
//        patientDTO.setEmail("mourad@gmail.com");
//        patientDTO.setPassword("mourad123");
//        patientDTO.setCin("EE222288");
//        patientDTO.setGender(Gender.MALE);
//        patientDTO.setDateOfBirth(java.time.LocalDate.of(1995, 5, 10));
//        patientDTO.setBloodType(BloodType.A_NEGATIVE);
//        patientDTO.setInsuranceNumber("wafa assurance");
//        authService.registerPatient(patientDTO);

//        StaffDTO staffDTO = new StaffDTO();
//        staffDTO.setFullName("omar om");
//        staffDTO.setEmail("omar@gmail.com");
//        staffDTO.setPassword("omar123");
//        staffDTO.setPosition("testeur");
//        authService.registerStaff(staffDTO);

        DoctorRegisterRequestDTO doctorRegisterRequestDTO = new DoctorRegisterRequestDTO();
        doctorRegisterRequestDTO.setFullName("said gahtani");
        doctorRegisterRequestDTO.setEmail("said@gmail.com");
        doctorRegisterRequestDTO.setPassword("said123");
        doctorRegisterRequestDTO.setMatricule("CN5555F447");
        doctorRegisterRequestDTO.setSpecialiteId(null);
        authService.registerDoctor(doctorRegisterRequestDTO);

//        authService.registerAdmin(user);

//        authService.login("admin@gmail.com","admin123");
//        authService.logout();

    }

}
