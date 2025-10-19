package org.example.clinique.servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.clinique.dto.PatientRegisterRequestDTO;
import org.example.clinique.model.enums.BloodType;
import org.example.clinique.model.enums.Gender;
import org.example.clinique.repository.implementation.*;
import org.example.clinique.service.AuthService;
import org.example.clinique.validator.PatientValidator;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/register-patient")
public class RegisterPatientServlet extends HttpServlet {
    private AuthService authService;
    private PatientValidator validator;

    @Override
    public void init() {
        this.authService = new AuthService(
                new UserRepositoryImpl(),
                new PatientRepositoryImpl(),
                new DoctorRepositoryImpl(),
                new StaffRepositoryImpl(),
                new SpecialiteRepositoryImpl()
        );
        this.validator = new PatientValidator();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        PatientRegisterRequestDTO dto = new PatientRegisterRequestDTO();
        dto.setFullName(req.getParameter("fullName"));
        dto.setEmail(req.getParameter("email"));
        dto.setPassword(req.getParameter("password"));
        dto.setCin(req.getParameter("cin"));
        String dateStr = req.getParameter("dateOfBirth");
        if (dateStr != null && !dateStr.isEmpty()) {
            dto.setDateOfBirth(LocalDate.parse(dateStr));
        } else {
            dto.setDateOfBirth(null);
        }
        dto.setGender(Gender.valueOf(req.getParameter("gender")));
        dto.setBloodType(BloodType.valueOf(req.getParameter("bloodType")));
        dto.setInsuranceNumber(req.getParameter("insuranceNumber"));

        List<String> errors = validator.validate(dto);

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/pages/auth/registerPatient.jsp").forward(req, resp);
            return;
        }

        authService.registerPatient(dto);
        resp.sendRedirect(req.getContextPath() + "/");
    }
}

