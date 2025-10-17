package org.example.clinique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.clinique.dto.AvailabilityRequestDTO;
import org.example.clinique.dto.AvailabilityResponseDTO;
import org.example.clinique.dto.UserResponseLoginDTO;
import org.example.clinique.dto.DoctorResponseDTO;
import org.example.clinique.repository.implementation.*;
import org.example.clinique.service.AuthService;
import org.example.clinique.service.AvailabilityService;
import org.example.clinique.validator.AvailabilityValidator;

import java.io.IOException;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@WebServlet("/doctor/availabilities")
public class AvailabilityServlet extends HttpServlet {

    private AvailabilityService availabilityService;
    private AuthService authService;
    private AvailabilityValidator validator;

    @Override
    public void init() throws ServletException {
        this.availabilityService = new AvailabilityService(new AvailabilityRepositoryImpl());
        this.validator = new AvailabilityValidator();
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
        UserResponseLoginDTO currentUser = (UserResponseLoginDTO) req.getSession().getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/pages/auth/login.jsp");
            return;
        }

        UUID userId = currentUser.getId();
        Optional<DoctorResponseDTO> doctorOpt = authService.getDoctorByUserId(userId);

        if (doctorOpt.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/pages/auth/login.jsp");
            return;
        }

        UUID doctorId = doctorOpt.get().getId();

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                req.getRequestDispatcher("/dashboard/pages/availabilities/add.jsp").forward(req, resp);
                break;

            case "edit":
                String id = req.getParameter("id");
                Optional<AvailabilityResponseDTO> availabilityOpt =
                        Optional.ofNullable(availabilityService.getAvailabilityById(UUID.fromString(id)));

                if (availabilityOpt.isEmpty()) {
                    resp.sendRedirect(req.getContextPath() + "/doctor/availabilities");
                    return;
                }

                req.setAttribute("availability", availabilityOpt.get());
                req.getRequestDispatcher("/dashboard/pages/availabilities/edit.jsp").forward(req, resp);
                break;

            case "delete":
                handleDelete(req, resp);
                break;

            default:
                List<AvailabilityResponseDTO> availabilities = availabilityService.getAvailabilitiesByDoctorId(doctorId);
                req.setAttribute("availabilities", availabilities);
                req.setAttribute("count", availabilities.size());
                req.getRequestDispatcher("/dashboard/pages/availabilities/list.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("add".equals(action)) {
            handleAdd(req, resp);
        } else if ("update".equals(action)) {
            handleUpdate(req, resp);
        }
    }

    private void handleAdd(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        UserResponseLoginDTO currentUser = (UserResponseLoginDTO) req.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/pages/auth/login.jsp");
            return;
        }

        Optional<DoctorResponseDTO> doctorOpt = authService.getDoctorByUserId(currentUser.getId());
        if (doctorOpt.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/pages/auth/login.jsp");
            return;
        }

        UUID doctorId = doctorOpt.get().getId();

        AvailabilityRequestDTO dto = extractDTO(req, doctorId);
        List<String> errors = validator.validate(dto);

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/dashboard/pages/availabilities/add.jsp").forward(req, resp);
            return;
        }

        availabilityService.createAvailability(dto);
        resp.sendRedirect(req.getContextPath() + "/doctor/availabilities");
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        UUID id = UUID.fromString(req.getParameter("id"));

        UserResponseLoginDTO currentUser = (UserResponseLoginDTO) req.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/pages/auth/login.jsp");
            return;
        }

        Optional<DoctorResponseDTO> doctorOpt = authService.getDoctorByUserId(currentUser.getId());
        if (doctorOpt.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/pages/auth/login.jsp");
            return;
        }

        UUID doctorId = doctorOpt.get().getId();

        AvailabilityRequestDTO dto = extractDTO(req, doctorId);
        List<String> errors = validator.validate(dto);

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("availability", availabilityService.getAvailabilityById(id));
            req.getRequestDispatcher("/dashboard/pages/availabilities/edit.jsp").forward(req, resp);
            return;
        }

        availabilityService.updateAvailability(id, dto);
        resp.sendRedirect(req.getContextPath() + "/doctor/availabilities");
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        UUID id = UUID.fromString(req.getParameter("id"));
        availabilityService.deleteAvailability(id);
        resp.sendRedirect(req.getContextPath() + "/doctor/availabilities");
    }

    /**
     * 🧠 Helper: بناء DTO من الفورم + doctorId من session
     */
    private AvailabilityRequestDTO extractDTO(HttpServletRequest req, UUID doctorId) {
        String dayOfWeek = req.getParameter("dayOfWeek");
        LocalTime startTime = LocalTime.parse(req.getParameter("startTime"));
        LocalTime endTime = LocalTime.parse(req.getParameter("endTime"));
        int slotDuration = Integer.parseInt(req.getParameter("slotDuration"));
        boolean isAvailable = req.getParameter("isAvailable") != null;

        AvailabilityRequestDTO dto = new AvailabilityRequestDTO();
        dto.setDayOfWeek(dayOfWeek);
        dto.setStartTime(startTime);
        dto.setEndTime(endTime);
        dto.setSlotDuration(slotDuration);
        dto.setAvailable(isAvailable);
        dto.setDoctorId(doctorId);

        return dto;
    }
}
