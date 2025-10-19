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

@WebServlet("/dashboard/appointments/cancelProcess")
public class DoctorCancelAppointmentServlet extends HttpServlet {

    private AppointmentService appointmentService;

    @Override
    public void init() throws ServletException {
        this.appointmentService = new AppointmentService();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserResponseLoginDTO currentUser = (UserResponseLoginDTO) req.getSession().getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/pages/auth/login.jsp");
            return;
        }

        if (!"DOCTOR".equals(currentUser.getRole())) {
            req.getSession().setAttribute("errorMessage", "Access denied. Admins only.");
            resp.sendRedirect("/clinique/");
            return;
        }

        try {
            String appointmentIdStr = req.getParameter("appointmentId");
            String reason = req.getParameter("reason");

            if (appointmentIdStr == null || appointmentIdStr.isEmpty()) {
                req.getSession().setAttribute("errorMessage", "Appointment ID is required");
                resp.sendRedirect(req.getContextPath() + "/dashboard/appointments/list");
                return;
            }

            if (reason == null || reason.trim().isEmpty()) {
                req.getSession().setAttribute("errorMessage", "Cancellation reason is required");
                resp.sendRedirect(req.getContextPath() + "/dashboard/appointments/cancelForm?appointmentId=" + appointmentIdStr);
                return;
            }

            UUID appointmentId = UUID.fromString(appointmentIdStr);
            String canceledBy = "Dr. " + currentUser.getFullName();

            // Annuler l'appointment
            appointmentService.cancelAppointment(appointmentId, canceledBy, reason);

            req.getSession().setAttribute("successMessage", "Appointment cancelled successfully!");
            resp.sendRedirect(req.getContextPath() + "/dashboard/appointments/list");

        } catch (RuntimeException e) {
            req.getSession().setAttribute("errorMessage", e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/dashboard/appointments/list");
        } catch (Exception e) {
            req.getSession().setAttribute("errorMessage", "Unexpected error: " + e.getMessage());
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/dashboard/appointments/list");
        }
    }
}