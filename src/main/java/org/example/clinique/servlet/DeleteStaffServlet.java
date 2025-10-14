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

@WebServlet("/admin/delete-staff")
public class DeleteStaffServlet extends HttpServlet {

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
        String idParam = req.getParameter("id");
        if(idParam != null && !idParam.isEmpty()){
            UUID staffId = UUID.fromString(idParam);
            authService.deleteStaff(staffId);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/staff");
    }
}
