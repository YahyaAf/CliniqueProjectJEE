package org.example.clinique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.clinique.dto.AppointmentResponseDTO;
import org.example.clinique.dto.UserResponseLoginDTO;
import org.example.clinique.model.Appointment;
import org.example.clinique.repository.implementation.AppointmentRepositoryImpl;
import org.example.clinique.service.AppointmentService;

import java.io.IOException;
import java.util.Optional;
import java.util.UUID;

@WebServlet("/dashboard/appointments/cancelForm")
public class DoctorCancelAppointmentFormServlet extends HttpServlet {

    private AppointmentService appointmentService;
    private AppointmentRepositoryImpl appointmentRepository;

    @Override
    public void init() throws ServletException {
        this.appointmentService = new AppointmentService();
        this.appointmentRepository = new AppointmentRepositoryImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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

            if (appointmentIdStr == null || appointmentIdStr.isEmpty()) {
                req.getSession().setAttribute("errorMessage", "Appointment ID is required");
                resp.sendRedirect(req.getContextPath() + "/dashboard/appointments/list");
                return;
            }

            UUID appointmentId = UUID.fromString(appointmentIdStr);
            Optional<Appointment> appointmentOpt = appointmentRepository.findById(appointmentId);

            if (appointmentOpt.isEmpty()) {
                req.getSession().setAttribute("errorMessage", "Appointment not found");
                resp.sendRedirect(req.getContextPath() + "/dashboard/appointments/list");
                return;
            }

            Appointment appointment = appointmentOpt.get();
            req.setAttribute("appointment", appointment);

            req.getRequestDispatcher("/dashboard/pages/appointments/cancelForm.jsp").forward(req, resp);

        } catch (Exception e) {
            req.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/dashboard/appointments/list");
        }
    }
}