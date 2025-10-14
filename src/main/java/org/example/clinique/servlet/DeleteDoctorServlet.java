package org.example.clinique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.clinique.repository.implementation.*;
import org.example.clinique.service.AuthService;

import java.io.IOException;
import java.util.UUID;

@WebServlet("/admin/delete-doctor")
public class DeleteDoctorServlet extends HttpServlet {

    private AuthService authService;

    @Override
    public void init() throws ServletException {
        this.authService = new AuthService(
                new UserRepositoryImpl(),
                new PatientRepositoryImpl(),
                new DoctorRepositoryImpl(),
                new StaffRepositoryImpl(),
                new SpecialiteRepositoryImpl()
        );
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            UUID doctorId = UUID.fromString(idParam);
            authService.deleteDoctor(doctorId);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/doctors");
    }
}
