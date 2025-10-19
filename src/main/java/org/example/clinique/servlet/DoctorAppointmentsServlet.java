package org.example.clinique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.clinique.dto.AppointmentResponseDTO;
import org.example.clinique.dto.DoctorResponseDTO;
import org.example.clinique.dto.UserResponseLoginDTO;
import org.example.clinique.repository.implementation.*;
import org.example.clinique.service.AppointmentService;
import org.example.clinique.service.AuthService;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@WebServlet("/dashboard/appointments/list")
public class DoctorAppointmentsServlet extends HttpServlet {

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
        // Vérifier que le doctor est connecté
        UserResponseLoginDTO currentUser = (UserResponseLoginDTO) req.getSession().getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/pages/auth/login.jsp");
            return;
        }

        UUID userId = currentUser.getId();
        Optional<DoctorResponseDTO> doctorOpt = authService.getDoctorByUserId(userId);

        if (doctorOpt.isEmpty()) {
            req.getSession().setAttribute("errorMessage", "You must be a doctor to view this page");
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        try {
            DoctorResponseDTO doctor = doctorOpt.get();

            // Récupérer le filtre (optionnel)
            String statusFilter = req.getParameter("status");
            String dateFilter = req.getParameter("date");

            // Récupérer tous les appointments du doctor
            List<AppointmentResponseDTO> appointments = appointmentService.getAppointmentsByDoctorId(doctor.getId());

            // Appliquer les filtres si nécessaire
            if (statusFilter != null && !statusFilter.isEmpty() && !statusFilter.equals("ALL")) {
                appointments = appointments.stream()
                        .filter(apt -> apt.getStatus().equals(statusFilter))
                        .collect(Collectors.toList());
            }

            if (dateFilter != null && !dateFilter.isEmpty()) {
                LocalDate filterDate = LocalDate.parse(dateFilter);
                appointments = appointments.stream()
                        .filter(apt -> apt.getAppointmentDate().equals(filterDate))
                        .collect(Collectors.toList());
            }

            // Statistiques
            long totalAppointments = appointments.size();
            long todayAppointments = appointments.stream()
                    .filter(apt -> apt.getAppointmentDate().equals(LocalDate.now()))
                    .count();
            long plannedAppointments = appointments.stream()
                    .filter(apt -> "PLANNED".equals(apt.getStatus()))
                    .count();
            long doneAppointments = appointments.stream()
                    .filter(apt -> "DONE".equals(apt.getStatus()))
                    .count();
            long canceledAppointments = appointments.stream()
                    .filter(apt -> "CANCELED".equals(apt.getStatus()))
                    .count();

            // Grouper par date pour vue calendrier
            Map<LocalDate, Long> appointmentsByDate = appointments.stream()
                    .filter(apt -> !"CANCELED".equals(apt.getStatus()))
                    .collect(Collectors.groupingBy(
                            AppointmentResponseDTO::getAppointmentDate,
                            Collectors.counting()
                    ));

            // Passer les données à la JSP
            req.setAttribute("doctor", doctor);
            req.setAttribute("appointments", appointments);
            req.setAttribute("totalAppointments", totalAppointments);
            req.setAttribute("todayAppointments", todayAppointments);
            req.setAttribute("plannedAppointments", plannedAppointments);
            req.setAttribute("doneAppointments", doneAppointments);
            req.setAttribute("canceledAppointments", canceledAppointments);
            req.setAttribute("appointmentsByDate", appointmentsByDate);
            req.setAttribute("statusFilter", statusFilter);
            req.setAttribute("dateFilter", dateFilter);

            req.getRequestDispatcher("/dashboard/pages/appointments/list.jsp").forward(req, resp);

        } catch (Exception e) {
            req.setAttribute("errorMessage", "Error loading appointments: " + e.getMessage());
            e.printStackTrace();
            req.getRequestDispatcher("/dashboard/pages/appointments/list.jsp").forward(req, resp);
        }
    }
}