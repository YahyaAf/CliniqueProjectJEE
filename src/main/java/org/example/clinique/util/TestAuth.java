package org.example.clinique.util;

import org.example.clinique.dto.DoctorDTO;
import org.example.clinique.dto.PatientDTO;
import org.example.clinique.dto.StaffDTO;
import org.example.clinique.model.Doctor;
import org.example.clinique.model.Patient;
import org.example.clinique.model.Staff;
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

        DoctorDTO doctorDTO = new DoctorDTO();
        doctorDTO.setFullName("said gahtani");
        doctorDTO.setEmail("said@gmail.com");
        doctorDTO.setPassword("said123");
        doctorDTO.setMatricule("CN5555F447");
        doctorDTO.setSpecialiteId(null);
        authService.registerDoctor(doctorDTO);

//        authService.registerAdmin(user);

//        authService.login("admin@gmail.com","admin123");
//        authService.logout();

    }

}
