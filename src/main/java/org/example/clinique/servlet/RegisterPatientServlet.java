package org.example.clinique.servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.clinique.dto.PatientDTO;
import org.example.clinique.model.enums.BloodType;
import org.example.clinique.model.enums.Gender;
import org.example.clinique.repository.implementation.DoctorRepositoryImpl;
import org.example.clinique.repository.implementation.PatientRepositoryImpl;
import org.example.clinique.repository.implementation.StaffRepositoryImpl;
import org.example.clinique.repository.implementation.UserRepositoryImpl;
import org.example.clinique.service.AuthService;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/pages/auth/register-patient")
public class RegisterPatientServlet extends HttpServlet {
    private AuthService authService;

    @Override
    public void init() {
        this.authService = new AuthService(
                new UserRepositoryImpl(),
                new PatientRepositoryImpl(),
                new DoctorRepositoryImpl(),
                new StaffRepositoryImpl()
        );
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        PatientDTO dto = new PatientDTO();
        dto.setFullName(req.getParameter("fullName"));
        dto.setEmail(req.getParameter("email"));
        dto.setPassword(req.getParameter("password"));
        dto.setCin(req.getParameter("cin"));
        dto.setDateOfBirth(LocalDate.parse(req.getParameter("dateOfBirth")));
        dto.setGender(Gender.valueOf(req.getParameter("gender")));
        dto.setBloodType(BloodType.valueOf(req.getParameter("bloodType")));
        dto.setInsuranceNumber(req.getParameter("insuranceNumber"));

        authService.registerPatient(dto);
        resp.sendRedirect(req.getContextPath() + "/pages/auth/successRegisterPatient.jsp");
    }
}
