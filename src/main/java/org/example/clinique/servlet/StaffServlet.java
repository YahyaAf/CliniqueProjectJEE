package org.example.clinique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.clinique.dto.StaffResponseDTO;
import org.example.clinique.repository.implementation.*;
import org.example.clinique.service.AuthService;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/staff")
public class StaffServlet extends HttpServlet {

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
        List<StaffResponseDTO> allStaff = authService.getAllStaffs();
        List<StaffResponseDTO> activeStaff = allStaff.stream()
                .filter(StaffResponseDTO::getIsActive)
                .toList();
        req.setAttribute("staff",activeStaff);
        req.setAttribute("count",activeStaff.size());

        req.getRequestDispatcher("/dashboard/pages/staff/listStaff.jsp").forward(req,resp);
    }
}
