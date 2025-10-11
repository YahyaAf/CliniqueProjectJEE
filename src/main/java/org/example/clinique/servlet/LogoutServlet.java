package org.example.clinique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.clinique.repository.implementation.DoctorRepositoryImpl;
import org.example.clinique.repository.implementation.PatientRepositoryImpl;
import org.example.clinique.repository.implementation.StaffRepositoryImpl;
import org.example.clinique.repository.implementation.UserRepositoryImpl;
import org.example.clinique.service.AuthService;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
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

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        authService.logout();
        req.getSession().invalidate();
        resp.sendRedirect(req.getContextPath() + "/pages/auth/login.jsp");
    }
}
