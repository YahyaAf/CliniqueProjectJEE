package org.example.clinique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.clinique.dto.*;
import org.example.clinique.repository.implementation.*;
import org.example.clinique.service.AppointmentService;
import org.example.clinique.service.AuthService;
import org.example.clinique.service.SpecialiteService;
import org.example.clinique.validator.AppointmentValidator;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@WebServlet("/appointments/create")
public class CreateAppointmentServlet extends HttpServlet {

    private AppointmentService appointmentService;
    private SpecialiteService specialiteService;
    private AuthService authService;
    private AppointmentValidator appointmentValidator;

    @Override
    public void init() throws ServletException {
        this.appointmentService = new AppointmentService();
        this.specialiteService = new SpecialiteService(
                new SpecialiteRepositoryImpl(),
                new DepartmentRepositoryImpl()
        );
        this.authService = new AuthService(
                new UserRepositoryImpl(),
                new PatientRepositoryImpl(),
                new DoctorRepositoryImpl(),
                new StaffRepositoryImpl(),
                new SpecialiteRepositoryImpl()
        );
        // Initialiser le validator
        this.appointmentValidator = new AppointmentValidator(new AppointmentRepositoryImpl());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Vérifier que le patient est connecté
        UserResponseLoginDTO currentUser = (UserResponseLoginDTO) req.getSession().getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/pages/auth/login.jsp");
            return;
        }

        if (!"PATIENT".equals(currentUser.getRole())) {
            req.getSession().setAttribute("errorMessage", "Access denied. Patients only.");
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        UUID userId = currentUser.getId();
        Optional<PatientResponseDTO> patientOpt = authService.getPatientByUserId(userId);

        if (patientOpt.isEmpty()) {
            req.setAttribute("errorMessage", "You must be a patient to book an appointment");
            req.getRequestDispatcher("/pages/error.jsp").forward(req, resp);
            return;
        }

        PatientResponseDTO patient = patientOpt.get();
        req.setAttribute("patient", patient);

        // Récupérer toutes les spécialités
        List<SpecialiteResponseDTO> specialites = specialiteService.getAllSpecialites();
        req.setAttribute("specialites", specialites);

        // Si une spécialité est sélectionnée, charger les doctors
        String specialiteIdParam = req.getParameter("specialiteId");
        if (specialiteIdParam != null && !specialiteIdParam.isEmpty()) {
            try {
                UUID specialiteId = UUID.fromString(specialiteIdParam);
                List<DoctorResponseDTO> doctors = authService.getDoctorsBySpecialityId(specialiteId);
                req.setAttribute("doctors", doctors);
                req.setAttribute("selectedSpecialiteId", specialiteId);
            } catch (IllegalArgumentException e) {
                req.setAttribute("errorMessage", "Invalid speciality ID");
            }
        }

        // Si un doctor et une date sont sélectionnés, charger les time slots
        String doctorIdParam = req.getParameter("doctorId");
        String dateParam = req.getParameter("date");

        if (doctorIdParam != null && !doctorIdParam.isEmpty() &&
                dateParam != null && !dateParam.isEmpty()) {
            try {
                UUID doctorId = UUID.fromString(doctorIdParam);
                LocalDate date = LocalDate.parse(dateParam);

                List<TimeSlotDTO> timeSlots = appointmentService.getAvailableTimeSlots(doctorId, date);
                req.setAttribute("timeSlots", timeSlots);
                req.setAttribute("selectedDoctorId", doctorId);
                req.setAttribute("selectedDate", date);
            } catch (Exception e) {
                req.setAttribute("errorMessage", "Error loading time slots: " + e.getMessage());
            }
        }

        req.getRequestDispatcher("/pages/appointments/createAppointment.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Vérifier que le patient est connecté
        UserResponseLoginDTO currentUser = (UserResponseLoginDTO) req.getSession().getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/pages/auth/login.jsp");
            return;
        }

        UUID userId = currentUser.getId();
        Optional<PatientResponseDTO> patientOpt = authService.getPatientByUserId(userId);

        if (patientOpt.isEmpty()) {
            req.setAttribute("errorMessage", "Patient not found");
            req.getRequestDispatcher("/pages/error.jsp").forward(req, resp);
            return;
        }

        PatientResponseDTO patient = patientOpt.get();

        try {
            // Récupérer les données du formulaire
            String doctorIdStr = req.getParameter("doctorId");
            String dateStr = req.getParameter("appointmentDate");
            String startTimeStr = req.getParameter("startTime");
            String endTimeStr = req.getParameter("endTime");

            // Validation basique des champs
            if (doctorIdStr == null || doctorIdStr.isEmpty() ||
                    dateStr == null || dateStr.isEmpty() ||
                    startTimeStr == null || startTimeStr.isEmpty() ||
                    endTimeStr == null || endTimeStr.isEmpty()) {

                req.setAttribute("errorMessage", "All fields are required");
                doGet(req, resp);
                return;
            }

            // Créer le DTO
            AppointmentRequestDTO dto = new AppointmentRequestDTO();
            dto.setDoctorId(UUID.fromString(doctorIdStr));
            dto.setPatientId(patient.getId());
            dto.setAppointmentDate(LocalDate.parse(dateStr));
            dto.setStartTime(LocalTime.parse(startTimeStr));
            dto.setEndTime(LocalTime.parse(endTimeStr));

            // VALIDER L'APPOINTMENT
            AppointmentValidator.ValidationResult validationResult = appointmentValidator.validate(dto);

            if (!validationResult.isValid()) {
                req.setAttribute("errorMessage", validationResult.getErrorMessage());
                doGet(req, resp);
                return;
            }

            // Créer l'appointment
            AppointmentResponseDTO createdAppointment = appointmentService.createAppointment(dto);

            // Success message
            req.getSession().setAttribute("successMessage",
                    "Appointment created successfully! Appointment Number: " + createdAppointment.getAppointmentNumber());

            // Rediriger vers la page de liste des appointments
            resp.sendRedirect(req.getContextPath() + "/pages/appointments/list");

        } catch (IllegalArgumentException e) {
            req.setAttribute("errorMessage", "Invalid data format: " + e.getMessage());
            doGet(req, resp);
        } catch (RuntimeException e) {
            req.setAttribute("errorMessage", "Error creating appointment: " + e.getMessage());
            doGet(req, resp);
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Unexpected error: " + e.getMessage());
            e.printStackTrace();
            doGet(req, resp);
        }
    }
}