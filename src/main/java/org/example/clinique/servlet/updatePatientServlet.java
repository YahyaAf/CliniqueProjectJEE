package org.example.clinique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.clinique.dto.PatientRegisterRequestDTO;
import org.example.clinique.dto.UserResponseLoginDTO;
import org.example.clinique.model.enums.BloodType;
import org.example.clinique.model.enums.Gender;
import org.example.clinique.repository.implementation.*;
import org.example.clinique.service.AuthService;
import org.example.clinique.validator.PatientValidator;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@WebServlet("/admin/update-patient")
public class updatePatientServlet extends HttpServlet {

    private AuthService authService;
    private PatientValidator validator;

    public void init() throws ServletException{
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
            resp.sendRedirect("/pages/auth/login.jsp");
            return;
        }

        if (!"ADMIN".equals(currentUser.getRole())) {
            req.getSession().setAttribute("errorMessage", "Access denied. Admins only.");
            resp.sendRedirect("/");
            return;
        }

        String idParam = req.getParameter("id");
        if(idParam != null && !idParam.isEmpty()){
            UUID patiendId = UUID.fromString(idParam);
            authService.getPatientById(patiendId).ifPresent(patient-> req.setAttribute("patient", patient));
        }
        req.getRequestDispatcher("/dashboard/pages/patients/editPatient.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserResponseLoginDTO currentUser = (UserResponseLoginDTO) req.getSession().getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect("/clinique/pages/auth/login.jsp");
            return;
        }

        if (!"ADMIN".equals(currentUser.getRole())) {
            req.getSession().setAttribute("errorMessage", "Access denied. Admins only.");
            resp.sendRedirect("/clinique/");
            return;
        }

        String idParam = req.getParameter("id");
        if(idParam == null || idParam.isEmpty()){
            resp.sendRedirect(req.getContextPath() + "/admin/patients");
            return;
        }

        UUID patientId = UUID.fromString(idParam);

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
            req.setAttribute("patient", authService.getPatientById(patientId).orElse(null));
            req.getRequestDispatcher("/dashboard/pages/patients/editPatient.jsp").forward(req, resp);
            return;
        }

        authService.updatePatient(patientId,dto);

        resp.sendRedirect(req.getContextPath() + "/admin/patients");
    }
}
