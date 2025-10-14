package org.example.clinique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.clinique.dto.LoginDTO;
import org.example.clinique.repository.implementation.*;
import org.example.clinique.service.AuthService;
import org.example.clinique.validator.LoginValidator;

import java.io.IOException;
import java.util.List;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private AuthService authService;
    private LoginValidator validator;

    public void init() {
        this.authService = new AuthService(
                new UserRepositoryImpl(),
                new PatientRepositoryImpl(),
                new DoctorRepositoryImpl(),
                new StaffRepositoryImpl(),
                new SpecialiteRepositoryImpl()
        );
        this.validator = new LoginValidator();
    }


    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/pages/auth/login.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        LoginDTO loginDTO = new LoginDTO(email,password);
        List<String> errors = validator.validate(loginDTO);

        if(!errors.isEmpty()){
            req.setAttribute("errors",errors);
            req.getRequestDispatcher("/pages/auth/login.jsp").forward(req,resp);
            return;
        }
        boolean success = authService.login(email,password);
        if(!success){
            errors.add("Invalid email or passowrd");
            req.setAttribute("errors",errors);
            req.getRequestDispatcher("/pages/auth/login.jsp").forward(req,resp);
            return;
        }
        req.getSession().setAttribute("currentUser", authService.getCurrentUser());
        resp.sendRedirect(req.getContextPath() + "/pages/auth/success.jsp");

    }

}
