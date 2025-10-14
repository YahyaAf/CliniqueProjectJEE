package org.example.clinique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.clinique.dto.DoctorRegisterRequestDTO;
import org.example.clinique.repository.implementation.*;
import org.example.clinique.service.AuthService;
import org.example.clinique.validator.DoctorValidator;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet("/admin/update-doctor")
public class UpdateDoctorServlet extends HttpServlet {

    private AuthService authService;
    private DoctorValidator validator;

    @Override
    public void init() throws ServletException {
        this.authService = new AuthService(
                new UserRepositoryImpl(),
                new PatientRepositoryImpl(),
                new DoctorRepositoryImpl(),
                new StaffRepositoryImpl(),
                new SpecialiteRepositoryImpl()
        );
        this.validator = new DoctorValidator();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            UUID doctorId = UUID.fromString(idParam);
            authService.getDoctorById(doctorId).ifPresent(doctor -> req.setAttribute("doctor", doctor));
        }

        req.setAttribute("specialites", authService.getAllSpecialites());

        req.getRequestDispatcher("/dashboard/pages/editDoctor.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/doctors");
            return;
        }

        UUID doctorId = UUID.fromString(idParam);

        DoctorRegisterRequestDTO dto = new DoctorRegisterRequestDTO(
                req.getParameter("fullName"),
                req.getParameter("email"),
                req.getParameter("password"),
                req.getParameter("matricule"),
                req.getParameter("specialiteId") != null && !req.getParameter("specialiteId").isEmpty()
                        ? UUID.fromString(req.getParameter("specialiteId"))
                        : null
        );

        List<String> errors = validator.validate(dto);
        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("doctor", authService.getDoctorById(doctorId).orElse(null));
            req.setAttribute("specialites", authService.getAllSpecialites());
            req.getRequestDispatcher("/dashboard/pages/editDoctor.jsp").forward(req, resp);
            return;
        }

        authService.updateDoctor(doctorId, dto);

        resp.sendRedirect(req.getContextPath() + "/admin/doctors");
    }
}
