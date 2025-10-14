package org.example.clinique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.clinique.dto.DoctorResponseDTO;
import org.example.clinique.repository.implementation.*;
import org.example.clinique.service.AuthService;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/doctors")
public class DoctorServlet extends HttpServlet {

    private AuthService authService;

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
        List<DoctorResponseDTO> doctors = authService.getAllDoctors();
        req.setAttribute("doctors", doctors);
        req.setAttribute("count",doctors.size());

        req.getRequestDispatcher("/dashboard/pages/listDoctors.jsp").forward(req,resp);
    }
}
