package org.example.clinique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.clinique.dto.UserResponseLoginDTO;
import org.example.clinique.service.AppointmentService;

import java.io.IOException;
import java.util.UUID;

@WebServlet("/appointments/cancel")
public class CancelAppointmentServlet extends HttpServlet {

    private AppointmentService appointmentService;

    @Override
    public void init() throws ServletException {
        this.appointmentService = new AppointmentService();
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

            // Annuler l'appointment
            appointmentService.cancelAppointment(appointmentId);

            req.getSession().setAttribute("successMessage", "Appointment cancelled successfully!");
            resp.sendRedirect(req.getContextPath() + "/pages/appointments/list");

        } catch (IllegalArgumentException e) {
            req.getSession().setAttribute("errorMessage", "Invalid appointment ID");
            resp.sendRedirect(req.getContextPath() + "/pages/appointments/list");
        } catch (RuntimeException e) {
            req.getSession().setAttribute("errorMessage", "Error cancelling appointment: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/pages/appointments/list");
        } catch (Exception e) {
            req.getSession().setAttribute("errorMessage", "Unexpected error: " + e.getMessage());
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/pages/appointments/list");
        }
    }
}