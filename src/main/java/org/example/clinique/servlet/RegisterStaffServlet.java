package org.example.clinique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.clinique.dto.StaffDTO;
import org.example.clinique.repository.implementation.DoctorRepositoryImpl;
import org.example.clinique.repository.implementation.PatientRepositoryImpl;
import org.example.clinique.repository.implementation.StaffRepositoryImpl;
import org.example.clinique.repository.implementation.UserRepositoryImpl;
import org.example.clinique.service.AuthService;
import org.example.clinique.validator.StaffValidator;

import java.io.IOException;
import java.rmi.ServerException;
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
                new StaffRepositoryImpl()
        );
        this.validator = new StaffValidator();
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        StaffDTO dto = new StaffDTO(
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
        resp.sendRedirect(req.getContextPath()+"/dashboard/pages/registerStaff.jsp");
    }
}
