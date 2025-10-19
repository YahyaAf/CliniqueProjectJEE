package org.example.clinique.validator;

import org.example.clinique.dto.AppointmentRequestDTO;
import org.example.clinique.model.Appointment;
import org.example.clinique.repository.AppointmentRepository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class AppointmentValidator {

    // Constants
    private static final int APPOINTMENT_DURATION_MINUTES = 30;
    private static final int BUFFER_MINUTES = 5;
    private static final int ADVANCE_BOOKING_HOURS = 2;
    private static final LocalTime LUNCH_BREAK_START = LocalTime.of(12, 0);
    private static final LocalTime LUNCH_BREAK_END = LocalTime.of(13, 0);

    private final AppointmentRepository appointmentRepository;

    public AppointmentValidator(AppointmentRepository appointmentRepository) {
        this.appointmentRepository = appointmentRepository;
    }

    /**
     * Valider un appointment complet
     */
    public ValidationResult validate(AppointmentRequestDTO dto) {
        ValidationResult result = new ValidationResult();

        // 1. Valider les champs requis
        if (dto.getDoctorId() == null) {
            result.addError("Doctor ID is required");
        }
        if (dto.getPatientId() == null) {
            result.addError("Patient ID is required");
        }
        if (dto.getAppointmentDate() == null) {
            result.addError("Appointment date is required");
        }
        if (dto.getStartTime() == null) {
            result.addError("Start time is required");
        }
        if (dto.getEndTime() == null) {
            result.addError("End time is required");
        }

        if (!result.isValid()) {
            return result;
        }

        // 2. Valider que la date n'est pas dans le passé
        if (dto.getAppointmentDate().isBefore(LocalDate.now())) {
            result.addError("Appointment date cannot be in the past");
        }

        // 3. Valider l'avance de réservation (≥ 2h)
        if (!validateAdvanceBooking(dto.getAppointmentDate(), dto.getStartTime())) {
            result.addError("Appointments must be booked at least 2 hours in advance");
        }

        // 4. Valider la durée (30 minutes)
        if (!validateDuration(dto.getStartTime(), dto.getEndTime())) {
            result.addError("Appointment duration must be exactly 30 minutes");
        }

        // 5. Valider que ce n'est pas pendant la pause déjeuner
        if (isLunchBreak(dto.getStartTime(), dto.getEndTime())) {
            result.addError("Appointments cannot be scheduled during lunch break (12:00 - 13:00)");
        }

        // 6. Valider le buffer entre rendez-vous (5 min)
        if (!validateBuffer(dto.getDoctorId(), dto.getAppointmentDate(), dto.getStartTime(), dto.getEndTime())) {
            result.addError("There must be at least 5 minutes buffer between appointments");
        }

        // 7. Valider qu'il n'y a pas de conflit de rendez-vous
        if (hasConflict(dto.getDoctorId(), dto.getAppointmentDate(), dto.getStartTime(), dto.getEndTime())) {
            result.addError("This time slot is already booked");
        }

        return result;
    }

    /**
     * Valider que la réservation est au moins 2h à l'avance
     */
    private boolean validateAdvanceBooking(LocalDate appointmentDate, LocalTime appointmentTime) {
        LocalDateTime appointmentDateTime = LocalDateTime.of(appointmentDate, appointmentTime);
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime minimumDateTime = now.plusHours(ADVANCE_BOOKING_HOURS);

        return appointmentDateTime.isAfter(minimumDateTime) || appointmentDateTime.isEqual(minimumDateTime);
    }

    /**
     * Valider que la durée est exactement 30 minutes
     */
    private boolean validateDuration(LocalTime startTime, LocalTime endTime) {
        long minutes = java.time.Duration.between(startTime, endTime).toMinutes();
        return minutes == APPOINTMENT_DURATION_MINUTES;
    }

    /**
     * Vérifier si le créneau est pendant la pause déjeuner
     */
    private boolean isLunchBreak(LocalTime startTime, LocalTime endTime) {
        // Si le start ou end time est entre 12h et 13h
        return (startTime.isBefore(LUNCH_BREAK_END) && endTime.isAfter(LUNCH_BREAK_START));
    }

    /**
     * Valider le buffer de 5 minutes entre les rendez-vous
     */
    /**
     * Valider le buffer de 5 minutes entre les rendez-vous
     */
    private boolean validateBuffer(UUID doctorId, LocalDate date, LocalTime startTime, LocalTime endTime) {
        List<Appointment> doctorAppointments = appointmentRepository.findAll()
                .stream()
                .filter(apt -> apt.getDoctor().getId().equals(doctorId))
                .filter(apt -> apt.getAppointmentDate().equals(date))
                .filter(apt -> apt.getStatus() != org.example.clinique.model.enums.AppointmentStatusEnum.CANCELED)
                .toList();

        for (Appointment existingApt : doctorAppointments) {
            LocalTime existingStart = existingApt.getStartTime();
            LocalTime existingEnd = existingApt.getEndTime();

            // Calculer la distance entre les appointments
            boolean newIsAfter = startTime.isAfter(existingEnd) || startTime.equals(existingEnd);
            boolean newIsBefore = endTime.isBefore(existingStart) || endTime.equals(existingStart);

            if (newIsAfter) {
                // Le nouveau appointment commence après l'existant
                long minutesBetween = java.time.Duration.between(existingEnd, startTime).toMinutes();
                if (minutesBetween < BUFFER_MINUTES) {
                    return false;
                }
            } else if (newIsBefore) {
                // Le nouveau appointment finit avant l'existant
                long minutesBetween = java.time.Duration.between(endTime, existingStart).toMinutes();
                if (minutesBetween < BUFFER_MINUTES) {
                    return false;
                }
            } else {
                // Les appointments se chevauchent
                return false;
            }
        }

        return true;
    }

    /**
     * Vérifier s'il y a un conflit avec un rendez-vous existant
     */
    private boolean hasConflict(UUID doctorId, LocalDate date, LocalTime startTime, LocalTime endTime) {
        List<Appointment> doctorAppointments = appointmentRepository.findAll()
                .stream()
                .filter(apt -> apt.getDoctor().getId().equals(doctorId))
                .filter(apt -> apt.getAppointmentDate().equals(date))
                .filter(apt -> apt.getStatus() != org.example.clinique.model.enums.AppointmentStatusEnum.CANCELED)
                .toList();

        for (Appointment existingApt : doctorAppointments) {
            LocalTime existingStart = existingApt.getStartTime();
            LocalTime existingEnd = existingApt.getEndTime();

            // Vérifier le chevauchement
            if (!(endTime.isBefore(existingStart) ||
                    endTime.equals(existingStart) ||
                    startTime.isAfter(existingEnd) ||
                    startTime.equals(existingEnd))) {
                return true; // Conflit détecté
            }
        }

        return false;
    }

    /**
     * Classe pour stocker les résultats de validation
     */
    public static class ValidationResult {
        private final List<String> errors = new ArrayList<>();

        public void addError(String error) {
            errors.add(error);
        }

        public boolean isValid() {
            return errors.isEmpty();
        }

        public List<String> getErrors() {
            return new ArrayList<>(errors);
        }

        public String getErrorMessage() {
            return String.join("; ", errors);
        }
    }
}