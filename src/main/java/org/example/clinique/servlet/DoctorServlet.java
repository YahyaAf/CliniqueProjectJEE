package org.example.clinique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.clinique.dto.DoctorResponseDTO;
import org.example.clinique.dto.UserResponseLoginDTO;
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

        List<DoctorResponseDTO> allDoctors = authService.getAllDoctors();
        List<DoctorResponseDTO> activeDoctors = allDoctors.stream()
                .filter(DoctorResponseDTO::getIsActive)
                .toList();

        req.setAttribute("doctors", activeDoctors);
        req.setAttribute("count", activeDoctors.size());

        req.getRequestDispatcher("/dashboard/pages/doctors/listDoctors.jsp").forward(req, resp);
    }
}
