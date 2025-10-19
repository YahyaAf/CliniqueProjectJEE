package org.example.clinique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.clinique.dto.UserResponseLoginDTO;
import org.example.clinique.model.Appointment;
import org.example.clinique.repository.implementation.AppointmentRepositoryImpl;
import org.example.clinique.service.AppointmentService;
import org.example.clinique.validator.CancelAppointmentValidator;

import java.io.IOException;
import java.util.Optional;
import java.util.UUID;

@WebServlet("/appointments/cancel")
public class CancelAppointmentServlet extends HttpServlet {

    private AppointmentService appointmentService;
    private CancelAppointmentValidator cancelValidator;
    private AppointmentRepositoryImpl appointmentRepository;

    @Override
    public void init() throws ServletException {
        this.appointmentService = new AppointmentService();
        this.cancelValidator = new CancelAppointmentValidator();
        this.appointmentRepository = new AppointmentRepositoryImpl();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Vérifier que l'utilisateur est connecté
        UserResponseLoginDTO currentUser = (UserResponseLoginDTO) req.getSession().getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/pages/auth/login.jsp");
            return;
        }

        try {
            String appointmentIdStr = req.getParameter("appointmentId");

            if (appointmentIdStr == null || appointmentIdStr.isEmpty()) {
                req.getSession().setAttribute("errorMessage", "Appointment ID is required");
                resp.sendRedirect(req.getContextPath() + "/pages/appointments/list");
                return;
            }

            UUID appointmentId = UUID.fromString(appointmentIdStr);

            // Récupérer l'appointment
            Optional<Appointment> appointmentOpt = appointmentRepository.findById(appointmentId);

            if (appointmentOpt.isEmpty()) {
                req.getSession().setAttribute("errorMessage", "Appointment not found");
                resp.sendRedirect(req.getContextPath() + "/pages/appointments/list");
                return;
            }

            Appointment appointment = appointmentOpt.get();

            // VALIDER L'ANNULATION
            CancelAppointmentValidator.ValidationResult validationResult = cancelValidator.validate(appointment);

            if (!validationResult.isValid()) {
                req.getSession().setAttribute("errorMessage", validationResult.getErrorMessage());
                resp.sendRedirect(req.getContextPath() + "/pages/appointments/list");
                return;
            }

            // Annuler l'appointment (sans validation car déjà validé)
            appointmentService.cancelAppointmentWithoutValidation(appointmentId);

            req.getSession().setAttribute("successMessage", "Appointment cancelled successfully!");
            resp.sendRedirect(req.getContextPath() + "/pages/appointments/list");

        } catch (IllegalArgumentException e) {
            req.getSession().setAttribute("errorMessage", "Invalid appointment ID");
            resp.sendRedirect(req.getContextPath() + "/pages/appointments/list");
        } catch (RuntimeException e) {
            req.getSession().setAttribute("errorMessage", e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/pages/appointments/list");
        } catch (Exception e) {
            req.getSession().setAttribute("errorMessage", "Unexpected error: " + e.getMessage());
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/pages/appointments/list");
        }
    }
}