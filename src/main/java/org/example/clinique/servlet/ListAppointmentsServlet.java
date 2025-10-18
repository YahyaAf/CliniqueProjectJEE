package org.example.clinique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.clinique.dto.AppointmentResponseDTO;
import org.example.clinique.dto.PatientResponseDTO;
import org.example.clinique.dto.UserResponseLoginDTO;
import org.example.clinique.repository.implementation.*;
import org.example.clinique.service.AppointmentService;
import org.example.clinique.service.AuthService;

import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@WebServlet("/pages/appointments/list")
public class ListAppointmentsServlet extends HttpServlet {

    private AppointmentService appointmentService;
    private AuthService authService;

    @Override
    public void init() throws ServletException {
        this.appointmentService = new AppointmentService();
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
        // Vérifier que le patient est connecté
        UserResponseLoginDTO currentUser = (UserResponseLoginDTO) req.getSession().getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/pages/auth/login.jsp");
            return;
        }

        UUID userId = currentUser.getId();
        Optional<PatientResponseDTO> patientOpt = authService.getPatientByUserId(userId);

        if (patientOpt.isEmpty()) {
            req.getSession().setAttribute("errorMessage", "You must be a patient to view appointments");
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        try {
            PatientResponseDTO patient = patientOpt.get();

            // Récupérer tous les appointments du patient
            List<AppointmentResponseDTO> appointments = appointmentService.getAppointmentsByPatientId(patient.getId());

            // Passer les données à la JSP
            req.setAttribute("patient", patient);
            req.setAttribute("appointments", appointments);

            req.getRequestDispatcher("/pages/appointments/list.jsp").forward(req, resp);

        } catch (Exception e) {
            req.setAttribute("errorMessage", "Error loading appointments: " + e.getMessage());
            e.printStackTrace();
            req.getRequestDispatcher("/pages/appointments/list.jsp").forward(req, resp);
        }
    }
}