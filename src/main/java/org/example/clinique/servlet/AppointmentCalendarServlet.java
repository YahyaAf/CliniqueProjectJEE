package org.example.clinique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.clinique.dto.AppointmentResponseDTO;
import org.example.clinique.dto.UserResponseLoginDTO;
import org.example.clinique.service.AppointmentService;

import java.io.IOException;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;

@WebServlet("/appointments/calendar")
public class AppointmentCalendarServlet extends HttpServlet {

    private AppointmentService appointmentService;

    @Override
    public void init() throws ServletException {
        this.appointmentService = new AppointmentService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Vérifier que l'utilisateur est connecté
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

        try {
            // Récupérer le mois et l'année depuis les paramètres (ou utiliser le mois actuel)
            String yearParam = req.getParameter("year");
            String monthParam = req.getParameter("month");

            LocalDate today = LocalDate.now();
            int year = (yearParam != null && !yearParam.isEmpty()) ? Integer.parseInt(yearParam) : today.getYear();
            int month = (monthParam != null && !monthParam.isEmpty()) ? Integer.parseInt(monthParam) : today.getMonthValue();

            // Créer YearMonth pour le mois sélectionné
            YearMonth yearMonth = YearMonth.of(year, month);
            LocalDate firstDayOfMonth = yearMonth.atDay(1);
            LocalDate lastDayOfMonth = yearMonth.atEndOfMonth();

            // Récupérer tous les appointments du mois
            List<AppointmentResponseDTO> appointments = appointmentService.getAppointmentsByDateRange(firstDayOfMonth, lastDayOfMonth);

            // Informations pour le calendrier
            int daysInMonth = yearMonth.lengthOfMonth();
            int firstDayOfWeek = firstDayOfMonth.getDayOfWeek().getValue(); // 1=Monday, 7=Sunday

            // Calculer le mois précédent et suivant
            YearMonth previousMonth = yearMonth.minusMonths(1);
            YearMonth nextMonth = yearMonth.plusMonths(1);

            // Passer les données à la JSP
            req.setAttribute("appointments", appointments);
            req.setAttribute("currentYear", year);
            req.setAttribute("currentMonth", month);
            req.setAttribute("daysInMonth", daysInMonth);
            req.setAttribute("firstDayOfWeek", firstDayOfWeek);
            req.setAttribute("today", today);
            req.setAttribute("yearMonth", yearMonth);

            req.setAttribute("previousYear", previousMonth.getYear());
            req.setAttribute("previousMonth", previousMonth.getMonthValue());
            req.setAttribute("nextYear", nextMonth.getYear());
            req.setAttribute("nextMonth", nextMonth.getMonthValue());

            req.getRequestDispatcher("/pages/appointments/calendar.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "Invalid date format");
            req.getRequestDispatcher("/pages/error.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Error loading calendar: " + e.getMessage());
            e.printStackTrace();
            req.getRequestDispatcher("/pages/error.jsp").forward(req, resp);
        }
    }
}