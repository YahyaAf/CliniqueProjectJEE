package org.example.clinique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.clinique.dto.PatientRegisterRequestDTO;
import org.example.clinique.dto.PatientResponseDTO;
import org.example.clinique.dto.UserResponseLoginDTO;
import org.example.clinique.model.enums.BloodType;
import org.example.clinique.model.enums.Gender;
import org.example.clinique.repository.implementation.*;
import org.example.clinique.service.AuthService;
import org.example.clinique.validator.PatientValidator;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@WebServlet("/patient/update-profile")
public class UpdateProfileServlet extends HttpServlet {
    private AuthService authService;
    private PatientValidator validator;

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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserResponseLoginDTO currentUser = (UserResponseLoginDTO) req.getSession().getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/pages/auth/login.jsp");
            return;
        }

        UUID userId = currentUser.getId();
        authService.getPatientByUserId(userId).ifPresent(patient -> req.setAttribute("patient", patient));

        req.getRequestDispatcher("/pages/auth/editProfile.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserResponseLoginDTO currentUser = (UserResponseLoginDTO) req.getSession().getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/pages/auth/login.jsp");
            return;
        }

        UUID userId = currentUser.getId();
        Optional<PatientResponseDTO> patientOpt = authService.getPatientByUserId(userId);
        
        PatientResponseDTO patient = patientOpt.get();
        UUID patientId = patient.getId();


        PatientRegisterRequestDTO dto = new PatientRegisterRequestDTO();
        dto.setFullName(req.getParameter("fullName"));
        dto.setEmail(req.getParameter("email"));
        dto.setPassword(req.getParameter("password"));
        dto.setCin(req.getParameter("cin"));
        dto.setDateOfBirth(LocalDate.parse(req.getParameter("dateOfBirth")));
        dto.setGender(Gender.valueOf(req.getParameter("gender")));
        dto.setBloodType(BloodType.valueOf(req.getParameter("bloodType")));
        dto.setInsuranceNumber(req.getParameter("insuranceNumber"));

        List<String> errors = validator.validate(dto);
        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("patient", dto);
            req.getRequestDispatcher("/pages/auth/editProfile.jsp").forward(req, resp);
            return;
        }

        authService.updatePatient(patientId, dto);
        resp.sendRedirect(req.getContextPath());
    }
}

