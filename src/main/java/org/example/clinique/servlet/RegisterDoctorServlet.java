package org.example.clinique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.clinique.dto.DoctorRegisterRequestDTO;
import org.example.clinique.dto.SpecialiteResponseDTO;
import org.example.clinique.dto.UserResponseLoginDTO;
import org.example.clinique.repository.implementation.*;
import org.example.clinique.service.AuthService;
import org.example.clinique.validator.DoctorValidator;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet("/admin/register-doctor")
public class RegisterDoctorServlet extends HttpServlet {

    private AuthService authService;
    private DoctorValidator validator;

    @Override
    public void init() {
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

        List<SpecialiteResponseDTO> specialites  = authService.getAllSpecialites();
        req.setAttribute("specialites", specialites);
        req.getRequestDispatcher("/dashboard/pages/doctors/registerDoctor.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
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

        if(!errors.isEmpty()){
            List<SpecialiteResponseDTO> specialites  = authService.getAllSpecialites();
            req.setAttribute("specialites", specialites);

            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/dashboard/pages/doctors/registerDoctor.jsp").forward(req, resp);
            return;
        }

        authService.registerDoctor(dto);

        resp.sendRedirect(req.getContextPath() + "/admin/list-users");
    }
}
