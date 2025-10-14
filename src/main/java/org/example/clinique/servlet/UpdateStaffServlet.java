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
import java.util.UUID;

@WebServlet("/admin/update-staff")
public class UpdateStaffServlet extends HttpServlet {

    private AuthService authService;
    private StaffValidator validator;

    public void init() throws ServletException{
        this.authService = new AuthService(
                new UserRepositoryImpl(),
                new PatientRepositoryImpl(),
                new DoctorRepositoryImpl(),
                new StaffRepositoryImpl(),
                new SpecialiteRepositoryImpl()
        );

        this.validator = new StaffValidator();
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            UUID staffId = UUID.fromString(idParam);
            authService.getStaffById(staffId).ifPresent(staff -> req.setAttribute("staff", staff));
        }

        req.getRequestDispatcher("/dashboard/pages/staff/editStaff.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if(idParam == null || idParam.isEmpty()){
            resp.sendRedirect(req.getContextPath()+ "/admin/staff");
            return;
        }

        UUID staffId = UUID.fromString(idParam);
        StaffRegisterRequestDTO dto = new StaffRegisterRequestDTO(
                req.getParameter("fullName"),
                req.getParameter("email"),
                req.getParameter("password"),
                req.getParameter("position")
        );

        List<String> errors = validator.validate(dto);
        if(!errors.isEmpty()){
            req.setAttribute("errors",errors);
            req.setAttribute("staff",authService.getStaffById(staffId).orElse(null));
            req.getRequestDispatcher("/dashboard/pages/staff/editStaff.jsp").forward(req,resp);
            return;
        }

        authService.updateStaff(staffId, dto);
        resp.sendRedirect(req.getContextPath()+ "/admin/staff");
    }
}
