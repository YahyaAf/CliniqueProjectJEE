package org.example.clinique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.clinique.dto.StaffRegisterRequestDTO;
import org.example.clinique.repository.implementation.*;
import org.example.clinique.service.AuthService;
import org.example.clinique.validator.StaffValidator;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/register-staff")
public class RegisterStaffServlet extends HttpServlet {
    private AuthService authService;
    private StaffValidator validator;

    public void init(){
        this.authService = new AuthService(
                new UserRepositoryImpl(),
                new PatientRepositoryImpl(),
                new DoctorRepositoryImpl(),
                new StaffRepositoryImpl(),
                new SpecialiteRepositoryImpl()
        );
        this.validator = new StaffValidator();
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        StaffRegisterRequestDTO dto = new StaffRegisterRequestDTO(
                req.getParameter("fullName"),
                req.getParameter("email"),
                req.getParameter("password"),
                req.getParameter("position")
        );

        List<String> errors = validator.validate(dto);

        if(!errors.isEmpty()){
            req.setAttribute("errors",errors);
            req.getRequestDispatcher("/dashboard/pages/registerStaff.jsp").forward(req,resp);
            return;
        }

        authService.registerStaff(dto);
        resp.sendRedirect(req.getContextPath() + "/admin/list-users");
    }
}
