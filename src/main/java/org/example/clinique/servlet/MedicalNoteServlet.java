package org.example.clinique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.clinique.dto.MedicalNoteRequestDTO;
import org.example.clinique.dto.MedicalNoteResponseDTO;
import org.example.clinique.dto.UserResponseLoginDTO;
import org.example.clinique.dto.DoctorResponseDTO;
import org.example.clinique.model.Appointment;
import org.example.clinique.repository.implementation.*;
import org.example.clinique.service.MedicalNoteService;
import org.example.clinique.service.AuthService;

import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@WebServlet("/dashboard/medicalNotes")
public class MedicalNoteServlet extends HttpServlet {

    private MedicalNoteService medicalNoteService;
    private AuthService authService;

    @Override
    public void init() throws ServletException {
        this.medicalNoteService = new MedicalNoteService(
                new MedicalNoteRepositoryImpl(),
                new AppointmentRepositoryImpl()
        );
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

        if (!"DOCTOR".equals(currentUser.getRole())) {
            req.getSession().setAttribute("errorMessage", "Access denied. Admins only.");
            resp.sendRedirect("/clinique/");
            return;
        }

        UUID userId = currentUser.getId();
        Optional<DoctorResponseDTO> doctorOpt = authService.getDoctorByUserId(userId);

        if (doctorOpt.isEmpty()) {
            req.getSession().setAttribute("errorMessage", "You must be a doctor to access this page");
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        DoctorResponseDTO doctor = doctorOpt.get();
        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "add":
                    handleAddPage(req, resp, doctor);
                    break;

                case "edit":
                    handleEditPage(req, resp, doctor);
                    break;

                case "delete":
                    handleDelete(req, resp);
                    break;

                case "view":
                    handleView(req, resp);
                    break;

                default:
                    handleList(req, resp, doctor);
                    break;
            }
        } catch (Exception e) {
            req.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/dashboard/medicalNotes");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Vérifier que le doctor est connecté
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

        String action = req.getParameter("action");

        try {
            if ("add".equals(action)) {
                handleAdd(req, resp);
            } else if ("update".equals(action)) {
                handleUpdate(req, resp);
            }
        } catch (Exception e) {
            req.getSession().setAttribute("errorMessage", e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/dashboard/medicalNotes");
        }
    }

    /**
     * Afficher la liste des medical notes du doctor
     */
    private void handleList(HttpServletRequest req, HttpServletResponse resp, DoctorResponseDTO doctor)
            throws ServletException, IOException {
        List<MedicalNoteResponseDTO> medicalNotes = medicalNoteService.getMedicalNotesByDoctorId(doctor.getId());

        req.setAttribute("doctor", doctor);
        req.setAttribute("medicalNotes", medicalNotes);
        req.setAttribute("count", medicalNotes.size());
        req.getRequestDispatcher("/dashboard/pages/medicalNotes/list.jsp").forward(req, resp);
    }

    /**
     * Afficher la page d'ajout avec les appointments disponibles
     */
    private void handleAddPage(HttpServletRequest req, HttpServletResponse resp, DoctorResponseDTO doctor)
            throws ServletException, IOException {
        // Récupérer les appointments DONE sans medical notes
        List<Appointment> availableAppointments = medicalNoteService.getAppointmentsWithoutMedicalNotes(doctor.getId());

        req.setAttribute("doctor", doctor);
        req.setAttribute("appointments", availableAppointments);
        req.getRequestDispatcher("/dashboard/pages/medicalNotes/add.jsp").forward(req, resp);
    }

    /**
     * Afficher la page d'édition
     */
    private void handleEditPage(HttpServletRequest req, HttpServletResponse resp, DoctorResponseDTO doctor)
            throws ServletException, IOException {
        String id = req.getParameter("id");
        Optional<MedicalNoteResponseDTO> medicalNoteOpt = medicalNoteService.getMedicalNoteById(UUID.fromString(id));

        if (medicalNoteOpt.isEmpty()) {
            req.getSession().setAttribute("errorMessage", "Medical note not found");
            resp.sendRedirect(req.getContextPath() + "/dashboard/medicalNotes");
            return;
        }

        MedicalNoteResponseDTO medicalNote = medicalNoteOpt.get();

        req.setAttribute("doctor", doctor);
        req.setAttribute("medicalNote", medicalNote);
        req.getRequestDispatcher("/dashboard/pages/medicalNotes/edit.jsp").forward(req, resp);
    }

    /**
     * Afficher les détails d'une medical note
     */
    private void handleView(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String id = req.getParameter("id");
        Optional<MedicalNoteResponseDTO> medicalNoteOpt = medicalNoteService.getMedicalNoteById(UUID.fromString(id));

        if (medicalNoteOpt.isEmpty()) {
            req.getSession().setAttribute("errorMessage", "Medical note not found");
            resp.sendRedirect(req.getContextPath() + "/dashboard/medicalNotes");
            return;
        }

        MedicalNoteResponseDTO medicalNote = medicalNoteOpt.get();
        req.setAttribute("medicalNote", medicalNote);
        req.getRequestDispatcher("/dashboard/pages/medicalNotes/view.jsp").forward(req, resp);
    }

    /**
     * Ajouter une nouvelle medical note
     */
    private void handleAdd(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String appointmentId = req.getParameter("appointmentId");
        String symptoms = req.getParameter("symptoms");
        String prescription = req.getParameter("prescription");
        String notes = req.getParameter("notes");

        MedicalNoteRequestDTO dto = new MedicalNoteRequestDTO();
        dto.setAppointmentId(UUID.fromString(appointmentId));
        dto.setSymptoms(symptoms);
        dto.setPrescription(prescription);
        dto.setNotes(notes);

        medicalNoteService.createMedicalNote(dto);

        req.getSession().setAttribute("successMessage", "Medical note created successfully!");
        resp.sendRedirect(req.getContextPath() + "/dashboard/medicalNotes");
    }

    /**
     * Mettre à jour une medical note
     */
    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        UUID id = UUID.fromString(req.getParameter("id"));
        String symptoms = req.getParameter("symptoms");
        String prescription = req.getParameter("prescription");
        String notes = req.getParameter("notes");

        MedicalNoteRequestDTO dto = new MedicalNoteRequestDTO();
        dto.setSymptoms(symptoms);
        dto.setPrescription(prescription);
        dto.setNotes(notes);

        medicalNoteService.updateMedicalNote(id, dto);

        req.getSession().setAttribute("successMessage", "Medical note updated successfully!");
        resp.sendRedirect(req.getContextPath() + "/dashboard/medicalNotes");
    }

    /**
     * Supprimer une medical note
     */
    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        UUID id = UUID.fromString(req.getParameter("id"));
        boolean deleted = medicalNoteService.deleteMedicalNote(id);

        if (deleted) {
            req.getSession().setAttribute("successMessage", "Medical note deleted successfully!");
        } else {
            req.getSession().setAttribute("errorMessage", "Failed to delete medical note");
        }

        resp.sendRedirect(req.getContextPath() + "/dashboard/medicalNotes");
    }
}